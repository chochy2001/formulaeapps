import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MedicionYClasificacionDeAngulos extends StatefulWidget {
  @override
  _MedicionYClasificacionDeAngulosState createState() =>
      _MedicionYClasificacionDeAngulosState();
}

class _MedicionYClasificacionDeAngulosState
    extends State<MedicionYClasificacionDeAngulos> {
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
                    AppLocalizations.of(context)!
                        .medicionYClasificacionDeAngulos,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .medicionYClasificacionDeAngulos,
                            widgetName: kWidgetMedicionYClasificacionDeAngulos),
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
                                        .medicionYClasificacionDeAngulos,
                                    widgetName:
                                        kWidgetMedicionYClasificacionDeAngulos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .medicionYClasificacionDeAngulos,
                                    widgetName:
                                        kWidgetMedicionYClasificacionDeAngulos),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.sistema}               ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${AppLocalizations.of(context)!.sexagesimal}    ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: AppLocalizations.of(context)!.circular,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.unidad}                 ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${AppLocalizations.of(context)!.grados}              ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: AppLocalizations.of(context)!.radian,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.circunferencia}   ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                          children: const <TextSpan>[
                            TextSpan(
                                text: '360°                   ',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: 'πd',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.grados,
                        ),
                        Latex(
                            formulaText: r"\frac{(180^\circ " +
                                AppLocalizations.of(context)!.radianes +
                                r")}{\pi}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.radianes,
                        ),
                        Latex(
                            formulaText: r"\frac{(\pi )" +
                                AppLocalizations.of(context)!.grados +
                                r"}{180^\circ}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!
                          .clasificacionSegunMedida,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.anguloRecto,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.anguloLlano,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.anguloAgudo,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.anguloObtuso,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!
                          .clasificacionSegunValorSuma,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!
                              .angulosComplementarios,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!
                              .angulosSuplementarios,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.angulosConjugados,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMedicionYClasificacionDeAngulos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMedicionYClasificacionDeAngulos,
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
