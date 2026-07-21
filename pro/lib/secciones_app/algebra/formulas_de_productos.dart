import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class FormulasDeProductos extends StatefulWidget {
  const FormulasDeProductos({super.key});

  @override
  FormulasDeProductosState createState() => FormulasDeProductosState();
}

class FormulasDeProductosState extends State<FormulasDeProductos> {
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
                      AppLocalizations.of(context)!.formulaProductos,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!.formulaProductos,
                          widgetName: kWidgetFormulasDeProductos,
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
                                  title: AppLocalizations.of(
                                    context,
                                  )!.formulaProductos,
                                  widgetName: kWidgetFormulasDeProductos,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.formulaProductos,
                                  widgetName: kWidgetFormulasDeProductos,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width),
                        const Latex(
                          formulaText: r"(a+b)^2=a^2+2ab+b^2=(a-b)^2+4ab",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"(a-b)^2=a^2-2ab+b^2=(a+b)^2-4ab",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(a+b)^3=a^3+3a^2+3ab^2+b^3 =(a+b)(a^2+2ab+b^2)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(a+b)^2-(a-b)^2=4ab"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(a+b)(a+c)=a^2+ab+ac+bc"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(a+b)(a-b)=a^2-b^2"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"2(a^2+b^2)=(a+b)^2+(a-b)^2"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"(a+b+c)^2=a^2+b^2+c^2+2ab+2bc+2ca",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"(a+b-c)^2=a^2+b^2+c^2+2ab-2bc-2ca",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"(a-b-c)^2=a^2+b^2+c^2-2ab+2bc-2ca",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetFormulasDeProductos),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetFormulasDeProductos),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
