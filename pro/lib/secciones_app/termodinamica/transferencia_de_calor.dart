import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class TransferenciaDeCalor extends StatefulWidget {
  const TransferenciaDeCalor({super.key});

  @override
  TransferenciaDeCalorState createState() => TransferenciaDeCalorState();
}

class TransferenciaDeCalorState extends State<TransferenciaDeCalor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChatGPTButton(
                  child: TituloPersonalizado(
                    AppLocalizations.of(context)!.transferenciaDeCalor,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.transferenciaDeCalor,
                        widgetName: kWidgetTransferenciaDeCalor,
                      ),
                    );
                    return IconButton(
                      icon: isFavorite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoritesNotifier.removeFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.transferenciaDeCalor,
                                widgetName: kWidgetTransferenciaDeCalor,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.transferenciaDeCalor,
                                widgetName: kWidgetTransferenciaDeCalor,
                              ),
                            );
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  Latex(formulaText: r"H = \frac{dQ}{dt}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"H = K A \frac{T_{H} - T_{C}}{L}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{T_{H} - T_{C}}{L}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"R = \frac{L}{K}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"H = A e \sigma T^{4}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetTransferenciaDeCalor),
            const DescargarPDF(url: kWidgetTransferenciaDeCalor),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
