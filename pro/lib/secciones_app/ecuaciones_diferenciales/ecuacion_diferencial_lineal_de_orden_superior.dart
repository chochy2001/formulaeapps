import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionDiferencialLinealDeOrdenSuperior extends StatefulWidget {
  const EcuacionDiferencialLinealDeOrdenSuperior({super.key});

  @override
  EcuacionDiferencialLinealDeOrdenSuperiorState createState() =>
      EcuacionDiferencialLinealDeOrdenSuperiorState();
}

class EcuacionDiferencialLinealDeOrdenSuperiorState
    extends State<EcuacionDiferencialLinealDeOrdenSuperior> {
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
                      AppLocalizations.of(
                        context,
                      )!.ecuacionDiferencialLinealOrdenSuperior,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.ecuacionDiferencialLinealOrdenSuperior,
                          widgetName:
                              kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
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
                                  )!.ecuacionDiferencialLinealOrdenSuperior,
                                  widgetName:
                                      kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.ecuacionDiferencialLinealOrdenSuperior,
                                  widgetName:
                                      kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
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
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"a_n(x)y^n+a_{n-1}(x)y^{n-1}+\cdots+a_0(x)y= g(x)",
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.variacionDeParametros,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionHomogenea,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(
                          formulaText:
                              r"a_ny^n+a_{n-1}(x)y^{n-1}+\cdots + a_0(x)y = 0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"y_h = c_1u_1+c_2u_2 + \cdots + c_nu_n = 0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionParticular,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(
                          formulaText:
                              r"y_p = u_1v_1 + u_2v_2 + \cdots + u_nv_n",
                        ),
                        const SizedBox(height: 5),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.seResuelveElSistemaDeEcuaciones,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(formulaText: r"y_g = y_h+y_p"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
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
