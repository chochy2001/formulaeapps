import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FavoritesNotifier folders', () {
    test('migrates legacy flat favorites into the default folder', () async {
      final favorite = Favorite(
        title: 'Derivative',
        widgetName: 'DerivativeWidget',
      );

      SharedPreferences.setMockInitialValues({
        'favorites': jsonEncode([favorite.toJson()]),
      });

      final notifier = await FavoritesNotifier.loadFavorites();

      expect(notifier.folders, hasLength(1));
      expect(notifier.activeFolder.name, FavoritesNotifier.defaultFolderName);
      expect(notifier.activeFolder.favorites, contains(favorite));
      expect(notifier.isFavorite(favorite), isTrue);
    });

    test('adds new favorites to the active folder', () {
      SharedPreferences.setMockInitialValues({});
      final notifier = FavoritesNotifier();
      final favorite = Favorite(
        title: 'Integral',
        widgetName: 'IntegralWidget',
      );

      notifier.createFolder('Exam');
      notifier.addFavorite(favorite);

      expect(notifier.activeFolder.name, 'Exam');
      expect(notifier.activeFolder.favorites, contains(favorite));
      expect(notifier.favorites, contains(favorite));
    });
  });
}
