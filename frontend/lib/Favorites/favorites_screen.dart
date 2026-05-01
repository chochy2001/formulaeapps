import 'package:flutter/material.dart';

import '../constantes/export_constantes.dart';
import 'favorites_pdf_generator.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isExporting = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Consumer<FavoritesNotifier>(
          builder: (context, favoritesNotifier, child) {
            final activeFolder = favoritesNotifier.activeFolder;

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(
                    title: localizations.favoritos,
                    isExporting: _isExporting,
                    canExport: activeFolder.favorites.isNotEmpty,
                    onCreateFolder: () =>
                        _showCreateFolderDialog(favoritesNotifier),
                    onExport: () => _exportFolder(activeFolder),
                    onClearAll: favoritesNotifier.favorites.isEmpty
                        ? null
                        : () => _confirmClearAll(favoritesNotifier),
                  ),
                  const SizedBox(height: 12),
                  _FolderSelector(
                    folders: favoritesNotifier.folders,
                    activeFolderId: favoritesNotifier.activeFolderId,
                    onSelect: favoritesNotifier.setActiveFolder,
                    onDelete: (folder) =>
                        _confirmDeleteFolder(favoritesNotifier, folder),
                  ),
                  const SizedBox(height: 12),
                  _ActiveFolderLabel(folderName: activeFolder.name),
                  const SizedBox(height: 12),
                  Expanded(
                    child: activeFolder.favorites.isEmpty
                        ? _EmptyFavorites(folderName: activeFolder.name)
                        : ListView.separated(
                            controller: _scrollController,
                            itemCount: activeFolder.favorites.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final favorite = activeFolder.favorites[index];
                              return _FavoriteTile(
                                favorite: favorite,
                                onOpen: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        favorite.getWidget(context),
                                  ),
                                ),
                                onMove: favoritesNotifier.folders.length <= 1
                                    ? null
                                    : () => _showMoveFavoriteDialog(
                                          favoritesNotifier,
                                          favorite,
                                        ),
                                onDelete: () => _confirmRemoveFavorite(
                                  favoritesNotifier,
                                  favorite,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showCreateFolderDialog(
    FavoritesNotifier favoritesNotifier,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final controller = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: kColorBotones,
        title: Text(localizations.crearCarpeta, style: kTextoBotones),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: kTexto,
          decoration: InputDecoration(
            hintText: localizations.nombreCarpeta,
            hintStyle: kTextoBotonesDelgado,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kColorBlanco),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kColorBlanco),
            ),
          ),
          onSubmitted: (_) {
            favoritesNotifier.createFolder(controller.text);
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(localizations.cancelar, style: kTextoBotones2),
          ),
          TextButton(
            onPressed: () {
              favoritesNotifier.createFolder(controller.text);
              Navigator.of(context).pop();
            },
            child: Text(localizations.guardar, style: kTextoBotones2),
          ),
        ],
      ),
    );

    controller.dispose();
  }

  Future<void> _showMoveFavoriteDialog(
    FavoritesNotifier favoritesNotifier,
    Favorite favorite,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    var selectedFolderId = favoritesNotifier.activeFolderId;

    final targetFolderId = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: kColorBotones,
            title: Text(localizations.moverACarpeta, style: kTextoBotones),
            content: DropdownButton<String>(
              value: selectedFolderId,
              dropdownColor: kColorBotones,
              iconEnabledColor: kColorBlanco,
              isExpanded: true,
              items: favoritesNotifier.folders
                  .map(
                    (folder) => DropdownMenuItem<String>(
                      value: folder.id,
                      child: Text(folder.name, style: kTexto),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setDialogState(() {
                    selectedFolderId = value;
                  });
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(localizations.cancelar, style: kTextoBotones2),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(selectedFolderId),
                child: Text(localizations.guardar, style: kTextoBotones2),
              ),
            ],
          );
        },
      ),
    );

    if (targetFolderId != null) {
      favoritesNotifier.moveFavoriteToFolder(favorite, targetFolderId);
    }
  }

  Future<void> _confirmRemoveFavorite(
    FavoritesNotifier favoritesNotifier,
    Favorite favorite,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final shouldDelete = await _confirmDialog(
      title: localizations.eliminarFavoritos,
      message:
          '${localizations.confirmacionEliminarFavoritos1} ${favorite.title} ${localizations.confirmacionEliminarFavoritosComplemento}',
    );

    if (shouldDelete) {
      favoritesNotifier.removeFavorite(favorite);
    }
  }

  Future<void> _confirmClearAll(FavoritesNotifier favoritesNotifier) async {
    final localizations = AppLocalizations.of(context)!;
    final shouldDelete = await _confirmDialog(
      title: localizations.eliminarFavoritos,
      message: localizations.confirmacionEliminarFavoritos,
    );

    if (shouldDelete) {
      favoritesNotifier.removeAllFavorites();
    }
  }

  Future<void> _confirmDeleteFolder(
    FavoritesNotifier favoritesNotifier,
    FavoriteFolder folder,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final shouldDelete = await _confirmDialog(
      title: localizations.eliminarCarpeta,
      message: folder.name,
    );

    if (shouldDelete) {
      favoritesNotifier.deleteFolder(folder.id);
    }
  }

  Future<bool> _confirmDialog({
    required String title,
    required String message,
  }) async {
    final localizations = AppLocalizations.of(context)!;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: kColorBotones,
        title: Text(title, style: kTextoBotones),
        content: Text(message, style: kTexto),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(localizations.cancelar, style: kTextoBotones2),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(localizations.eliminar, style: kTextoCerrar),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  Future<void> _exportFolder(FavoriteFolder folder) async {
    final localizations = AppLocalizations.of(context)!;
    setState(() {
      _isExporting = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(localizations.generandoPDF)),
    );

    try {
      await FavoritesPdfGenerator.exportFolder(
        context: context,
        folder: folder,
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.pdfGenerado)),
      );
    } catch (error, stackTrace) {
      debugPrint('Formulae folder PDF export failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.mensajeError)),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
        });
      }
    }
  }
}

class _Header extends StatelessWidget {
  final String title;
  final bool isExporting;
  final bool canExport;
  final VoidCallback onCreateFolder;
  final VoidCallback onExport;
  final VoidCallback? onClearAll;

  const _Header({
    required this.title,
    required this.isExporting,
    required this.canExport,
    required this.onCreateFolder,
    required this.onExport,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 10,
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(title, style: kTextoBotones),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              icon: Icons.create_new_folder_rounded,
              label: localizations.crearCarpeta,
              onPressed: onCreateFolder,
            ),
            _ActionButton(
              icon: Icons.picture_as_pdf_rounded,
              label: localizations.exportarPDF,
              onPressed: canExport && !isExporting ? onExport : null,
            ),
            _ActionButton(
              icon: Icons.delete_forever,
              label: localizations.borrarTodo,
              onPressed: onClearAll,
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorBotones,
        foregroundColor: kColorBlanco,
        disabledBackgroundColor: kColorBotones.withValues(alpha: 0.35),
        disabledForegroundColor: kColorBlanco.withValues(alpha: 0.45),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _FolderSelector extends StatelessWidget {
  final List<FavoriteFolder> folders;
  final String activeFolderId;
  final ValueChanged<String> onSelect;
  final ValueChanged<FavoriteFolder> onDelete;

  const _FolderSelector({
    required this.folders,
    required this.activeFolderId,
    required this.onSelect,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: folders.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final folder = folders[index];
          final isActive = folder.id == activeFolderId;

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onSelect(folder.id),
            child: Container(
              width: 190,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActive ? kColorBotones : kColorFondo,
                border: Border.all(
                  color: isActive ? kColorBlanco : kColorTextoBotones,
                  width: isActive ? 1.5 : 0.3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.folder_rounded, color: kColorBlanco),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          folder.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kTextoBotonesDelgado,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${folder.favorites.length}',
                          style: kTexto,
                        ),
                      ],
                    ),
                  ),
                  if (folder.id != FavoritesNotifier.defaultFolderId)
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: kColorBlanco,
                        size: 18,
                      ),
                      onPressed: () => onDelete(folder),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ActiveFolderLabel extends StatelessWidget {
  final String folderName;

  const _ActiveFolderLabel({required this.folderName});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        const Icon(Icons.bookmark_added_rounded, color: kColorBlanco),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '${localizations.carpetaActiva}: $folderName',
            style: kTexto,
          ),
        ),
      ],
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  final Favorite favorite;
  final VoidCallback onOpen;
  final VoidCallback? onMove;
  final VoidCallback onDelete;

  const _FavoriteTile({
    required this.favorite,
    required this.onOpen,
    required this.onMove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 8),
          ),
        ],
        borderRadius: BorderRadius.circular(12.0),
        color: kColorBotones,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                tooltip: AppLocalizations.of(context)!.eliminar,
                icon: const Icon(Icons.delete, color: kColorBlanco),
                onPressed: onDelete,
              ),
              Expanded(
                child: Text(
                  favorite.title,
                  style: kTexto,
                  textAlign: TextAlign.start,
                ),
              ),
              IconButton(
                tooltip: AppLocalizations.of(context)!.moverACarpeta,
                icon: const Icon(Icons.drive_file_move_rounded),
                color: kColorBlanco,
                onPressed: onMove,
              ),
              const Icon(Icons.chevron_right_rounded, color: kColorBlanco),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  final String folderName;

  const _EmptyFavorites({required this.folderName});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.folder_off_rounded,
            size: 92,
            color: kColorBlanco,
          ),
          const SizedBox(height: 12),
          Text(
            folderName,
            style: kTextoBotones,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            localizations.carpetaVacia,
            style: kTexto,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
