import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuTrigonometriaEsferica extends StatefulWidget {
  const MenuTrigonometriaEsferica({Key? key}) : super(key: key);

  @override
  MenuTrigonometriaEsfericaState createState() =>
      MenuTrigonometriaEsfericaState();
}

class MenuTrigonometriaEsfericaState extends State<MenuTrigonometriaEsferica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.trigonometriaEsferica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.analogiasDeGaussDelambre,
                    ruta: kRutaAnalogiasDeGaussDelambre,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.analogiasDeNeper,
                    ruta: kRutaAnalogiasDeNeper,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.funcionesDelAnguloMitad,
                    ruta: kRutaFuncionesDelAnguloMitad,
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
