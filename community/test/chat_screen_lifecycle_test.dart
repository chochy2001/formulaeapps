import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/chat_gpt/api_service.dart';
import 'package:formulae/chat_gpt/chat_screen.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/models/task_data.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_iap_platform.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'does not update ChatScreen after a delayed assistant response completes post-disposal',
    (tester) async {
      SharedPreferences.setMockInitialValues({'hasValidPurchase': true});
      final platform = _RestoringIapPlatform();
      final chatProvider = _DelayedChatProvider();
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

      try {
        // InAppPurchase registers Android/iOS implementations lazily, so use
        // a non-store target before installing the local fake platform.
        InAppPurchasePlatform.instance = platform;
        await tester.pumpWidget(_harness(chatProvider));
        await _pumpUntilTextFieldIsReady(tester);
        await _pumpUntilPurchaseEntitlementIsReady(tester, platform);

        await tester.enterText(find.byType(TextField), 'Explain a derivative');
        await tester.tap(find.byIcon(Icons.send));
        await tester.pump();
        expect(chatProvider.requestStarted, isTrue);

        // Complete the BFF-like response only after the screen that started it
        // has been removed. Before the mounted checks this produced a
        // "setState() called after dispose" exception in this path.
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        chatProvider.completeAssistantResponse();
        await tester.pump();

        expect(chatProvider.getChatList, hasLength(2));
        expect(tester.takeException(), isNull);
      } finally {
        debugDefaultTargetPlatformOverride = null;
        await platform.close();
      }
    },
  );
}

Future<void> _pumpUntilTextFieldIsReady(WidgetTester tester) async {
  for (var attempt = 0; attempt < 10; attempt++) {
    await tester.pump(const Duration(milliseconds: 1));
    if (find.byType(TextField).evaluate().isNotEmpty) return;
  }

  fail('ChatScreen did not become ready for a paid user.');
}

Future<void> _pumpUntilPurchaseEntitlementIsReady(
  WidgetTester tester,
  FakeInAppPurchasePlatform platform,
) async {
  for (var attempt = 0; attempt < 10; attempt++) {
    await tester.pump(const Duration(milliseconds: 1));
    if (platform.completedPurchases.isNotEmpty) return;
  }

  fail('ChatScreen did not receive the restored purchase entitlement.');
}

Widget _harness(ChatProvider chatProvider) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(const Locale('en')),
      ),
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>.value(value: chatProvider),
      ChangeNotifierProvider<TaskData>(create: (_) => TaskData()),
      ChangeNotifierProvider<FavoritesNotifier>(
        create: (_) => FavoritesNotifier(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
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

class _DelayedChatProvider extends ChatProvider {
  final Completer<void> _assistantResponse = Completer<void>();
  bool requestStarted = false;

  @override
  Future<void> sendMessageAndGetAnswers({
    required String msg,
    required String chosenModelId,
  }) async {
    requestStarted = true;
    await _assistantResponse.future;
    chatList.add(ChatModel(msg: 'A delayed assistant response', chatIndex: 1));
    notifyListeners();
  }

  void completeAssistantResponse() => _assistantResponse.complete();
}

class _RestoringIapPlatform extends FakeInAppPurchasePlatform {
  @override
  Future<void> restorePurchases({String? applicationUserName}) async {
    await super.restorePurchases(applicationUserName: applicationUserName);
    scheduleMicrotask(
      () => emit([
        fakePurchase(
          productId: 'chat_mensual_2023_community',
          status: PurchaseStatus.restored,
          pendingCompletePurchase: true,
        ),
      ]),
    );
  }
}
