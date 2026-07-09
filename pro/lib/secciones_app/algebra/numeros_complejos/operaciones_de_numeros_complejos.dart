import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class OperacionesNumerosComplejos extends StatefulWidget {
  const OperacionesNumerosComplejos({super.key});

  @override
  OperacionesNumerosComplejosState createState() =>
      OperacionesNumerosComplejosState();
}

class OperacionesNumerosComplejosState
    extends State<OperacionesNumerosComplejos> {
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
                          .operacionesDeNumerosComplejos,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .operacionesDeNumerosComplejos,
                            widgetName: kWidgetOperacionesDeNumerosComplejos),
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
                                        .operacionesDeNumerosComplejos,
                                    widgetName:
                                        kWidgetOperacionesDeNumerosComplejos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .operacionesDeNumerosComplejos,
                                    widgetName:
                                        kWidgetOperacionesDeNumerosComplejos),
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
                  Column(
                    children: [
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.enFormaBinomica,
                      ),
                      const SizedBox(
                        height: kEspacioEntreBotones,
                      ),
                      ZoomPersonalizado(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                              ),
                              //Adición
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.adicion,
                              ),
                              const Column(
                                children: [
                                  Latex(
                                      formulaText:
                                          r"(a+bi)+(c+di)=(a+c)+(b+d)i"),
                                  SizedBox(height: kEspacioEntreBotones),
                                ],
                              ),

                              //Sustracción
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.sustraccion,
                              ),
                              const Column(
                                children: [
                                  Latex(
                                      formulaText:
                                          r"(a+bi)-(c+di)=(a-c)+(b-d)i"),
                                  SizedBox(height: kEspacioEntreBotones),
                                ],
                              ),

                              //Multiplicación
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.multiplicacion,
                              ),
                              const Column(
                                children: [
                                  Latex(
                                      formulaText:
                                          r"(a+bi)(c+di)=ac+adi+bci+bdi^2=(ac-bd)+(ad+bc)i"),
                                  SizedBox(height: kEspacioEntreBotones),
                                ],
                              ),

                              //División
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.division,
                              ),
                              const Column(
                                children: [
                                  Latex(
                                      formulaText:
                                          r"\frac{(a+bi)}{(c+di)}=\frac{(a+bi)(c-di)}{(c+di)(c-di)}=\frac{ac-adi+bci-bdi^2}{c^2-d^2i^2}=\frac{(ac+bd)+(bc-ad)i}{c^2+d^2}"),
                                  SizedBox(
                                    height: kEspacioEntreBotones,
                                  ),
                                ],
                              ),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.enFormaPolar,
                              ),
                              const SizedBox(
                                height: kEspacioEntreBotones,
                              ),
                              //Multiplicación
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.multiplicacion,
                              ),
                              const Latex(
                                  formulaText:
                                      r"z_\alpha \cdot z_\alpha ' = zz_{\alpha +' \alpha}"),
                              const SizedBox(height: kEspacioEntreBotones),

                              //División
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.division,
                              ),
                              const Latex(
                                  formulaText:
                                      r"\frac{z_\alpha}{z_\alpha '}=\frac{z}{z_{\alpha -'\alpha}}"),
                              const SizedBox(height: kEspacioEntreBotones),

                              //Potencia
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.potencia,
                              ),
                              const Latex(
                                  formulaText:
                                      r"(z_\alpha)^n=z_{\alpha\cdot n}^{\space\thinspace n}"),
                              const SizedBox(height: kEspacioEntreBotones),

                              //Raices

                              TextoEcuaciones(
                                AppLocalizations.of(context)!.raices,
                              ),
                              const Latex(formulaText: r"\sqrt[n]{R_\beta}"),
                              const SizedBox(height: kEspacioEntreBotones),

                              //Módulo de las raíces
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.moduloDeLasRaices,
                              ),
                              const Latex(formulaText: r"r=\sqrt[n]{R}"),
                              const SizedBox(height: kEspacioEntreBotones),

                              //Argumentos de las raíces
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .argumentosDeLasRaices,
                              ),
                              const Latex(
                                  formulaText:
                                      r"\alpha = \frac{\beta +360^\circ \cdot k}{n}"),
                              const SizedBox(height: kEspacioEntreBotones),

                              TextoEcuaciones(
                                AppLocalizations.of(context)!.desdeKHastaN,
                              ),
                              const SizedBox(
                                height: kEspacioEntreBotones,
                              ),
                            ]),
                      ),
                      //Boton para acceder al formulario en PDF
                      const VerPDF(
                        url: kWidgetOperacionesDeNumerosComplejos,
                      ),
                      //Descargar PDF
                      const DescargarPDF(
                        url: kWidgetOperacionesDeNumerosComplejos,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kColorBotones,
                          border: Border.all(
                            color: kColorFondo,
                            width: 8,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const Notas(),
                            const SizedBox(height: kEspacioEntreBotones),
                            const Latex(formulaText: r"z,R"),
                            TextoEcuaciones(
                              AppLocalizations.of(context)!.modulo,
                            ),
                            const SizedBox(height: kEspacioEntreBotones),
                            const Latex(formulaText: r"\theta,\beta"),
                            TextoEcuaciones(
                              AppLocalizations.of(context)!.argumento,
                            ),
                            const SizedBox(height: kEspacioEntreBotones),
                            const Latex(formulaText: r"n"),
                            TextoEcuaciones(
                              AppLocalizations.of(context)!.indiceDeLaRaiz,
                            ),
                            const SizedBox(height: kEspacioEntreBotones),
                            const CapdesisLatex(),
                            const SizedBox(height: kEspacioEntreBotones),
                          ],
                        ),
                      ),
                    ],
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
