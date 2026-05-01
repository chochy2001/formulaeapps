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

    final favorite = Favorite(
      title: 'Teorema del rotacional',
      widgetName: kWidgetTeoremaDelRotacional,
    );

    final contentFuture = FavoritesPdfGenerator.extractFavoriteFormulaContent(
      context: capturedContext,
      favorite: favorite,
    );
    await tester.pump();
    final content = await contentFuture;

    expect(
      content.blocks.where(
        (block) => block.type == FormulaPdfBlockType.formula,
      ),
      isNotEmpty,
    );
    expect(
      content.blocks.any((block) => block.text.contains(r'\vec{F}')),
      isTrue,
    );

    final pdfFuture = FavoritesPdfGenerator.buildFavoritePdfBytes(
      context: capturedContext,
      favorite: favorite,
      folderName: 'General',
    ).catchError((error) {
      capturedError = error;
      return Uint8List(0);
    });
    await tester.pump();
    pdfBytes = await pdfFuture;

    expect(capturedError, isNull);
    expect(pdfBytes, isNotNull);
    expect(String.fromCharCodes(pdfBytes.take(4)), '%PDF');
  });
}
