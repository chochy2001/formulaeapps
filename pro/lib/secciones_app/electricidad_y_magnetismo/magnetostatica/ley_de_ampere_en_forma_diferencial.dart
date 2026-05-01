import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyDeAmpereEnFormaDiferencial extends StatefulWidget {
  const LeyDeAmpereEnFormaDiferencial({Key? key}) : super(key: key);

  @override
  State<LeyDeAmpereEnFormaDiferencial> createState() =>
      _LeyDeAmpereEnFormaDiferencialState();
}

class _LeyDeAmpereEnFormaDiferencialState
    extends State<LeyDeAmpereEnFormaDiferencial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.leyDeAmpereEnFormaDiferencial,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .leyDeAmpereEnFormaDiferencial,
                      widgetName: kWidgetLeyDeAmpereEnFormaDiferencial),
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
                                  .leyDeAmpereEnFormaDiferencial,
                              widgetName: kWidgetLeyDeAmpereEnFormaDiferencial),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyDeAmpereEnFormaDiferencial,
                              widgetName: kWidgetLeyDeAmpereEnFormaDiferencial),
                        );
                      }
                    });
                  },
                );
              },
            ),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .definicionDeCorrienteElectrica,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"i= \iint \vec{J}\cdot d\vec{A}"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyDeAmperePalabra,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText: r"\oint \vec{B}\cdot d\vec{l} = \mu _0 i"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\oint \vec{B} \cdot d \vec{l} = \mu _0 \iint \vec{J} \cdot d\vec{A}"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.deAcuerdoConElTeoremaDeStokes,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\iint(\nabla \times \vec{F})\cdot d\vec{S} = \oint \vec{F}\cdot d\vec{l}"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\iint(\nabla \times \vec{B})\cdot d\vec{A} = \mu_0 \iint \vec{J}\cdot d\vec{A}"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyDeAmpereEnFormaDiferencial,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText: r"\nabla \times \vec{B} = \mu_0 \vec{J}"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetLeyDeAmpereEnFormaDiferencial,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetLeyDeAmpereEnFormaDiferencial,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
