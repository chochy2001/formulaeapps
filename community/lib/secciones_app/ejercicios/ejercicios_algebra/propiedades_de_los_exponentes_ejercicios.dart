import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class PropiedadesDeLosExponentesEjercicios extends StatefulWidget {
  const PropiedadesDeLosExponentesEjercicios({super.key});
  @override
  State<PropiedadesDeLosExponentesEjercicios> createState() =>
      _PropiedadesDeLosExponentesEjerciciosState();
}

class _PropiedadesDeLosExponentesEjerciciosState
    extends State<PropiedadesDeLosExponentesEjercicios> {
  bool _respuestaCorrecta = true;
  bool seleccionadoMostrar = false;
  double catetoOpuesto = 0.0, catetoAdyacente = 0.0, hipotenusa = 0.0;

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TituloPersonalizado(
                  AppLocalizations.of(context)!
                      .ejerciciosPropiedadesDeLosExponentes,
                ),
                adContainer,
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                          title: AppLocalizations.of(context)!
                              .ejerciciosPropiedadesDeLosExponentes,
                          widgetName:
                              kWidgetPropiedadesDeLosExponentesEjercicios),
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
                                      .ejerciciosPropiedadesDeLosExponentes,
                                  widgetName:
                                      kWidgetPropiedadesDeLosExponentesEjercicios),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                  title: AppLocalizations.of(context)!
                                      .ejerciciosPropiedadesDeLosExponentes,
                                  widgetName:
                                      kWidgetPropiedadesDeLosExponentesEjercicios),
                            );
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            //Pregunta 1
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"2^2 \cdot 2^5 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"3^9 \cdot 3^2 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta1,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BotonVerPistas(
                    Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(r"a^n \cdot a^m = a^{n+m}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  BotonVerRespuesta(
                    Column(
                      children: [
                        Math.tex(r"2^{7} = 128",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kBordeBotones),
                        Math.tex(r"2^{2} \cdot 2^5 = 2^{2+5} = 2^7 = 128",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(r"3^{11} = 177147",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kBordeBotones),
                        Math.tex(
                            r"3^{9} \cdot 3^{2} = 3^{9+2} = 3^{11} = 177147",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                ]),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),

            //Pregunta 2
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"10^1 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"987^1 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"a^1 = a",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(r"10^1 = 10",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"987^1 = 987",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),
            //Pregunta 3
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"\frac{2^3}{2^2}= \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"\frac{5^{10}}{5^5}= \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kBordeBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"{\frac{a^{n}}{{a^m}}} = {a^{n-m}}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(r"\frac{2^3}{2^2} = \space 2^{(3-2)} = 2^1 = 2",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(
                          r"\frac{5^{10}}{5^5} = \space 5^{(10-5)} = 5^5 = 3125",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),
            //Pregunta 4
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"1000^0 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"\pi^0 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kBordeBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"a^0 = 1",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.aDiferenteDeCero,
                      )
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(r"1000^0 = \space 1",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"\pi^0 = \space 1",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),

            //Pregunta 5
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"(4^2)^2 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"(4^3)^2 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kBordeBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"{(a^m)^n={a^{m\cdot  n}}}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(r"(4^2)^2 = \space 4^{(2\cdot 2)}= 4^4 = 256",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"(4^3)^2 = \space 4^{(3\cdot 2)}= 4^6 = 4096",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),
            //Pregunta 6
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"(5\cdot 2)^3 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"(3\cdot 7)^2 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kBordeBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"({a\cdot b})^m={a^m}\cdot{b^m}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(r"(5\cdot 2)^3 = \space 5^3\cdot 2^3",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"(3\cdot 7)^2 = \space 3^2 \cdot 7^2",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),

            //Pregunta 7
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"6^{\frac{1}{2}} = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"4^{\frac{3}{4}} = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kBordeBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"{a^{\frac{n}{m}}=\sqrt[m]{a^{n}}}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(r"6^{\frac{1}{2}} = \space \sqrt{6} ",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(
                          r"4^{\frac{3}{4}} = \space \sqrt[4]{4^3} = \sqrt[4]{64}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),

            //Pregunta 8
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"\left( \frac{2}{3} \right)^2 = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(
                      r"\left( \frac{4}{6} \right)^{\frac{1}{2}} = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kBordeBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(
                          r"{\left(\frac{a}{b}\right)^{n}={\frac{a^n}{b^n}}}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(
                          r"\left( \frac{2}{3} \right)^2 = \space \frac{2^2}{3^2} = \frac{4}{9}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(
                          r"\left( \frac{4}{6} \right)^{\frac{1}{2}} = \space \frac{4^{\frac{1}{2}}}{6^{\frac{1}{2}}} =\frac{\sqrt{4}}{\sqrt{6}}= \frac{2}{\sqrt{6}} =\frac{\sqrt{6}}{3}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),

            //Pregunta 9
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"\left( \frac{4}{6} \right)^{-2} = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(
                      r"\left( \frac{3}{9} \right)^{-\frac{1}{2}} = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kBordeBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"\left(\frac{a}{b}\right)^{-n}=\frac{b^n}{a^n}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(
                          r"\left( \frac{4}{6} \right)^{-2} = \space \frac{6^2}{4^2} = \frac{36}{16} =\frac{9}{4}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(
                          r"\left( \frac{3}{9} \right)^{-\frac{1}{2}} = \space \frac{9^{\frac{1}{2}}}{3^{\frac{1}{2}}} = \frac{\sqrt{9}}{\sqrt{3}} = \frac{3}{\sqrt{3}} = \sqrt{3}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),

            //Pregunta 10
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"43^{-2} = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"12^{-5} = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kBordeBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"a^{-n}=\frac{1}{a^n}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(
                          r"43^{-2} = \space \frac{1}{43^2} = \frac{1}{1849}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(
                          r"12^{-5} = \space \frac{1}{12^5} = \frac{1}{248832}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),

            //Pregunta 11
            PreguntasEjercicios(
              pregunta: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"\left( \frac{5}{6} \right)^{-1} = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kEspacioEntreBotones),
                  Math.tex(r"\left( \frac{12}{10} \right)^{-1} = \space ?",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: kBordeBotones),
                ],
              ),
              texto: AppLocalizations.of(context)!.pregunta11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonVerPistas(
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(r"\left(\frac{a}{b}\right)^{-1}=\frac{b}{a}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
                BotonVerRespuesta(
                  Column(
                    children: <Widget>[
                      Math.tex(
                          r"\left( \frac{5}{6} \right)^{-1} = \space \frac{6}{5}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                      const SizedBox(height: kEspacioEntreBotones),
                      Math.tex(
                          r"\left( \frac{12}{10} \right)^{-1} = \space \frac{10}{12} = \frac{5}{6}",
                          mathStyle: MathStyle.display,
                          textStyle: kTextoLatexFormulas),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntrePistas),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: kEspacioEntrePistas),

            /// Ver respuestas correctas
            /// (En esta sección sera para mostrar todas las respuestas correctas de las preguntas anteriores)
            //Boton que muestra la respuesta correcta

            Container(
              color: kColorBotones,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _respuestaCorrecta = !_respuestaCorrecta;
                  });
                },
                child: const TextoBotonesDelgado(
                  'Ocultar/Mostrar\nRespuestas',
                ),
              ),
            ),
            //Con este visibility se muestra la respuesta correcta
            Visibility(
              visible: _respuestaCorrecta,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  //Respuesta 1
                  RespuestaEjercicios(
                    texto: AppLocalizations.of(context)!.respuesta1,
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(r"2^{7} = 128",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kBordeBotones),
                        Math.tex(r"2^{2} \cdot 2^5 = 2^{2+5} = 2^7 = 128",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(r"3^{11} = 177147",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kBordeBotones),
                        Math.tex(
                            r"3^{9} \cdot 3^{2} = 3^{9+2} = 3^{11} = 177147",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Respuesta 2
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(r"10^1 = 10",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(r"987^1 = 987",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta2,
                  ),
                  //Respuesta 3
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(
                            r"\frac{2^3}{2^2} = \space 2^{(3-2)} = 2^1 = 2",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(
                            r"\frac{5^{10}}{5^5} = \space 5^{(10-5)} = 5^5 = 3125",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta3,
                  ),
                  //Respuesta 4
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(r"1000^0 = \space 1",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(r"\pi^0 = \space 1",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta4,
                  ),
                  //Respuesta 5
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(r"(4^2)^2 = \space 4^{(2\cdot 2)}= 4^4 = 256",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(r"(4^3)^2 = \space 4^{(3\cdot 2)}= 4^6 = 4096",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta5,
                  ),
                  //Respuesta 6
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(r"(5\cdot 2)^3 = \space 5^3\cdot 2^3",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(r"(3\cdot 7)^2 = \space 3^2 \cdot 7^2",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta6,
                  ),
                  //Respuesta 7
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(r"6^{\frac{1}{2}} = \space \sqrt{6} ",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(
                            r"4^{\frac{3}{4}} = \space \sqrt[4]{4^3} = \sqrt[4]{64}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta7,
                  ),
                  //Respuesta 8
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(
                            r"\left( \frac{2}{3} \right)^2 = \space \frac{2^2}{3^2} = \frac{4}{9}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(
                            r"\left( \frac{4}{6} \right)^{\frac{1}{2}} = \space \frac{4^{\frac{1}{2}}}{6^{\frac{1}{2}}} =\frac{\sqrt{4}}{\sqrt{6}}= \frac{2}{\sqrt{6}} =\frac{\sqrt{6}}{3}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta8,
                  ),
                  //Respuesta 9
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(
                            r"\left( \frac{4}{6} \right)^{-2} = \space \frac{6^2}{4^2} = \frac{36}{16} =\frac{9}{4}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(
                            r"\left( \frac{3}{9} \right)^{-\frac{1}{2}} = \space \frac{9^{\frac{1}{2}}}{3^{\frac{1}{2}}} = \frac{\sqrt{9}}{\sqrt{3}} = \frac{3}{\sqrt{3}} = \sqrt{3}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta9,
                  ),
                  //Respuesta 10
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(
                            r"43^{-2} = \space \frac{1}{43^2} = \frac{1}{1849}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(
                            r"12^{-5} = \space \frac{1}{12^5} = \frac{1}{248832}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta10,
                  ),
                  //Respuesta 11
                  RespuestaEjercicios(
                    respuesta: Column(
                      children: [
                        const SizedBox(height: kBordeBotones),
                        Math.tex(
                            r"\left( \frac{5}{6} \right)^{-1} = \space \frac{6}{5}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        Math.tex(
                            r"\left( \frac{12}{10} \right)^{-1} = \space \frac{10}{12} = \frac{5}{6}",
                            mathStyle: MathStyle.display,
                            textStyle: kTextoLatexFormulas),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                    texto: AppLocalizations.of(context)!.respuesta11,
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
