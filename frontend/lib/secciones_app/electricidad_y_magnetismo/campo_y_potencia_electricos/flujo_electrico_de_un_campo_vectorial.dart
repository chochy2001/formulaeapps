import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class FlujoDeUnCampoVectorial extends StatefulWidget {
  const FlujoDeUnCampoVectorial({Key? key}) : super(key: key);

  @override
  State<FlujoDeUnCampoVectorial> createState() =>
      _FlujoDeUnCampoVectorialState();
}

class _FlujoDeUnCampoVectorialState extends State<FlujoDeUnCampoVectorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.flujoElectricoCampoVectorial,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .flujoElectricoCampoVectorial,
                      widgetName: kWidgetFlujoElectricoDeUnCampoVectorial),
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
                                  .flujoElectricoCampoVectorial,
                              widgetName:
                                  kWidgetFlujoElectricoDeUnCampoVectorial),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .flujoElectricoCampoVectorial,
                              widgetName:
                                  kWidgetFlujoElectricoDeUnCampoVectorial),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            TextoEcuaciones(
              AppLocalizations.of(context)!
                  .flujoCampoVectorialSuperficieFijaImaginaria,
            ),

            const SizedBox(height: 20.0),
            const ZoomImagePersonalizado(urlImagen: kUrlImagenFlujo1),
            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.flujoCampoVectorialSuperficieAreaA,
            ),

            const SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .flujoCampoVectorialRespectoSuperficie,
                ),
                const Latex(
                    formulaText:
                        r"\phi = V A \cos \theta = \vec{V} \cdot \vec{A}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenFlujoRespectoASuperficie),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .flujoCampoVectorialRespectoSuperficiesDiscretas,
                ),
                const Latex(
                    formulaText:
                        r"\phi = \sum_{i=1}^{n} V_i A_i \cos \theta_i = \sum_{i=1}^{n} \vec{V_i} \cdot \vec{A_i}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenFlujoRespectoASuperficies),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .flujoCampoVectorialSuperficieContinua,
                ),
                const Latex(
                    formulaText: r"\phi = \iint \vec{V} \cdot d\vec{A}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenFlujoRespectoASuperficieContinua),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.flujoCampoElectricoEntenderse,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\phi _E = \iint \vec{E} \cdot d\vec{A}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.flujoCampoElectricoNumeroLineas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.integralFuncionContinua,
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetFlujoElectricoDeUnCampoVectorial,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetFlujoElectricoDeUnCampoVectorial,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
