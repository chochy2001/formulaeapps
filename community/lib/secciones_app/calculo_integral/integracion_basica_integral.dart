import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class IntegracionBasicaIntegral extends StatefulWidget {
  const IntegracionBasicaIntegral({super.key});
  @override
  State<IntegracionBasicaIntegral> createState() =>
      _IntegracionBasicaIntegralState();
}

class _IntegracionBasicaIntegralState extends State<IntegracionBasicaIntegral> {
  bool seleccionadoMostrar = false;

  bool seleccionadoIntegralDx = false;
  bool seleccionadoConstantePorDx = false;
  bool seleccionadoVariableElevadoAUnExponente = false;
  bool seleccionadoVariableElevadoAlaMenosUno = false;
  bool seleccionadoVariableElevadoAlaMenosN = false;
  bool seleccionadoCocienteDeAxMasB = false;
  bool seleccionadoVariableElevadoAUnCociente = false;
  bool seleccionadoSumaDeFuncionesCompuestas = false;
  bool seleccionadoConstantesPorFunciones = false;
  bool seleccionadoIntegracionPorPartes = false;

  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(
      onBannerReady: () {
        if (mounted) setState(() {});
      },
    );
  }

  Widget get adContainer => _ads.banner;

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: SafeArea(
          child: ListView(
            children: [
              TituloPersonalizado(
                AppLocalizations.of(context)!.integracionBasica,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                      title: AppLocalizations.of(context)!.integracionBasica,
                      widgetName: kWidgetIntegracionBasica,
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
                              )!.integracionBasica,
                              widgetName: kWidgetIntegracionBasica,
                            ),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                              title: AppLocalizations.of(
                                context,
                              )!.integracionBasica,
                              widgetName: kWidgetIntegracionBasica,
                            ),
                          );
                        }
                      });
                    },
                  );
                },
              ),

              const SizedBox(height: 40.0),
              //Integracion
              Column(
                children: [
                  //Integral de una Variable
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        seleccionadoIntegralDx = !seleccionadoIntegralDx;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: seleccionadoIntegralDx
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: seleccionadoIntegralDx
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: seleccionadoIntegralDx ? 250.0 : 300.0,
                      height: seleccionadoIntegralDx ? 80.0 : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(context)!.integraldex,
                                ),
                              ),
                              SizedBox(
                                width: seleccionadoIntegralDx ? 5.0 : 10.0,
                              ),
                              Visibility(
                                visible: !seleccionadoIntegralDx,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kColorTextoBotones,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: seleccionadoIntegralDx,
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
                    visible: seleccionadoIntegralDx,
                    child: const Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\int dx = x + C"),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(kVideoIntegralDeX),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //Integral de constante por una Variable
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        seleccionadoConstantePorDx =
                            !seleccionadoConstantePorDx;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: seleccionadoConstantePorDx
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: seleccionadoConstantePorDx
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: seleccionadoConstantePorDx ? 250.0 : 300.0,
                      height: seleccionadoConstantePorDx ? 80.0 : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.integraldeconstanteporx,
                                ),
                              ),
                              SizedBox(
                                width: seleccionadoConstantePorDx ? 5.0 : 10.0,
                              ),
                              Visibility(
                                visible: !seleccionadoConstantePorDx,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kColorTextoBotones,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: seleccionadoConstantePorDx,
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
                    visible: seleccionadoConstantePorDx,
                    child: const Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\int adx = ax + C"),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(kVideoIntegralDeConstantePorX),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //Integral de x con exponente
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        seleccionadoVariableElevadoAUnExponente =
                            !seleccionadoVariableElevadoAUnExponente;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: seleccionadoVariableElevadoAUnExponente
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: seleccionadoVariableElevadoAUnExponente
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: seleccionadoVariableElevadoAUnExponente
                          ? 250.0
                          : 300.0,
                      height: seleccionadoVariableElevadoAUnExponente
                          ? 80.0
                          : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.variableconexponenten,
                                ),
                              ),
                              SizedBox(
                                width: seleccionadoVariableElevadoAUnExponente
                                    ? 5.0
                                    : 10.0,
                              ),
                              Visibility(
                                visible:
                                    !seleccionadoVariableElevadoAUnExponente,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kColorTextoBotones,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    seleccionadoVariableElevadoAUnExponente,
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
                    visible: seleccionadoVariableElevadoAUnExponente,
                    child: const Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\int x^n dx = \frac{1}{n+1} x^{n+1}+C, \space n\neq -1",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(kVideoIntegralDeVariableConExponenteN),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //Integral de x con exponente a la menos 1
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        seleccionadoVariableElevadoAlaMenosUno =
                            !seleccionadoVariableElevadoAlaMenosUno;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: seleccionadoVariableElevadoAlaMenosUno
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: seleccionadoVariableElevadoAlaMenosUno
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: seleccionadoVariableElevadoAlaMenosUno
                          ? 250.0
                          : 300.0,
                      height: seleccionadoVariableElevadoAlaMenosUno
                          ? 80.0
                          : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.varibaleconexponentemenos1,
                                ),
                              ),
                              SizedBox(
                                width: seleccionadoVariableElevadoAlaMenosUno
                                    ? 5.0
                                    : 10.0,
                              ),
                              Visibility(
                                visible:
                                    !seleccionadoVariableElevadoAlaMenosUno,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kColorTextoBotones,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: seleccionadoVariableElevadoAlaMenosUno,
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
                    visible: seleccionadoVariableElevadoAlaMenosUno,
                    child: const Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\int x^{-1}dx = ln|x|+C"),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(
                          kVideoIntegralDeVariableConExponenteMenosUno,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //Integral de x con exponente negativo
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        seleccionadoVariableElevadoAlaMenosN =
                            !seleccionadoVariableElevadoAlaMenosN;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: seleccionadoVariableElevadoAlaMenosN
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: seleccionadoVariableElevadoAlaMenosN
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: seleccionadoVariableElevadoAlaMenosN
                          ? 250.0
                          : 300.0,
                      height: seleccionadoVariableElevadoAlaMenosN
                          ? 80.0
                          : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.variableconexponentemenosn,
                                ),
                              ),
                              SizedBox(
                                width: seleccionadoVariableElevadoAlaMenosN
                                    ? 5.0
                                    : 10.0,
                              ),
                              Visibility(
                                visible: !seleccionadoVariableElevadoAlaMenosN,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kColorTextoBotones,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: seleccionadoVariableElevadoAlaMenosN,
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
                    visible: seleccionadoVariableElevadoAlaMenosN,
                    child: const Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Latex(
                            formulaText:
                                r"\int x^{-n}dx = \frac{1}{-n+1} x^{-n+1}+C, \space n\neq 1",
                          ),
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(
                          kVideoIntegralDeVariableConExponenteMenosN,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //Integral de una fracción
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        seleccionadoCocienteDeAxMasB =
                            !seleccionadoCocienteDeAxMasB;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: seleccionadoCocienteDeAxMasB
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: seleccionadoCocienteDeAxMasB
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: seleccionadoCocienteDeAxMasB ? 250.0 : 300.0,
                      height: seleccionadoCocienteDeAxMasB ? 80.0 : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.integraldeuncociente,
                                ),
                              ),
                              SizedBox(
                                width: seleccionadoCocienteDeAxMasB
                                    ? 5.0
                                    : 10.0,
                              ),
                              Visibility(
                                visible: !seleccionadoCocienteDeAxMasB,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kColorTextoBotones,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: seleccionadoCocienteDeAxMasB,
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
                    visible: seleccionadoCocienteDeAxMasB,
                    child: const Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\int \frac{1}{ax+b}dx = \frac{1}{a}ln|ax+b|+C",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(kVideoIntegralDeUnCociente),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //Integral de x con exponente fraccionario
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        seleccionadoVariableElevadoAUnCociente =
                            !seleccionadoVariableElevadoAUnCociente;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: seleccionadoVariableElevadoAUnCociente
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: seleccionadoVariableElevadoAUnCociente
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: seleccionadoVariableElevadoAUnCociente
                          ? 250.0
                          : 300.0,
                      height: seleccionadoVariableElevadoAUnCociente
                          ? 80.0
                          : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.exponentefraccionario,
                                ),
                              ),
                              SizedBox(
                                width: seleccionadoVariableElevadoAUnCociente
                                    ? 5.0
                                    : 10.0,
                              ),
                              Visibility(
                                visible:
                                    !seleccionadoVariableElevadoAUnCociente,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kColorTextoBotones,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: seleccionadoVariableElevadoAUnCociente,
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
                    visible: seleccionadoVariableElevadoAUnCociente,
                    child: const Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\int x^{(\frac{p}{q})}dx = \frac{1}{\frac{p}{q}+1}x^{(\frac{p}{q}+1)}+C",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(kVideoIntegralDeExponenteFraccionario),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //Integral de suma de funciones
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
                      width: seleccionadoSumaDeFuncionesCompuestas
                          ? 250.0
                          : 300.0,
                      height: seleccionadoSumaDeFuncionesCompuestas
                          ? 80.0
                          : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(context)!.sumadefunciones,
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
                                r"\int (u\pm v\pm w\pm\dotsm)dx = \int udx\pm\int vdx\pm\int wdx\pm\dotsm",
                          ),
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(kVideoIntegralDeSumaDeFunciones),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //Integral de constantes por funciones
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        seleccionadoConstantesPorFunciones =
                            !seleccionadoConstantesPorFunciones;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: seleccionadoConstantesPorFunciones
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: seleccionadoConstantesPorFunciones
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: seleccionadoConstantesPorFunciones ? 300.0 : 300.0,
                      height: seleccionadoConstantesPorFunciones ? 80.0 : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.productoconstanteyfuncion,
                                ),
                              ),
                              SizedBox(
                                width: seleccionadoConstantesPorFunciones
                                    ? 5.0
                                    : 10.0,
                              ),
                              Visibility(
                                visible: !seleccionadoConstantesPorFunciones,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kColorTextoBotones,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: seleccionadoConstantesPorFunciones,
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
                    visible: seleccionadoConstantesPorFunciones,
                    child: const Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\int af(x)dx = a\int f(x)dx+ C"),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(
                          kVideoIntegralDeProductoConstanteYFuncion,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),

                  //Integracion por partes
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        seleccionadoIntegracionPorPartes =
                            !seleccionadoIntegracionPorPartes;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      alignment: seleccionadoIntegracionPorPartes
                          ? Alignment.center
                          : AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorBotones),
                        borderRadius: BorderRadius.circular(kBordeBotones),
                        color: seleccionadoIntegracionPorPartes
                            ? kColorFondo
                            : kColorBotones,
                      ),
                      width: seleccionadoIntegracionPorPartes ? 300.0 : 300.0,
                      height: seleccionadoIntegracionPorPartes ? 80.0 : 100.0,
                      duration: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.integracionporpartes,
                                ),
                              ),
                              SizedBox(
                                width: seleccionadoIntegracionPorPartes
                                    ? 5.0
                                    : 10.0,
                              ),
                              Visibility(
                                visible: !seleccionadoIntegracionPorPartes,
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_downward_rounded,
                                    color: kColorTextoBotones,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: seleccionadoIntegracionPorPartes,
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
                    visible: seleccionadoIntegracionPorPartes,
                    child: const Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\int udv = uv -\int vdu"),
                        SizedBox(height: kEspacioEntreBotones),
                        VideosYoutube(kVideoIntegralPorPartes),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),

              const SizedBox(height: 20.0),

              const Padding(padding: EdgeInsets.only(top: 10.0)),
              const SizedBox(height: 20.0),
              //Boton para acceder al formulario en PDF
              const VerPDF(url: kWidgetIntegracionBasica),
              //Descargar PDF
              const DescargarPDF(url: kWidgetIntegracionBasica),
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
                    const Latex(
                      formulaText: r"\int u\cdot dv = u\cdot v -\int v\cdot du",
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    Text(
                      AppLocalizations.of(context)!.dondeUVValores,
                      style: kTextoNotas,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(AppLocalizations.of(context)!.logaritmicas),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(
                        context,
                      )!.trigonometricasInversasNumero,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(AppLocalizations.of(context)!.algebraicas),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.trigonometricas,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.exponenciales,
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
      ),
    );
  }
}
