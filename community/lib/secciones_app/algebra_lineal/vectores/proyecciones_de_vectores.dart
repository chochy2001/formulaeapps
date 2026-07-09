import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ProyeccionesDeVectores extends StatefulWidget {
  @override
  _ProyeccionesDeVectoresState createState() => _ProyeccionesDeVectoresState();
}

class _ProyeccionesDeVectoresState extends State<ProyeccionesDeVectores> {
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
                    AppLocalizations.of(context)!.proyeccionesDeVectores,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .proyeccionesDeVectores,
                            widgetName: kWidgetProyeccionesDeVectores),
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
                                        .proyeccionesDeVectores,
                                    widgetName: kWidgetProyeccionesDeVectores),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .proyeccionesDeVectores,
                                    widgetName: kWidgetProyeccionesDeVectores),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.vectorProyeccion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\mathrm{proy}_v\mathrm{u}=\left(\frac{\mathrm{u}\cdot\mathrm{v}}{|\mathrm{v}|^2}\right) \mathrm{v}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\mathrm{u}=\mathrm{proy}_\mathrm{v}\mathrm{u}+(\mathrm{u}-\mathrm{proy}_\mathrm{v}\mathrm{u})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\mathrm{u}=\left(\frac{\mathrm{u}\cdot\mathrm{v}}{|\mathrm{v}|^2}\right)\mathrm{v}+\left(\mathrm{u}-\left(\frac{\mathrm{u}\cdot\mathrm{v}}{|\mathrm{v}|^2}\right)\mathrm{v}\right)"),
                        const SizedBox(height: 60),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.componenteEscalar,
                        ),
                        const SizedBox(height: 5),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"|\mathrm{u}|\cos{\theta}=\frac{\mathrm{u}\cdot\mathrm{v}}{|\mathrm{v}|}=\mathrm{u}\cdot\frac{\mathrm{v}}{|\mathrm{v}|}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetProyeccionesDeVectores,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetProyeccionesDeVectores,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(
                        color: kColorFondo,
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(
                          height: 10,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.vectoresOrtogonales,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
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
