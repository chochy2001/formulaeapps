import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:formulae/Favorites/favorite.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Favorite', () {
    test('equality compares title and widgetName', () {
      final a = Favorite(title: 'A', widgetName: 'WidgetA');
      final b = Favorite(title: 'A', widgetName: 'WidgetA');
      final c = Favorite(title: 'B', widgetName: 'WidgetA');

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('JSON round-trip preserves fields', () {
      final favorite = Favorite(title: 'Limits', widgetName: 'LimitsWidget');
      final restored = Favorite.fromJson(favorite.toJson());

      expect(restored, equals(favorite));
    });
  });

  group('FavoritesNotifier', () {
    test('addFavorite stores and deduplicates entries', () {
      final notifier = FavoritesNotifier();
      final favorite = Favorite(title: 'Derivatives', widgetName: 'DerivWidget');

      notifier.addFavorite(favorite);
      notifier.addFavorite(favorite);

      expect(notifier.favorites, hasLength(1));
      expect(notifier.isFavorite(favorite), isTrue);
    });

    test('removeFavorite deletes a stored favorite', () {
      final notifier = FavoritesNotifier();
      final favorite = Favorite(title: 'Integrals', widgetName: 'IntWidget');

      notifier.addFavorite(favorite);
      notifier.removeFavorite(favorite);

      expect(notifier.favorites, isEmpty);
      expect(notifier.isFavorite(favorite), isFalse);
    });

    test('removeAllFavorites clears the list', () {
      final notifier = FavoritesNotifier();
      notifier.addFavorite(Favorite(title: 'A', widgetName: 'AWidget'));
      notifier.addFavorite(Favorite(title: 'B', widgetName: 'BWidget'));

      notifier.removeAllFavorites();

      expect(notifier.favorites, isEmpty);
    });
  });
}
