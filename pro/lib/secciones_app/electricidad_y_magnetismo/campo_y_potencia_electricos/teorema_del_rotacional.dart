import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class TeoremaDelRotacional extends StatefulWidget {
  const TeoremaDelRotacional({super.key});

  @override
  State<TeoremaDelRotacional> createState() => _TeoremaDelRotacionalState();
}

class _TeoremaDelRotacionalState extends State<TeoremaDelRotacional> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.teoremaRotacional,
              ),
            ),
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
            const Column(
              children: [
                VerPDF(
                  url: kWidgetTeoremaDelRotacional,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetTeoremaDelRotacional,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
