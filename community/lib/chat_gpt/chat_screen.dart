// todo Codigo de produccion
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chat_gpt/chats_provider.dart';
import '../chat_gpt/export_chat_gpt.dart';
import '../constantes/export_constantes.dart';
import 'models_provider.dart';
import 'package:formulae/chat_gpt/in_app_purchase_manager.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  final InAppPurchaseManager _inAppPurchaseManager = InAppPurchaseManager();
  // Agregar un Future para la validación de la compra
  Future<bool>? _purchaseValidated;
  Timer? _validationTimer;

  void _storePurchaseState(bool hasValidPurchase) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasValidPurchase', hasValidPurchase);
  }

  Future<bool> _getPurchaseValidation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasValidPurchase = prefs.getBool('hasValidPurchase');

    if (hasValidPurchase != null && hasValidPurchase) {
      return hasValidPurchase;
    }

    bool validated =
        await _inAppPurchaseManager.checkValidPurchase().catchError((error) {
      if (kDebugMode) {
        print('Error al validar la compra: $error');
      }
      return false;
    });
    _storePurchaseState(validated);
    return validated;
  }

  @override
  bool get wantKeepAlive => true;

  late AnimationController _animationController;
  late Animation<Offset> _animation;
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;

  // Variables and methods for in-app purchases
  late ScrollController _listScrollController;
  late StreamSubscription<List<PurchaseDetails>> purchaseSubscription;

  @override
  void initState() {
    super.initState();
    _initializePurchaseDetails();
    _initializeAnimation();
    _initializeChatInputs();
    _inAppPurchaseManager.getProducts();

    _purchaseValidated = _getPurchaseValidation().catchError((error) {
      if (kDebugMode) {
        print('Error al validar la compra: $error');
      }
      return Future.value(false);
    });

    _purchaseValidated!.then((value) {
      if (kDebugMode) {
        print('Validación de compra completada, valor: $value');
      }
      _storePurchaseState(value);
      _validationTimer = Timer.periodic(
          const Duration(hours: 1), (Timer t) => _getPurchaseValidation());
    }).catchError((error) {
      if (kDebugMode) {
        print('Error después de la validación de compra: $error');
      }
    });
  }

  void _initializePurchaseDetails() {
    _inAppPurchaseManager.inAppPurchase;
    purchaseSubscription =
        _inAppPurchaseManager.inAppPurchase.purchaseStream.listen((purchases) {
      _inAppPurchaseManager.handlePurchaseUpdates(purchases);
      setState(() {});
    });
    WidgetsBinding.instance.addObserver(this);
    _inAppPurchaseManager.checkValidPurchase();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.2),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _initializeChatInputs() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _animationController.stop();
    } else if (state == AppLifecycleState.resumed) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _validationTimer?.cancel();
    purchaseSubscription.cancel();
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    _inAppPurchaseManager.dispose();
    super.dispose();
  }

  Future<void> sendMessageFCT({
    required ModelsProvider modelsProvider,
    required ChatProvider chatProvider,
  }) async {
    if (!_inAppPurchaseManager.hasValidPurchase) {
      _inAppPurchaseManager.showProductsDialog(context);
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kColorFondo,
          content: Text(
            AppLocalizations.of(context)!.mensajeVacio,
            style: kTextoBotonesDelgado,
          ),
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
        msg: msg,
        chosenModelId: modelsProvider.getCurrentModel,
      );
      setState(() {
        _isTyping = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kColorBotones,
          content: TextWidget(
            label: e.toString(),
          ),
        ),
      );
    } finally {
      setState(() {
        scrollToBottom();
        _isTyping = false;
      });
    }
  }

  void scrollToBottom() {
    if (_listScrollController.hasClients) {
      _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return FutureBuilder<bool>(
      future: _getPurchaseValidation(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Ahora puedes usar el valor de snapshot.data para determinar si se ha realizado una compra válida
          bool hasValidPurchase = snapshot.data ?? false;
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FadeInImage(
                  height: 200.0,
                  width: 200.0,
                  placeholder: AssetImage(kUrlImagenGifCarga),
                  image: NetworkImage(kUrlImagenFormulae),
                ),
              ),
              title: Text(AppLocalizations.of(context)!.formulaeProChat),
              actions: [
                SlideTransition(
                  position: _animation,
                  child: Visibility(
                    visible: !hasValidPurchase,
                    child: IconButton(
                      icon: Animate(
                        effects: const [
                          ShakeEffect(
                            duration: Duration(seconds: 1),
                          ),
                        ],
                        child: Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : kColorFondo,
                        ),
                      ),
                      onPressed: () {
                        _animationController.stop();
                        _inAppPurchaseManager.showProductsDialog(context);
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : kColorFondo),
                  onPressed: () {
                    setState(() {
                      chatProvider.clearChat();
                    });
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: hasValidPurchase
                  ? Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                            controller: _listScrollController,
                            itemCount:
                                chatProvider.chatList.length, //chatList.length,
                            itemBuilder: (context, index) {
                              return ChatWidget(
                                msg: chatProvider.getChatList[index]
                                    .msg, //chatList[index].msg,
                                chatIndex: chatProvider.getChatList[index]
                                    .chatIndex, //chatList[index].chatIndex,
                              );
                            },
                          ),
                        ),
                        if (_isTyping) ...[
                          const SpinKitThreeBounce(
                            color: kColorBlanco,
                            size: 30.0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                        Material(
                          color: kColorBotones,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: focusNode,
                                    controller: textEditingController,
                                    onSubmitted: hasValidPurchase
                                        ? (value) async {
                                            await sendMessageFCT(
                                              modelsProvider: modelsProvider,
                                              chatProvider: chatProvider,
                                            );
                                          }
                                        : null,
                                    enabled: hasValidPurchase,
                                    style: kTextoBotonesDelgado,
                                    decoration: InputDecoration(
                                      hintText: hasValidPurchase
                                          ? AppLocalizations.of(context)!
                                              .comoPuedoAyudarte
                                          : AppLocalizations.of(context)!
                                              .suscribeteParaAcceder,
                                      hintStyle: kTextoBotonesDelgado,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: hasValidPurchase
                                      ? () async {
                                          await sendMessageFCT(
                                            modelsProvider: modelsProvider,
                                            chatProvider: chatProvider,
                                          );
                                        }
                                      : null,
                                  icon: const Icon(Icons.send,
                                      color: kColorBlanco),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: FadeInImage(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: double.infinity,
                        placeholder: const AssetImage(kUrlImagenGifCarga),
                        image: NetworkImage(
                            getImageUrlById(context, kImagenChat) ??
                                kUrlImagenChat),
                      ),
                    ),
            ),
          );
        }
      },
    );
  }
}
