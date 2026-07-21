import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class FuncionImpulsoUnitario extends StatefulWidget {
  const FuncionImpulsoUnitario({super.key});

  @override
  FuncionImpulsoUnitarioState createState() => FuncionImpulsoUnitarioState();
}

class FuncionImpulsoUnitarioState extends State<FuncionImpulsoUnitario> {
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
                      AppLocalizations.of(context)!.funcionImpulsoUnitario,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.funcionImpulsoUnitario,
                          widgetName: kWidgetFuncionImpulsoUnitario,
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
                                  )!.funcionImpulsoUnitario,
                                  widgetName: kWidgetFuncionImpulsoUnitario,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.funcionImpulsoUnitario,
                                  widgetName: kWidgetFuncionImpulsoUnitario,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.funcionImpulsoUnitario,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\delta(t) = \left\{\begin{aligned}0 \space\space\space\space & \mathsf{Si\space}a\\\infty \space\space\space\space & \mathsf{Si\space}b\end{aligned}\right.",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\int_{-\infty}^{\infty}\delta(t)dt = 1",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\int_{-\infty}^{\infty}\delta(t)\phi (t)dt = \phi(0)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a\rightarrow t\not = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"b\rightarrow t = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.serieTrenPeriodicoImpulsosUnitarios,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\sum_{n=-\infty}^{\infty}\delta(t-nT) = \frac{1}{T}+\frac{2}{T}\sum_{n=1}^{\infty}\cos(n\omega_0t)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetFuncionImpulsoUnitario),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetFuncionImpulsoUnitario),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
