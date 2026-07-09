import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class FormulaGeneral extends StatefulWidget {
  const FormulaGeneral({super.key});

  @override
  FormulaGeneralState createState() => FormulaGeneralState();
}

class FormulaGeneralState extends State<FormulaGeneral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.formulaGeneral,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.formulaGeneral,
                      widgetName: kWidgetFormulaGeneral),
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
                              title:
                                  AppLocalizations.of(context)!.formulaGeneral,
                              widgetName: kWidgetFormulaGeneral),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.formulaGeneral,
                              widgetName: kWidgetFormulaGeneral),
                        );
                      }
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 30),
            const SizedBox(
              height: 30,
            ),
            ZoomPersonalizado(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  const Latex(
                      formulaText: r"x = \frac {-b \pm \sqrt {b^2 - 4ac}}{2a}"),
                  const SizedBox(
                    height: 30,
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.caracteristicas,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.si,
                  ),
                  const Latex(formulaText: r"b^2-4ac=0"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.lasRaicesSonRealesEIguales,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.si,
                  ),
                  const Latex(formulaText: r"b^2-4ac<0"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.lasRaicesNoSonReales,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.si,
                  ),
                  const Latex(formulaText: r"b^2-4ac>0"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .lasRaicesSonRealesYDeDiferenteValor,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetFormulaGeneral,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetFormulaGeneral,
            ),
          ],
        ),
      ),
    );
  }
}
