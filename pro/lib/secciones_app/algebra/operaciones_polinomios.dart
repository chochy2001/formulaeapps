import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class OperacionesConPolinomios extends StatefulWidget {
  const OperacionesConPolinomios({Key? key}) : super(key: key);

  @override
  OperacionesConPolinomiosState createState() =>
      OperacionesConPolinomiosState();
}

class OperacionesConPolinomiosState extends State<OperacionesConPolinomios> {
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
                      AppLocalizations.of(context)!.operacionesPolinomios,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .operacionesPolinomios,
                            widgetName: kWidgetOperacionesPolinomios),
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
                                        .operacionesPolinomios,
                                    widgetName: kWidgetOperacionesPolinomios),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .operacionesPolinomios,
                                    widgetName: kWidgetOperacionesPolinomios),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        //Suma
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.adicion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a+b"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Resta
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sustraccion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a+(-b)=a-b"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Multiplicacion
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.multiplicacion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a(b+c+...+z)=ab+ac+...+az"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(a+b)(c+d)=ac+ad+bc+bd"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //División
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.division,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\frac{a}{b}"),

                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetOperacionesPolinomios,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetOperacionesPolinomios,
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
