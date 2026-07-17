import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CantidadDeMovimientoEImpulso extends StatefulWidget {
  const CantidadDeMovimientoEImpulso({super.key});

  @override
  CantidadDeMovimientoEImpulsoState createState() => CantidadDeMovimientoEImpulsoState();
}

class CantidadDeMovimientoEImpulsoState extends State<CantidadDeMovimientoEImpulso> {
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
                    AppLocalizations.of(context)!.cantidadDeMovimientoEImpulso,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.cantidadDeMovimientoEImpulso,
                        widgetName: kWidgetCantidadDeMovimientoEImpulso,
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
                                title: AppLocalizations.of(context)!.cantidadDeMovimientoEImpulso,
                                widgetName: kWidgetCantidadDeMovimientoEImpulso,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.cantidadDeMovimientoEImpulso,
                                widgetName: kWidgetCantidadDeMovimientoEImpulso,
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
                  Latex(formulaText: r"P = m\,v"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F\,t = m\,V_{f} - m\,V_{0}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F = m\left(\frac{V_{f} - V_{0}}{t}\right)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F\,t = m\,V"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"m_1 u_1 + m_2 u_2 = m_1 v_1 + m_2 v_2"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCantidadDeMovimientoEImpulso),
            const DescargarPDF(url: kWidgetCantidadDeMovimientoEImpulso),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
