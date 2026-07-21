import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class AreaBajoLaCurva extends StatefulWidget {
  const AreaBajoLaCurva({super.key});

  @override
  AreaBajoLaCurvaState createState() => AreaBajoLaCurvaState();
}

class AreaBajoLaCurvaState extends State<AreaBajoLaCurva> {
  bool seleccionadoMostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.areaBajoCurva,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.areaBajoCurva,
                    widgetName: kWidgetAreaBajoLaCurva,
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
                            title: AppLocalizations.of(context)!.areaBajoCurva,
                            widgetName: kWidgetAreaBajoLaCurva,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.areaBajoCurva,
                            widgetName: kWidgetAreaBajoLaCurva,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(
                      context,
                    )!.silacurvaestadadaporlasecuacionesparametricas,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"x=f(t),\space y=g(t)"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\alpha \leq t \leq \beta"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.paraYIgualFdeX),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"A=\int_{a}^b F(x)dx = \int_{a}^b y\thinspace dx",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"\left| A= \int_{\alpha}^\beta g(t) f'(t) \thinspace dt\right|",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.paraXIgualGdeY),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"A=\int_{a}^b G(y)dy = \int_{a}^b x\thinspace dy",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"\left| A= \int_{\alpha}^\beta f(t) g'(t) \thinspace dt\right|",
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetAreaBajoLaCurva),
                //Descargar PDF
                DescargarPDF(url: kWidgetAreaBajoLaCurva),
              ],
            ),

            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
