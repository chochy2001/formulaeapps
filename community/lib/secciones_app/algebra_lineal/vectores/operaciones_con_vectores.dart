import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class OperacionesConVectores extends StatefulWidget {
  @override
  _OperacionesConVectoresState createState() => _OperacionesConVectoresState();
}

class _OperacionesConVectoresState extends State<OperacionesConVectores> {
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
                    AppLocalizations.of(context)!.operacionesConVectores,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .operacionesConVectores,
                            widgetName: kWidgetOperacionesConVectores),
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
                                        .operacionesConVectores,
                                    widgetName: kWidgetOperacionesConVectores),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .operacionesConVectores,
                                    widgetName: kWidgetOperacionesConVectores),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sean,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\mathrm{u} = \langle u_1,u_2,u_3 \rangle,\space \mathrm{v} = \langle v_1,v_2,v_3 \rangle"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"k"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.escalar,
                        ),
                        const SizedBox(height: 100),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sumaYResta,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\mathrm{u}\pm\mathrm{v}=\langle u_1\pm v_1,\thinspace u_2\pm v_2,\thinspace u_3\pm v_3 \rangle"),
                        const SizedBox(height: 100),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.multiplicacion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"k\mathrm{u} = \langle ku_1,\thinspace ku_2,\thinspace ku_3\rangle"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetOperacionesConVectores,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetOperacionesConVectores,
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
