import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class GradienteDeUnaFuncion extends StatefulWidget {
  const GradienteDeUnaFuncion({super.key});

  @override
  GradienteDeUnaFuncionState createState() => GradienteDeUnaFuncionState();
}

class GradienteDeUnaFuncionState extends State<GradienteDeUnaFuncion> {
  bool seleccionadoMostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: Column(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.gradienteFuncion,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.gradienteFuncion,
                    widgetName: kWidgetGradienteDeUnaFuncion,
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
                            )!.gradienteFuncion,
                            widgetName: kWidgetGradienteDeUnaFuncion,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.gradienteFuncion,
                            widgetName: kWidgetGradienteDeUnaFuncion,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.sean),
                  const Latex(formulaText: r"f(x,y)"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unafunciondedosvariables,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\vec{u} = u_1\hat{i}+u_2\hat{j}"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unvectorunitario,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"\vec{\nabla} f(x,y) = f_x(x,y)\hat{i}+f_y(x,y)\hat{j}",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"\vec{\nabla} f(x,y) =\left(\frac{\partial f(x,y)}{\partial x},\frac{\partial f(x,y)}{\partial y}\right)",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetGradienteDeUnaFuncion),
                //Descargar PDF
                DescargarPDF(url: kWidgetGradienteDeUnaFuncion),
              ],
            ),

            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
