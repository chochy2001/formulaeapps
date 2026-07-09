import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';

import '../constantes/export_constantes.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
  }


  Widget get adContainer => _ads.banner;

  final ScrollController _scrollController = ScrollController();

  bool _showButton = true;

  @override
  void dispose() {
    _scrollController.dispose();
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showButton
          ? Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                if (favoritesNotifier.favorites.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Animate(
                  effects: const [
                    MoveEffect(
                      curve: Curves.bounceIn,
                      duration: Duration(milliseconds: 100),
                    ),
                    ShakeEffect(
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 100),
                    ),
                    ScaleEffect(
                      duration: Duration(milliseconds: 10),
                    ),
                  ],
                  child: FloatingActionButton.extended(
                    label: Text(
                      AppLocalizations.of(context)!.borrarTodo,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: kColorBotones,
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: kColorBotones,
                          title: Text(
                            AppLocalizations.of(context)!.eliminarFavoritos,
                            style: kTextoBotones,
                          ),
                          content: Text(
                            AppLocalizations.of(context)!
                                .confirmacionEliminarFavoritos,
                            style: kTexto,
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.cancelar,
                                style: kTextoBotones2,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.eliminar,
                                style: kTextoCerrar,
                              ),
                              onPressed: () {
                                favoritesNotifier.removeAllFavorites();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : null,
      body: Consumer<FavoritesNotifier>(
        builder: (context, favoritesNotifier, child) {
          if (favoritesNotifier.favorites.isEmpty) {
            return Center(
                //todo_poner imagen de no hay formulas favoritas
                child: FadeInImage(
              height: 300.0,
              width: MediaQuery.of(context).size.width,
              placeholder: const AssetImage(kUrlImagenGifCarga),
              image: NetworkImage(getImageUrlById(context, kImagenFavoritos) ??
                  kUrlImagenFavoritos),
            ));
          }
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() {
                  _showButton = true;
                });
              } else if (notification.direction == ScrollDirection.reverse) {
                setState(() {
                  _showButton = false;
                });
              }
              return false;
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: favoritesNotifier.favorites.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            // Color de la sombra.
                            spreadRadius: 5,
                            // Extensión de la sombra. Puedes modificarlo a tu gusto.
                            blurRadius: 10,
                            // Suavizado de la sombra. Puedes modificarlo a tu gusto.
                            offset:
                                const Offset(0, 15), // Dirección de la sombra.
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15.0),
                        color: kColorBotones,
                      ),
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => favoritesNotifier
                                .favorites[index]
                                .getWidget(context),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor: kColorBotones,
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .eliminarFavoritos,
                                        style: kTextoBotones,
                                      ),
                                      content: Text(
                                        ' ${AppLocalizations.of(context)!.confirmacionEliminarFavoritos1} ${favoritesNotifier.favorites[index].title} ${AppLocalizations.of(context)!.confirmacionEliminarFavoritosComplemento}',
                                        style: kTexto,
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .cancelar,
                                            style: kTextoBotones2,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .eliminar,
                                            style: kTextoCerrar,
                                          ),
                                          onPressed: () {
                                            favoritesNotifier.removeFavorite(
                                              favoritesNotifier
                                                  .favorites[index],
                                            );
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              // Puedes ajustar el espacio entre el icono y el texto modificando el valor de SizedBox.
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  favoritesNotifier.favorites[index].title,
                                  style: kTexto,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
