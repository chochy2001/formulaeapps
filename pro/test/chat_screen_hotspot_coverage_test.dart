import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/api_service.dart';
import 'package:formulae/chat_gpt/chat_screen.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_iap_platform.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<FakeInAppPurchasePlatform> installFakeStore() async {
    InAppPurchase.instance;
    final previous = InAppPurchasePlatform.instance;
    final platform = FakeInAppPurchasePlatform();
    InAppPurchasePlatform.instance = platform;
    addTearDown(() async {
      InAppPurchasePlatform.instance = previous;
      await platform.close();
    });
    return platform;
  }

  testWidgets(
    'without a valid subscription the chat shows the paywall cart action',
    (tester) async {
      SharedPreferences.setMockInitialValues({'hasValidPurchase': false});
      await installFakeStore();

      await tester.pumpWidget(
        _chatApp(
          chatProvider: ChatProvider(
            sendMessage: ({required message, required modelId}) async => [],
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      expect(find.byType(TextField), findsNothing);

      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'empty send shows the empty-message snackbar and does not add chat rows',
    (tester) async {
      SharedPreferences.setMockInitialValues({'hasValidPurchase': true});
      await installFakeStore();
      final chatProvider = ChatProvider(
        sendMessage: ({required message, required modelId}) async => [
          ChatModel(msg: 'no debería llegar', chatIndex: 1),
        ],
      );

      await tester.pumpWidget(_chatApp(chatProvider: chatProvider));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(chatProvider.getChatList, isEmpty);
      expect(find.byType(SnackBar), findsOneWidget);
    },
  );

  testWidgets(
    'send error surfaces a snackbar and clears the typing indicator',
    (tester) async {
      SharedPreferences.setMockInitialValues({'hasValidPurchase': true});
      await installFakeStore();
      final chatProvider = ChatProvider(
        sendMessage: ({required message, required modelId}) async {
          throw StateError('BFF unavailable');
        },
      );

      await tester.pumpWidget(_chatApp(chatProvider: chatProvider));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(find.byType(TextField), '¿Qué es un límite?');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.byType(SpinKitThreeBounce), findsNothing);
      expect(chatProvider.getChatList.map((m) => m.msg), [
        '¿Qué es un límite?',
      ]);
    },
  );

  testWidgets('clear chat removes prior messages from the list', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'hasValidPurchase': true});
    await installFakeStore();
    final chatProvider = ChatProvider(
      sendMessage: ({required message, required modelId}) async => [
        ChatModel(msg: 'respuesta', chatIndex: 1),
      ],
    );
    chatProvider.addUserMessage(msg: 'mensaje previo');

    await tester.pumpWidget(_chatApp(chatProvider: chatProvider));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('mensaje previo'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(chatProvider.getChatList, isEmpty);
    expect(find.text('mensaje previo'), findsNothing);
  });

  testWidgets(
    'submitting from the text field sends the message when subscribed',
    (tester) async {
      SharedPreferences.setMockInitialValues({'hasValidPurchase': true});
      await installFakeStore();
      final chatProvider = ChatProvider(
        sendMessage: ({required message, required modelId}) async => [
          ChatModel(msg: 'ok', chatIndex: 1),
        ],
      );

      await tester.pumpWidget(_chatApp(chatProvider: chatProvider));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(find.byType(TextField), 'Hola chat');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(chatProvider.getChatList.map((m) => m.msg), ['Hola chat', 'ok']);
    },
  );

  testWidgets(
    'pausing and resuming the app lifecycle does not throw on the chat screen',
    (tester) async {
      SharedPreferences.setMockInitialValues({'hasValidPurchase': true});
      await installFakeStore();

      await tester.pumpWidget(
        _chatApp(
          chatProvider: ChatProvider(
            sendMessage: ({required message, required modelId}) async => [],
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Call the observer directly to avoid AppLifecycleListener transition
      // guards on the binding (hidden/inactive sequencing differs by platform).
      final dynamic state = tester.state(find.byType(ChatScreen));
      state.didChangeAppLifecycleState(AppLifecycleState.paused);
      await tester.pump();
      state.didChangeAppLifecycleState(AppLifecycleState.resumed);
      await tester.pump();

      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'a slow reply shows typing then settles once the stream completes',
    (tester) async {
      SharedPreferences.setMockInitialValues({'hasValidPurchase': true});
      await installFakeStore();
      final reply = Completer<List<ChatModel>>();
      final chatProvider = ChatProvider(
        sendMessage: ({required message, required modelId}) => reply.future,
      );

      await tester.pumpWidget(_chatApp(chatProvider: chatProvider));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(find.byType(TextField), 'Espera');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      expect(find.byType(SpinKitThreeBounce), findsOneWidget);

      reply.complete([ChatModel(msg: 'Listo', chatIndex: 1)]);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));

      expect(find.byType(SpinKitThreeBounce), findsNothing);
      expect(chatProvider.getChatList.map((m) => m.msg), ['Espera', 'Listo']);
    },
  );
}

Widget _chatApp({required ChatProvider chatProvider}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ModelsProvider()),
      ChangeNotifierProvider.value(value: chatProvider),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: const ChatScreen(),
    ),
  );
}
