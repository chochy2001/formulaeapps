import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ConjuncionMatematicasDiscretas extends StatefulWidget {
  const ConjuncionMatematicasDiscretas({Key? key}) : super(key: key);

  @override
  ConjuncionMatematicasDiscretasState createState() =>
      ConjuncionMatematicasDiscretasState();
}

class ConjuncionMatematicasDiscretasState
    extends State<ConjuncionMatematicasDiscretas> {
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
                      AppLocalizations.of(context)!.conjuncion,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.conjuncion,
                            widgetName: kWidgetConjuncion),
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
                                        .conjuncion,
                                    widgetName: kWidgetConjuncion),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .conjuncion,
                                    widgetName: kWidgetConjuncion),
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conector,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathsf{y}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.simbolos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathsf{ p\land q}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\mathsf{p \space\&\&\space q}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.tablaVerdad,
                  ),
                  ZoomImagePersonalizado(
                      urlImagen: getImageUrlById(context, kImagenConjuncion) ??
                          kUrlImagenConjuncion),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetConjuncion,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetConjuncion,
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
