import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class FuncionesDelAnguloMitad extends StatefulWidget {
  const FuncionesDelAnguloMitad({super.key});

  @override
  FuncionesDelAnguloMitadState createState() => FuncionesDelAnguloMitadState();
}

class FuncionesDelAnguloMitadState extends State<FuncionesDelAnguloMitad> {
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
                      AppLocalizations.of(context)!.funcionesDelAnguloMitad,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.funcionesDelAnguloMitad,
                          widgetName: kWidgetFuncionesDelAnguloMitad,
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
                                  )!.funcionesDelAnguloMitad,
                                  widgetName: kWidgetFuncionesDelAnguloMitad,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.funcionesDelAnguloMitad,
                                  widgetName: kWidgetFuncionesDelAnguloMitad,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"p = \frac{a+b+c}{2}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\sin\frac{\alpha}{2} = \sqrt{\frac{\sin(p-b)\sin(p-c)}{\sin b\sin c}}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cos\frac{\alpha}{2} = \sqrt{\frac{\sin p \sin(p-a)}{\sin b \sin c}}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\tan\frac{\alpha}{2} = \sqrt{\frac{\sin (p-b) \sin(p-c)}{\sin p \sin (p-a)}}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(url: kWidgetFuncionesDelAnguloMitad),
                      //Descargar PDF
                      DescargarPDF(url: kWidgetFuncionesDelAnguloMitad),
                    ],
                  ),

                  //Notas
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(color: kColorFondo, width: 8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a,b,c"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.ladosTrianguloEsferico,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\alpha,\beta,\gamma"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.angulosTrianguloEsferico,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
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
