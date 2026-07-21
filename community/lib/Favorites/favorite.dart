import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Favorites/widget_mapper.dart';

class Favorite {
  final String title;
  final String widgetName;

  Favorite({required this.title, required this.widgetName});

  Map<String, dynamic> toJson() => {'title': title, 'widgetName': widgetName};

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(title: json['title'], widgetName: json['widgetName']);
  }

  Widget getWidget(BuildContext context) {
    return widgetMapper(widgetName, context);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Favorite &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          widgetName == other.widgetName;

  @override
  int get hashCode => title.hashCode ^ widgetName.hashCode;
}

extension TypeNameExtension on Type {
  String get typeName => toString().replaceAll("$packageName.", "");

  String get packageName {
    final parts = toString().split(".");
    if (parts.length > 1) {
      return parts.sublist(0, parts.length - 1).join(".");
    } else {
      return "";
    }
  }
}

class FavoritesNotifier extends ChangeNotifier {
  List<Favorite> _favorites = [];

  List<Favorite> get favorites => _favorites;

  bool isFavorite(Favorite favorite) {
    return _favorites.any((element) => element == favorite);
  }

  void _updateFavorites(List<Favorite> newFavorites) {
    _favorites = newFavorites;
    notifyListeners();
  }

  void removeAllFavorites() {
    _favorites.clear();
    notifyListeners();
    _saveFavorites();
  }

  static Future<FavoritesNotifier> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('favorites');
    final favoritesNotifier = FavoritesNotifier();
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      favoritesNotifier._updateFavorites(
        jsonList.map((e) => Favorite.fromJson(e)).toList(),
      );
    }
    return favoritesNotifier;
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_favorites.map((e) => e.toJson()).toList());
    prefs.setString('favorites', jsonString);
  }

  // Actualiza los métodos addFavorite y removeFavorite para guardar los favoritos después de realizar cambios
  void addFavorite(Favorite favorite) {
    if (!isFavorite(favorite)) {
      _favorites.add(favorite);
      notifyListeners();
      _saveFavorites();
    }
  }

  void removeFavorite(Favorite favorite) {
    _favorites.remove(favorite);
    notifyListeners();
    _saveFavorites();
  }
}
