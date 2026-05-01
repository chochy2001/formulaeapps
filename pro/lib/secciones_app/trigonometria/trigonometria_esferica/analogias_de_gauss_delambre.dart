import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class AnalogiasDeGaussDelambre extends StatefulWidget {
  const AnalogiasDeGaussDelambre({Key? key}) : super(key: key);

  @override
  AnalogiasDeGaussDelambreState createState() =>
      AnalogiasDeGaussDelambreState();
}

class AnalogiasDeGaussDelambreState extends State<AnalogiasDeGaussDelambre> {
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
                      AppLocalizations.of(context)!.analogiasDeGaussDelambre,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .analogiasDeGaussDelambre,
                            widgetName: kWidgetAnalogiasDeGaussDelambre),
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
                                        .analogiasDeGaussDelambre,
                                    widgetName:
                                        kWidgetAnalogiasDeGaussDelambre),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .analogiasDeGaussDelambre,
                                    widgetName:
                                        kWidgetAnalogiasDeGaussDelambre),
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
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\frac{\sin\frac{\alpha+\beta}{2}}{\cos\frac{\gamma}{2}} = \frac{\cos\frac{a-b}{2}}{\cos{\frac{c}{2}}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\frac{\cos\frac{\alpha+\beta}{2}}{\sin\frac{\gamma}{2}} = \frac{\cos\frac{a+b}{2}}{\cos{\frac{c}{2}}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\frac{\sin\frac{\gamma+\alpha}{2}}{\cos\frac{\beta}{2}} = \frac{\cos\frac{c-a}{2}}{\cos{\frac{b}{2}}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\frac{\cos\frac{\gamma+\alpha}{2}}{\sin\frac{\beta}{2}} = \frac{\cos\frac{c+a}{2}}{\cos{\frac{b}{2}}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\frac{\sin\frac{\alpha-\beta}{2}}{\cos\frac{\gamma}{2}} = \frac{\sin\frac{a-b}{2}}{\sin{\frac{c}{2}}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\frac{\cos\frac{\alpha-\beta}{2}}{\sin\frac{\gamma}{2}} = \frac{\sin\frac{a+b}{2}}{\sin{\frac{c}{2}}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\frac{\sin\frac{\gamma-\alpha}{2}}{\cos\frac{\beta}{2}} = \frac{\sin\frac{c-a}{2}}{\sin{\frac{b}{2}}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\frac{\cos\frac{\gamma-\alpha}{2}}{\sin\frac{\beta}{2}} = \frac{\sin\frac{c+a}{2}}{\sin{\frac{b}{2}}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(
                        url: kWidgetAnalogiasDeGaussDelambre,
                      ),
                      //Descargar PDF
                      DescargarPDF(
                        url: kWidgetAnalogiasDeGaussDelambre,
                      ),
                    ],
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
                        const Latex(formulaText: r"a,b,c"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.ladosTrianguloEsferico,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\alpha,\beta,\gamma"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .angulosTrianguloEsferico,
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
