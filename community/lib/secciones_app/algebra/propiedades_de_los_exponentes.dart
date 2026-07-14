import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class PropiedadesDeLosExponentes extends StatefulWidget {
  const PropiedadesDeLosExponentes({super.key});
  @override
  State<PropiedadesDeLosExponentes> createState() =>
      _PropiedadesDeLosExponentesState();
}

class _PropiedadesDeLosExponentesState
    extends State<PropiedadesDeLosExponentes> {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TituloPersonalizado(
                  AppLocalizations.of(context)!.propiedadesExponentes,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    mostrarInfo(
                      context,
                      AppLocalizations.of(context)!.propiedadesExponentesTexto,
                    );
                  },
                ),
                adContainer,
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                          title: AppLocalizations.of(context)!
                              .propiedadesExponentes,
                          widgetName: kWidgetPropiedadesDeLosExponentes),
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
                                      .propiedadesExponentes,
                                  widgetName:
                                      kWidgetPropiedadesDeLosExponentes),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                  title: AppLocalizations.of(context)!
                                      .propiedadesExponentes,
                                  widgetName:
                                      kWidgetPropiedadesDeLosExponentes),
                            );
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: kEspacioEntreBotones),
                ZoomPersonalizado(
                  child: ZoomPersonalizado(
                    child: Column(
                      children: [
                        const Latex(formulaText: r"a^1 = a"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a^n \cdot a^m = a^{n+m}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"{\frac{a^{n}}{{a^m}}} = {a^{n-m}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"{a^0 = 1 }"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.aDiferenteDeCero,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"{{(a^m)^n={a^{m\cdot  n}}}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(a\cdot b)^m=a^m\cdot b^m"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"(a\cdot b\cdot c)^m = a^m\cdot b^m\cdot c^m"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"a^{\frac{n}{m}}=\sqrt[m]{a^{n}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\left(\frac{a}{b}\right)^{n}={\frac{a^n}{b^n}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"{\left(\frac{a}{b}\right)^{-n}=\frac{b^n}{a^n}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a^{-n}=\frac{1}{a^n}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\left(\frac{a}{b}\right)^{-1}=\frac{b}{a}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => mostrarEjemplos(context),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.ejercicios,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetPropiedadesDeLosExponentes,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetPropiedadesDeLosExponentes,
            ),
            const VideosYoutube(kVideoPropiedadesDeLosExponentes),
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
                  const Latex(formulaText: r"(\cdot)"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.multiplicacion,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"a^{n}= {a} \cdot {a} \cdot {a} "),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.nVeces,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"ab = a\cdot b"),
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
