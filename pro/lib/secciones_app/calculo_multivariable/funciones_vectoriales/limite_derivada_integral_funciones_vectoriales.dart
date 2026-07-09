import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LimiteDerivadaIntegralFuncionesVectoriales extends StatefulWidget {
  const LimiteDerivadaIntegralFuncionesVectoriales({super.key});

  @override
  LimiteDerivadaIntegralFuncionesVectorialesState createState() =>
      LimiteDerivadaIntegralFuncionesVectorialesState();
}

class LimiteDerivadaIntegralFuncionesVectorialesState
    extends State<LimiteDerivadaIntegralFuncionesVectoriales> {
  bool seleccionadoMostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!
                    .limitesDerivadasIntegralesFuncionesVectoriales,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .limitesDerivadasIntegralesFuncionesVectoriales,
                      widgetName:
                          kWidgetLimiteDerivadaIntegralFuncionesVectoriales),
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
                                  .limitesDerivadasIntegralesFuncionesVectoriales,
                              widgetName:
                                  kWidgetLimiteDerivadaIntegralFuncionesVectoriales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .limitesDerivadasIntegralesFuncionesVectoriales,
                              widgetName:
                                  kWidgetLimiteDerivadaIntegralFuncionesVectoriales),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 40.0,
            ),
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.sea,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText: r"\vec{R}(t) = f(t)\hat{i} +g(t) \hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unaFuncionVectorial,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.limite,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\lim_{t \to t_1}\vec{R}(t) = \left[\lim_{t \to t_1} f(t)\right]\hat{i}+\left[\lim_{t \to t_1} g(t)\right]\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.derivada,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\vec{R}'(t) = \lim_{t \to 0}\frac{\vec{R}(t+\Delta t)-\vec{R}(t)}{\Delta t}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText: r"\vec{R}'(t) = f'(t)\hat{i}+g'(t)\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.integral,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\int_a^b \vec{R}(t)dt = \left[\int_a^b f(t)dt\right]\hat{i}+\left[\int_a^b g(t)dt\right]\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetLimiteDerivadaIntegralFuncionesVectoriales,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetLimiteDerivadaIntegralFuncionesVectoriales,
                ),
              ],
            ),

            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
