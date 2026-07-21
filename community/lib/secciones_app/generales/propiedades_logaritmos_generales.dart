import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class PropiedadesLogaritmosGenerales extends StatefulWidget {
  const PropiedadesLogaritmosGenerales({super.key});
  @override
  State<PropiedadesLogaritmosGenerales> createState() =>
      _PropiedadesLogaritmosGeneralesState();
}

class _PropiedadesLogaritmosGeneralesState
    extends State<PropiedadesLogaritmosGenerales> {
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

  bool seleccionadoMostrar = false;
  bool seleccionadoLogaritmoIgualaCero = false;
  bool seleccionadoLogaritmoBaseDiez = false;
  bool seleccionadoLogaritmoDeUno = false;
  bool seleccionadoSuma = false;
  bool seleccionadoResta = false;
  bool seleccionadoProducto = false;
  bool seleccionadoCociente = false;
  bool seleccionadoPotencia = false;
  bool seleccionadoLogaritmoNatural = false;
  bool seleccionadoCambioDeBase = false;
  bool seleccionadoLogaritmoDeUnaRaiz = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            TituloPersonalizado(
              AppLocalizations.of(context)!.propiedadesLogaritmos,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.propiedadesLogaritmos,
                    widgetName: kWidgetPropiedadesLogaritmosGenerales,
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
                            )!.propiedadesLogaritmos,
                            widgetName: kWidgetPropiedadesLogaritmosGenerales,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.propiedadesLogaritmos,
                            widgetName: kWidgetPropiedadesLogaritmosGenerales,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 30.0),
            Column(
              children: [
                //Logaritmo igual a cero
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoLogaritmoIgualaCero =
                          !seleccionadoLogaritmoIgualaCero;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoLogaritmoIgualaCero
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoLogaritmoIgualaCero
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoLogaritmoIgualaCero ? 250.0 : 300.0,
                    height: seleccionadoLogaritmoIgualaCero ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: seleccionadoLogaritmoIgualaCero ? 5.0 : 10.0,
                        ),
                        Visibility(
                          visible: !seleccionadoLogaritmoIgualaCero,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoIgualACero,
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
                          visible: seleccionadoLogaritmoIgualaCero,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoIgualACero,
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
                  visible: seleccionadoLogaritmoIgualaCero,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\log_{a}1=0"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesLogaritmoIgualACero),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),
                //Logaritmo con base diez
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoLogaritmoBaseDiez =
                          !seleccionadoLogaritmoBaseDiez;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoLogaritmoBaseDiez
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoLogaritmoBaseDiez
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoLogaritmoBaseDiez ? 250.0 : 300.0,
                    height: seleccionadoLogaritmoBaseDiez ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: seleccionadoLogaritmoBaseDiez ? 5.0 : 10.0,
                        ),
                        Visibility(
                          visible: !seleccionadoLogaritmoBaseDiez,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoConBaseDiez,
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
                          visible: seleccionadoLogaritmoBaseDiez,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoConBaseDiez,
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
                  visible: seleccionadoLogaritmoBaseDiez,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\log_{10}N=\log N"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesLogaritmoBaseDiez),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),

                //Logaritmo de uno
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoLogaritmoDeUno = !seleccionadoLogaritmoDeUno;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoLogaritmoDeUno
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoLogaritmoDeUno
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoLogaritmoDeUno ? 250.0 : 300.0,
                    height: seleccionadoLogaritmoDeUno ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: seleccionadoLogaritmoDeUno ? 5.0 : 10.0,
                        ),
                        Visibility(
                          visible: !seleccionadoLogaritmoDeUno,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(context)!.logaritmoDeUno,
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
                          visible: seleccionadoLogaritmoDeUno,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(context)!.logaritmoDeUno,
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
                  visible: seleccionadoLogaritmoDeUno,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\log_a{a}=1"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesLogaritmoDeUno),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),

                //Suma
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoSuma = !seleccionadoSuma;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoSuma
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoSuma ? kColorFondo : kColorBotones,
                    ),
                    width: seleccionadoSuma ? 250.0 : 300.0,
                    height: seleccionadoSuma ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(width: seleccionadoSuma ? 5.0 : 10.0),
                        Visibility(
                          visible: !seleccionadoSuma,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.sumaDeLogaritmos,
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
                          visible: seleccionadoSuma,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.sumaDeLogaritmos,
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
                  visible: seleccionadoSuma,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\log_aM+\log_aN = \log_a(M\cdot N)"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesSumaLogaritmo),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),

                //Resta
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoResta = !seleccionadoResta;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoResta
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoResta ? kColorFondo : kColorBotones,
                    ),
                    width: seleccionadoResta ? 250.0 : 300.0,
                    height: seleccionadoResta ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(width: seleccionadoResta ? 5.0 : 10.0),
                        Visibility(
                          visible: !seleccionadoResta,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.restaDeLogaritmos,
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
                          visible: seleccionadoResta,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.restaDeLogaritmos,
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
                  visible: seleccionadoResta,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\log_aM-\log_aN = \log_a\left(\frac{M}{N}\right)",
                      ),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesRestaLogaritmo),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),

                //Producto
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoProducto = !seleccionadoProducto;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoProducto
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoProducto ? kColorFondo : kColorBotones,
                    ),
                    width: seleccionadoProducto ? 250.0 : 300.0,
                    height: seleccionadoProducto ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(width: seleccionadoProducto ? 5.0 : 10.0),
                        Visibility(
                          visible: !seleccionadoProducto,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.productoDeLogaritmos,
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
                          visible: seleccionadoProducto,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.productoDeLogaritmos,
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
                  visible: seleccionadoProducto,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\log_a{(M\cdot N)} = \log_{a}M+\log_{a}N",
                      ),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesProductoLogaritmo),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),

                //Cociente
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoCociente = !seleccionadoCociente;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoCociente
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoCociente ? kColorFondo : kColorBotones,
                    ),
                    width: seleccionadoCociente ? 250.0 : 300.0,
                    height: seleccionadoCociente ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(width: seleccionadoCociente ? 5.0 : 10.0),
                        Visibility(
                          visible: !seleccionadoCociente,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.cocienteDeLogaritmos,
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
                          visible: seleccionadoCociente,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.cocienteDeLogaritmos,
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
                  visible: seleccionadoCociente,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\log_a\left(\frac {M}{N}\right) = \log_{a}M-\log_{a}N",
                      ),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesCocienteLogaritmo),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),

                //Potencia
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoPotencia = !seleccionadoPotencia;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoPotencia
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoPotencia ? kColorFondo : kColorBotones,
                    ),
                    width: seleccionadoPotencia ? 250.0 : 300.0,
                    height: seleccionadoPotencia ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(width: seleccionadoPotencia ? 5.0 : 10.0),
                        Visibility(
                          visible: !seleccionadoPotencia,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.potenciaDeLogaritmos,
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
                          visible: seleccionadoPotencia,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.potenciaDeLogaritmos,
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
                  visible: seleccionadoPotencia,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\log_a{N}^{r} = r\log_{a}N"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesPotenciaLogaritmo),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),

                //Logaritmo Natural
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoLogaritmoNatural =
                          !seleccionadoLogaritmoNatural;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoLogaritmoNatural
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoLogaritmoNatural
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoLogaritmoNatural ? 250.0 : 300.0,
                    height: seleccionadoLogaritmoNatural ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: seleccionadoLogaritmoNatural ? 5.0 : 10.0,
                        ),
                        Visibility(
                          visible: !seleccionadoLogaritmoNatural,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoNatural,
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
                          visible: seleccionadoLogaritmoNatural,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoNatural,
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
                  visible: seleccionadoLogaritmoNatural,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\log_e{N}=\ln{N}"),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesLogaritmoNatural),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),

                //Cambio de Base
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoCambioDeBase = !seleccionadoCambioDeBase;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoCambioDeBase
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoCambioDeBase
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoCambioDeBase ? 250.0 : 300.0,
                    height: seleccionadoCambioDeBase ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(width: seleccionadoCambioDeBase ? 5.0 : 10.0),
                        Visibility(
                          visible: !seleccionadoCambioDeBase,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoConCambioDeBase,
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
                          visible: seleccionadoCambioDeBase,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoConCambioDeBase,
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
                  visible: seleccionadoCambioDeBase,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\log_{a}{N} = \frac{\log_{b}{N}}{\log_{b}{a}}=\frac{\ln{N}}{\ln{a}}",
                      ),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesLogaritmoCambioDeBase),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),

                //Logaritmo de una raiz
                GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionadoLogaritmoDeUnaRaiz =
                          !seleccionadoLogaritmoDeUnaRaiz;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    alignment: seleccionadoLogaritmoDeUnaRaiz
                        ? Alignment.center
                        : AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: kColorBotones),
                      borderRadius: BorderRadius.circular(kBordeBotones),
                      color: seleccionadoLogaritmoDeUnaRaiz
                          ? kColorFondo
                          : kColorBotones,
                    ),
                    width: seleccionadoLogaritmoDeUnaRaiz ? 250.0 : 300.0,
                    height: seleccionadoLogaritmoDeUnaRaiz ? 80.0 : 100.0,
                    duration: const Duration(milliseconds: 600),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: seleccionadoLogaritmoDeUnaRaiz ? 5.0 : 10.0,
                        ),
                        Visibility(
                          visible: !seleccionadoLogaritmoDeUnaRaiz,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoDeUnaRaiz,
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
                          visible: seleccionadoLogaritmoDeUnaRaiz,
                          child: Column(
                            children: [
                              Center(
                                child: TextoBotonesDelgado(
                                  AppLocalizations.of(
                                    context,
                                  )!.logaritmoDeUnaRaiz,
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
                  visible: seleccionadoLogaritmoDeUnaRaiz,
                  child: const Column(
                    children: [
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                        formulaText:
                            r"\log_a{\sqrt[n]{m}=\log_a{m}^\frac{1}{n}=\frac{1}{n}\cdot \log_a{m}}",
                      ),
                      SizedBox(height: kEspacioEntreBotones),
                      VideosYoutube(kVideoPropiedadesLogaritmoRaiz),
                    ],
                  ),
                ),
                const SizedBox(height: kEspacioEntreBotones),
              ],
            ),
            const SizedBox(height: kEspacioEntreBotones),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetPropiedadesLogaritmosGenerales),
            //Descargar PDF
            const DescargarPDF(url: kWidgetPropiedadesLogaritmosGenerales),
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
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.explicacionLogaritmo,
                  ),
                  const SizedBox(height: 10.0),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.ejemplo),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\log_a{x} = y\rightarrow a^y = x"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                    formulaText: r"3^2 = 9 \rightarrow \log_3{9} = 2",
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
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
