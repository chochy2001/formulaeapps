import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionDiferencialConCoeficientesConstantes extends StatefulWidget {
  const EcuacionDiferencialConCoeficientesConstantes({super.key});

  @override
  EcuacionDiferencialConCoeficientesConstantesState createState() =>
      EcuacionDiferencialConCoeficientesConstantesState();
}

class EcuacionDiferencialConCoeficientesConstantesState
    extends State<EcuacionDiferencialConCoeficientesConstantes> {
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
                      )!.ecuacionDiferencialCoeficientesConstantes,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.ecuacionDiferencialCoeficientesConstantes,
                          widgetName:
                              kWidgetEcuacionDiferencialConCoeficientesConstantes,
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
                                  )!.ecuacionDiferencialCoeficientesConstantes,
                                  widgetName:
                                      kWidgetEcuacionDiferencialConCoeficientesConstantes,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.ecuacionDiferencialCoeficientesConstantes,
                                  widgetName:
                                      kWidgetEcuacionDiferencialConCoeficientesConstantes,
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
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\frac{d^ny}{dx^n}+a_{n-1}\frac{d^{n-1}y}{dx^{n-1}}+\cdots + a_1\frac{dy}{dx}+a_0y=f(x)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(D^n+a_{n-1}D^{n-1}+\cdots +a_1D+a_0)y= f(x)",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"Dy = \frac{dy}{dx}, D^2y=\frac{d^2y}{dx^2}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.homogenea,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(D^n+a_{n-1}D^{n-1}+\cdots +a_1D+a_0)y=0",
                        ),
                        const SizedBox(height: 5),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.seObtienenLasRaicesDeLaEcuacion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.caso1RaicesYDiferentes,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(D\pm r_1)(D\pm r_2)\cdots (D\pm r_n)y=0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"y=c_1e^{r_1x}+c_2e^{r_2x}+\cdots+c_ne^{r_nx}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.caso2RaicesRealesYRepetidas,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(D\pm r_1)^p(D\pm r_{p+1})\cdots (D\pm r_n)y=0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"y=(c_1+c_2x+c_3x^2+\cdots +c_px^{p-1})",
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                          formulaText:
                              r"e^{r_1x}+c_{p+1}e^{r_2x}+\cdots+c_ne^{r_nx}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: 30.0),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.caso3RaicesComplejas,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"(D + a+bi)(D+a-bi)\cdots(D\pm r_n)y=0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"y=(c_1 \cos bx +c_2 \sin bx)e^{ax}+\cdots + c_ne^{r_nx}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.caso4RaicesComplejasYRepetidas,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(D+a+bi)^p(D+a-bi)^p\cdots (D\pm r_n)y=0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"y=e^{ax}[(c_1+c_2x+\cdots + c_px^{p-1})",
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                          formulaText:
                              r"\cos bx+(c_{p+1}+c_{p+2}x+\cdots +c_{2p}x^{p-1})",
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                          formulaText: r"\sin bx]+\cdots + c_ne^{r_nx}",
                        ),
                        const SizedBox(height: 5),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialConCoeficientesConstantes,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialConCoeficientesConstantes,
                  ),
                  //Notas
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
                        const Latex(formulaText: r"D"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.operadorQueSignificaDerivada,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"n"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.ordenDeLaEcuacionSusRaicesSeran,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"r_1,r_2,\cdots ,r_n"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
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
