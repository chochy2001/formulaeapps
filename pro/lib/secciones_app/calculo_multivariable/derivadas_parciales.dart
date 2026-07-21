import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class DerivadasParciales extends StatefulWidget {
  const DerivadasParciales({super.key});

  @override
  DerivadasParcialesState createState() => DerivadasParcialesState();
}

class DerivadasParcialesState extends State<DerivadasParciales> {
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
                AppLocalizations.of(context)!.derivadasParciales,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.derivadasParciales,
                    widgetName: kWidgetDerivadasParciales,
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
                            )!.derivadasParciales,
                            widgetName: kWidgetDerivadasParciales,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.derivadasParciales,
                            widgetName: kWidgetDerivadasParciales,
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
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.dadaFuncionFDeXYZ,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"f_x(x,y,z) = \lim_{h \to 0}\frac{f(x+h,y,z)-f(x,y,z)}{h}",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"f_y(x,y,z) = \lim_{h \to 0}\frac{f(x,y+h,z)-f(x,y,z)}{h}",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"f_z(x,y,z) = \lim_{h \to 0}\frac{f(x,y,z+h)-f(x,y,z)}{h}",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.notacion),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"f_{x} = \frac{\partial f(x,y,z)}{\partial x}",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"f_{y} = \frac{\partial f(x,y,z)}{\partial y}",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText:
                        r"f_{z} = \frac{\partial f(x,y,z)}{\partial z}",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetDerivadasParciales),
                //Descargar PDF
                DescargarPDF(url: kWidgetDerivadasParciales),
              ],
            ),

            const SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: kColorBotones,
                border: Border.all(color: kColorFondo, width: 8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Notas(),
                  const SizedBox(height: kEspacioEntreBotones),
                  Center(
                    child: TextoEcuaciones(
                      AppLocalizations.of(
                        context,
                      )!.elsubindiceindicarespectodequevariablesevaaderivar,
                    ),
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
    );
  }
}
