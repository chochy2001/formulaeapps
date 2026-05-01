import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../screens_personalizados/configuracion.dart';
import 'export_constantes.dart';

Map<String, Map<String, String>> imageUrlMap = {
  kImagenFavoritos: {
    'es': kUrlImagenFavoritos,
    'en': kUrlImagenFavoritosIngles,
  },
  kImagenAgregarTarea: {
    'es': kUrlImagenAgregarTarea,
    'en': kUrlImagenAgregarTareaIngles,
  },
  kImagenCapacitor1: {
    'es': kUrlImagenCapacitor1,
    'en': kUrlImagenCapacitor1Ingles,
  },
  kImagenCapacitor2: {
    'es': kUrlImagenCapacitor2,
    'en': kUrlImagenCapacitor2Ingles,
  },
  kImagenCircuitoRCYVoltajeContinuo: {
    'es': kUrlImagenCircuitoRCYVoltajeContinuo,
    'en': kUrlImagenCircuitoRCYVoltajeContinuoIngles,
  },
  kImagenCircuitoRCYVoltajeContinuo2: {
    'es': kUrlImagenCircuitoRCYVoltajeContinuo2,
    'en': kUrlImagenCircuitoRCYVoltajeContinuo2Ingles,
  },
  kImagenConexionEnParaleloResistor: {
    'es': kUrlImagenConexionEnParaleloResistor,
    'en': kUrlImagenConexionEnParaleloResistorIngles,
  },
  kImagenConexionEnSerieResistor: {
    'es': kUrlImagenConexionEnSerieResistor,
    'en': kUrlImagenConexionEnSerieResistorIngles,
  },
  kImagenCorrienteEnElCapacitor: {
    'es': kUrlImagenCorrienteEnElCapacitor,
    'en': kUrlImagenCorrienteEnElCapacitorIngles,
  },
  kImagenCorrienteEnElCapacitor1: {
    'es': kUrlImagenCorrienteEnElCapacitor1,
    'en': kUrlImagenCorrienteEnElCapacitor1Ingles,
  },
  kImagenDiferenciaDePotencialEnElCapacitor: {
    'es': kUrlImagenDiferenciaDePotencialEnElCapacitor,
    'en': kUrlImagenDiferenciaDePotencialEnElCapacitorIngles,
  },
  kImagenDiferenciaDePotencialEnElCapacitor1: {
    'es': kUrlImagenDiferenciaDePotencialEnElCapacitor1,
    'en': kUrlImagenDiferenciaDePotencialEnElCapacitor1Ingles,
  },
  kImagenElementosCapacitorYResistor: {
    'es': kUrlImagenElementosCapacitorYResistor,
    'en': kUrlImagenElementosCapacitorYResistorIngles,
  },
  kImagenElementosFem: {
    'es': kUrlImagenElementosFem,
    'en': kUrlImagenElementosFemIngles,
  },
  kImagenEnergiaYCapacitancia: {
    'es': kUrlImagenEnergiaYCapacitancia,
    'en': kUrlImagenEnergiaYCapacitanciaIngles,
  },
  kImagenFemAspectosRelevantes: {
    'es': kUrlImagenFemAspectosRelevantes,
    'en': kUrlImagenFemAspectosRelevantesIngles,
  },
  kImagenFemIdealYReal: {
    'es': kUrlImagenFemIdealYReal,
    'en': kUrlImagenFemIdealYRealIngles,
  },
  kImagenFuenteDeFuerzaElectromotriz: {
    'es': kUrlImagenFuenteDeFuerzaElectromotriz,
    'en': kUrlImagenFuenteDeFuerzaElectromotrizIngles,
  },
  kImagenFuerzaDeLorentz: {
    'es': kUrlImagenFuerzaDeLorentz,
    'en': kUrlImagenFuerzaDeLorentzIngles,
  },
  kImagenGraficaCapacitancia: {
    'es': kUrlImagenGraficaCapacitancia,
    'en': kUrlImagenGraficaCapacitanciaIngles,
  },
  kImagenLeyDeBiotSavart1: {
    'es': kUrlImagenLeyDeBiotSavart1,
    'en': kUrlImagenLeyDeBiotSavart1Ingles,
  },
  kImagenLeyDeLenz1: {
    'es': kUrlImagenLeyDeLenz1,
    'en': kUrlImagenLeyDeLenz1Ingles,
  },
  kImagenMotorDeCorrienteDirecta: {
    'es': kUrlImagenMotorDeCorrienteDirecta,
    'en': kUrlImagenMotorDeCorrienteDirectaIngles,
  },
  kImagenMotorDeCorrienteDirecta1: {
    'es': kUrlImagenMotorDeCorrienteDirecta1,
    'en': kUrlImagenMotorDeCorrienteDirecta1Ingles,
  },
  //todo hasta aqui
  kImagenNoPolarizado: {
    'es': kUrlImagenNoPolarizado,
    'en': kUrlImagenNoPolarizadoIngles,
  },
  kImagenNomenclaturaBasica1: {
    'es': kUrlImagenNomenclaturaBasica1,
    'en': kUrlImagenNomenclaturaBasica1Ingles,
  },
  kImagenNomenclaturaBasica2: {
    'es': kUrlImagenNomenclaturaBasica2,
    'en': kUrlImagenNomenclaturaBasica2Ingles,
  },
  kImagenPolaridadDevanado1: {
    'es': kUrlImagenPolaridadDevanado1,
    'en': kUrlImagenPolaridadDevanado1Ingles,
  },
  kImagenPolaridadDevanado2: {
    'es': kUrlImagenPolaridadDevanado2,
    'en': kUrlImagenPolaridadDevanado2Ingles,
  },
  kImagenPolaridadDevanadoParalelo1: {
    'es': kUrlImagenPolaridadDevanadoParalelo1,
    'en': kUrlImagenPolaridadDevanadoParalelo1Ingles,
  },
  kImagenPolaridadDevanadoParalelo2: {
    'es': kUrlImagenPolaridadDevanadoParalelo2,
    'en': kUrlImagenPolaridadDevanadoParalelo2Ingles,
  },
  kImagenPolarizacion: {
    'es': kUrlImagenPolarizacion,
    'en': kUrlImagenPolarizacionIngles,
  },
  kImagenPolarizado: {
    'es': kUrlImagenPolarizado,
    'en': kUrlImagenPolarizadoIngles,
  },
  kImagenPortadoresDeCargaLibre: {
    'es': kUrlImagenPortadoresDeCargaLibreIngles,
    'en': kUrlImagenPortadoresDeCargaLibreIngles,
  },
  kImagenReglaDeLaManoDerecha: {
    'es': kUrlImagenReglaDeLaManoDerecha,
    'en': kUrlImagenReglaDeLaManoDerechaIngles,
  },
  kImagenRepresentacionDeLosVectoresElectricos: {
    'es': kUrlImagenRepresentacionDeLosVectoresElectricos,
    'en': kUrlImagenRepresentacionDeLosVectoresElectricosIngles,
  },
  kImagenResistorLinealYNoLineal: {
    'es': kUrlImagenResistorLinealYNoLineal,
    'en': kUrlImagenResistorLinealYNoLinealIngles,
  },
  kImagenResistorSimbologiaBasica: {
    'es': kUrlImagenResistorSimbologiaBasica,
    'en': kUrlImagenResistorSimbologiaBasicaIngles,
  },
  kImagenSimbologiaCapacitores: {
    'es': kUrlImagenSimbologiaCapacitores,
    'en': kUrlImagenSimbologiaCapacitoresIngles,
  },
  kImagenTiposDeCorrienteElectrica: {
    'es': kUrlImagenTiposDeCorrienteElectrica,
    'en': kUrlImagenTiposDeCorrienteElectricaIngles,
  },
  kImagenPiramide: {
    'es': kUrlImagenPiramide,
    'en': kUrlImagenPiramideIngles,
  },
  kImagenPrismaPentagonal: {
    'es': kUrlImagenPrismaPentagonal,
    'en': kUrlImagenPrismaPentagonalIngles,
  },
  kImagenBicondicional: {
    'es': kUrlImagenBicondicional,
    'en': kUrlImagenBicondicionalIngles,
  },
  kImagenCondicional: {
    'es': kUrlImagenCondicional,
    'en': kUrlImagenCondicionalIngles,
  },
  kImagenConjuncion: {
    'es': kUrlImagenConjuncion,
    'en': kUrlImagenConjuncionIngles,
  },
  kImagenNegacion: {
    'es': kUrlImagenNegacion,
    'en': kUrlImagenNegacionIngles,
  },
  kImagenTablaDeVerdadDisyuncion1: {
    'es': kUrlImagenTablaDeVerdadDisyuncion1,
    'en': kUrlImagenTablaDeVerdadDisyuncion1Ingles,
  },
  kImagenTablaDeVerdadDisyuncion2: {
    'es': kUrlImagenTablaDeVerdadDisyuncion2,
    'en': kUrlImagenTablaDeVerdadDisyuncion2Ingles,
  },
  kImagenTrianguloRectangulo: {
    'es': kUrlImagenTrianguloRectangulo,
    'en': kUrlImagenTrianguloRectanguloIngles,
  },
  kImagenBotones: {
    'es': kUrlImagenBotones,
    'en': kUrlImagenBotonesIngles,
  },
  kImagenOpcionesPdf: {
    'es': kUrlImagenOpcionesPdf,
    'en': kUrlImagenOpcionesPdfIngles,
  },
  kImagenTresPuntos: {
    'es': kUrlImagenTresPuntos,
    'en': kUrlImagenTresPuntosIngles,
  },
  kImagenChat: {
    'es': kUrlImagenChat,
    'en': kUrlImagenChatIngles,
  },
};

String? getImageUrlById(BuildContext context, String id) {
  Locale currentLocale =
      Provider.of<LocaleProvider>(context, listen: false).locale;
  return imageUrlMap[id]?[currentLocale.languageCode];
}

class VerImagen extends StatelessWidget {
  final String url;

  const VerImagen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? url_1 = getImageUrlById(context, url);
    // Si no existe imagen, no se muestra
    if (kIsWeb || url_1 == null || url == '') {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerImagenNuevo(
              imageUrl: url_1,
            ),
          ),
        );
      },
      child: Image.network(
        url_1,
        // Puedes ajustar estas propiedades como desees
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.4,
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class VerImagenNuevo extends StatelessWidget {
  final String imageUrl;

  const VerImagenNuevo({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver Imagen'),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          // Puedes ajustar estas propiedades como desees
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.8,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
