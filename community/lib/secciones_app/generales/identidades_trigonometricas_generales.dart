import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class IdentidadesTrigonometricasGenerales extends StatefulWidget {
  @override
  _IdentidadesTrigonometricasGeneralesState createState() =>
      _IdentidadesTrigonometricasGeneralesState();
}

class _IdentidadesTrigonometricasGeneralesState
    extends State<IdentidadesTrigonometricasGenerales> {
  bool seleccionadoIdentidadesBasicas = false;
  bool seleccionadoIdentidadesPitagoricas = false;
  bool seleccionadoIdentidadesReciprocas = false;
  bool seleccionadoIdentidadesPorCociente = false;
  bool seleccionadoParImpar = false;
  bool seleccionadoSuplementoComplemento = false;
  bool seleccionadoAnguloDobleyMedio = false;
  bool seleccionadoSumayResta = false;
  bool seleccionadoProductoaSumaSumaaProducto = false;
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
              AppLocalizations.of(context)!.identidadesTrigonometricas,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .identidadesTrigonometricas,
                      widgetName: kWidgetIdentidadesTrigonometricasGenerales),
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
                                  .identidadesTrigonometricas,
                              widgetName:
                                  kWidgetIdentidadesTrigonometricasGenerales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .identidadesTrigonometricas,
                              widgetName:
                                  kWidgetIdentidadesTrigonometricasGenerales),
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
            //Apoyar al creador
            //Identidades Básicas
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoIdentidadesBasicas =
                      !seleccionadoIdentidadesBasicas;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoIdentidadesBasicas
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoIdentidadesBasicas
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoIdentidadesBasicas ? 80.0 : 50.0,
                height: seleccionadoIdentidadesBasicas ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.identidadesBasicas,
                    ),
                    SizedBox(
                      width: seleccionadoIdentidadesBasicas ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoIdentidadesBasicas,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoIdentidadesBasicas,
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
              visible: seleccionadoIdentidadesBasicas,
              child: const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\sin\thinspace x = \frac{1}{\csc\thinspace x}"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\cos\thinspace x = \frac{1}{\sec\thinspace x}"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\tan\thinspace x = \frac{\sin\thinspace x}{\cos\thinspace x} = \frac{1}{\cot\thinspace x}"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\csc\thinspace x = \frac{1}{\sin\thinspace x}"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\sec\thinspace x = \frac{1}{\cos\thinspace x}"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\cot\thinspace x = \frac{\cos\thinspace x}{\sin\thinspace x} = \frac{1}{\tan\thinspace x}"),
                    SizedBox(height: kEspacioEntreBotones),
                    VideosYoutube(kVideoIdentidadesBasicas),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Identidades Pitagoricas
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoIdentidadesPitagoricas =
                      !seleccionadoIdentidadesPitagoricas;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoIdentidadesPitagoricas
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoIdentidadesPitagoricas
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoIdentidadesPitagoricas ? 80.0 : 50.0,
                height: seleccionadoIdentidadesPitagoricas ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.identidadesPitagoricas,
                    ),
                    SizedBox(
                      width: seleccionadoIdentidadesPitagoricas ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoIdentidadesPitagoricas,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoIdentidadesPitagoricas,
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
              visible: seleccionadoIdentidadesPitagoricas,
              child: const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\sin^2\thinspace x+\cos^2\thinspace x = 1"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\csc^2\thinspace x = \cot^2\thinspace x+1"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\sec^2\thinspace x=\tan^2\thinspace x+1"),
                    SizedBox(height: kEspacioEntreBotones),
                    VideosYoutube(kVideoIdentidadesPitagoricas),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Identidades Reciprocas
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoIdentidadesReciprocas =
                      !seleccionadoIdentidadesReciprocas;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoIdentidadesReciprocas
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoIdentidadesReciprocas
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoIdentidadesReciprocas ? 80.0 : 50.0,
                height: seleccionadoIdentidadesReciprocas ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.identidadesReciprocas,
                    ),
                    SizedBox(
                      width: seleccionadoIdentidadesReciprocas ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoIdentidadesReciprocas,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoIdentidadesReciprocas,
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
              visible: seleccionadoIdentidadesReciprocas,
              child: ZoomPersonalizado(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sin\thinspace x\cdot \csc\thinspace x = 1"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\cos\thinspace x\cdot \sec\thinspace x = 1"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\tan\thinspace x\cdot \cot\thinspace x = 1"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Identidades Por Cociente
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoIdentidadesPorCociente =
                      !seleccionadoIdentidadesPorCociente;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoIdentidadesPorCociente
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoIdentidadesPorCociente
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoIdentidadesPorCociente ? 80.0 : 50.0,
                height: seleccionadoIdentidadesPorCociente ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.identidadesPorCociente,
                    ),
                    SizedBox(
                      width: seleccionadoIdentidadesPorCociente ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoIdentidadesPorCociente,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoIdentidadesPorCociente,
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
              visible: seleccionadoIdentidadesPorCociente,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\tan\thinspace x = \frac{\sin\thinspace x}{\cos\thinspace x}"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\cot\thinspace x = \frac{\cos\thinspace x}{\sin\thinspace x}"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Par e Impar
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoParImpar = !seleccionadoParImpar;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoParImpar
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoParImpar ? kColorFondo : kColorBotones,
                ),
                width: seleccionadoParImpar ? 80.0 : 50.0,
                height: seleccionadoParImpar ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.parEImpar,
                    ),
                    SizedBox(
                      width: seleccionadoParImpar ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoParImpar,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoParImpar,
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
              visible: seleccionadoParImpar,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\sin(-\theta) = -\sin\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\cos(-\theta) = -\cos\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\tan(-\theta) = -\tan\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\csc(-\theta) = -\csc\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\cot(-\theta) = -\cot\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Suplemento, Complemento
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoSuplementoComplemento =
                      !seleccionadoSuplementoComplemento;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoSuplementoComplemento
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoSuplementoComplemento
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoSuplementoComplemento ? 80.0 : 50.0,
                height: seleccionadoSuplementoComplemento ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.suplementoComplemento,
                    ),
                    SizedBox(
                      width: seleccionadoSuplementoComplemento ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoSuplementoComplemento,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoSuplementoComplemento,
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
              visible: seleccionadoSuplementoComplemento,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText: r"\sin(\pi\pm\theta) = \mp \sin\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sin(\frac{\pi}{2}-\theta) = \cos\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText: r"\cos(\pi\pm\theta) = - \cos\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\cos(\frac{\pi}{2}-\theta) = \sin\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Angulo Doble y medio
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoAnguloDobleyMedio =
                      !seleccionadoAnguloDobleyMedio;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoAnguloDobleyMedio
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoAnguloDobleyMedio
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoAnguloDobleyMedio ? 80.0 : 50.0,
                height: seleccionadoAnguloDobleyMedio ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.anguloDobleYMedio,
                    ),
                    SizedBox(
                      width: seleccionadoAnguloDobleyMedio ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoAnguloDobleyMedio,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoAnguloDobleyMedio,
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
              visible: seleccionadoAnguloDobleyMedio,
              child: ZoomPersonalizado(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sin(2\theta) = 2\sin\theta\cdot cos\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\cos(2\theta) = cos^2\theta - \sin^2\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText: r"\cos(2\theta) = 1 - 2\sin^2\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText: r"\cos(2\theta) = 2\cos^2\theta - 1"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\tan(2\theta) = \frac{2\tan\theta}{1-\tan^2\theta}"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sin\frac{\theta}{2} = \pm \sqrt{\frac{1-\cos\theta}{2}}"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\cos\frac{\theta}{2} = \pm \sqrt{\frac{1+\cos\theta}{2}}"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\tan\frac{\theta}{2} = \pm \sqrt{\frac{1-\cos\theta}{1+\cos\theta}}"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\tan\frac{\theta}{2} = \frac{1-\cos\theta}{\sin\theta} =\frac{\sin\theta}{1+\cos\theta}"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Suma y Resta
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoSumayResta = !seleccionadoSumayResta;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoSumayResta
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoSumayResta ? kColorFondo : kColorBotones,
                ),
                width: seleccionadoSumayResta ? 80.0 : 50.0,
                height: seleccionadoSumayResta ? 50.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.sumaYResta,
                    ),
                    SizedBox(
                      width: seleccionadoSumayResta ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoSumayResta,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: kColorTextoBotones,
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoSumayResta,
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
              visible: seleccionadoSumayResta,
              child: ZoomPersonalizado(
                child: Column(
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"1+\tan^2\thinspace x = \sec^2\thinspace x"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"1+\cot^2\thinspace x = \csc^2\thinspace x"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sin(\theta\pm\beta) = \sin\theta \cdot \cos\beta\pm \sin\beta\cdot\cos\theta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\cos(\theta\pm\beta) = \cos\theta \cdot \cos\beta\mp \sin\theta\cdot\cos\beta"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\tan(\theta\pm\beta) = \frac{\tan\theta\pm \tan\beta}{1\mp \tan\theta\cdot tan\beta}"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Suma a Producto
            GestureDetector(
              onTap: () {
                setState(() {
                  seleccionadoProductoaSumaSumaaProducto =
                      !seleccionadoProductoaSumaSumaaProducto;
                });
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                alignment: seleccionadoProductoaSumaSumaaProducto
                    ? Alignment.center
                    : AlignmentDirectional.center,
                decoration: BoxDecoration(
                  border: Border.all(color: kColorBotones),
                  borderRadius: BorderRadius.circular(kBordeBotones),
                  color: seleccionadoProductoaSumaSumaaProducto
                      ? kColorFondo
                      : kColorBotones,
                ),
                width: seleccionadoProductoaSumaSumaaProducto ? 80.0 : 80.0,
                height: seleccionadoProductoaSumaSumaaProducto ? 80.0 : 80.0,
                duration: const Duration(milliseconds: 600),
                child: Column(
                  children: [
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.sumaAProductoYViceversa,
                    ),
                    SizedBox(
                      width:
                          seleccionadoProductoaSumaSumaaProducto ? 5.0 : 10.0,
                    ),
                    Visibility(
                      visible: !seleccionadoProductoaSumaSumaaProducto,
                      child: const Center(
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          color: kColorTextoBotones,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: seleccionadoProductoaSumaSumaaProducto,
                      child: const Center(
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          color: kColorTextoBotones,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: seleccionadoProductoaSumaSumaaProducto,
              child: ZoomPersonalizado(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sin\theta+ \sin\beta = 2\sin\left(\frac{\theta+\beta}{2}\right)\cos\left(\frac{\theta-\beta}{2}\right)"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sin\theta- \sin\beta = 2\sin\left(\frac{\theta-\beta}{2}\right)\cos\left(\frac{\theta+\beta}{2}\right)"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\cos\theta+ \cos\beta = 2\cos\left(\frac{\theta+\beta}{2}\right)\cos\left(\frac{\theta-\beta}{2}\right)"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const SafeArea(
                      child: Latex(
                          formulaText:
                              r"\cos\theta- \cos\beta = -2\sin\left(\frac{\theta+\beta}{2}\right)\sin\left(\frac{\theta-\beta}{2}\right)"),
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sin\theta \cdot sin\beta = \frac{1}{2}[\cos(\theta-\beta)-\cos(\theta+\beta)]"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\cos\theta \cdot \cos\beta = \frac{1}{2}[\cos(\theta-\beta)+\cos(\theta+\beta)]"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"\sin\theta \cdot \cos\beta = \frac{1}{2}[\sin(\theta+\beta)+\sin(\theta-\beta)]"),
                    Math.tex(r"",
                        mathStyle: MathStyle.display,
                        textStyle: kTextoLatexFormulas),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetIdentidadesTrigonometricasGenerales,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetIdentidadesTrigonometricasGenerales,
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
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"\sin"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.seno,
                      ),
                      Math.tex(r"",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"\cos"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.coseno,
                      ),
                      Math.tex(r"",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"\tan"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.tangente,
                      ),
                      Math.tex(r"",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"\csc"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.cosecante,
                      ),
                      Math.tex(r"",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"\sec"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.secante,
                      ),
                      Math.tex(r"",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"\cot"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.cotangente,
                      ),
                      Math.tex(r"",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"\pm"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.masMenos,
                      ),
                      Math.tex(r"",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.interpretacionMasMenos,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
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
