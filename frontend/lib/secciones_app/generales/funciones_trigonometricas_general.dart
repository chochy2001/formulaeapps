import 'package:flutter/material.dart';
import 'package:formulae/fraccion.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';
import '../../constantes/nombres_videos.dart';

class FuncionesTrigonometricasGenerales extends StatefulWidget {
  const FuncionesTrigonometricasGenerales({Key? key}) : super(key: key);

  @override
  FuncionesTrigonometricasGeneralesState createState() =>
      FuncionesTrigonometricasGeneralesState();
}

class FuncionesTrigonometricasGeneralesState
    extends State<FuncionesTrigonometricasGenerales> {
  bool seleccionadoMostrar = false;
  double catetoOpuesto = 1.0, catetoAdyacente = 1.0, hipotenusa = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.funcionesTrigonometricas,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .funcionesTrigonometricas,
                      widgetName: kWidgetFuncionesTrigonometricasGeneral),
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
                                  .funcionesTrigonometricas,
                              widgetName:
                                  kWidgetFuncionesTrigonometricasGeneral),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .funcionesTrigonometricas,
                              widgetName:
                                  kWidgetFuncionesTrigonometricasGeneral),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 40.0,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoMostrar = !seleccionadoMostrar;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoMostrar
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoMostrar ? kColorFondo : kColorBotones,
                ),
                width: seleccionadoMostrar ? 80.0 : 70.0,
                height: seleccionadoMostrar ? 70.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Wrap(
                  children: [
                    SizedBox(
                      width: seleccionadoMostrar ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoMostrar,
                      child: Column(
                        children: [
                          Center(
                            child: TextoBotonesDelgado(
                              AppLocalizations.of(context)!.mostrar,
                            ),
                          ),
                          const Center(
                            child: Icon(
                              Icons.arrow_downward_rounded,
                              color: kColorTextoBotones,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoMostrar,
                      child: Column(
                        children: [
                          Center(
                            child: TextoBotonesDelgado(
                              AppLocalizations.of(context)!.ocultar,
                            ),
                          ),
                          const Center(
                            child: Icon(
                              Icons.arrow_upward_rounded,
                              color: kColorTextoBotones,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Imagen
            ZoomImagePersonalizado(
                urlImagen:
                    getImageUrlById(context, kImagenTrianguloRectangulo) ??
                        kUrlImagenTrianguloRectangulo),
            const SizedBox(
              height: 30.0,
            ),
            Visibility(
              visible: seleccionadoMostrar,
              child: const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"{\sin}{\theta} =\frac{Co}{Hi}"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"{\cos}{\theta}  = \frac{Ca}{Hi}"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"{\tan}{\theta}  = \frac{Co}{Ca}"),
                    SizedBox(height: kEspacioEntreBotones * 3),
                    Latex(formulaText: r"{\csc}{\theta} = \frac{Hi}{Co}"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"{\sec}{\theta} = \frac{Hi}{Ca}"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"{\cot}{\theta} = \frac{Ca}{Co}"),
                    SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                primaryColor: Colors.white,
                primaryColorDark: Colors.white,
                hintColor: Colors.white,
                inputDecorationTheme: const InputDecorationTheme(
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              child: TextField(
                style: kTextoBotones,
                cursorColor: Colors.white,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                  hintText: "5",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: AppLocalizations.of(context)!.catetoOpuesto,
                ),
                onChanged: (valor) {
                  setState(() {
                    catetoOpuesto = double.parse(valor);
                  });
                },
              ),
            ),
            const SizedBox(height: 30.0),
            Theme(
              data: ThemeData(
                primaryColor: Colors.white,
                primaryColorDark: Colors.white,
                hintColor: Colors.white,
                inputDecorationTheme: const InputDecorationTheme(
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              child: TextField(
                style: kTextoBotones,
                cursorColor: Colors.white,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                  hintText: "5",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: AppLocalizations.of(context)!.catetoAdyacente,
                ),
                onChanged: (valor) {
                  setState(() {
                    catetoAdyacente = double.parse(valor);
                  });
                },
              ),
            ),
            const SizedBox(height: 30.0),
            Theme(
              data: ThemeData(
                primaryColor: Colors.white,
                primaryColorDark: Colors.white,
                hintColor: Colors.white,
                inputDecorationTheme: const InputDecorationTheme(
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              child: TextField(
                style: kTextoBotones,
                cursorColor: Colors.white,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                  hintText: "5",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: AppLocalizations.of(context)!.hipotenusa,
                ),
                onChanged: (valor) {
                  setState(() {
                    hipotenusa = double.parse(valor);
                  });
                },
              ),
            ),
            const SizedBox(height: 30.0),
            _solucionFuncionesTrigonometricas(
                catetoOpuesto, catetoAdyacente, hipotenusa),
            const VideosYoutube(kVideoFuncionesTrigonometricas),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetFuncionesTrigonometricasGeneral,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetFuncionesTrigonometricasGeneral,
                ),
              ],
            ),
            //Notas
            Container(
              decoration: BoxDecoration(
                color: kColorBotones,
                border: Border.all(
                  color: kColorFondo,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Notas(),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"Hi"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.hipotenusa,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"Co"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.catetoOpuesto,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"Ca"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.catetoAdyacente,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _solucionFuncionesTrigonometricas(
      catetoOpuesto, catetoAdyacente, hipotenusa) {
    double seno, coseno, tangente, cosecante, secante, cotangente;
    seno = catetoOpuesto / hipotenusa;
    coseno = catetoAdyacente / hipotenusa;
    tangente = catetoOpuesto / catetoAdyacente;
    cosecante = hipotenusa / catetoOpuesto;
    secante = hipotenusa / catetoAdyacente;
    cotangente = catetoAdyacente / catetoOpuesto;
    return Container(
      color: kColorBotones,
      child: ListTile(
        title: Text(
          'Sin θ = ${implementFraction(seno)}\nCos θ = ${implementFraction(coseno)}\nTan θ = ${implementFraction(tangente)}\nCsc θ = ${implementFraction(cosecante)}\nSec θ = ${implementFraction(secante)}\nCot θ = ${implementFraction(cotangente)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }
}
