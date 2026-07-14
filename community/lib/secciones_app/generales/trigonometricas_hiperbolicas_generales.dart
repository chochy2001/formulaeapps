import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TrigonometricasHiperbolicasGenerales extends StatefulWidget {
  const TrigonometricasHiperbolicasGenerales({super.key});
  @override
  State<TrigonometricasHiperbolicasGenerales> createState() =>
      _TrigonometricasHiperbolicasGeneralesState();
}

class _TrigonometricasHiperbolicasGeneralesState
    extends State<TrigonometricasHiperbolicasGenerales> {
  bool seleccionadoSenoHiperbolico = false;
  bool seleccionadoCosenoHiperbolico = false;
  bool seleccionadoTangenteHiperbolica = false;
  bool seleccionadoCotangenteHiperbolica = false;
  bool seleccionadoSecanteHiperbolica = false;
  bool seleccionadoCosecanteHiperbolica = false;
  bool seleccionadoNotas = false;

  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
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
        child: ListView(
          children: [
            TituloPersonalizado(
              AppLocalizations.of(context)!.trigonometricasHiperbolicas,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .trigonometricasHiperbolicas,
                      widgetName: kWidgetTrigonometricasHiperbolicasGenerales),
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
                                  .trigonometricasHiperbolicas,
                              widgetName:
                                  kWidgetTrigonometricasHiperbolicasGenerales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .trigonometricasHiperbolicas,
                              widgetName:
                                  kWidgetTrigonometricasHiperbolicasGenerales),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 30.0,
            ),
            //Seno Hiperbólico
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoSenoHiperbolico = !seleccionadoSenoHiperbolico;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoSenoHiperbolico
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color:
                      seleccionadoSenoHiperbolico ? kColorFondo : kColorBotones,
                ),
                width: seleccionadoSenoHiperbolico ? 80.0 : 50.0,
                height: seleccionadoSenoHiperbolico ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.senoHiperbolico,
                    ),
                    SizedBox(
                      width: seleccionadoSenoHiperbolico ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoSenoHiperbolico,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoSenoHiperbolico,
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: seleccionadoSenoHiperbolico,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sinh\thinspace x = \frac{e^x-e^{-x}}{2}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.dominio,
                    ),
                    const Latex(formulaText: r" \mathbb R"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.imagen,
                    ),
                    const Latex(formulaText: r" \mathbb R"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Coseno Hiperbólico
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoCosenoHiperbolico =
                      !seleccionadoCosenoHiperbolico;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoCosenoHiperbolico
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoCosenoHiperbolico
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoCosenoHiperbolico ? 80.0 : 50.0,
                height: seleccionadoCosenoHiperbolico ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cosenoHiperbolico,
                    ),
                    SizedBox(
                      width: seleccionadoCosenoHiperbolico ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoCosenoHiperbolico,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoCosenoHiperbolico,
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: seleccionadoCosenoHiperbolico,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\cosh\thinspace x = \frac{e^x+e^{-x}}{2}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.dominio,
                    ),
                    const Latex(formulaText: r" \mathbb R"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.imagen,
                    ),
                    const Latex(formulaText: r" [1,+\infty)"),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Tangente Hiperbólica
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoTangenteHiperbolica =
                      !seleccionadoTangenteHiperbolica;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoTangenteHiperbolica
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoTangenteHiperbolica
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoTangenteHiperbolica ? 80.0 : 50.0,
                height: seleccionadoTangenteHiperbolica ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.tangenteHiperbolica,
                    ),
                    SizedBox(
                      width: seleccionadoTangenteHiperbolica ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoTangenteHiperbolica,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoTangenteHiperbolica,
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: seleccionadoTangenteHiperbolica,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\tanh\thinspace x = \frac{\sinh\thinspace x}{\cosh\thinspace x} = \frac{e^x-e^{-x}}{e^x+e^{-x}}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.dominio,
                    ),
                    const Latex(formulaText: r"\mathbb R"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.imagen,
                    ),
                    const Latex(formulaText: r"(-1,1)"),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),

            //Cotangente Hiperbólica
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoCotangenteHiperbolica =
                      !seleccionadoCotangenteHiperbolica;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoCotangenteHiperbolica
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoCotangenteHiperbolica
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoCotangenteHiperbolica ? 80.0 : 50.0,
                height: seleccionadoCotangenteHiperbolica ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cotangenteHiperbolica,
                    ),
                    SizedBox(
                      width: seleccionadoCotangenteHiperbolica ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoCotangenteHiperbolica,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoCotangenteHiperbolica,
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: seleccionadoCotangenteHiperbolica,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\coth\thinspace x = \frac{1}{\tanh\thinspace x} = \frac{e^x+e^{-x}}{e^x-e^{-x}}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.dominio,
                    ),
                    const Latex(formulaText: r"\mathbb R \setminus \{0\}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.imagen,
                    ),
                    const Latex(formulaText: r"(-\infty,-1)\cup(1,+\infty)"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),

            //Secante Hiperbólica
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoSecanteHiperbolica =
                      !seleccionadoSecanteHiperbolica;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoSecanteHiperbolica
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoSecanteHiperbolica
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoSecanteHiperbolica ? 80.0 : 50.0,
                height: seleccionadoSecanteHiperbolica ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.secanteHiperbolica,
                    ),
                    SizedBox(
                      width: seleccionadoSecanteHiperbolica ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoSecanteHiperbolica,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoSecanteHiperbolica,
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: seleccionadoSecanteHiperbolica,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"sech \thinspace x = \frac{1}{\cosh\thinspace x} = \frac{2}{e^x+e^{-x}}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.dominio,
                    ),
                    const Latex(formulaText: r"\mathbb R"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.imagen,
                    ),
                    const Latex(formulaText: r" (0,1]"),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),

            //Cosecante Hiperbólica
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoCosecanteHiperbolica =
                      !seleccionadoCosecanteHiperbolica;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoCosecanteHiperbolica
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoCosecanteHiperbolica
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoCosecanteHiperbolica ? 80.0 : 50.0,
                height: seleccionadoCosecanteHiperbolica ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cosecanteHiperbolica,
                    ),
                    SizedBox(
                      width: seleccionadoCosecanteHiperbolica ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoCosecanteHiperbolica,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoCosecanteHiperbolica,
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: seleccionadoCosecanteHiperbolica,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"csch\thinspace x = \frac{1}{\sinh\thinspace x} = \frac{2}{e^x-e^{-x}}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.dominio,
                    ),
                    const Latex(formulaText: r" \mathbb R \setminus \{0\}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.imagen,
                    ),
                    const Latex(formulaText: r" \mathbb R \setminus \{0\}"),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
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

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetTrigonometricasHiperbolicasGenerales,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetTrigonometricasHiperbolicasGenerales,
            ),

            //Notas
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoNotas = !seleccionadoNotas;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 600),
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
                    Visibility(
                      visible: !seleccionadoNotas,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoNotas,
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: !seleccionadoNotas,
                      child: Column(
                        children: [
                          TextoEcuaciones(
                            AppLocalizations.of(context)!.dominio,
                          ),
                          TextoEcuaciones(
                            AppLocalizations.of(context)!.explicacionDominio,
                          ),
                          const SizedBox(height: kEspacioEntreBotones),
                          TextoEcuaciones(
                            AppLocalizations.of(context)!.imagen,
                          ),
                          TextoEcuaciones(
                            AppLocalizations.of(context)!.explicacionImagen,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
