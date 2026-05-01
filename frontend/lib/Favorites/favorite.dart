import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Favorites/widget_mapper.dart';

class Favorite {
  final String title;
  final String widgetName;

  Favorite({required this.title, required this.widgetName});

  Map<String, dynamic> toJson() => {
        'title': title,
        'widgetName': widgetName,
      };

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      title: json['title'],
      widgetName: json['widgetName'],
    );
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

class FavoriteFolder {
  final String id;
  String name;
  final List<Favorite> favorites;

  FavoriteFolder({
    required this.id,
    required this.name,
    List<Favorite>? favorites,
  }) : favorites = favorites ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'favorites': favorites.map((e) => e.toJson()).toList(),
      };

  factory FavoriteFolder.fromJson(Map<String, dynamic> json) {
    final rawFavorites = json['favorites'];

    return FavoriteFolder(
      id: json['id'] ?? FavoritesNotifier.defaultFolderId,
      name: json['name'] ?? FavoritesNotifier.defaultFolderName,
      favorites: rawFavorites is List
          ? rawFavorites
              .whereType<Map<String, dynamic>>()
              .map(Favorite.fromJson)
              .toList()
          : [],
    );
  }

  bool contains(Favorite favorite) {
    return favorites.any((element) => element == favorite);
  }
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
  static const String defaultFolderId = 'default';
  static const String defaultFolderName = 'General';

  static const String _legacyFavoritesKey = 'favorites';
  static const String _foldersStorageKey = 'favoriteFolders';
  static const String _activeFolderStorageKey = 'activeFavoriteFolderId';

  final List<FavoriteFolder> _folders = [];
  String _activeFolderId = defaultFolderId;

  FavoritesNotifier() {
    _ensureDefaultFolder();
  }

  List<FavoriteFolder> get folders => List.unmodifiable(_folders);

  FavoriteFolder get activeFolder {
    _ensureDefaultFolder();
    return _folders.firstWhere(
      (folder) => folder.id == _activeFolderId,
      orElse: () => _folders.first,
    );
  }

  String get activeFolderId => activeFolder.id;

  List<Favorite> get favorites =>
      _folders.expand((folder) => folder.favorites).toList(growable: false);

  bool isFavorite(Favorite favorite) {
    return _folders.any((folder) => folder.contains(favorite));
  }

  void setActiveFolder(String folderId) {
    if (_folders.any((folder) => folder.id == folderId)) {
      _activeFolderId = folderId;
      notifyListeners();
      _saveFavorites();
    }
  }

  void createFolder(String name) {
    final cleanName = name.trim();
    if (cleanName.isEmpty) {
      return;
    }

    final duplicate = _folders.any(
      (folder) => folder.name.toLowerCase() == cleanName.toLowerCase(),
    );
    if (duplicate) {
      return;
    }

    final id = 'folder_${DateTime.now().microsecondsSinceEpoch}';
    _folders.add(FavoriteFolder(id: id, name: cleanName));
    _activeFolderId = id;
    notifyListeners();
    _saveFavorites();
  }

  void renameFolder(String folderId, String name) {
    final cleanName = name.trim();
    if (cleanName.isEmpty) {
      return;
    }

    final folder = _folderById(folderId);
    if (folder == null || folder.id == defaultFolderId) {
      return;
    }

    folder.name = cleanName;
    notifyListeners();
    _saveFavorites();
  }

  void deleteFolder(String folderId) {
    if (folderId == defaultFolderId || _folders.length == 1) {
      return;
    }

    _folders.removeWhere((folder) => folder.id == folderId);
    if (_activeFolderId == folderId) {
      _activeFolderId = defaultFolderId;
    }
    _ensureDefaultFolder();
    notifyListeners();
    _saveFavorites();
  }

  void moveFavoriteToFolder(Favorite favorite, String folderId) {
    final targetFolder = _folderById(folderId);
    if (targetFolder == null) {
      return;
    }

    for (final folder in _folders) {
      folder.favorites.remove(favorite);
    }
    if (!targetFolder.contains(favorite)) {
      targetFolder.favorites.add(favorite);
    }
    notifyListeners();
    _saveFavorites();
  }

  void removeAllFavorites() {
    for (final folder in _folders) {
      folder.favorites.clear();
    }
    notifyListeners();
    _saveFavorites();
  }

  static Future<FavoritesNotifier> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final foldersJsonString = prefs.getString(_foldersStorageKey);
    final legacyJsonString = prefs.getString(_legacyFavoritesKey);
    final activeFolderId = prefs.getString(_activeFolderStorageKey);
    final favoritesNotifier = FavoritesNotifier();

    if (foldersJsonString != null) {
      final List<dynamic> jsonList = jsonDecode(foldersJsonString);
      favoritesNotifier._folders
        ..clear()
        ..addAll(
          jsonList
              .whereType<Map<String, dynamic>>()
              .map(FavoriteFolder.fromJson),
        );
    } else if (legacyJsonString != null) {
      final List<dynamic> jsonList = jsonDecode(legacyJsonString);
      final legacyFavorites = jsonList
          .whereType<Map<String, dynamic>>()
          .map(Favorite.fromJson)
          .toList();
      favoritesNotifier._folders
        ..clear()
        ..add(
          FavoriteFolder(
            id: defaultFolderId,
            name: defaultFolderName,
            favorites: legacyFavorites,
          ),
        );
    }

    favoritesNotifier._ensureDefaultFolder();
    if (activeFolderId != null &&
        favoritesNotifier._folders
            .any((folder) => folder.id == activeFolderId)) {
      favoritesNotifier._activeFolderId = activeFolderId;
    }

    return favoritesNotifier;
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final foldersJsonString =
        jsonEncode(_folders.map((e) => e.toJson()).toList());
    final legacyJsonString =
        jsonEncode(favorites.map((e) => e.toJson()).toList());
    await prefs.setString(_foldersStorageKey, foldersJsonString);
    await prefs.setString(_legacyFavoritesKey, legacyJsonString);
    await prefs.setString(_activeFolderStorageKey, activeFolder.id);
  }

  void addFavorite(Favorite favorite) {
    if (!isFavorite(favorite)) {
      activeFolder.favorites.add(favorite);
      notifyListeners();
      _saveFavorites();
    }
  }

  void removeFavorite(Favorite favorite) {
    for (final folder in _folders) {
      folder.favorites.remove(favorite);
    }
    notifyListeners();
    _saveFavorites();
  }

  FavoriteFolder? _folderById(String folderId) {
    for (final folder in _folders) {
      if (folder.id == folderId) {
        return folder;
      }
    }
    return null;
  }

  void _ensureDefaultFolder() {
    if (_folders.isEmpty) {
      _folders.add(
        FavoriteFolder(id: defaultFolderId, name: defaultFolderName),
      );
      _activeFolderId = defaultFolderId;
      return;
    }

    if (!_folders.any((folder) => folder.id == defaultFolderId)) {
      _folders.insert(
        0,
        FavoriteFolder(id: defaultFolderId, name: defaultFolderName),
      );
    }

    if (!_folders.any((folder) => folder.id == _activeFolderId)) {
      _activeFolderId = defaultFolderId;
    }
  }
}
