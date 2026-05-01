import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class PropiedadesDesigualdad extends StatefulWidget {
  const PropiedadesDesigualdad({Key? key}) : super(key: key);

  @override
  PropiedadesDesigualdadState createState() => PropiedadesDesigualdadState();
}

class PropiedadesDesigualdadState extends State<PropiedadesDesigualdad> {
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
                      AppLocalizations.of(context)!.propiedadesDesigualdades,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .propiedadesDesigualdades,
                            widgetName: kWidgetPropiedadesDesigualdad),
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
                                        .propiedadesDesigualdades,
                                    widgetName: kWidgetPropiedadesDesigualdad),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .propiedadesDesigualdades,
                                    widgetName: kWidgetPropiedadesDesigualdad),
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
                        //Principal
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.desigualdadSumaResta,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a>b\rightarrow a+c>b+c\rightarrow a-c>b-c"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //sentido desigualdad
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .desigualdadMultiplicaDivide,
                        ),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a>b\rightarrow ac< bc \rightarrow\frac{a}{c}<\frac{b}{c}"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Exponentes
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.exponentes,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a>b\rightarrow a^c>b^c"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a^{(-c)} < b^{(-c)}"),

                        const SizedBox(
                          height: kEspacioEntreBotones,
                        ),
                        //Propiedad Transitiva
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.propiedadTransitiva,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a>b\space y \space b>c\rightarrow a>c"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a< b\space y \space b< c\rightarrow a< c"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Propiedad de la no negatividad
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .propiedadDeLaNoNegatividad,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a^2\geq 0"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Propiedad del recíproco
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.propiedadDelReciproco,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"a>0 \rightarrow \frac{1}{a}>0"),

                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetPropiedadesDesigualdad,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetPropiedadesDesigualdad,
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
