import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MenuConversionDeUnidades extends StatefulWidget {
  const MenuConversionDeUnidades({super.key});

  @override
  MenuConversionDeUnidadesState createState() => MenuConversionDeUnidadesState();
}

class MenuConversionDeUnidadesState extends State<MenuConversionDeUnidades> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(
        visible: false,
      ),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              MenuColumn(
                children: [
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.seccionConversionDeUnidades,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.longitudConversion,
                    ruta: kRutaLongitudConversion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.superficieConversion,
                    ruta: kRutaSuperficieConversion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.volumenConversion,
                    ruta: kRutaVolumenConversion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.masaConversion,
                    ruta: kRutaMasaConversion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.densidadConversion,
                    ruta: kRutaDensidadConversion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.presionConversion,
                    ruta: kRutaPresionConversion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.energiaConversion,
                    ruta: kRutaEnergiaConversion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.potenciaConversion,
                    ruta: kRutaPotenciaConversion,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
