import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuVectoresLineal extends StatefulWidget {
  const MenuVectoresLineal({super.key});

  @override
  MenuVectoresLinealState createState() => MenuVectoresLinealState();
}

class MenuVectoresLinealState extends State<MenuVectoresLineal> {
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
        child: FondoDegradado(
          child: ListView(
            children: [
              TextButton(
                onPressed: () {},
                child: const ImagenLogoFormulae(),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.vectores,
                  style: kTextoBotones,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              adContainer,
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Ecuaciones Lineales
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.anguloEntreVectores,
                      ruta: kRutaAnguloEntreVectores,
                    ),
                    //Formulas de Productos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.normalizacion,
                      ruta: kRutaNormalizacion,
                    ),
                    //Formula General
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.operacionesConVectores,
                      ruta: kRutaOperacionesConVectores,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.productoCruz,
                      ruta: kRutaProductoCruz,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.productoPunto,
                      ruta: kRutaProductoPunto,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .propiedadesDeLosVectores,
                      ruta: kRutaPropiedadesDeLosVectores,
                    ),
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.proyeccionesDeVectores,
                      ruta: kRutaProyeccionesDeVectores,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.vectorUnitario,
                      ruta: kRutaVectorUnitario,
                    ),
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.vectoresYSuMagnitud,
                      ruta: kRutaVectoresYSuMagnitud,
                    ),
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
