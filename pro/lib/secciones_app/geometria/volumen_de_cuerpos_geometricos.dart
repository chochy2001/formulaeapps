import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class VolumenDeCuerposGeometricos extends StatefulWidget {
  const VolumenDeCuerposGeometricos({Key? key}) : super(key: key);

  @override
  VolumenDeCuerposGeometricosState createState() =>
      VolumenDeCuerposGeometricosState();
}

class VolumenDeCuerposGeometricosState
    extends State<VolumenDeCuerposGeometricos> {
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
                      AppLocalizations.of(context)!.volumenDeCuerposGeometricos,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .volumenDeCuerposGeometricos,
                            widgetName: kWidgetVolumenDeCuerposGeometricos),
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
                                        .volumenDeCuerposGeometricos,
                                    widgetName:
                                        kWidgetVolumenDeCuerposGeometricos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .volumenDeCuerposGeometricos,
                                    widgetName:
                                        kWidgetVolumenDeCuerposGeometricos),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cubo,
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"V = a^3"),

                  const SizedBox(height: kEspacioEntreBotones),
                  const ZoomImagePersonalizado(urlImagen: kUrlImagenCubo),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.prisma,
                  ),

                  //todo  poner area_base
                  //TextoEcuaciones(AppLocalizations.of(context)!.areaDeLaBase,),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"V=\mathsf{Area_{base}}\cdot h"),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomImagePersonalizado(
                      urlImagen:
                          getImageUrlById(context, kImagenPrismaPentagonal) ??
                              kUrlImagenPrismaPentagonal),

                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cilindro,
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"V = \pi r^2\cdot h"),

                  const SizedBox(height: kEspacioEntreBotones),

                  const ZoomImagePersonalizado(
                      urlImagen: kUrlImagenPrismaCircular),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.esfera,
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"V = \frac{4}{3}\pi r^3"),

                  const SizedBox(height: kEspacioEntreBotones),

                  const ZoomImagePersonalizado(urlImagen: kUrlImagenEsfera),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.piramide,
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  //todo cambiar por variable
                  //TextoEcuaciones(AppLocalizations.of(context)!.areaDeLaBase,),
                  const Latex(
                      formulaText: r"V= \frac{\mathsf{Area_{base}}\cdot h}{3}"),

                  const SizedBox(height: kEspacioEntreBotones),

                  ZoomImagePersonalizado(
                      urlImagen: getImageUrlById(context, kImagenPiramide) ??
                          kUrlImagenPiramide),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cono,
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"V = \frac{\pi r^2\cdot h}{3}"),

                  const SizedBox(height: kEspacioEntreBotones),
                  const ZoomImagePersonalizado(urlImagen: kUrlImagenCono),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetVolumenDeCuerposGeometricos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetVolumenDeCuerposGeometricos,
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
