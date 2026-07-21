import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';

class PreguntasFrecuentes extends StatefulWidget {
  const PreguntasFrecuentes({super.key});

  @override
  PreguntasFrecuentesState createState() => PreguntasFrecuentesState();
}

class PreguntasFrecuentesState extends State<PreguntasFrecuentes> {
  bool numerosNegativos = false;
  bool formulasCortadas = false;
  bool resultadoNaN = false;
  bool descargarImprimirPDF = false;
  bool videosNoCargan = false;
  bool pdfNoCargan = false;

  Widget _faqImage(String urlImagen) {
    return SizedBox(
      height: 200.0,
      width: 300.0,
      child: InteractiveViewer(
        child: ImagenRemotaRobusta(
          urlImagen: urlImagen,
          height: 300.0,
          width: double.infinity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(visible: false),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.preguntasFrecuentes,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        descargarImprimirPDF = !descargarImprimirPDF;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: descargarImprimirPDF
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: descargarImprimirPDF
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: descargarImprimirPDF ? 250.0 : 300.0,
                      height: descargarImprimirPDF ? 80.0 : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Wrap(
                        children: [
                          SizedBox(width: descargarImprimirPDF ? 5.0 : 10.0),
                          Visibility(
                            visible: !descargarImprimirPDF,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.comoTrabajarConLosPdf,
                                    textAlign: TextAlign.center,
                                    style: kTextoMostrarOcultar,
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
                            visible: descargarImprimirPDF,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.comoTrabajarConLosPdf,
                                    textAlign: TextAlign.center,
                                    style: kTextoMostrarOcultar,
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
                  Visibility(
                    visible: descargarImprimirPDF,
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.botonVerPDF,
                          style: kTextoMostrarOcultar,
                        ),
                        _faqImage(
                          getImageUrlById(context, kImagenBotones) ??
                              kUrlImagenBotones,
                        ),
                        Text(
                          AppLocalizations.of(context)!.parteSuperiorCelular,
                          style: kTextoMostrarOcultar,
                        ),
                        _faqImage(
                          getImageUrlById(context, kImagenTresPuntos) ??
                              kUrlImagenTresPuntos,
                        ),
                        Text(
                          AppLocalizations.of(context)!.presionandoOpcionesPDF,
                          style: kTextoMostrarOcultar,
                        ),
                        _faqImage(
                          getImageUrlById(context, kImagenOpcionesPdf) ??
                              kUrlImagenOpcionesPdf,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //No me cargan los videos
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        videosNoCargan = !videosNoCargan;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: videosNoCargan
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: videosNoCargan ? kColorFondo : kColorBotones,
                      ),
                      width: videosNoCargan ? 250.0 : 300.0,
                      height: videosNoCargan ? 80.0 : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Wrap(
                        children: [
                          SizedBox(width: videosNoCargan ? 5.0 : 10.0),
                          Visibility(
                            visible: !videosNoCargan,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.noCarganLosVideos,
                                    textAlign: TextAlign.center,
                                    style: kTextoMostrarOcultar,
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
                            visible: videosNoCargan,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.noCarganLosVideos,
                                    textAlign: TextAlign.center,
                                    style: kTextoMostrarOcultar,
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
                  const SizedBox(height: kEspacioEntreBotones),
                  Visibility(
                    visible: videosNoCargan,
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(
                            context,
                          )!.asegurarConexionInternet,
                          style: kTextoMostrarOcultar,
                        ),
                        _faqImage(kUrlImagenConexion1),
                        const SizedBox(height: kEspacioEntreBotones),
                        Text(
                          AppLocalizations.of(context)!.activarDesactivado,
                          style: kTextoMostrarOcultar,
                        ),
                        _faqImage(kUrlImagenConexion2),
                        const SizedBox(height: kEspacioEntreBotones),
                        Text(
                          AppLocalizations.of(context)!.esperarCargaVideo,
                          style: kTextoMostrarOcultar,
                        ),
                        _faqImage(kUrlImagenConexion3),
                        const SizedBox(height: kEspacioEntreBotones),
                        Text(
                          AppLocalizations.of(context)!.disfrutarVideo,
                          style: kTextoMostrarOcultar,
                        ),
                        _faqImage(kUrlImagenConexion4),
                        const SizedBox(height: kEspacioEntreBotones),
                        Text(
                          AppLocalizations.of(context)!.siNoFunciona,
                          style: kTextoMostrarOcultar,
                        ),
                        Text(
                          AppLocalizations.of(context)!.salirVolverSeccion,
                          style: kTextoMostrarOcultar,
                        ),
                      ],
                    ),
                  ),
                  //No me cargan los PDF
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pdfNoCargan = !pdfNoCargan;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: pdfNoCargan
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: pdfNoCargan ? kColorFondo : kColorBotones,
                      ),
                      width: pdfNoCargan ? 250.0 : 300.0,
                      height: pdfNoCargan ? 80.0 : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Wrap(
                        children: [
                          SizedBox(width: pdfNoCargan ? 5.0 : 10.0),
                          Visibility(
                            visible: !pdfNoCargan,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.noCarganLosPdf,
                                    textAlign: TextAlign.center,
                                    style: kTextoMostrarOcultar,
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
                            visible: pdfNoCargan,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.noCarganLosPdf,
                                    textAlign: TextAlign.center,
                                    style: kTextoMostrarOcultar,
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
                  Visibility(
                    visible: pdfNoCargan,
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(
                            context,
                          )!.asegurarConexionInternet,
                          style: kTextoMostrarOcultar,
                        ),
                        _faqImage(kUrlImagenConexion1),
                        const SizedBox(height: kEspacioEntreBotones),
                        Text(
                          AppLocalizations.of(context)!.activarDesactivado,
                          style: kTextoMostrarOcultar,
                        ),
                        _faqImage(kUrlImagenConexion2),
                        const SizedBox(height: kEspacioEntreBotones),
                        Text(
                          AppLocalizations.of(context)!.esperarCargaPDF,
                          style: kTextoMostrarOcultar,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        Text(
                          AppLocalizations.of(context)!.disfrutarPDF,
                          style: kTextoMostrarOcultar,
                        ),
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
