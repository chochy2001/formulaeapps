import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/chat_screen.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/in_app_purchase_manager.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/screens_personalizados/informacion.dart';
import 'package:formulae/secciones_app/ejercicios/alert_ejercicios.dart';
import 'package:formulae/widgets_personalizados/alerts_dialogs.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:formulae/widgets_personalizados/todo/tasks_list.dart';
import 'package:formulae/widgets_personalizados/zoom_image_personalizado.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_iap_platform.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget harness(Widget child) {
    return MaterialApp(
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

  testWidgets('information and configuration use the robust remote loader', (
    tester,
  ) async {
    await tester.pumpWidget(harness(const Informacion()));
    await tester.pump();
    expect(find.byType(ImagenRemotaRobusta), findsOneWidget);

    await tester.pumpWidget(harness(const Configuracion()));
    await tester.pump();
    expect(find.byType(ImagenRemotaRobusta), findsOneWidget);
  });

  testWidgets('empty task list uses the robust remote loader', (tester) async {
    final taskData = TaskData();
    taskData.deleteAllTasks();
    await tester.pumpWidget(
      ChangeNotifierProvider<TaskData>.value(
        value: taskData,
        child: harness(const Scaffold(body: TasksList())),
      ),
    );
    await tester.pump();

    expect(find.byType(ImagenRemotaRobusta), findsOneWidget);
  });

  testWidgets('information and exercise dialogs use the robust remote loader', (
    tester,
  ) async {
    await tester.pumpWidget(
      harness(
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => mostrarInfo(context, 'Información'),
            child: const Text('Abrir'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Abrir'));
    await tester.pump();
    expect(find.byType(ImagenRemotaRobusta), findsOneWidget);

    await tester.tap(find.text('Cerrar'));
    await tester.pump();

    await tester.pumpWidget(
      harness(
        const AlertEjercicios(
          ruta: '/',
          textoEjercicio: 'Ejercicio',
          ejercicioEjemplo: Column(children: [SizedBox()]),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(ImagenRemotaRobusta), findsOneWidget);
  });

  testWidgets('purchase dialog uses a compact robust remote loader', (
    tester,
  ) async {
    final platform = FakeInAppPurchasePlatform();
    final manager = InAppPurchaseManager(
      platform: platform,
      listenToPurchases: false,
      platformOverride: 'ios',
    )..products = [fakeProduct('chat_mensual_2023_01')];
    addTearDown(() async {
      manager.dispose();
      await platform.close();
    });

    await tester.pumpWidget(
      harness(
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => manager.showProductsDialog(context),
            child: const Text('Comprar'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Comprar'));
    await tester.pump();

    expect(find.byType(ImagenRemotaRobusta), findsOneWidget);
    expect(
      tester.getSize(find.byType(ImagenRemotaRobusta)),
      const Size(50, 50),
    );
  });

  testWidgets('chat uses robust loaders for its header and empty state', (
    tester,
  ) async {
    // Initialize the facade first so setting the fake is not overwritten by
    // the platform registration performed by InAppPurchase.instance.
    InAppPurchase.instance;
    final previousPlatform = InAppPurchasePlatform.instance;
    final platform = FakeInAppPurchasePlatform();
    InAppPurchasePlatform.instance = platform;
    addTearDown(() async {
      InAppPurchasePlatform.instance = previousPlatform;
      await platform.close();
    });

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ModelsProvider>(
            create: (_) => ModelsProvider(),
          ),
          ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
        ],
        child: harness(const ChatScreen()),
      ),
    );
    await tester.pump();

    expect(find.byType(ImagenRemotaRobusta), findsNWidgets(2));

    platform.emit([
      fakePurchase(
        productId: 'chat_mensual_2023_01',
        status: PurchaseStatus.restored,
      ),
    ]);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
  });
}
