import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class LeyesDeLaLogicaProposicional extends StatefulWidget {
  const LeyesDeLaLogicaProposicional({super.key});
  @override
  State<LeyesDeLaLogicaProposicional> createState() =>
      _LeyesDeLaLogicaProposicionalState();
}

class _LeyesDeLaLogicaProposicionalState
    extends State<LeyesDeLaLogicaProposicional> {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.leyesDeLaLogicaProposicional,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .leyesDeLaLogicaProposicional,
                            widgetName: kWidgetLeyesDeLaLogicaProposicional),
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
                                        .leyesDeLaLogicaProposicional,
                                    widgetName:
                                        kWidgetLeyesDeLaLogicaProposicional),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .leyesDeLaLogicaProposicional,
                                    widgetName:
                                        kWidgetLeyesDeLaLogicaProposicional),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  ZoomPersonalizado(
                      child: Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"v"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.esTautologia,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"f"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.esContradiccion,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.dobleNegacion,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText: r"\overline{\overline{p}}\equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.deMorgan,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"\overline{p\lor q}\equiv \overline{p}\land \overline{q}"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"\overline{p\land q}\equiv \overline{p}\lor \overline{q}"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.conmutativa,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\lor q \equiv q\lor p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land q \equiv q\land p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.asociativa,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"(p\lor q)\lor r \equiv p\lor (q\lor r)"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"(p\land q)\lor r \equiv p\land (q\land r)"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.distributiva,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"p\land(q\lor r)\equiv (p\land q)\lor(p\land r)"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"p\lor(q\land r)\equiv (p\lor q)\land (p\lor r)"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.idempotencia,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\lor p \equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land p \equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.neutros,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\lor f \equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land v \equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.dominacion,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land f \equiv f"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\lor v \equiv v"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.inversos,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p \lor \overline{p} \equiv v"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText: r"p \land \overline{p} \equiv f"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.absorcion,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p \lor (p\land q)\equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land (p\lor q)\equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
                  )),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetLeyesDeLaLogicaProposicional,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetLeyesDeLaLogicaProposicional,
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
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"(\equiv) = (\leftrightarrow) = (\Leftrightarrow)"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.siysolosi,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(\land) = (\&)"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conjuncionLogica,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(\lor)"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.disyuncionLogica,
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
