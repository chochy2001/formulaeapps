import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

  testWidgets(
    'disposing the chat screen while a reply is pending does not update disposed state',
    (tester) async {
      SharedPreferences.setMockInitialValues({'hasValidPurchase': true});
      InAppPurchase.instance;
      final previousPlatform = InAppPurchasePlatform.instance;
      final platform = FakeInAppPurchasePlatform();
      InAppPurchasePlatform.instance = platform;
      addTearDown(() async {
        InAppPurchasePlatform.instance = previousPlatform;
        await platform.close();
      });

      final reply = Completer<List<ChatModel>>();
      final chatProvider = ChatProvider(
        sendMessage: ({required message, required modelId}) => reply.future,
      );

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ModelsProvider()),
            ChangeNotifierProvider.value(value: chatProvider),
          ],
          child: _app(const ChatScreen()),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(find.byType(TextField), '¿Qué es un límite?');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      await tester.pumpWidget(_app(const SizedBox.shrink()));
      reply.complete([ChatModel(msg: 'Respuesta tardía', chatIndex: 1)]);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'cached valid subscription sends the typed chat message instead of reopening purchase',
    (tester) async {
      SharedPreferences.setMockInitialValues({'hasValidPurchase': true});
      InAppPurchase.instance;
      final previousPlatform = InAppPurchasePlatform.instance;
      final platform = FakeInAppPurchasePlatform();
      InAppPurchasePlatform.instance = platform;
      addTearDown(() async {
        InAppPurchasePlatform.instance = previousPlatform;
        await platform.close();
      });

      final chatProvider = ChatProvider(
        sendMessage: ({required message, required modelId}) async => [
          ChatModel(msg: 'Respuesta de prueba', chatIndex: 1),
        ],
      );

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ModelsProvider()),
            ChangeNotifierProvider.value(value: chatProvider),
          ],
          child: _app(const ChatScreen()),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(find.byType(TextField), '¿Qué es una integral?');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('¿Qué es una integral?'), findsOneWidget);
      expect(chatProvider.getChatList.map((message) => message.msg), [
        '¿Qué es una integral?',
        'Respuesta de prueba',
      ]);
      expect(find.byType(AlertDialog), findsNothing);
    },
  );
}

Widget _app(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: const Locale('es'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: L10n.all,
    home: child,
  );
}
