import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class AnualidadAnticipadaSimpleYCierta extends StatefulWidget {
  const AnualidadAnticipadaSimpleYCierta({Key? key}) : super(key: key);

  @override
  AnualidadAnticipadaSimpleYCiertaState createState() =>
      AnualidadAnticipadaSimpleYCiertaState();
}

class AnualidadAnticipadaSimpleYCiertaState
    extends State<AnualidadAnticipadaSimpleYCierta> {
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
                      AppLocalizations.of(context)!
                          .anualidadAnticipadaSimpleYCierta,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .anualidadAnticipadaSimpleYCierta,
                            widgetName:
                                kWidgetAnualidadAnticipadaSimpleyCierta),
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
                                        .anualidadAnticipadaSimpleYCierta,
                                    widgetName:
                                        kWidgetAnualidadAnticipadaSimpleyCierta),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .anualidadAnticipadaSimpleYCierta,
                                    widgetName:
                                        kWidgetAnualidadAnticipadaSimpleyCierta),
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
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.montoAcumulado,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"M=R\left(1+\frac{i}{p}\right)\left[\frac{\left(1+\frac{i}{p}\right)^{np}-1}{\left(\frac{i}{p}\right)}\right]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorPresente,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"C = R\left(1+\frac{i}{p}\right)\left[\frac{1-\left(1+\frac{i}{p}\right)^{-np}}{\left(\frac{i}{p}\right)}\right]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetAnualidadAnticipadaSimpleyCierta,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetAnualidadAnticipadaSimpleyCierta,
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
                        ZoomPersonalizado(
                          child: Column(
                            children: [
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"C"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.valorPresente,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"i"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.tasaInteresAnual,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"M"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.montoAcumulado,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"n"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.periodoAnos,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"p"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .frecuenciaCapitalizacion,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"R"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.renta,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r""),
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
          ],
        ),
      ),
    );
  }
}
