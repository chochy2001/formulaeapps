import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyesDelAlgebraDeBoole extends StatefulWidget {
  const LeyesDelAlgebraDeBoole({super.key});

  @override
  LeyesDelAlgebraDeBooleState createState() => LeyesDelAlgebraDeBooleState();
}

class LeyesDelAlgebraDeBooleState extends State<LeyesDelAlgebraDeBoole> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                      AppLocalizations.of(context)!.leyesDelAlgebraDeBoole,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .leyesDelAlgebraDeBoole,
                            widgetName: kWidgetLeyesDelAlgebraDeBoole),
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
                                        .leyesDelAlgebraDeBoole,
                                    widgetName: kWidgetLeyesDelAlgebraDeBoole),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .leyesDelAlgebraDeBoole,
                                    widgetName: kWidgetLeyesDelAlgebraDeBoole),
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
                  // On wide screens the ten Boolean laws read as a responsive
                  // 2-column grid; on phones they stay a single column. Each
                  // law block stays intact inside its own cell.
                  ZoomPersonalizado(
                    child: ResponsiveFormulaColumns(
                      children: [
                        _leyGrupo(loc.dobleComplemento, const [
                          Latex(formulaText: r"(x')' = x"),
                        ]),
                        _leyGrupo(loc.deMorgan, const [
                          Latex(formulaText: r"(x+y)'=x'\times y'"),
                          SizedBox(height: kEspacioEntreBotones),
                          Latex(formulaText: r"(x\times y)'=x'+y'"),
                        ]),
                        _leyGrupo(loc.conmutativa, const [
                          Latex(formulaText: r"x+y=y+x"),
                          SizedBox(height: kEspacioEntreBotones),
                          Latex(formulaText: r"x\times y = y\times x"),
                        ]),
                        _leyGrupo(loc.asociativa, const [
                          Latex(formulaText: r"(x+y)+z=x+(y+z)"),
                          SizedBox(height: kEspacioEntreBotones),
                          Latex(
                              formulaText:
                                  r"(x\times y)\times z=x\times (y\times z)"),
                        ]),
                        _leyGrupo(loc.distributiva, const [
                          Latex(
                              formulaText:
                                  r"x\times (y+z) = (x\times y)+(x \times z)"),
                          SizedBox(height: kEspacioEntreBotones),
                          Latex(
                              formulaText:
                                  r"x+ (y\times z) = (x + y)\times (x + z)"),
                        ]),
                        _leyGrupo(loc.idempotencia, const [
                          Latex(formulaText: r"x+ x = x"),
                          SizedBox(height: kEspacioEntreBotones),
                          Latex(formulaText: r"x \times x = x"),
                        ]),
                        _leyGrupo(loc.neutros, const [
                          Latex(formulaText: r"x+0=x"),
                          SizedBox(height: kEspacioEntreBotones),
                          Latex(formulaText: r"x\times 1= x"),
                        ]),
                        _leyGrupo(loc.dominacion, const [
                          Latex(formulaText: r"x+1=1"),
                          SizedBox(height: kEspacioEntreBotones),
                          Latex(formulaText: r"x\times 0 = 0"),
                        ]),
                        _leyGrupo(loc.inversos, const [
                          Latex(formulaText: r"x+x' = 1"),
                          SizedBox(height: kEspacioEntreBotones),
                          Latex(formulaText: r"x\times x' = 0"),
                        ]),
                        _leyGrupo(loc.absorcion, const [
                          Latex(formulaText: r"x+(x\times y)= x"),
                          SizedBox(height: kEspacioEntreBotones),
                          Latex(formulaText: r"x\times(x+y)=x"),
                        ]),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetLeyesDelAlgebraDeBoole,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetLeyesDelAlgebraDeBoole,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// A single Boolean-law block: its label followed by its formula(s). Kept
  /// intact so a law is never split across responsive columns.
  Widget _leyGrupo(String titulo, List<Widget> formulas) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: kEspacioEntreBotones),
        TextoEcuaciones(titulo),
        const SizedBox(height: kEspacioEntreBotones),
        ...formulas,
        const SizedBox(height: kEspacioEntreBotones),
      ],
    );
  }
}
