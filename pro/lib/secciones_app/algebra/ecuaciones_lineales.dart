import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionesLineales extends StatefulWidget {
  const EcuacionesLineales({super.key});

  @override
  EcuacionesLinealesState createState() => EcuacionesLinealesState();
}

class EcuacionesLinealesState extends State<EcuacionesLineales> {
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
                      AppLocalizations.of(context)!.ecuacionesLineales,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.ecuacionesLineales,
                          widgetName: kWidgetEcuacionesLineales,
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
                                  )!.ecuacionesLineales,
                                  widgetName: kWidgetEcuacionesLineales,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.ecuacionesLineales,
                                  widgetName: kWidgetEcuacionesLineales,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.propiedadAditivaDeLaIgualdad,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a=b\rightarrow a+c=b+c"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.propiedadMultiplicativaDeLaIgualdad,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a=b\rightarrow ac=bc"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.ecuacionesConValorAbsoluto,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Column(
                          children: [
                            Latex(formulaText: r"|ax+b|=c"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"ax+b=c"),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(formulaText: r"ax+b=-c"),
                            SizedBox(height: kEspacioEntreBotones),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetEcuacionesLineales),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetEcuacionesLineales),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
