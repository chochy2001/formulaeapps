import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ParabolaConVerticeDiferenteDelOrigen extends StatefulWidget {
  const ParabolaConVerticeDiferenteDelOrigen({super.key});

  @override
  ParabolaConVerticeDiferenteDelOrigenState createState() =>
      ParabolaConVerticeDiferenteDelOrigenState();
}

class ParabolaConVerticeDiferenteDelOrigenState
    extends State<ParabolaConVerticeDiferenteDelOrigen> {
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
                      AppLocalizations.of(
                        context,
                      )!.parabolaConVerticeDiferenteDelOrigen,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.parabolaConVerticeDiferenteDelOrigen,
                          widgetName:
                              kWidgetParabolaConVerticeDiferenteDelOrigen,
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
                                  )!.parabolaConVerticeDiferenteDelOrigen,
                                  widgetName:
                                      kWidgetParabolaConVerticeDiferenteDelOrigen,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.parabolaConVerticeDiferenteDelOrigen,
                                  widgetName:
                                      kWidgetParabolaConVerticeDiferenteDelOrigen,
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
                        TextoEcuaciones(AppLocalizations.of(context)!.focoEn),
                        const Latex(
                          formulaText: r"(h+a,k)\space\space\space (h,k+a)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(y-k)^2 = 4a(x-h)\space\space\space\space (x-h)^2 = 4ac(y-k)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"x = h-a\space\space\space\space y = k-a",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"L(h+a,k+2a)\space\space\space\space L(h-2a,k+a)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"R(h+a,k-2a)\space\space\space\space R(h+2a,k+a)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\overline{LR} = |4a|\space\space\space\space \overline{LR}|4a|",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.focoEn),
                        const Latex(
                          formulaText: r"(h-a,k)\space\space\space (h,k-a)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(y-k)^2 = -4a(x-h)\space\space\space\space (x-h)^2 = -4a(y-k)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"x = h+a\space\space\space\space y=k+a",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"L(h-a,k+2a)\space\space\space\space L(h-2a,k-a)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"R(h-a,k-2a)\space\space\space\space R(h+2a,k-a)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\overline{LR} = |4a|\space\space\space\space \overline{LR}|4a|",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetParabolaConVerticeDiferenteDelOrigen,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetParabolaConVerticeDiferenteDelOrigen,
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
