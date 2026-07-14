import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';
import '../../constantes/nombres_videos.dart';

class DerivacionBasicaDiferencial extends StatefulWidget {
  const DerivacionBasicaDiferencial({super.key});

  @override
  DerivacionBasicaDiferencialState createState() =>
      DerivacionBasicaDiferencialState();
}

class DerivacionBasicaDiferencialState
    extends State<DerivacionBasicaDiferencial> {
  bool seleccionadoU = true;
  bool seleccionadoDX = false;

  bool seleccionadoDerivacionConstante = false;
  bool seleccionadoDerivacionDeX = false;
  bool seleccionadoConstantePorX = false;
  bool seleccionadoXaLaN = false;
  bool seleccionadoConstantePorXaLaN = false;
  bool seleccionadoConstantePorFuncionCompuesta = false;
  bool seleccionadoFuncionCompuestaaLaN = false;
  bool seleccionadoFuncionCompuestaPorUnaFuncionCompuesta = false;
  bool seleccionadoCocienteDeFuncionesCompuestas = false;
  bool seleccionadoProductoDeFuncionesCompuestas = false;
  bool seleccionadoSumaDeFuncionesCompuestas = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.derivacionBasica,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.derivacionBasica,
                      widgetName: kWidgetDerivacionBasicaDiferencial),
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
                                  .derivacionBasica,
                              widgetName: kWidgetDerivacionBasicaDiferencial),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .derivacionBasica,
                              widgetName: kWidgetDerivacionBasicaDiferencial),
                        );
                      }
                    });
                  },
                );
              },
            ),

            //Derivación u
            Column(
              children: [
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),
                //Derivacion de una Constante
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoDerivacionConstante =
                          !seleccionadoDerivacionConstante;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoDerivacionConstante
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoDerivacionConstante
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoDerivacionConstante ? 250.0 : 300.0,
                    height: seleccionadoDerivacionConstante ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!
                                    .derivacionConstante,
                              ),
                            ),
                            SizedBox(
                              width:
                                  seleccionadoDerivacionConstante ? 5.0 : 10.0,
                            ),
                            Visibility(
                              visible: !seleccionadoDerivacionConstante,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: seleccionadoDerivacionConstante,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoDerivacionConstante,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\frac{d}{dx}(c) = 0"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoDerivadaDeUnaConstante),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion de una variable
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoDerivacionDeX = !seleccionadoDerivacionDeX;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoDerivacionDeX
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoDerivacionDeX
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoDerivacionDeX ? 250.0 : 300.0,
                    height: seleccionadoDerivacionDeX ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!.derivadaVariable,
                              ),
                            ),
                            SizedBox(
                              width: seleccionadoDerivacionDeX ? 5.0 : 10.0,
                            ),
                            Visibility(
                              visible: !seleccionadoDerivacionDeX,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: seleccionadoDerivacionDeX,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoDerivacionDeX,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\frac{d}{dx}(x) = 1"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoDerivadaDeUnaVariable),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion de una Constante Por una Variable
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoConstantePorX = !seleccionadoConstantePorX;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoConstantePorX
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoConstantePorX
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoConstantePorX ? 260.0 : 300.0,
                    height: seleccionadoConstantePorX ? 100.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!
                                    .derivadaConstanteVariable,
                              ),
                            ),
                            SizedBox(
                              width: seleccionadoConstantePorX ? 5.0 : 10.0,
                            ),
                            Visibility(
                              visible: !seleccionadoConstantePorX,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: seleccionadoConstantePorX,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoConstantePorX,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\frac{d}{dx}(cx) = c"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoDerivadaDeUnaConstantePorVariable),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion de Exponente
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoXaLaN = !seleccionadoXaLaN;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoXaLaN
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoXaLaN ? kColorFondo : kColorBotones,
                    ),
                    width: seleccionadoXaLaN ? 260.0 : 300.0,
                    height: seleccionadoXaLaN ? 100.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!.derivadaExponente,
                              ),
                            ),
                            SizedBox(
                              width: seleccionadoXaLaN ? 5.0 : 10.0,
                            ),
                            Visibility(
                              visible: !seleccionadoXaLaN,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: seleccionadoXaLaN,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoXaLaN,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\frac{d}{dx}(x^n) = nx^{n-1}"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoDerivadaExponente),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion de Constante por Exponente
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoConstantePorXaLaN =
                          !seleccionadoConstantePorXaLaN;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoConstantePorXaLaN
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoConstantePorXaLaN
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoConstantePorXaLaN ? 260.0 : 300.0,
                    height: seleccionadoConstantePorXaLaN ? 100.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!
                                    .derivadaConstanteExponente,
                              ),
                            ),
                            SizedBox(
                              width: seleccionadoConstantePorXaLaN ? 5.0 : 10.0,
                            ),
                            Visibility(
                              visible: !seleccionadoConstantePorXaLaN,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: seleccionadoConstantePorXaLaN,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoConstantePorXaLaN,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\frac{d}{dx}(cx^n) = ncx^{n-1}"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoDerivadaConstantePorExponente),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion de Constante por Funcion Compuesta
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoConstantePorFuncionCompuesta =
                          !seleccionadoConstantePorFuncionCompuesta;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoConstantePorFuncionCompuesta
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoConstantePorFuncionCompuesta
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoConstantePorFuncionCompuesta
                        ? 260.0
                        : 300.0,
                    height: seleccionadoConstantePorFuncionCompuesta
                        ? 100.0
                        : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!
                                    .derivadaConstanteFuncionCompuesta,
                              ),
                            ),
                            SizedBox(
                              width: seleccionadoConstantePorFuncionCompuesta
                                  ? 5.0
                                  : 10.0,
                            ),
                            Visibility(
                              visible:
                                  !seleccionadoConstantePorFuncionCompuesta,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: seleccionadoConstantePorFuncionCompuesta,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoConstantePorFuncionCompuesta,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\frac{d}{dx}(cu) =cu'"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoDerivadaConstantePorFuncionCompuesta),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion una Funcion Compuesta con Exponente
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoFuncionCompuestaaLaN =
                          !seleccionadoFuncionCompuestaaLaN;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoFuncionCompuestaaLaN
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoFuncionCompuestaaLaN
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoFuncionCompuestaaLaN ? 260.0 : 300.0,
                    height: seleccionadoFuncionCompuestaaLaN ? 100.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!
                                    .derivadaFuncionCompuestaExponente,
                              ),
                            ),
                            SizedBox(
                              width:
                                  seleccionadoFuncionCompuestaaLaN ? 5.0 : 10.0,
                            ),
                            Visibility(
                              visible: !seleccionadoFuncionCompuestaaLaN,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: seleccionadoFuncionCompuestaaLaN,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoFuncionCompuestaaLaN,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\frac{d}{dx}(u^n) = nu^{n-1}u'"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoDerivadaFuncionCompuestaConExponente),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion una Funcion Compuesta por Función Compuesta
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoFuncionCompuestaPorUnaFuncionCompuesta =
                          !seleccionadoFuncionCompuestaPorUnaFuncionCompuesta;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment:
                        seleccionadoFuncionCompuestaPorUnaFuncionCompuesta
                            ? Alignment.center
                            : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoFuncionCompuestaPorUnaFuncionCompuesta
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoFuncionCompuestaPorUnaFuncionCompuesta
                        ? 260.0
                        : 300.0,
                    height: 120.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!
                                    .derivadaProductoFuncionesCompuestas,
                              ),
                            ),
                            SizedBox(
                              width:
                                  seleccionadoFuncionCompuestaPorUnaFuncionCompuesta
                                      ? 5.0
                                      : 10.0,
                            ),
                            Visibility(
                              visible:
                                  !seleccionadoFuncionCompuestaPorUnaFuncionCompuesta,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  seleccionadoFuncionCompuestaPorUnaFuncionCompuesta,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoFuncionCompuestaPorUnaFuncionCompuesta,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\frac{d}{dx}(uv) = uv'+vu'"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(
                          kVideoDerivadaDelProductoDeDosFuncionesCompuestas),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion una Funcion Compuesta Entre Función Compuesta
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoCocienteDeFuncionesCompuestas =
                          !seleccionadoCocienteDeFuncionesCompuestas;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoCocienteDeFuncionesCompuestas
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoCocienteDeFuncionesCompuestas
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoCocienteDeFuncionesCompuestas
                        ? 260.0
                        : 300.0,
                    height: 120.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!
                                    .derivadaCocienteFuncionesCompuestas,
                              ),
                            ),
                            SizedBox(
                              width: seleccionadoCocienteDeFuncionesCompuestas
                                  ? 5.0
                                  : 10.0,
                            ),
                            Visibility(
                              visible:
                                  !seleccionadoCocienteDeFuncionesCompuestas,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  seleccionadoCocienteDeFuncionesCompuestas,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoCocienteDeFuncionesCompuestas,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\frac{d}{dx}\left(\frac{u}{v}\right) = \frac{vu'-uv'}{v^2}"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(
                          kVideoDerivadaDelCocienteDeDosFuncionesCompuestas),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion una Funcion Compuesta por Función Compuesta Tres
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoProductoDeFuncionesCompuestas =
                          !seleccionadoProductoDeFuncionesCompuestas;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoProductoDeFuncionesCompuestas
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoProductoDeFuncionesCompuestas
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoProductoDeFuncionesCompuestas
                        ? 260.0
                        : 300.0,
                    height: 120.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!
                                    .derivadaProductoNFuncionesCompuestas,
                              ),
                            ),
                            SizedBox(
                              width: seleccionadoProductoDeFuncionesCompuestas
                                  ? 5.0
                                  : 10.0,
                            ),
                            Visibility(
                              visible:
                                  !seleccionadoProductoDeFuncionesCompuestas,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  seleccionadoProductoDeFuncionesCompuestas,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoProductoDeFuncionesCompuestas,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\frac{d}{dx}(uvw) = uvw'+uwv'+vwu'"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(
                          kVideoDerivadaDelProductoDeNFuncionesCompuestas),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),

                //Derivacion la Suma de Funciones Compuestas
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoSumaDeFuncionesCompuestas =
                          !seleccionadoSumaDeFuncionesCompuestas;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoSumaDeFuncionesCompuestas
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoSumaDeFuncionesCompuestas
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width:
                        seleccionadoSumaDeFuncionesCompuestas ? 260.0 : 300.0,
                    height:
                        seleccionadoSumaDeFuncionesCompuestas ? 100.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: TextoBotonesDelgado(
                                AppLocalizations.of(context)!
                                    .derivadaSumaFuncionesCompuestas,
                              ),
                            ),
                            SizedBox(
                              width: seleccionadoSumaDeFuncionesCompuestas
                                  ? 5.0
                                  : 10.0,
                            ),
                            Visibility(
                              visible: !seleccionadoSumaDeFuncionesCompuestas,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: seleccionadoSumaDeFuncionesCompuestas,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: kColorTextoBotones,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: seleccionadoSumaDeFuncionesCompuestas,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Latex(
                            formulaText:
                                r"\frac{d}{dx}(u\pm v\pm w\pm \dotsm ) = u'\pm v'\pm w'\pm\dotsm"),
                      ),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(
                          kVideoDerivadaDeLaSumaDeFuncionesCompuestas),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kEspacioEntreBotones,
                ),
                //Todo hacer opcion para que los usuarios pongan su polinomio y se resuelva su derivada

                //Boton para acceder al formulario en PDF
                const VerPDF(
                  url: kWidgetDerivacionBasicaDiferencial,
                ),
                //Descargar PDF
                const DescargarPDF(
                  url: kWidgetDerivacionBasicaDiferencial,
                ),
              ],
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),

            const Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),

            const SizedBox(
              height: 20.0,
            ),
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
                  const Latex(formulaText: r"c"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.constante,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"x"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.variable,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"u"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.funcioncompuesta,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\frac{du}{dx} = u^{'}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\frac{dv}{dx} = v^{'}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\frac{dw}{dx} = w^{'}"),
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
