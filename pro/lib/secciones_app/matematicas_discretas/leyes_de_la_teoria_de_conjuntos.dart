import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyesDeLaTeoriaDeConjuntos extends StatefulWidget {
  const LeyesDeLaTeoriaDeConjuntos({super.key});

  @override
  LeyesDeLaTeoriaDeConjuntosState createState() =>
      LeyesDeLaTeoriaDeConjuntosState();
}

class LeyesDeLaTeoriaDeConjuntosState
    extends State<LeyesDeLaTeoriaDeConjuntos> {
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
                      AppLocalizations.of(context)!.leyesDeLaTeoriaDeConjuntos,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .leyesDeLaTeoriaDeConjuntos,
                            widgetName: kWidgetLeyesDeLaTeoriaDeConjuntos),
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
                                        .leyesDeLaTeoriaDeConjuntos,
                                    widgetName:
                                        kWidgetLeyesDeLaTeoriaDeConjuntos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .leyesDeLaTeoriaDeConjuntos,
                                    widgetName:
                                        kWidgetLeyesDeLaTeoriaDeConjuntos),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"X"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.esConjuntoY,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A,B,C"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sonSubconjuntosDe,
                        ),
                        const Latex(formulaText: r"X"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.dobleComplemento,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\overline{\overline{A}} = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.deMorgan,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{A\cup B}\equiv \overline{A}\cap\overline{B}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{A\cap B}\equiv \overline{A}\cup\overline{B}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conmutativa,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cup B = B\cup A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cap B = B\cap A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.asociativa,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"(A \cup B)\cup C = A\cup (B\cup C)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"(A \cap B)\cap C = A\cap (B\cap C)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.distributiva,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A\cap (B\cup C) = (A\cap B)\cup(A\cap C)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A\cup (B\cap C) = (A\cup B)\cap (A\cup C)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.idempotencia,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cup A = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cap A = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.neutros,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cup \varnothing = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cap X = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.absorbentes,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cup X = X"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"A \cap \varnothing = \varnothing"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.inversos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cup \overline{A} = X"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"A\cap \overline{A} = \varnothing"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.absorcion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cup (A\cap B) = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cap (A\cup B) = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetLeyesDeLaTeoriaDeConjuntos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetLeyesDeLaTeoriaDeConjuntos,
                  ),
                  //Notas
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
                        const Latex(formulaText: r"\cup"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.unionConjuntos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\cap"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.interseccionConjuntos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\varnothing "),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conjuntoVacio,
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
