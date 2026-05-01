import 'package:flutter/material.dart';

import '../../../../constantes/export_constantes.dart';
import '../../../../widgets_personalizados/export_widgets_personalizados.dart';

class PropiedadesNumerosComplejos extends StatefulWidget {
  const PropiedadesNumerosComplejos({Key? key}) : super(key: key);

  @override
  PropiedadesNumerosComplejosState createState() =>
      PropiedadesNumerosComplejosState();
}

class PropiedadesNumerosComplejosState
    extends State<PropiedadesNumerosComplejos> {
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
                  ChatGPTButton(
                    child: TituloPersonalizado(
                      AppLocalizations.of(context)!
                          .propiedadesDeLosNumerosComplejos,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .propiedadesDeLosNumerosComplejos,
                            widgetName: kWidgetPropiedadesNumerosComplejos),
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
                                        .propiedadesDeLosNumerosComplejos,
                                    widgetName:
                                        kWidgetPropiedadesNumerosComplejos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .propiedadesDeLosNumerosComplejos,
                                    widgetName:
                                        kWidgetPropiedadesNumerosComplejos),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.propiedades,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const Column(
                          children: [
                            Latex(formulaText: r"z+w=w+z"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"zw=wz"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"v+(w+z)=(v+w)+z"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"v(wz)=(vw)z"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"v(w+z)=vw+vz"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"(w+z)v=wz+zv"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"z+0=0+z=z"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"z\cdot 1=1\cdot z=z"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"z+(-z)=0"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"z\cdot z^{-1}=1"),
                            SizedBox(height: kEspacioEntreBotones),
                            SizedBox(
                              height: kEspacioEntreBotones,
                            ),
                          ],
                        ),
                        //Potencias de la unidad imaginaria
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .potenciasDeLaUnidadImaginaria,
                        ),
                        const SizedBox(height: 20),
                        const Column(
                          children: [
                            Latex(formulaText: r"i=\sqrt{-1}"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"i^3=-i"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"i^2=-1"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"i^4=1"),
                            SizedBox(height: kEspacioEntreBotones),
                            SizedBox(
                              height: kEspacioEntreBotones,
                            ),
                          ],
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetPropiedadesNumerosComplejos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetPropiedadesNumerosComplejos,
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
