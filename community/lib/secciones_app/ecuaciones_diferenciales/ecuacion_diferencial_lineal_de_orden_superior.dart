import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class EcuacionDiferencialLinealDeOrdenSuperior extends StatefulWidget {
  const EcuacionDiferencialLinealDeOrdenSuperior({super.key});
  @override
  State<EcuacionDiferencialLinealDeOrdenSuperior> createState() =>
      _EcuacionDiferencialLinealDeOrdenSuperiorState();
}

class _EcuacionDiferencialLinealDeOrdenSuperiorState
    extends State<EcuacionDiferencialLinealDeOrdenSuperior> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(
      onBannerReady: () {
        if (mounted) setState(() {});
      },
    );
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
                    AppLocalizations.of(
                      context,
                    )!.ecuacionDiferencialLinealOrdenSuperior,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.ecuacionDiferencialLinealOrdenSuperior,
                          widgetName:
                              kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
                        ),
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
                                  title: AppLocalizations.of(
                                    context,
                                  )!.ecuacionDiferencialLinealOrdenSuperior,
                                  widgetName:
                                      kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.ecuacionDiferencialLinealOrdenSuperior,
                                  widgetName:
                                      kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"a_n(x)y^n+a_{n-1}(x)y^{n-1}+\cdots+a_0(x)y= g(x)",
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.variacionDeParametros,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionHomogenea,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(
                          formulaText:
                              r"a_ny^n+a_{n-1}(x)y^{n-1}+\cdots + a_0(x)y = 0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"y_h = c_1u_1+c_2u_2 + \cdots + c_nu_n = 0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionParticular,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(
                          formulaText:
                              r"y_p = u_1v_1 + u_2v_2 + \cdots + u_nv_n",
                        ),
                        const SizedBox(height: 5),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.seResuelveElSistemaDeEcuaciones,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(formulaText: r"y_g = y_h+y_p"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
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
