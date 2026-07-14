import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class DisyuncionMatematicasDiscretas extends StatefulWidget {
  const DisyuncionMatematicasDiscretas({super.key});
  @override
  State<DisyuncionMatematicasDiscretas> createState() =>
      _DisyuncionMatematicasDiscretasState();
}

class _DisyuncionMatematicasDiscretasState
    extends State<DisyuncionMatematicasDiscretas> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
  }


  Widget get adContainer => _ads.banner;

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.disyuncion,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.disyuncion,
                            widgetName: kWidgetDisyuncion),
                      );
                      return IconButton(
                        icon: isFavorite
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border),
                        color: isFavorite ? Colors.white : Colors.white,
                        onPressed: () {
                          setState(() {
                            if (isFavorite) {
                              favoritesNotifier.removeFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .disyuncion,
                                    widgetName: kWidgetDisyuncion),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .disyuncion,
                                    widgetName: kWidgetDisyuncion),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conector,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        //todo poner el conector or
                        const Latex(formulaText: r"\mathsf{o}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.simbolos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathsf{ p\lor q}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\mathsf{ p\space \| \space  q}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.tablaVerdad,
                        ),
                      ],
                    ),
                  ),

                  ZoomImagePersonalizado(
                      urlImagen: getImageUrlById(
                              context, kImagenTablaDeVerdadDisyuncion1) ??
                          kUrlImagenTablaDeVerdadDisyuncion1),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ZoomPersonalizado(
                      child: Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.conector,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.oExclusivo,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.simbolo,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"\mathsf{ p\oplus q}"),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.tablaVerdad,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
                  )),
                  ZoomImagePersonalizado(
                      urlImagen: getImageUrlById(
                              context, kImagenTablaDeVerdadDisyuncion2) ??
                          kUrlImagenTablaDeVerdadDisyuncion2),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetDisyuncion,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetDisyuncion,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
