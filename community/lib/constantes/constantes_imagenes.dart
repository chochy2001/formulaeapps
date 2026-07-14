import 'package:flutter/material.dart';

import 'export_constantes.dart';

/// Canonical, language-neutral image URL for every image identifier.
///
/// Explanatory prose belongs in Flutter localizations, not in image pixels.
/// A single route per identifier keeps every current and future locale on the
/// same verified diagram.
const Map<String, String> imageUrlMap = {
  kImagenFavoritos: kUrlImagenFavoritos,
  kImagenAgregarTarea: kUrlImagenAgregarTarea,
  kImagenCapacitor1: kUrlImagenCapacitor1,
  kImagenCapacitor2: kUrlImagenCapacitor2,
  kImagenCircuitoRCYVoltajeContinuo: kUrlImagenCircuitoRCYVoltajeContinuo,
  kImagenCircuitoRCYVoltajeContinuo2: kUrlImagenCircuitoRCYVoltajeContinuo2,
  kImagenConexionEnParaleloResistor: kUrlImagenConexionEnParaleloResistor,
  kImagenConexionEnSerieResistor: kUrlImagenConexionEnSerieResistor,
  kImagenCorrienteEnElCapacitor: kUrlImagenCorrienteEnElCapacitor,
  kImagenCorrienteEnElCapacitor1: kUrlImagenCorrienteEnElCapacitor1,
  kImagenDiferenciaDePotencialEnElCapacitor:
      kUrlImagenDiferenciaDePotencialEnElCapacitor,
  kImagenDiferenciaDePotencialEnElCapacitor1:
      kUrlImagenDiferenciaDePotencialEnElCapacitor1,
  kImagenElementosCapacitorYResistor: kUrlImagenElementosCapacitorYResistor,
  kImagenElementosFem: kUrlImagenElementosFem,
  kImagenEnergiaYCapacitancia: kUrlImagenEnergiaYCapacitancia,
  kImagenFemAspectosRelevantes: kUrlImagenFemAspectosRelevantes,
  kImagenFemIdealYReal: kUrlImagenFemIdealYReal,
  kImagenFuenteDeFuerzaElectromotriz: kUrlImagenFuenteDeFuerzaElectromotriz,
  kImagenFuerzaDeLorentz: kUrlImagenFuerzaDeLorentz,
  kImagenGraficaCapacitancia: kUrlImagenGraficaCapacitancia,
  kImagenLeyDeBiotSavart1: kUrlImagenLeyDeBiotSavart1,
  kImagenLeyDeLenz1: kUrlImagenLeyDeLenz1,
  kImagenMotorDeCorrienteDirecta: kUrlImagenMotorDeCorrienteDirecta,
  kImagenMotorDeCorrienteDirecta1: kUrlImagenMotorDeCorrienteDirecta1,
  kImagenNoPolarizado: kUrlImagenNoPolarizado,
  kImagenNomenclaturaBasica1: kUrlImagenNomenclaturaBasica1,
  kImagenNomenclaturaBasica2: kUrlImagenNomenclaturaBasica2,
  kImagenPolaridadDevanado1: kUrlImagenPolaridadDevanado1,
  kImagenPolaridadDevanado2: kUrlImagenPolaridadDevanado2,
  kImagenPolaridadDevanadoParalelo1: kUrlImagenPolaridadDevanadoParalelo1,
  kImagenPolaridadDevanadoParalelo2: kUrlImagenPolaridadDevanadoParalelo2,
  kImagenPolarizacion: kUrlImagenPolarizacion,
  kImagenPolarizado: kUrlImagenPolarizado,
  kImagenPortadoresDeCargaLibre: kUrlImagenPortadoresDeCargaLibre,
  kImagenReglaDeLaManoDerecha: kUrlImagenReglaDeLaManoDerecha,
  kImagenRepresentacionDeLosVectoresElectricos:
      kUrlImagenRepresentacionDeLosVectoresElectricos,
  kImagenResistorLinealYNoLineal: kUrlImagenResistorLinealYNoLineal,
  kImagenResistorSimbologiaBasica: kUrlImagenResistorSimbologiaBasica,
  kImagenSimbologiaCapacitores: kUrlImagenSimbologiaCapacitores,
  kImagenTiposDeCorrienteElectrica: kUrlImagenTiposDeCorrienteElectrica,
  kImagenPiramide: kUrlImagenPiramide,
  kImagenPrismaPentagonal: kUrlImagenPrismaPentagonal,
  kImagenBicondicional: kUrlImagenBicondicional,
  kImagenCondicional: kUrlImagenCondicional,
  kImagenConjuncion: kUrlImagenConjuncion,
  kImagenNegacion: kUrlImagenNegacion,
  kImagenTablaDeVerdadDisyuncion1: kUrlImagenTablaDeVerdadDisyuncion1,
  kImagenTablaDeVerdadDisyuncion2: kUrlImagenTablaDeVerdadDisyuncion2,
  kImagenTrianguloRectangulo: kUrlImagenTrianguloRectangulo,
  kImagenBotones: kUrlImagenBotones,
  kImagenOpcionesPdf: kUrlImagenOpcionesPdf,
  kImagenTresPuntos: kUrlImagenTresPuntos,
  kImagenChat: kUrlImagenChat,
};

/// Compatibility adapter for existing widget call sites.
///
/// [context] is intentionally ignored because diagram routing is independent
/// of the app locale.
String? getImageUrlById(BuildContext context, String id) => imageUrlMap[id];

class VerImagen extends StatelessWidget {
  final String url;

  const VerImagen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    String? url_1 = getImageUrlById(context, url);
    // Si no existe imagen, no se muestra
    if (url_1 == null || url == '') {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerImagenNuevo(imageUrl: url_1),
          ),
        );
      },
      child: ImagenRemotaRobusta(
        urlImagen: url_1,
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.4,
      ),
    );
  }
}

class VerImagenNuevo extends StatelessWidget {
  final String imageUrl;

  const VerImagenNuevo({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.imagen)),
      body: Center(
        child: ImagenRemotaRobusta(
          urlImagen: imageUrl,
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
