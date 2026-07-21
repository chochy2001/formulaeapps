import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EspiraCuadrada extends StatefulWidget {
  const EspiraCuadrada({super.key});

  @override
  State<EspiraCuadrada> createState() => _EspiraCuadradaState();
}

class _EspiraCuadradaState extends State<EspiraCuadrada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.espiraCuadrada,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.espiraCuadrada,
                    widgetName: kWidgetEspiraCuadrada,
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
                            title: AppLocalizations.of(context)!.espiraCuadrada,
                            widgetName: kWidgetEspiraCuadrada,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.espiraCuadrada,
                            widgetName: kWidgetEspiraCuadrada,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenEspiraCuadrada,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(AppLocalizations.of(context)!.leyDeBiotSavart),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"d\vec{B}= \frac{\mu_0}{4\pi}\frac{id\vec{l}\times \bar{r}}{r^3}",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.campoParaUnConductorRecto,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"B = \frac{\mu _0 i}{4\pi y}\frac{L}{(\frac{L^2}{4}+y^2)^\frac{1}{2}}",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.campoMagneticoProducidoPorUnConductor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"B = \frac{\sqrt{2}\mu_0 i}{2\pi L}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.paraLosCuatroConductoresRectos,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"B = \frac{2\sqrt{2}\mu_0 i}{\pi L}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.paraUnPuntoFueraDelPlanoAlCentro,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"B = \frac{\mu_0 i}{4\pi y} \frac{L}{(\frac{L^2}{4}+y^2)^{\frac{1}{2}}}",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.paraLosCuatroConductoresRectos,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"B = \frac{\mu_0 i}{2\pi y^2} \frac{L^2}{(\frac{L^2}{4}+y^2)^{\frac{1}{2}}}",
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetEspiraCuadrada),
                //Descargar PDF
                DescargarPDF(url: kWidgetEspiraCuadrada),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
