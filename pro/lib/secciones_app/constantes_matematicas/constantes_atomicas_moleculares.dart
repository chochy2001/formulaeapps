import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ConstantesAtomicasMoleculares extends StatefulWidget {
  const ConstantesAtomicasMoleculares({super.key});

  @override
  ConstantesAtomicasMolecularesState createState() =>
      ConstantesAtomicasMolecularesState();
}

class ConstantesAtomicasMolecularesState
    extends State<ConstantesAtomicasMoleculares> {
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
                    AppLocalizations.of(context)!.constantesAtomicasMoleculares,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.constantesAtomicasMoleculares,
                        widgetName: kWidgetConstantesAtomicasMoleculares,
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
                                )!.constantesAtomicasMoleculares,
                                widgetName:
                                    kWidgetConstantesAtomicasMoleculares,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.constantesAtomicasMoleculares,
                                widgetName:
                                    kWidgetConstantesAtomicasMoleculares,
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
                  Latex(
                    formulaText: r"m_e = 9.11 \times 10^{-31}\ \mathrm{kg}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"m_p = 1.673 \times 10^{-27}\ \mathrm{kg}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"a_0 = 5.29\,177 \times 10^{-11}\ \mathrm{m}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V_m = 0.0224141\ \mathrm{m^3/mol}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"N_A h = 3.990\,312 \times 10^{-10}\ \mathrm{J\cdot s\cdot mol^{-1}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetConstantesAtomicasMoleculares),
            const DescargarPDF(url: kWidgetConstantesAtomicasMoleculares),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
