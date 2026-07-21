import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuLimites extends StatefulWidget {
  const MenuLimites({super.key});

  @override
  MenuLimitesState createState() => MenuLimitesState();
}

class MenuLimitesState extends State<MenuLimites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
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
                    AppLocalizations.of(context)!.limites,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  //Propiedades de los Limites
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.propiedadesDeLosLimites,
                    ruta: kRutaPropiedadesLimites,
                  ),
                  //Limites Trigonometricos
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.limitesTrigonometricos,
                    ruta: kRutaLimitesTrigonometricos,
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
