import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class OperadorGradiente extends StatefulWidget {
  const OperadorGradiente({super.key});

  @override
  State<OperadorGradiente> createState() => _OperadorGradienteState();
}

class _OperadorGradienteState extends State<OperadorGradiente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.operadorGradiente,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.operadorGradiente,
                    widgetName: kWidgetOperadorGradiente,
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
                            )!.operadorGradiente,
                            widgetName: kWidgetOperadorGradiente,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.operadorGradiente,
                            widgetName: kWidgetOperadorGradiente,
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
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.operadorGradienteFuncion,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"\vec{\nabla} \varphi = \left( \frac{\partial \varphi}{\partial x},\frac{\partial \varphi}{\partial y},\frac{\partial \varphi}{\partial z}\right)",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(
                      context,
                    )!.operadorGradienteDerivadasDireccionales,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(
                      context,
                    )!.operadorGradienteDiferencialTotal,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"d\varphi = \vec{\nabla}\varphi \cdot d\vec{l}",
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetOperadorGradiente),
                //Descargar PDF
                DescargarPDF(url: kWidgetOperadorGradiente),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
