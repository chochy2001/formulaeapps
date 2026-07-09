import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class PropiedadesDeLosVectores extends StatefulWidget {
  const PropiedadesDeLosVectores({super.key});

  @override
  PropiedadesDeLosVectoresState createState() =>
      PropiedadesDeLosVectoresState();
}

class PropiedadesDeLosVectoresState extends State<PropiedadesDeLosVectores> {
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
                      AppLocalizations.of(context)!.propiedadesDeLosVectores,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .propiedadesDeLosVectores,
                            widgetName: kWidgetPropiedadesDeLosVectores),
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
                                        .propiedadesDeLosVectores,
                                    widgetName:
                                        kWidgetPropiedadesDeLosVectores),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .propiedadesDeLosVectores,
                                    widgetName:
                                        kWidgetPropiedadesDeLosVectores),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sean,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\mathrm{u},\thinspace  \mathrm{v},\thinspace \mathrm{w}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.vectores,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"a,\thinspace b"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.escalares,
                        ),
                        const SizedBox(height: 50),
                        const Latex(
                            formulaText:
                                r"\mathrm{u}+\mathrm{v} = \mathrm{v}+\mathrm{u}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"(\mathrm{u}+\mathrm{v})+\mathrm{w}=\mathrm{u}+(\mathrm{v}+\mathrm{w})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathrm{u}+0 = \mathrm{u}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathrm{u}+(-\mathrm{u})=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"0\mathrm{u}=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"1\mathrm{u}=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"a(b\mathrm{u})=(ab)\mathrm{u}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a(\mathrm{u}+\mathrm{v})=a\mathrm{u}+a\mathrm{v}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"(a+b)\mathrm{u}=a\mathrm{u}+b\mathrm{v}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetPropiedadesDeLosVectores,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetPropiedadesDeLosVectores,
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
