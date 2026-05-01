import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorites_pdf_generator.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('builds a generated PDF for a formula widget', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final notifier = FavoritesNotifier();
    Uint8List? pdfBytes;
    Object? capturedError;
    late BuildContext capturedContext;

    await tester.pumpWidget(
      ChangeNotifierProvider<FavoritesNotifier>.value(
        value: notifier,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    await tester.runAsync(() async {
      try {
        pdfBytes = await FavoritesPdfGenerator.buildFavoritePdfBytes(
          context: capturedContext,
          favorite: Favorite(
            title: 'Teorema del rotacional',
            widgetName: kWidgetTeoremaDelRotacional,
          ),
          folderName: 'General',
        );
      } catch (error) {
        capturedError = error;
      }
    });

    expect(capturedError, isNull);
    expect(pdfBytes, isNotNull);
    expect(String.fromCharCodes(pdfBytes!.take(4)), '%PDF');
  });
}
