import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/Favorites/favorites_pdf_generator.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('exportFolder rejects an empty folder before generating bytes', (
    tester,
  ) async {
    final context = await _pumpHost(tester);

    expect(
      () => FavoritesPdfGenerator.exportFolder(
        context: context,
        folder: FavoriteFolder(id: 'empty', name: 'Vacía', favorites: []),
      ),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          'empty-folder',
        ),
      ),
    );
  });

  test(
    'downloadFileNameForTitle falls back when the title has no safe chars',
    () {
      expect(
        FavoritesPdfGenerator.downloadFileNameForTitle('@@@'),
        'formulae_favoritos.pdf',
      );
      expect(
        FavoritesPdfGenerator.downloadFileNameForTitle(
          'Movimiento de Proyectiles',
        ),
        startsWith('formulae_'),
      );
    },
  );

  test(
    'buildPdfFromContents produces a valid PDF for empty and multi-page sets',
    () async {
      final logo = await rootBundle.load('assets/images/capdesis_logo.png');
      final png = logo.buffer.asUint8List();

      final emptyBytes = await FavoritesPdfGenerator.buildPdfFromContents(
        appTitle: 'Formulae Pro',
        folderName: 'Vacío',
        contents: const [],
      );
      expect(String.fromCharCodes(emptyBytes.take(4)), '%PDF');

      final multiBytes = await FavoritesPdfGenerator.buildPdfFromContents(
        appTitle: 'Formulae Pro',
        folderName: 'Examen',
        size: PdfFormulaSize.large,
        contents: [
          const FavoriteFormulaContent(title: 'Primera', blocks: []),
          FavoriteFormulaContent(
            title: 'Segunda',
            blocks: [
              const FormulaPdfBlock(
                type: FormulaPdfBlockType.heading,
                text: 'Subtítulo distinto',
              ),
              const FormulaPdfBlock(
                type: FormulaPdfBlockType.text,
                text: 'Explicación breve',
              ),
              FormulaPdfBlock(
                type: FormulaPdfBlockType.formula,
                text: r'\sum_{i=1}^{n} i',
                image: png,
                imageWidth: 120,
                imageHeight: 40,
              ),
              const FormulaPdfBlock(
                type: FormulaPdfBlockType.formula,
                text: r'\int x dx',
              ),
            ],
          ),
        ],
      );

      expect(multiBytes, isNotEmpty);
      expect(String.fromCharCodes(multiBytes.take(4)), '%PDF');
    },
  );

  test(
    'buildPdfFromContents wraps long formula text and shrinks oversized images',
    () async {
      final logo = await rootBundle.load('assets/images/capdesis_logo.png');
      final png = logo.buffer.asUint8List();
      final longFormula = List.generate(
        20,
        (index) => 'term_$index = alpha + beta + gamma + delta',
      ).join(' + ');

      final bytes = await FavoritesPdfGenerator.buildPdfFromContents(
        appTitle: 'Formulae Pro',
        folderName: 'Largas',
        size: PdfFormulaSize.large,
        contents: [
          FavoriteFormulaContent(
            title: 'Fórmulas largas',
            blocks: [
              FormulaPdfBlock(
                type: FormulaPdfBlockType.formula,
                text: longFormula,
              ),
              FormulaPdfBlock(
                type: FormulaPdfBlockType.formula,
                text: r'\matrix{wide}',
                image: png,
                imageWidth: 2000,
                imageHeight: 80,
              ),
            ],
          ),
        ],
      );

      expect(String.fromCharCodes(bytes.take(4)), '%PDF');
      expect(bytes.length, greaterThan(500));
    },
  );

  test(
    'buildPdfFromContents skips duplicate headings that match the content title',
    () async {
      final bytes = await FavoritesPdfGenerator.buildPdfFromContents(
        appTitle: 'Formulae Pro',
        folderName: 'General',
        contents: const [
          FavoriteFormulaContent(
            title: 'Teorema',
            blocks: [
              FormulaPdfBlock(
                type: FormulaPdfBlockType.heading,
                text: 'Teorema',
              ),
              FormulaPdfBlock(type: FormulaPdfBlockType.text, text: 'Cuerpo'),
            ],
          ),
        ],
      );

      expect(String.fromCharCodes(bytes.take(4)), '%PDF');
    },
  );

  testWidgets(
    'exportFavorite and exportFolder deliver PDF bytes through the download seam',
    (tester) async {
      FavoritesPdfGenerator.debugDisableFormulaCapture = true;
      final downloads = <({Uint8List bytes, String fileName})>[];
      FavoritesPdfGenerator.debugDownloadOverride = (bytes, fileName) async {
        downloads.add((bytes: bytes, fileName: fileName));
      };
      addTearDown(() {
        FavoritesPdfGenerator.debugDisableFormulaCapture = false;
        FavoritesPdfGenerator.debugDownloadOverride = null;
      });

      final context = await _pumpHost(tester);
      final favorite = Favorite(
        title: 'Teorema del rotacional',
        widgetName: kWidgetTeoremaDelRotacional,
      );

      final exportFavoriteFuture = FavoritesPdfGenerator.exportFavorite(
        context: context,
        favorite: favorite,
        folderName: 'General',
        size: PdfFormulaSize.small,
      );
      await tester.pumpAndSettle();
      await exportFavoriteFuture;

      expect(downloads, hasLength(1));
      expect(String.fromCharCodes(downloads.single.bytes.take(4)), '%PDF');
      expect(downloads.single.fileName, endsWith('.pdf'));
      expect(downloads.single.fileName, startsWith('formulae_'));

      final exportFolderFuture = FavoritesPdfGenerator.exportFolder(
        context: context,
        folder: FavoriteFolder(
          id: 'folder-1',
          name: 'Examen Parcial',
          favorites: [favorite],
        ),
        size: PdfFormulaSize.large,
      );
      await tester.pumpAndSettle();
      await exportFolderFuture;

      expect(downloads, hasLength(2));
      expect(String.fromCharCodes(downloads.last.bytes.take(4)), '%PDF');
      expect(
        downloads.last.fileName,
        FavoritesPdfGenerator.downloadFileNameForTitle('Examen Parcial'),
      );
    },
    timeout: const Timeout(Duration(seconds: 90)),
  );
}

Future<BuildContext> _pumpHost(WidgetTester tester) async {
  late BuildContext capturedContext;
  await tester.pumpWidget(
    ChangeNotifierProvider<FavoritesNotifier>(
      create: (_) => FavoritesNotifier(),
      child: MaterialApp(
        locale: const Locale('es'),
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
  return capturedContext;
}
