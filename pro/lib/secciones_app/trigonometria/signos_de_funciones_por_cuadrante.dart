import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class SignosDeFuncionesPorCuadrante extends StatefulWidget {
  const SignosDeFuncionesPorCuadrante({super.key});

  @override
  SignosDeFuncionesPorCuadranteState createState() =>
      SignosDeFuncionesPorCuadranteState();
}

class SignosDeFuncionesPorCuadranteState
    extends State<SignosDeFuncionesPorCuadrante> {
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
                    AppLocalizations.of(context)!.signosDeFuncionesPorCuadrante,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.signosDeFuncionesPorCuadrante,
                        widgetName: kWidgetSignosDeFuncionesPorCuadrante,
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
                                )!.signosDeFuncionesPorCuadrante,
                                widgetName:
                                    kWidgetSignosDeFuncionesPorCuadrante,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.signosDeFuncionesPorCuadrante,
                                widgetName:
                                    kWidgetSignosDeFuncionesPorCuadrante,
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
                    formulaText:
                        r"\begin{array}{c|ccc} \text{Cuadrante} & \operatorname{sen} & \cos & \operatorname{tg} \\ \hline \text{I} & + & + & + \\ \text{II} & + & - & - \\ \text{III} & - & - & + \\ \text{IV} & - & + & - \end{array}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"(A,\; B):\quad \operatorname{sen},\,\cos,\,\operatorname{tg},\,\operatorname{ctg},\,\sec,\,\csc \; > 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"(-A,\; B):\quad \operatorname{sen},\,\csc > 0;\quad \text{las demas} < 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"(-A,\; -B):\quad \operatorname{tg},\,\operatorname{ctg} > 0;\quad \text{las demas} < 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"(A,\; -B):\quad \cos,\,\sec > 0;\quad \text{las demas} < 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetSignosDeFuncionesPorCuadrante),
            const DescargarPDF(url: kWidgetSignosDeFuncionesPorCuadrante),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
