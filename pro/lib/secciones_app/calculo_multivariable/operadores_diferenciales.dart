import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class OperadoresDiferenciales extends StatefulWidget {
  const OperadoresDiferenciales({super.key});

  @override
  OperadoresDiferencialesState createState() => OperadoresDiferencialesState();
}

class OperadoresDiferencialesState extends State<OperadoresDiferenciales> {
  bool seleccionadoMostrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.operadoresDiferenciales,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.operadoresDiferenciales,
                      widgetName: kWidgetOperadoresDiferenciales),
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
                                  .operadoresDiferenciales,
                              widgetName: kWidgetOperadoresDiferenciales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .operadoresDiferenciales,
                              widgetName: kWidgetOperadoresDiferenciales),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 20.0,
            ),
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\vec{F}"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .funcionVectorialDeLasVariables,
                  ),
                  const Latex(formulaText: r"x,y,z"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.divergencia,
                  ),
                  const Latex(
                      formulaText:
                          r"\nabla \cdot \vec{F} = \frac{\partial F_x}{\partial x}+\frac{\partial F_y}{\partial y}+\frac{\partial F_z}{\partial z}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"F_x,F_y,F_z"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.componentesDe,
                  ),
                  const Latex(formulaText: r"\vec{F}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.rotacional,
                  ),
                  const Latex(formulaText: r"\nabla \times \vec{F} ="),
                  const SizedBox(height: 10),
                  const Latex(
                      formulaText:
                          r"\hat{i} \begin{vmatrix}\frac{\partial}{\partial y} & \frac{\partial}{\partial z}\\F_y & F_z\\\end{vmatrix} - \hat{j} \begin{vmatrix}\frac{\partial}{\partial x} & \frac{\partial}{\partial z}\\F_x & F_z\\\end{vmatrix} + \hat{k} \begin{vmatrix}\frac{\partial}{\partial x} & \frac{\partial}{\partial y}\\F_x & F_y\\\end{vmatrix}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laplaciano,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"f"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.funcionEscalar,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\nabla ^2 f = \frac{\partial ^2 f}{\partial x^2}+\frac{\partial ^2 f}{\partial y^2}+\frac{\partial ^2 f}{\partial z^2}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laplacianoDeUnCampoVectorial,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\nabla ^2 \vec{A} = \nabla (\nabla \cdot \vec{A}) - \nabla \times(\nabla\times\vec{A})"),
                  const SizedBox(height: 10),
                  const Latex(formulaText: r"= (\nabla\cdot\nabla)\vec{A}"),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetOperadoresDiferenciales,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetOperadoresDiferenciales,
                ),
              ],
            ),

            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
