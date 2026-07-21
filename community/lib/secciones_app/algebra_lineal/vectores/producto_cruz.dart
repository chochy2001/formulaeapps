import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ProductoCruz extends StatefulWidget {
  const ProductoCruz({super.key});
  @override
  State<ProductoCruz> createState() => _ProductoCruzState();
}

class _ProductoCruzState extends State<ProductoCruz> {
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
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.productoCruz,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!.productoCruz,
                          widgetName: kWidgetProductoCruz,
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
                                  )!.productoCruz,
                                  widgetName: kWidgetProductoCruz,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.productoCruz,
                                  widgetName: kWidgetProductoCruz,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Latex(
                          formulaText:
                              r"\mathrm{u}\times\mathrm{v} = (|\mathrm{u}||\mathrm{v}|\sin\theta)\mathrm{n}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.vectoresParalelosSi,
                        ),
                        const Latex(
                          formulaText: r"\mathrm{u}\times\mathrm{v} = 0",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const TextoEcuaciones('Sí:'),
                        const Latex(
                          formulaText:
                              r"\mathrm{u}=u_1\mathrm{i}+u_2\mathrm{j}+u_3\mathrm{k}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\mathrm{v}=v_1\mathrm{i}+v_2\mathrm{j}+v_3\mathrm{k}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\mathrm{u}\times\mathrm{v}=\begin{vmatrix}\mathrm{i} & \mathrm{j} & \mathrm{k}\\u_1 & u_2 & u_3\\v_1 & v_2 & v_3\end{vmatrix}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.productoCruzDeterminante,
                        ),
                        const SizedBox(height: 50),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.propiedadesProductoCruz,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(a\mathrm{u}\times(b\mathrm{v})=(ab)(\mathrm{u}\times\mathrm{v})",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\mathrm{u}\times(\mathrm{v}+\mathrm{w})=\mathrm{u}\times\mathrm{v}+\mathrm{u}\times\mathrm{w}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"(\mathrm{v}+\mathrm{w})\times\mathrm{u}=\mathrm{v}\times\mathrm{u}+\mathrm{w}\times\mathrm{u}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\mathrm{v}\times\mathrm{u}=-(\mathrm{u}\times\mathrm{v})",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"0\times \mathrm{u}=0"),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetProductoCruz),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetProductoCruz),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(color: kColorFondo, width: 8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"\mathrm{u},\thinspace  \mathrm{v},\thinspace \mathrm{w}",
                        ),
                        TextoEcuaciones(AppLocalizations.of(context)!.vectores),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a,\thinspace b"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.escalares,
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
          ],
        ),
      ),
    );
  }
}
