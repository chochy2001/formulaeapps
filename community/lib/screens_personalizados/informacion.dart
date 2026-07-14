import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constantes/export_constantes.dart';

class Informacion extends StatelessWidget {
  const Informacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.informacion,
                  style: GoogleFonts.poppins(
                    textStyle: kEstiloTextoMenus,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const ImagenRemotaRobusta(
                  height: 200.0,
                  width: 200.0,
                  urlImagen: kUrlImagenFormulae,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  AppLocalizations.of(context)!.formulaePro,
                  style: GoogleFonts.poppins(
                    textStyle: kTextoBotones,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  AppLocalizations.of(context)!.descripcionApp,
                  style: GoogleFonts.poppins(
                    textStyle: kTexto,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  AppLocalizations.of(context)!.desarrolladoPor,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: kTextoDelgado,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.contacto,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: kTextoDelgado,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
