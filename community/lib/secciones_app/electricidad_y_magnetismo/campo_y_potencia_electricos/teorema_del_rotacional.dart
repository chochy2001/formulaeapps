import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TeoremaDelRotacional extends StatefulWidget {
  @override
  State<TeoremaDelRotacional> createState() => _TeoremaDelRotacionalState();
}

class _TeoremaDelRotacionalState extends State<TeoremaDelRotacional> {
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
            TituloPersonalizado(
              AppLocalizations.of(context)!.teoremaRotacional,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.teoremaRotacional,
                      widgetName: kWidgetTeoremaDelRotacional),
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
                                  .teoremaRotacional,
                              widgetName: kWidgetTeoremaDelRotacional),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .teoremaRotacional,
                              widgetName: kWidgetTeoremaDelRotacional),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const Column(
              children: <Widget>[
                ZoomImagePersonalizado(
                    urlImagen: kUrlImagenTeoremaDelRotacional),
                Latex(
                    formulaText:
                        r"\iint (\vec{\nabla}\times \vec{F})\cdot d\vec{S} = \oint \vec{F}\cdot d\vec{l}"),
                Latex(
                    formulaText:
                        r"\begin{vmatrix} \hat{i} & \hat{j} & \hat{k} \\ \frac{\partial}{\partial x} & \frac{\partial}{\partial y} & \frac{\partial}{\partial z}\\F_x & F_y & F_z\end{vmatrix}"),
                SizedBox(height: 20.0),
                SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetTeoremaDelRotacional,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetTeoremaDelRotacional,
            ),
          ],
        ),
      ),
    );
  }
}
