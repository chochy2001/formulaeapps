import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class IntegralesDeLinea extends StatefulWidget {
  const IntegralesDeLinea({super.key});
  @override
  State<IntegralesDeLinea> createState() => _IntegralesDeLineaState();
}

class _IntegralesDeLineaState extends State<IntegralesDeLinea> {
  bool seleccionadoMostrar = true;

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
            TituloPersonalizado(AppLocalizations.of(context)!.integralesLinea),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.integralesLinea,
                    widgetName: kWidgetIntegralesDeLinea,
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
                            )!.integralesLinea,
                            widgetName: kWidgetIntegralesDeLinea,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.integralesLinea,
                            widgetName: kWidgetIntegralesDeLinea,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.deCamposEscalares,
                  ),
                  const Latex(
                    formulaText:
                        r"\int_C F(s)ds= \int_{t_P}^{t_Q} F(x(t),y(t))\sqrt{(x'(t))^2+(y'(t))^2}dt",
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.deCamposVectoriales,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.seaElCampo),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText: r"F(x,y) = F_1(x,y)\hat{i}+F_2(x,y)\hat{j}",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"\int_C \vec{F}\cdot d\vec{r}=\int_{t_P}^{t_Q} F_1(x,y)dx + \int_{t_P}^{t_Q} F_2(x,y)dy",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetIntegralesDeLinea),
            //Descargar PDF
            const DescargarPDF(url: kWidgetIntegralesDeLinea),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
