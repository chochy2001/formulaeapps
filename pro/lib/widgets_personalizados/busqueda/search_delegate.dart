import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constantes/export_constantes.dart';

class DataSearch extends SearchDelegate {
  final String buscarFormula;

  DataSearch({required this.buscarFormula});

  @override
  String get searchFieldLabel {
    return buscarFormula;
  }

  String removeDiacritics(String str) {
    var withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }

    return str;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      hintColor: Colors.white,
      primaryColor: Colors.white,
      textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
            fontSize: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : kColorFondo),
      ),
    );
  }

  List<String> getSearchResults(BuildContext context) {
    return [
      AppLocalizations.of(context)!.coeficientesBinomiales,
      AppLocalizations.of(context)!.potenciasNEsimas,
      AppLocalizations.of(context)!.ecuacionCubica,
      AppLocalizations.of(context)!.ecuacionCuadraticaFormaMonicaVieta,
      AppLocalizations.of(context)!.numerosComplejosFormaExponencialNumeroComplejo,
      AppLocalizations.of(context)!.numerosComplejosRaicesEIgualdadNumerosComplejos,
      AppLocalizations.of(context)!.propiedadesLogaritmos2,
      AppLocalizations.of(context)!.determinantesCramerSarrus,
      AppLocalizations.of(context)!.algebraLinealMatricesTiposDeMatrices,
      AppLocalizations.of(context)!.algebraLinealVectoresProductosBaseCanonica,
      AppLocalizations.of(context)!.algebraLinealVectoresProductoEscalarTriple,
      AppLocalizations.of(context)!.algebraLinealVectoresSumaVectoresComponentes,
      AppLocalizations.of(context)!.algebraLinealVectoresLeySenosCosenos,
      AppLocalizations.of(context)!.algebraLinealVectoresRazonesTrigonometricas,
      AppLocalizations.of(context)!.limitesTeoremasLimites,
      AppLocalizations.of(context)!.limitesLimitesInfinitos,
      AppLocalizations.of(context)!.limitesLimitesImportantes,
      AppLocalizations.of(context)!.asintotasHorizontalesOblicuas,
      AppLocalizations.of(context)!.continuidad,
      AppLocalizations.of(context)!.reglaLhopital,
      AppLocalizations.of(context)!.diferenciales,
      AppLocalizations.of(context)!.derivadasAlgebraicasRadicales,
      AppLocalizations.of(context)!.reglaCadenaFuncionInversa,
      AppLocalizations.of(context)!.derivadasTrigonometricasComplementarias,
      AppLocalizations.of(context)!.derivadasHiperbolicasInversas,
      AppLocalizations.of(context)!.derivacionLogaritmica,
      AppLocalizations.of(context)!.razonCambioTangenteNormal,
      AppLocalizations.of(context)!.aplicacionFisicaDerivada,
      AppLocalizations.of(context)!.integralesInmediatasAdicionalesIntegral,
      AppLocalizations.of(context)!.potenciasReduccionTrigonometricasIntegral,
      AppLocalizations.of(context)!.trigonometricasRacionalesProductosIntegral,
      AppLocalizations.of(context)!.potenciasReduccionHiperbolicasIntegral,
      AppLocalizations.of(context)!.hiperbolicasInversasIntegral,
      AppLocalizations.of(context)!.integralDefinidaPropiedadesIntegral,
      AppLocalizations.of(context)!.integracionNumericaIntegral,
      AppLocalizations.of(context)!.sustitucionTrigonometricaIntegral,
      AppLocalizations.of(context)!.areaLongitudArcoIntegral,
      AppLocalizations.of(context)!.fraccionesParcialesIntegral,
      AppLocalizations.of(context)!.constantesMatematicas,
      AppLocalizations.of(context)!.constantesFisicasUniversales,
      AppLocalizations.of(context)!.constantesElectromagneticas,
      AppLocalizations.of(context)!.constantesAtomicasMoleculares,
      AppLocalizations.of(context)!.constantesTerrestresAstronomicas,
      AppLocalizations.of(context)!.longitudConversion,
      AppLocalizations.of(context)!.superficieConversion,
      AppLocalizations.of(context)!.volumenConversion,
      AppLocalizations.of(context)!.masaConversion,
      AppLocalizations.of(context)!.densidadConversion,
      AppLocalizations.of(context)!.presionConversion,
      AppLocalizations.of(context)!.energiaConversion,
      AppLocalizations.of(context)!.potenciaConversion,
      AppLocalizations.of(context)!.potenciaYReactanciasEnCa,
      AppLocalizations.of(context)!.caValoresEficacesTransformador,
      AppLocalizations.of(context)!.instrumentosDeMedicionElectrica,
      AppLocalizations.of(context)!.circuitoLrEnSerie,
      AppLocalizations.of(context)!.fuerzaYTorcaMagnetica,
      AppLocalizations.of(context)!.capacitoresCilindricoYEsferico,
      AppLocalizations.of(context)!.permeabilidadMagneticaEnMateriales,
      AppLocalizations.of(context)!.bateriaRealVoltajeEnTerminales,
      AppLocalizations.of(context)!.laRectaYElTriangulo,
      AppLocalizations.of(context)!.tangentesYPropiedadesDeLasConicas,
      AppLocalizations.of(context)!.hiperbolaEquilatera,
      AppLocalizations.of(context)!.laCurvaExponencial,
      AppLocalizations.of(context)!.aceleracionYMrua,
      AppLocalizations.of(context)!.caidaLibreYTiroVertical,
      AppLocalizations.of(context)!.movimientoDeProyectiles,
      AppLocalizations.of(context)!.movimientoCircularUniforme,
      AppLocalizations.of(context)!.cinematicaAngular,
      AppLocalizations.of(context)!.aceleracionYFuerzaCentripeta,
      AppLocalizations.of(context)!.leyesDeNewton,
      AppLocalizations.of(context)!.pesoYGravedad,
      AppLocalizations.of(context)!.cantidadDeMovimientoEImpulso,
      AppLocalizations.of(context)!.friccion,
      AppLocalizations.of(context)!.movimientoArmonicoSimple,
      AppLocalizations.of(context)!.penduloSimple,
      AppLocalizations.of(context)!.equilibrioDeCuerposRigidos,
      AppLocalizations.of(context)!.momentoDeTorsion,
      AppLocalizations.of(context)!.eficiencia,
      AppLocalizations.of(context)!.hidrostatica,
      AppLocalizations.of(context)!.hidrodinamica,
      AppLocalizations.of(context)!.axiomasDeCampoNumerosReales,
      AppLocalizations.of(context)!.axiomasDeOrdenYTeoremasReales,
      AppLocalizations.of(context)!.desigualdadesTeoremasDeOrden,
      AppLocalizations.of(context)!.conjuntosEIntervalos,
      AppLocalizations.of(context)!.valorAbsoluto,
      AppLocalizations.of(context)!.leyDeLaIluminacion,
      AppLocalizations.of(context)!.reflexionYAumentoFormaNewtoniana,
      AppLocalizations.of(context)!.ecuacionDeLasLentesFormaGaussiana,
      AppLocalizations.of(context)!.refraccionDeLaLuzLeyDeSnell,
      AppLocalizations.of(context)!.tiposDeLentesYMarchaDeRayos,
      AppLocalizations.of(context)!.axiomasDeProbabilidad,
      AppLocalizations.of(context)!.funcionesDeMasaDensidadYAcumulada,
      AppLocalizations.of(context)!.funcionesDeProbabilidadConjuntasYCondicionales,
      AppLocalizations.of(context)!.esperanzaMediaYVarianza,
      AppLocalizations.of(context)!.distribucionesDistribucionDeBernoulli,
      AppLocalizations.of(context)!.distribucionesDistribucionDePascal,
      AppLocalizations.of(context)!.distribucionesDistribucionBeta,
      AppLocalizations.of(context)!.distribucionesDistribucionDeCauchy,
      AppLocalizations.of(context)!.distribucionesDistribucionDeErlang,
      AppLocalizations.of(context)!.distribucionesDistribucionUniforme,
      AppLocalizations.of(context)!.regresionLineal,
      AppLocalizations.of(context)!.desigualdadDeChebyshevYConvergencia,
      AppLocalizations.of(context)!.transferenciaDeCalor,
      AppLocalizations.of(context)!.capacidadCalorificaYCalorLatente,
      AppLocalizations.of(context)!.leyesDeLosGases,
      AppLocalizations.of(context)!.cicloDeCarnotYLeyesDeLaTermodinamica,
      AppLocalizations.of(context)!.trabajoTermodinamico,
      AppLocalizations.of(context)!.entalpiaYEnergiaInterna,
      AppLocalizations.of(context)!.dilatacionLineal,
      AppLocalizations.of(context)!.dilatacionSuperficialYVolumetrica,
      AppLocalizations.of(context)!.entropiaYTeoriaCinetica,
      AppLocalizations.of(context)!.procesosTermodinamicos,
      AppLocalizations.of(context)!.circuloUnitario,
      AppLocalizations.of(context)!.signosDeFuncionesPorCuadrante,
      AppLocalizations.of(context)!.angulosNotablesGradosRadianes,
      AppLocalizations.of(context)!.relacionEntreFuncionesTrigonometricas,
      AppLocalizations.of(context)!.identidadesDeAnguloTripleYCuadruple,
      AppLocalizations.of(context)!.identidadesDeReduccionDePotencias,
      AppLocalizations.of(context)!.identidadesFundamentalesFormasDerivadas,
      AppLocalizations.of(context)!.cotangenteDeSumaYRestaDeAngulos,
      AppLocalizations.of(context)!.productoDeCosenoPorSeno,
      AppLocalizations.of(context)!.electricidad,
      AppLocalizations.of(context)!.electricidadMagnetismo,
      AppLocalizations.of(context)!.cargaElectrica,
      AppLocalizations.of(context)!.cargaElectricaProtonElectron,
      AppLocalizations.of(context)!.distribucionesCargaElectrica,
      AppLocalizations.of(context)!.leyCoulomb,
      AppLocalizations.of(context)!.principioSuperposicion,
      AppLocalizations.of(context)!.campoElectrico,
      AppLocalizations.of(context)!.campoElectricoDistribucionesCarga,
      AppLocalizations.of(context)!.flujoElectricoCampoVectorial,
      AppLocalizations.of(context)!.leyGauss,
      AppLocalizations.of(context)!.energiaPotencialElectrica,
      AppLocalizations.of(context)!.calculoDiferenciasPotencial,
      AppLocalizations.of(context)!.teoremaDivergencia,
      AppLocalizations.of(context)!.teoremaRotacional,
      AppLocalizations.of(context)!.circulacionCampoElectrostatico,
      AppLocalizations.of(context)!.rotacionalCampoElectrostatico,
      AppLocalizations.of(context)!.operadorGradiente,
      AppLocalizations.of(context)!.gradienteFuncionEscalar,
      AppLocalizations.of(context)!.gradientePotencialElectrico,
      AppLocalizations.of(context)!.leyGaussFormaDiferencial,
      AppLocalizations.of(context)!.ecuacionPoissonLaplace,
      AppLocalizations.of(context)!.superficiesEquipotenciales,
      AppLocalizations.of(context)!.capacitor,
      AppLocalizations.of(context)!.cargaCapacitor,
      AppLocalizations.of(context)!.definicionCapacitancia,
      AppLocalizations.of(context)!.graficaCapacitancia,
      AppLocalizations.of(context)!.simbologiaCapacitores,
      AppLocalizations.of(context)!.capacitorPlacasPlanasParalelas,
      AppLocalizations.of(context)!.energiaCapacitancia,
      AppLocalizations.of(context)!.energiaAlmacenadaCapacitor,
      AppLocalizations.of(context)!.conexionSerieCapacitor,
      AppLocalizations.of(context)!.conexionParaleloCapacitor,
      AppLocalizations.of(context)!.polarizacion,
      AppLocalizations.of(context)!.polarizacionCargaInducida,
      AppLocalizations.of(context)!.constantesDielectricas,
      AppLocalizations.of(context)!.rigidezDielectrica,
      AppLocalizations.of(context)!.vectorDesplazamientoElectrico,
      AppLocalizations.of(context)!.representacionVectoresElectricos,
      AppLocalizations.of(context)!.portadoresCargaLibre,
      AppLocalizations.of(context)!
          .movimientoPortadoresCargaLibreDensidadCorriente,
      AppLocalizations.of(context)!.densidadCorrienteCorrienteElectrica,
      AppLocalizations.of(context)!.tiposCorrienteElectrica,
      AppLocalizations.of(context)!.conductividadResistividad,
      AppLocalizations.of(context)!.leyOhm,
      AppLocalizations.of(context)!.ecuacionOhm,
      AppLocalizations.of(context)!.resistividadTemperatura,
      AppLocalizations.of(context)!.efectoJoule,
      AppLocalizations.of(context)!.resistorSimbologiaBasica,
      AppLocalizations.of(context)!.resistorLinealNoLineal,
      AppLocalizations.of(context)!.conexionSerieResistor,
      AppLocalizations.of(context)!.conexionParaleloResistor,
      AppLocalizations.of(context)!.fuenteFuerzaElectromotriz,
      AppLocalizations.of(context)!.elementosCapacitorResistor,
      AppLocalizations.of(context)!.elementosFuerzaElectromotriz,
      AppLocalizations.of(context)!.teoriaCircuitos,
      AppLocalizations.of(context)!.leyVoltajesKirchhoff,
      AppLocalizations.of(context)!.leyCorrientesKirchhoff,
      AppLocalizations.of(context)!.reglasLVKLCK,
      AppLocalizations.of(context)!.circuitoRCVoltajeContinuo,
      AppLocalizations.of(context)!.leyesKirchhoffCircuitoRC,
      AppLocalizations.of(context)!.nomenclaturaBasicaCircuitos,
      AppLocalizations.of(context)!.campoYPotencialElectricos,
      AppLocalizations.of(context)!.capacitanciaDielectricos,
      AppLocalizations.of(context)!.circuitosElectricos,
      AppLocalizations.of(context)!.magnetostatica,
      AppLocalizations.of(context)!.induccionElectromagnetica,
      AppLocalizations.of(context)!.generadorHomopolar,
      AppLocalizations.of(context)!.inductanciaPropia,
      AppLocalizations.of(context)!.inductanciaMutua,
      AppLocalizations.of(context)!.inductanciaPropiaDeUnSolenoide,
      AppLocalizations.of(context)!.inductanciaParaUnToroide,
      AppLocalizations.of(context)!.inductanciaMutuaEntreDosSolenoidesCoaxiales,
      AppLocalizations.of(context)!.leyDeInduccionDeFaradayYEnergisEnUnInductor,
      AppLocalizations.of(context)!.energiaAlmacenadaEnUnCampoMagnetico,
      AppLocalizations.of(context)!.inductor,
      AppLocalizations.of(context)!.inductoresEnSerie,
      AppLocalizations.of(context)!
          .descripcionDeLosImanesYExperimentosDeOersted,
      AppLocalizations.of(context)!
          .fuerzaMagneticaComoVectorSobreCargasEnMovimiento,
      AppLocalizations.of(context)!.definicionDeCampoMagnetico,
      AppLocalizations.of(context)!.fuerzaDeLorentz,
      AppLocalizations.of(context)!.leyDeBiotSavart,
      AppLocalizations.of(context)!.segmentoConductorRecto,
      AppLocalizations.of(context)!.espiraEnFormaDeCircunferencia,
      AppLocalizations.of(context)!.espiraCuadrada,
      AppLocalizations.of(context)!.bobina,
      AppLocalizations.of(context)!.solenoide,
      AppLocalizations.of(context)!.circulacionDeUnCampoVectorial,
      AppLocalizations.of(context)!.campoMagneticoAPartirDeLeyDeAmpere,
      AppLocalizations.of(context)!.leyDeAmpereEnFormaDiferencial,
      AppLocalizations.of(context)!.flujoMagnetico,
      AppLocalizations.of(context)!.motorDeCorrienteDirecta,
      //Preguntas Frecuentes
      AppLocalizations.of(context)!.comoPonerNumerosNegativos,
      AppLocalizations.of(context)!.lasFormulasSeVenCortadas,
      AppLocalizations.of(context)!.resultadoNan,
      AppLocalizations.of(context)!.comoTrabajarConLosPdf,

//Generales
      AppLocalizations.of(context)!.generales,
      AppLocalizations.of(context)!.propiedadesLogaritmos,
      AppLocalizations.of(context)!.funcionesTrigonometricas,
      AppLocalizations.of(context)!.identidadesTrigonometricas,
      AppLocalizations.of(context)!.identidadesBasicas,
      AppLocalizations.of(context)!.trigonometricasHiperbolicas,
      AppLocalizations.of(context)!.identidadesHiperbolicas,

//Algebra
      AppLocalizations.of(context)!.algebra,
      AppLocalizations.of(context)!.solucionEcuaciones,
      AppLocalizations.of(context)!.ecuacionesDePrimerGrado,
      AppLocalizations.of(context)!.ecuacionesDeSegundoGrado,
      AppLocalizations.of(context)!.ecuacionesLineales,
      AppLocalizations.of(context)!.formulaGeneral,
      AppLocalizations.of(context)!.formulaProductos,
      AppLocalizations.of(context)!.formulasFactorizacion,
      AppLocalizations.of(context)!.operacionesFraccionesAlgebraicas,
      AppLocalizations.of(context)!.operacionesPolinomios,
      AppLocalizations.of(context)!.propiedadesExponentes,
      AppLocalizations.of(context)!.ejerciciosPropiedadesDeLosExponentes,
      AppLocalizations.of(context)!.propiedadesDesigualdades,
      AppLocalizations.of(context)!.propiedadesRadicales,
      AppLocalizations.of(context)!.serieTaylorMaclaurin,
      AppLocalizations.of(context)!.teoremaSumatoria,
      AppLocalizations.of(context)!.numerosComplejos,
      AppLocalizations.of(context)!.conjugadoDeUnNumeroComplejo,
      AppLocalizations.of(context)!.moduloYArgumentoDeUnNumeroComplejo,
      AppLocalizations.of(context)!.operacionesDeNumerosComplejos,
      AppLocalizations.of(context)!.propiedadesDeLosNumerosComplejos,
      AppLocalizations.of(context)!.representacionesDeUnNumeroComplejo,

//Algebra Lineal
      AppLocalizations.of(context)!.algebraLineal,
      AppLocalizations.of(context)!.determinantes,
      AppLocalizations.of(context)!.matrices,
      AppLocalizations.of(context)!.matrizAdjunta,
      AppLocalizations.of(context)!.matrizIdentidad,
      AppLocalizations.of(context)!.matrizInversa,
      AppLocalizations.of(context)!.matrizOrtogonal,
      AppLocalizations.of(context)!.matrizSimetrica,
      AppLocalizations.of(context)!.matrizTranspuesta,
      AppLocalizations.of(context)!.matrizTriangular,
      AppLocalizations.of(context)!.multiplicacionDeMatrices,
      AppLocalizations.of(context)!.propiedadesDeLasMatrices,
      AppLocalizations.of(context)!.sumaYRestaDeMatrices,
      AppLocalizations.of(context)!.puntoMedioEntreDosPuntos,
      AppLocalizations.of(context)!.reglaCramer,
      AppLocalizations.of(context)!.reglaSarrus,
      AppLocalizations.of(context)!.vectores,
      AppLocalizations.of(context)!.anguloEntreVectores,
      AppLocalizations.of(context)!.normalizacion,
      AppLocalizations.of(context)!.operacionesConVectores,
      AppLocalizations.of(context)!.productoCruz,
      AppLocalizations.of(context)!.productoPunto,
      AppLocalizations.of(context)!.propiedadesDeLosVectores,
      AppLocalizations.of(context)!.proyeccionesDeVectores,
      AppLocalizations.of(context)!.vectorUnitario,
      AppLocalizations.of(context)!.vectoresYSuMagnitud,
      //Calculo Diferencial
      AppLocalizations.of(context)!.calculoDiferencial,
      AppLocalizations.of(context)!.limites,
      AppLocalizations.of(context)!.propiedadesDeLosLimites,
      AppLocalizations.of(context)!.limitesTrigonometricos,
      AppLocalizations.of(context)!.derivacionBasica,
      AppLocalizations.of(context)!.derivadasDeFuncionesTrigonometricas,
      AppLocalizations.of(context)!.derivadasDeFuncionesTrigonometricasInversas,
      AppLocalizations.of(context)!
          .derivadasDeFuncionesTrigonometriasHiperbolicas,
      AppLocalizations.of(context)!.derivadasDeFuncionesExponencialYLogaritmos,

//Calculo Integral
      AppLocalizations.of(context)!.calculoIntegral,
      AppLocalizations.of(context)!.integracionBasica,
      AppLocalizations.of(context)!.integralesDeFuncionesTrigonometricas,
      AppLocalizations.of(context)!
          .integralesDeFuncionesTrigonometricasInversas,
      AppLocalizations.of(context)!
          .integralesDeFuncionesTrigonometricasHiperbolicas,
      AppLocalizations.of(context)!.integralesDelExponencialYLogaritmos,
      AppLocalizations.of(context)!.integralesExtras,

//Calculo Multivariable
      AppLocalizations.of(context)!.calculoMultivariable,
      AppLocalizations.of(context)!.areaBajoCurva,
      AppLocalizations.of(context)!.areaSuperficieRevolucion,
      AppLocalizations.of(context)!.cambioVariable,
      AppLocalizations.of(context)!.derivadasDireccionales,
      AppLocalizations.of(context)!.derivadasParciales,
      AppLocalizations.of(context)!.diferencialTotal,
      AppLocalizations.of(context)!.funcionesVectoriales,
      AppLocalizations.of(context)!.derivadasFuncionesVectoriales,
      AppLocalizations.of(context)!
          .limitesDerivadasIntegralesFuncionesVectoriales,
      AppLocalizations.of(context)!.gradienteFuncion,
      AppLocalizations.of(context)!.identidadesVectoriales,
      AppLocalizations.of(context)!.integralCoordenadasCilindricas,
      AppLocalizations.of(context)!.integralesLinea,
      AppLocalizations.of(context)!.longitudArco,
      AppLocalizations.of(context)!.operadoresDiferenciales,
      AppLocalizations.of(context)!.teoremaFubini,
      AppLocalizations.of(context)!.teoremaIntegrales,

//Ecuaciones Diferenciales
      AppLocalizations.of(context)!.ecuacionesDiferenciales,
      AppLocalizations.of(context)!.constanteDeIntegracion,
      AppLocalizations.of(context)!.ecuacionDiferencialCoeficientesConstantes,
      AppLocalizations.of(context)!.ecuacionDiferencialRectasNoParalelas,
      AppLocalizations.of(context)!.ecuacionDiferencialRectasParalelas,
      AppLocalizations.of(context)!.ecuacionDiferencialExacta,
      AppLocalizations.of(context)!.ecuacionDiferencialHomogenea,
      AppLocalizations.of(context)!.ecuacionDiferencialLinealOrdenSuperior,
      AppLocalizations.of(context)!.ecuacionDiferencialLinealPrimerOrden,
      AppLocalizations.of(context)!.ecuacionDiferencialSeparable,
      //Geometria
      AppLocalizations.of(context)!.geometria,
      AppLocalizations.of(context)!.angulosEnUnPoligono,
      AppLocalizations.of(context)!.areas,
      AppLocalizations.of(context)!.areaPerimetroCuadrilateros,
      AppLocalizations.of(context)!.areaPerimetroTriangulos,
      AppLocalizations.of(context)!.areaPerimetroCirculo,
      AppLocalizations.of(context)!.circunferencia,
      AppLocalizations.of(context)!.distanciaDeUnPuntoAUnaRecta,
      AppLocalizations.of(context)!.distanciaEntreDosPuntos,
      AppLocalizations.of(context)!.ecuacionRecta,
      AppLocalizations.of(context)!.elipseConCentroDiferenteDelOrigen,
      AppLocalizations.of(context)!.elipseConCentroEnElOrigen,
      AppLocalizations.of(context)!.hiperbola,
      AppLocalizations.of(context)!.parabolaConVerticeEnElOrigen,
      AppLocalizations.of(context)!.parabolaConVerticeEnElOrigen,
      AppLocalizations.of(context)!.puntoMedioEntreDosPuntos,
      AppLocalizations.of(context)!.volumenDeCuerposGeometricos,

//Matematicas Discretas
      AppLocalizations.of(context)!.matematicasDiscretas,
      AppLocalizations.of(context)!.bicondicional,
      AppLocalizations.of(context)!.condicional,
      AppLocalizations.of(context)!.conectoresLogicos,
      AppLocalizations.of(context)!.conjuncion,
      AppLocalizations.of(context)!.disyuncion,
      AppLocalizations.of(context)!.leyesDeLaLogicaProposicional,
      AppLocalizations.of(context)!.leyesDeLaTeoriaDeConjuntos,
      AppLocalizations.of(context)!.leyesDelAlgebraDeBoole,
      AppLocalizations.of(context)!.negacion,

//Matematicas Financieras
      AppLocalizations.of(context)!.matematicasFinancieras,
      AppLocalizations.of(context)!.amortizacion,
      AppLocalizations.of(context)!.anualidadAnticipadaSimpleYCierta,
      AppLocalizations.of(context)!.anualidadVencidaSimpleYCierta,
      AppLocalizations.of(context)!.descuentoCompuesto,
      AppLocalizations.of(context)!.descuentoSimple,
      AppLocalizations.of(context)!.interesCompuesto,
      AppLocalizations.of(context)!.interesSimple,
      AppLocalizations.of(context)!.saldoInsoluto,
      AppLocalizations.of(context)!.tasaInteresGlobal,
      AppLocalizations.of(context)!.tasaEfectiva,

//Probabilidad y Estadistica
      AppLocalizations.of(context)!.probabilidadEstadistica,
      AppLocalizations.of(context)!.distribuciones,
      AppLocalizations.of(context)!.distribucionBinomial,
      AppLocalizations.of(context)!.distribucionPoisson,
      AppLocalizations.of(context)!.distribucionExponencial,
      AppLocalizations.of(context)!.distribucionGeometrica,
      AppLocalizations.of(context)!.distribucionHipergeometrica,
      AppLocalizations.of(context)!.distribucionNormal,
      AppLocalizations.of(context)!.distribucionTStudent,
      AppLocalizations.of(context)!.medidas,
      AppLocalizations.of(context)!.dispersionParaDatosNoAgrupados,
      AppLocalizations.of(context)!.posicionParaDatosNoAgrupados,
      AppLocalizations.of(context)!.tendenciaCentralParaDatosAgrupados,
      AppLocalizations.of(context)!.tendenciaCentralParaDatosNoAgrupados,
      AppLocalizations.of(context)!.combinacionesYPermutaciones,
      AppLocalizations.of(context)!.cuantilesParaDatosAgrupados,
      AppLocalizations.of(context)!.estadisticaInferencial,
      AppLocalizations.of(context)!.intervalosDeConfianza,
      AppLocalizations.of(context)!.mediaGeometrica,
      AppLocalizations.of(context)!.momentosEstadisticos,
      AppLocalizations.of(context)!.probabilidad,
      AppLocalizations.of(context)!.tamanioMuestral,
      //Series de Fourier
      AppLocalizations.of(context)!.seriesFourier,
      AppLocalizations.of(context)!.simetrias,
      AppLocalizations.of(context)!.simetriaMediaOnda,
      AppLocalizations.of(context)!.simetriaCuartoOndaImpar,
      AppLocalizations.of(context)!.simetriaCuartoOndaPar,
      AppLocalizations.of(context)!.simetriaImpar,
      AppLocalizations.of(context)!.simetriaPar,
      AppLocalizations.of(context)!.transformadas,
      AppLocalizations.of(context)!.transformadaDeFourier,
      AppLocalizations.of(context)!.transformadaDeLaplace,
      AppLocalizations.of(context)!.transformadasBasicasDeFourier,
      AppLocalizations.of(context)!.transformadasDeFourier,
      AppLocalizations.of(context)!.transformadasDeLaplace,
      AppLocalizations.of(context)!.convolucion,
      AppLocalizations.of(context)!.formaComplejaDeLasSeriesDeFourier,
      AppLocalizations.of(context)!
          .formulasOperacionalesDeLaTransformadaDeLaplace,
      AppLocalizations.of(context)!.funcionImpulsoUnitario,
      AppLocalizations.of(context)!.funcionUnitariaDeHeaviside,
      AppLocalizations.of(context)!.serieYCoeficientesDeFourier,
      AppLocalizations.of(context)!.transformadaSenoYCosenoDeFourier,

//Trigonometria
      AppLocalizations.of(context)!.trigonometria,
      AppLocalizations.of(context)!.formulasDeBessel,
      AppLocalizations.of(context)!.teoremaDeLaCotangente,
      AppLocalizations.of(context)!.teoremaDelCosenoParaAngulos,
      AppLocalizations.of(context)!.teoremaDelCosenoParaLados,
      AppLocalizations.of(context)!.teoremaDelSeno,
      AppLocalizations.of(context)!.identidadesTrigonometricas,
      AppLocalizations.of(context)!.anguloDobleYMedio,
      AppLocalizations.of(context)!.deSumaAProductoYViceversa,
      AppLocalizations.of(context)!.deSumaYRestaDeAngulos,
      AppLocalizations.of(context)!.identidadesTrigonometricasExtras,
      AppLocalizations.of(context)!.identidadesTrigonometricas,
      AppLocalizations.of(context)!.funcionesTrigonometricasDeAngulosNotables,
      AppLocalizations.of(context)!.leyDeProyecciones,
      AppLocalizations.of(context)!.medicionYClasificacionDeAngulos,
      AppLocalizations.of(context)!.teoremaDePitagoras,
      AppLocalizations.of(context)!.trigonometriaEsferica,
      AppLocalizations.of(context)!.analogiasDeGaussDelambre,
      AppLocalizations.of(context)!.analogiasDeNeper,
      AppLocalizations.of(context)!.funcionesDelAnguloMitad,
      AppLocalizations.of(context)!.valoresDeSenoYCoseno,
      AppLocalizations.of(context)!.leyDeSenosCosenosYTangente,
      AppLocalizations.of(context)!.superficieDeUnTrianguloYUnPoligonoEsferico,
    ];
  }

  Map<dynamic, String> getSearchResultss(BuildContext context) {
    return {
      AppLocalizations.of(context)!.coeficientesBinomiales: kRutaCoeficientesBinomiales,
      AppLocalizations.of(context)!.potenciasNEsimas: kRutaPotenciasNEsimas,
      AppLocalizations.of(context)!.ecuacionCubica: kRutaEcuacionCubica,
      AppLocalizations.of(context)!.ecuacionCuadraticaFormaMonicaVieta: kRutaEcuacionCuadraticaFormaMonicaVieta,
      AppLocalizations.of(context)!.numerosComplejosFormaExponencialNumeroComplejo: kRutaNumerosComplejosFormaExponencialNumeroComplejo,
      AppLocalizations.of(context)!.numerosComplejosRaicesEIgualdadNumerosComplejos: kRutaNumerosComplejosRaicesEIgualdadNumerosComplejos,
      AppLocalizations.of(context)!.propiedadesLogaritmos2: kRutaPropiedadesLogaritmos2,
      AppLocalizations.of(context)!.determinantesCramerSarrus: kRutaDeterminantesCramerSarrus,
      AppLocalizations.of(context)!.algebraLinealMatricesTiposDeMatrices: kRutaAlgebraLinealMatricesTiposDeMatrices,
      AppLocalizations.of(context)!.algebraLinealVectoresProductosBaseCanonica: kRutaAlgebraLinealVectoresProductosBaseCanonica,
      AppLocalizations.of(context)!.algebraLinealVectoresProductoEscalarTriple: kRutaAlgebraLinealVectoresProductoEscalarTriple,
      AppLocalizations.of(context)!.algebraLinealVectoresSumaVectoresComponentes: kRutaAlgebraLinealVectoresSumaVectoresComponentes,
      AppLocalizations.of(context)!.algebraLinealVectoresLeySenosCosenos: kRutaAlgebraLinealVectoresLeySenosCosenos,
      AppLocalizations.of(context)!.algebraLinealVectoresRazonesTrigonometricas: kRutaAlgebraLinealVectoresRazonesTrigonometricas,
      AppLocalizations.of(context)!.limitesTeoremasLimites: kRutaLimitesTeoremasLimites,
      AppLocalizations.of(context)!.limitesLimitesInfinitos: kRutaLimitesLimitesInfinitos,
      AppLocalizations.of(context)!.limitesLimitesImportantes: kRutaLimitesLimitesImportantes,
      AppLocalizations.of(context)!.asintotasHorizontalesOblicuas: kRutaAsintotasHorizontalesOblicuas,
      AppLocalizations.of(context)!.continuidad: kRutaContinuidad,
      AppLocalizations.of(context)!.reglaLhopital: kRutaReglaLhopital,
      AppLocalizations.of(context)!.diferenciales: kRutaDiferenciales,
      AppLocalizations.of(context)!.derivadasAlgebraicasRadicales: kRutaDerivadasAlgebraicasRadicales,
      AppLocalizations.of(context)!.reglaCadenaFuncionInversa: kRutaReglaCadenaFuncionInversa,
      AppLocalizations.of(context)!.derivadasTrigonometricasComplementarias: kRutaDerivadasTrigonometricasComplementarias,
      AppLocalizations.of(context)!.derivadasHiperbolicasInversas: kRutaDerivadasHiperbolicasInversas,
      AppLocalizations.of(context)!.derivacionLogaritmica: kRutaDerivacionLogaritmica,
      AppLocalizations.of(context)!.razonCambioTangenteNormal: kRutaRazonCambioTangenteNormal,
      AppLocalizations.of(context)!.aplicacionFisicaDerivada: kRutaAplicacionFisicaDerivada,
      AppLocalizations.of(context)!.integralesInmediatasAdicionalesIntegral: kRutaIntegralesInmediatasAdicionalesIntegral,
      AppLocalizations.of(context)!.potenciasReduccionTrigonometricasIntegral: kRutaPotenciasReduccionTrigonometricasIntegral,
      AppLocalizations.of(context)!.trigonometricasRacionalesProductosIntegral: kRutaTrigonometricasRacionalesProductosIntegral,
      AppLocalizations.of(context)!.potenciasReduccionHiperbolicasIntegral: kRutaPotenciasReduccionHiperbolicasIntegral,
      AppLocalizations.of(context)!.hiperbolicasInversasIntegral: kRutaHiperbolicasInversasIntegral,
      AppLocalizations.of(context)!.integralDefinidaPropiedadesIntegral: kRutaIntegralDefinidaPropiedadesIntegral,
      AppLocalizations.of(context)!.integracionNumericaIntegral: kRutaIntegracionNumericaIntegral,
      AppLocalizations.of(context)!.sustitucionTrigonometricaIntegral: kRutaSustitucionTrigonometricaIntegral,
      AppLocalizations.of(context)!.areaLongitudArcoIntegral: kRutaAreaLongitudArcoIntegral,
      AppLocalizations.of(context)!.fraccionesParcialesIntegral: kRutaFraccionesParcialesIntegral,
      AppLocalizations.of(context)!.constantesMatematicas: kRutaConstantesMatematicas,
      AppLocalizations.of(context)!.constantesFisicasUniversales: kRutaConstantesFisicasUniversales,
      AppLocalizations.of(context)!.constantesElectromagneticas: kRutaConstantesElectromagneticas,
      AppLocalizations.of(context)!.constantesAtomicasMoleculares: kRutaConstantesAtomicasMoleculares,
      AppLocalizations.of(context)!.constantesTerrestresAstronomicas: kRutaConstantesTerrestresAstronomicas,
      AppLocalizations.of(context)!.longitudConversion: kRutaLongitudConversion,
      AppLocalizations.of(context)!.superficieConversion: kRutaSuperficieConversion,
      AppLocalizations.of(context)!.volumenConversion: kRutaVolumenConversion,
      AppLocalizations.of(context)!.masaConversion: kRutaMasaConversion,
      AppLocalizations.of(context)!.densidadConversion: kRutaDensidadConversion,
      AppLocalizations.of(context)!.presionConversion: kRutaPresionConversion,
      AppLocalizations.of(context)!.energiaConversion: kRutaEnergiaConversion,
      AppLocalizations.of(context)!.potenciaConversion: kRutaPotenciaConversion,
      AppLocalizations.of(context)!.potenciaYReactanciasEnCa: kRutaPotenciaYReactanciasEnCa,
      AppLocalizations.of(context)!.caValoresEficacesTransformador: kRutaCaValoresEficacesTransformador,
      AppLocalizations.of(context)!.instrumentosDeMedicionElectrica: kRutaInstrumentosDeMedicionElectrica,
      AppLocalizations.of(context)!.circuitoLrEnSerie: kRutaCircuitoLrEnSerie,
      AppLocalizations.of(context)!.fuerzaYTorcaMagnetica: kRutaFuerzaYTorcaMagnetica,
      AppLocalizations.of(context)!.capacitoresCilindricoYEsferico: kRutaCapacitoresCilindricoYEsferico,
      AppLocalizations.of(context)!.permeabilidadMagneticaEnMateriales: kRutaPermeabilidadMagneticaEnMateriales,
      AppLocalizations.of(context)!.bateriaRealVoltajeEnTerminales: kRutaBateriaRealVoltajeEnTerminales,
      AppLocalizations.of(context)!.laRectaYElTriangulo: kRutaLaRectaYElTriangulo,
      AppLocalizations.of(context)!.tangentesYPropiedadesDeLasConicas: kRutaTangentesYPropiedadesDeLasConicas,
      AppLocalizations.of(context)!.hiperbolaEquilatera: kRutaHiperbolaEquilatera,
      AppLocalizations.of(context)!.laCurvaExponencial: kRutaLaCurvaExponencial,
      AppLocalizations.of(context)!.aceleracionYMrua: kRutaAceleracionYMrua,
      AppLocalizations.of(context)!.caidaLibreYTiroVertical: kRutaCaidaLibreYTiroVertical,
      AppLocalizations.of(context)!.movimientoDeProyectiles: kRutaMovimientoDeProyectiles,
      AppLocalizations.of(context)!.movimientoCircularUniforme: kRutaMovimientoCircularUniforme,
      AppLocalizations.of(context)!.cinematicaAngular: kRutaCinematicaAngular,
      AppLocalizations.of(context)!.aceleracionYFuerzaCentripeta: kRutaAceleracionYFuerzaCentripeta,
      AppLocalizations.of(context)!.leyesDeNewton: kRutaLeyesDeNewton,
      AppLocalizations.of(context)!.pesoYGravedad: kRutaPesoYGravedad,
      AppLocalizations.of(context)!.cantidadDeMovimientoEImpulso: kRutaCantidadDeMovimientoEImpulso,
      AppLocalizations.of(context)!.friccion: kRutaFriccion,
      AppLocalizations.of(context)!.movimientoArmonicoSimple: kRutaMovimientoArmonicoSimple,
      AppLocalizations.of(context)!.penduloSimple: kRutaPenduloSimple,
      AppLocalizations.of(context)!.equilibrioDeCuerposRigidos: kRutaEquilibrioDeCuerposRigidos,
      AppLocalizations.of(context)!.momentoDeTorsion: kRutaMomentoDeTorsion,
      AppLocalizations.of(context)!.eficiencia: kRutaEficiencia,
      AppLocalizations.of(context)!.hidrostatica: kRutaHidrostatica,
      AppLocalizations.of(context)!.hidrodinamica: kRutaHidrodinamica,
      AppLocalizations.of(context)!.axiomasDeCampoNumerosReales: kRutaAxiomasDeCampoNumerosReales,
      AppLocalizations.of(context)!.axiomasDeOrdenYTeoremasReales: kRutaAxiomasDeOrdenYTeoremasReales,
      AppLocalizations.of(context)!.desigualdadesTeoremasDeOrden: kRutaDesigualdadesTeoremasDeOrden,
      AppLocalizations.of(context)!.conjuntosEIntervalos: kRutaConjuntosEIntervalos,
      AppLocalizations.of(context)!.valorAbsoluto: kRutaValorAbsoluto,
      AppLocalizations.of(context)!.leyDeLaIluminacion: kRutaLeyDeLaIluminacion,
      AppLocalizations.of(context)!.reflexionYAumentoFormaNewtoniana: kRutaReflexionYAumentoFormaNewtoniana,
      AppLocalizations.of(context)!.ecuacionDeLasLentesFormaGaussiana: kRutaEcuacionDeLasLentesFormaGaussiana,
      AppLocalizations.of(context)!.refraccionDeLaLuzLeyDeSnell: kRutaRefraccionDeLaLuzLeyDeSnell,
      AppLocalizations.of(context)!.tiposDeLentesYMarchaDeRayos: kRutaTiposDeLentesYMarchaDeRayos,
      AppLocalizations.of(context)!.axiomasDeProbabilidad: kRutaAxiomasDeProbabilidad,
      AppLocalizations.of(context)!.funcionesDeMasaDensidadYAcumulada: kRutaFuncionesDeMasaDensidadYAcumulada,
      AppLocalizations.of(context)!.funcionesDeProbabilidadConjuntasYCondicionales: kRutaFuncionesDeProbabilidadConjuntasYCondicionales,
      AppLocalizations.of(context)!.esperanzaMediaYVarianza: kRutaEsperanzaMediaYVarianza,
      AppLocalizations.of(context)!.distribucionesDistribucionDeBernoulli: kRutaDistribucionesDistribucionDeBernoulli,
      AppLocalizations.of(context)!.distribucionesDistribucionDePascal: kRutaDistribucionesDistribucionDePascal,
      AppLocalizations.of(context)!.distribucionesDistribucionBeta: kRutaDistribucionesDistribucionBeta,
      AppLocalizations.of(context)!.distribucionesDistribucionDeCauchy: kRutaDistribucionesDistribucionDeCauchy,
      AppLocalizations.of(context)!.distribucionesDistribucionDeErlang: kRutaDistribucionesDistribucionDeErlang,
      AppLocalizations.of(context)!.distribucionesDistribucionUniforme: kRutaDistribucionesDistribucionUniforme,
      AppLocalizations.of(context)!.regresionLineal: kRutaRegresionLineal,
      AppLocalizations.of(context)!.desigualdadDeChebyshevYConvergencia: kRutaDesigualdadDeChebyshevYConvergencia,
      AppLocalizations.of(context)!.transferenciaDeCalor: kRutaTransferenciaDeCalor,
      AppLocalizations.of(context)!.capacidadCalorificaYCalorLatente: kRutaCapacidadCalorificaYCalorLatente,
      AppLocalizations.of(context)!.leyesDeLosGases: kRutaLeyesDeLosGases,
      AppLocalizations.of(context)!.cicloDeCarnotYLeyesDeLaTermodinamica: kRutaCicloDeCarnotYLeyesDeLaTermodinamica,
      AppLocalizations.of(context)!.trabajoTermodinamico: kRutaTrabajoTermodinamico,
      AppLocalizations.of(context)!.entalpiaYEnergiaInterna: kRutaEntalpiaYEnergiaInterna,
      AppLocalizations.of(context)!.dilatacionLineal: kRutaDilatacionLineal,
      AppLocalizations.of(context)!.dilatacionSuperficialYVolumetrica: kRutaDilatacionSuperficialYVolumetrica,
      AppLocalizations.of(context)!.entropiaYTeoriaCinetica: kRutaEntropiaYTeoriaCinetica,
      AppLocalizations.of(context)!.procesosTermodinamicos: kRutaProcesosTermodinamicos,
      AppLocalizations.of(context)!.circuloUnitario: kRutaCirculoUnitario,
      AppLocalizations.of(context)!.signosDeFuncionesPorCuadrante: kRutaSignosDeFuncionesPorCuadrante,
      AppLocalizations.of(context)!.angulosNotablesGradosRadianes: kRutaAngulosNotablesGradosRadianes,
      AppLocalizations.of(context)!.relacionEntreFuncionesTrigonometricas: kRutaRelacionEntreFuncionesTrigonometricas,
      AppLocalizations.of(context)!.identidadesDeAnguloTripleYCuadruple: kRutaIdentidadesDeAnguloTripleYCuadruple,
      AppLocalizations.of(context)!.identidadesDeReduccionDePotencias: kRutaIdentidadesDeReduccionDePotencias,
      AppLocalizations.of(context)!.identidadesFundamentalesFormasDerivadas: kRutaIdentidadesFundamentalesFormasDerivadas,
      AppLocalizations.of(context)!.cotangenteDeSumaYRestaDeAngulos: kRutaCotangenteDeSumaYRestaDeAngulos,
      AppLocalizations.of(context)!.productoDeCosenoPorSeno: kRutaProductoDeCosenoPorSeno,
      // todo cambiar los strings por constantes
      //Electricidad
      AppLocalizations.of(context)!.electricidad: kRutaElectricidad,
      AppLocalizations.of(context)!.electricidadMagnetismo:
          kRutaMenuElectricidadYMagnetismo,
      AppLocalizations.of(context)!.cargaElectrica: kRutaCargaElectrica,
      AppLocalizations.of(context)!.cargaElectricaProtonElectron:
          kRutaCargaProtonElectron,
      AppLocalizations.of(context)!.distribucionesCargaElectrica:
          kRutaDistribucionesDeCargaElectrica,
      AppLocalizations.of(context)!.leyCoulomb: kRutaLeyDeCoulomb,
      AppLocalizations.of(context)!.principioSuperposicion:
          kRutaPrincipioDeSuperposicion,
      AppLocalizations.of(context)!.campoElectrico: kRutaCampoElectrico,
      AppLocalizations.of(context)!.campoElectricoDistribucionesCarga:
          kRutaCampoElectricoOriginadoPorDistribucionesDeCarga,
      AppLocalizations.of(context)!.flujoElectricoCampoVectorial:
          kRutaFlujoDeUnCampoVectorial,
      AppLocalizations.of(context)!.leyGauss: kRutaLeyDeGauss,
      AppLocalizations.of(context)!.energiaPotencialElectrica:
          kRutaEnergiaPotencialElectrica,
      AppLocalizations.of(context)!.calculoDiferenciasPotencial:
          kRutaCalculoDeDiferenciasDePotencial,
      AppLocalizations.of(context)!.teoremaDivergencia:
          kRutaTeoremaDeLaDivergencia,
      AppLocalizations.of(context)!.teoremaRotacional:
          kRutaTeoremaDelRotacional,
      AppLocalizations.of(context)!.circulacionCampoElectrostatico:
          kRutaCirculacionDelCampoElectrostatico,
      AppLocalizations.of(context)!.rotacionalCampoElectrostatico:
          kRutaRotacionalDelCampoElectrostatico,
      AppLocalizations.of(context)!.operadorGradiente: kRutaOperadorGradiente,
      AppLocalizations.of(context)!.gradienteFuncionEscalar:
          kRutaGradienteDeUnaFuncionEscalar,
      AppLocalizations.of(context)!.gradientePotencialElectrico:
          kRutaGradienteDePotencialElectrico,
      AppLocalizations.of(context)!.leyGaussFormaDiferencial:
          kRutaLeyDeGaussEnFormaDiferencial,
      AppLocalizations.of(context)!.ecuacionPoissonLaplace:
          kRutaEcuacionDePoissonYLaplace,
      AppLocalizations.of(context)!.superficiesEquipotenciales:
          kRutaSuperficiesEquipotenciales,

      AppLocalizations.of(context)!.capacitor: kRutaCapacitor,
      AppLocalizations.of(context)!.cargaCapacitor: kRutaCargaDeUnCapacitor,
      AppLocalizations.of(context)!.definicionCapacitancia:
          kRutaDefinicionDeCapacitancia,
      AppLocalizations.of(context)!.graficaCapacitancia:
          kRutaGraficaDeCapacitancia,
      AppLocalizations.of(context)!.simbologiaCapacitores:
          kRutaSimbologiaCapacitores,
      AppLocalizations.of(context)!.capacitorPlacasPlanasParalelas:
          kRutaCapacitorDePlacasPlanasYParalelas,
      AppLocalizations.of(context)!.energiaCapacitancia:
          kRutaEnergiaYCapacitancia,
      AppLocalizations.of(context)!.energiaAlmacenadaCapacitor:
          kRutaEnergiaAlmacenadaPorUnCapacitor,
      AppLocalizations.of(context)!.conexionSerieCapacitor:
          kRutaConexionEnSerieCapacitor,
      AppLocalizations.of(context)!.conexionParaleloCapacitor:
          kRutaConexionEnParaleloCapacitor,
      AppLocalizations.of(context)!.polarizacion: kRutaPolarizacion,
      AppLocalizations.of(context)!.polarizacionCargaInducida:
          kRutaPolarizacionYCargaInducida,
      AppLocalizations.of(context)!.constantesDielectricas:
          kRutaConstantesDielectricas,
      AppLocalizations.of(context)!.rigidezDielectrica: kRutaRigidezDielectrica,
      AppLocalizations.of(context)!.vectorDesplazamientoElectrico:
          kRutaVectorDeDesplazamientoElectrico,
      AppLocalizations.of(context)!.representacionVectoresElectricos:
          kRutaRepresentacionDeLosVectoresElectricos,

      AppLocalizations.of(context)!.portadoresCargaLibre:
          kRutaPortadoresDeCargaLibre,
      AppLocalizations.of(context)!
              .movimientoPortadoresCargaLibreDensidadCorriente:
          kRutaMovimientoDePortadoresDeCargaLibre,
      AppLocalizations.of(context)!.densidadCorrienteCorrienteElectrica:
          kRutaDensidadDeCorrienteYCorrienteElectrica,
      AppLocalizations.of(context)!.tiposCorrienteElectrica:
          kRutaTiposDeCorrienteElectrica,
      AppLocalizations.of(context)!.conductividadResistividad:
          kRutaConductividadYResistividad,
      AppLocalizations.of(context)!.leyOhm: kRutaLeyDeOhm,
      AppLocalizations.of(context)!.ecuacionOhm: kRutaEcuacionDeOhm,
      AppLocalizations.of(context)!.resistividadTemperatura:
          kRutaResistividadYTemperatura,
      AppLocalizations.of(context)!.efectoJoule: kRutaEfectoJoule,
      AppLocalizations.of(context)!.resistorSimbologiaBasica:
          kRutaResistorSimbologiaBasica,
      AppLocalizations.of(context)!.resistorLinealNoLineal:
          kRutaResistorLinealYNoLineal,
      AppLocalizations.of(context)!.conexionSerieResistor:
          kRutaConexionEnSerieResistor,
      AppLocalizations.of(context)!.conexionParaleloResistor:
          kRutaConexionEnParaleloResistor,
      AppLocalizations.of(context)!.fuenteFuerzaElectromotriz:
          kRutaFuenteDeFuerzaElectromotriz,
      AppLocalizations.of(context)!.elementosCapacitorResistor:
          kRutaElementosCapacitorYResistor,
      AppLocalizations.of(context)!.elementosFuerzaElectromotriz:
          kRutaElementosFem,
      AppLocalizations.of(context)!.teoriaCircuitos: kRutaTeoriaDeCircuitos,
      AppLocalizations.of(context)!.leyVoltajesKirchhoff:
          kRutaLeyDeVoltajesDeKirchhoff,
      AppLocalizations.of(context)!.leyCorrientesKirchhoff:
          kRutaLeyDeCorrientesDeKirchhoff,
      AppLocalizations.of(context)!.reglasLVKLCK: kRutaReglasParaLVKyLCK,
      AppLocalizations.of(context)!.circuitoRCVoltajeContinuo:
          kRutaCircuitoRCyVoltajeContinuo,
      AppLocalizations.of(context)!.leyesKirchhoffCircuitoRC:
          kRutaLeyesDeKirchhoffCircuitoRC,
      AppLocalizations.of(context)!.nomenclaturaBasicaCircuitos:
          kRutaNomenclaturaBasicaEmpleadaEnCircuitos,

      AppLocalizations.of(context)!.campoYPotencialElectricos:
          kRutaMenuCampoYPotencialElectricos,
      AppLocalizations.of(context)!.capacitanciaDielectricos:
          kRutaMenuCapacitanciaYDielectricos,
      AppLocalizations.of(context)!.circuitosElectricos:
          kRutaMenuCircuitosElectricos,
      AppLocalizations.of(context)!.magnetostatica: kRutaMenuMagnetostatica,
      AppLocalizations.of(context)!.induccionElectromagnetica:
          kRutaMenuInduccionElectromagnetica,

      AppLocalizations.of(context)!.generadorHomopolar: kRutaGeneradorHomopolar,
      AppLocalizations.of(context)!.inductanciaPropia: kRutaInductanciaPropia,
      AppLocalizations.of(context)!.inductanciaMutua: kRutaInductanciaMutua,
      AppLocalizations.of(context)!.inductanciaPropiaDeUnSolenoide:
          kRutaInductanciaPropiaDeUnSolenoide,
      AppLocalizations.of(context)!.inductanciaParaUnToroide:
          kRutaInductanciaParaUnToroide,
      AppLocalizations.of(context)!.inductanciaMutuaEntreDosSolenoidesCoaxiales:
          kRutaInductanciaMutuaEntreDosSolenoidesCoaxiales,
      AppLocalizations.of(context)!.leyDeInduccionDeFaradayYEnergisEnUnInductor:
          kRutaLeyDeInduccionDeFaraday,
      AppLocalizations.of(context)!.energiaAlmacenadaEnUnCampoMagnetico:
          kRutaEnergiaAlmacenadaEnUnCampoMagnetico,
      AppLocalizations.of(context)!.inductor: kRutaInductor,
      AppLocalizations.of(context)!.inductoresEnSerie: kRutaInductorEnSerie,

      AppLocalizations.of(context)!
              .descripcionDeLosImanesYExperimentosDeOersted:
          kRutaOrigenDeCampoMagnetico,
      AppLocalizations.of(context)!
              .fuerzaMagneticaComoVectorSobreCargasEnMovimiento:
          kRutaFuerzaMagneticaComoVectorSobreCargasEnMovimiento,
      AppLocalizations.of(context)!.definicionDeCampoMagnetico:
          kRutaDefinicionDeCampoMagnetico,
      AppLocalizations.of(context)!.fuerzaDeLorentz: kRutaFuerzaDeLorentz,
      AppLocalizations.of(context)!.leyDeBiotSavart: kRutaLeyDeBiotSavart,
      AppLocalizations.of(context)!.segmentoConductorRecto:
          kRutaSegmentoConductorRecto,
      AppLocalizations.of(context)!.espiraEnFormaDeCircunferencia:
          kRutaEspiraEnFormaDeCircunferencia,
      AppLocalizations.of(context)!.espiraCuadrada: kRutaEspiraCuadrada,
      AppLocalizations.of(context)!.bobina: kRutaBobina,
      AppLocalizations.of(context)!.solenoide: kRutaSolenoide,
      AppLocalizations.of(context)!.circulacionDeUnCampoVectorial:
          kRutaCirculacionDeUnCampoVectorial,
      AppLocalizations.of(context)!.campoMagneticoAPartirDeLeyDeAmpere:
          kRutaCampoMagneticoAPartirDeLeyDeAmpere,
      AppLocalizations.of(context)!.leyDeAmpereEnFormaDiferencial:
          kRutaLeyDeAmpereEnFormaDiferencial,
      AppLocalizations.of(context)!.flujoMagnetico: kRutaFlujoMagnetico,
      AppLocalizations.of(context)!.motorDeCorrienteDirecta:
          kRutaMotorDeCorrienteDirecta,

      //Preguntas Frecuentes
      AppLocalizations.of(context)!.comoPonerNumerosNegativos:
          kRutaPreguntasFrecuentes,
      //Generales
      AppLocalizations.of(context)!.generales: kRutaGenerales,
      AppLocalizations.of(context)!.propiedadesLogaritmos:
          kRutaPropiedadesLogaritmos,
      AppLocalizations.of(context)!.funcionesTrigonometricas:
          kRutaFuncionesTrigonometricasGenerales,
      AppLocalizations.of(context)!.identidadesTrigonometricas:
          kRutaIdentidadesTrigonometricas,
      //todo seleccionar cual será la que se queda de las identidades trigonometricas
      AppLocalizations.of(context)!.identidadesBasicas:
          '/identidadesTrigonometricas',

      AppLocalizations.of(context)!.trigonometricasHiperbolicas:
          kRutaTrigonometricasHiperbolicas,
      AppLocalizations.of(context)!.identidadesHiperbolicas:
          kRutaIdentidadesHiperbolicas,

      //Algebra
      AppLocalizations.of(context)!.algebra: kRutaMenuAlgebra,
      AppLocalizations.of(context)!.solucionEcuaciones: kRutaSolucionEcuaciones,
      AppLocalizations.of(context)!.ecuacionesDePrimerGrado:
          kRutaEcuacionesDePrimerGrado,
      AppLocalizations.of(context)!.ecuacionesDeSegundoGrado:
          kRutaEcuacionesDeSegundoGrado,
      AppLocalizations.of(context)!.ecuacionesLineales: kRutaEcuacionesLineales,
      AppLocalizations.of(context)!.formulaGeneral: kRutaFormulaGeneral,
      AppLocalizations.of(context)!.formulaProductos: kRutaFormulasDeProductos,
      AppLocalizations.of(context)!.formulasFactorizacion:
          kRutaFormulasDeFactorizacion,
      AppLocalizations.of(context)!.operacionesFraccionesAlgebraicas:
          kRutaOperacionesFraccionesAlgebraicas,
      AppLocalizations.of(context)!.operacionesPolinomios:
          kRutaOperacionesConPolinomios,
      AppLocalizations.of(context)!.propiedadesExponentes:
          kRutaPropiedadesDeLosExponentes,
      AppLocalizations.of(context)!.ejerciciosPropiedadesDeLosExponentes:
          kRutaPropiedadesDeLosExponentesEjercicios,
      AppLocalizations.of(context)!.propiedadesDesigualdades:
          kRutaPropiedadesDesigualdad,
      AppLocalizations.of(context)!.propiedadesRadicales:
          kRutaPropiedadesDesigualdad,
      AppLocalizations.of(context)!.serieTaylorMaclaurin:
          kRutaSerieTaylorMaClaurin,
      AppLocalizations.of(context)!.teoremaSumatoria: kRutaTeoremaSumatorias,
      AppLocalizations.of(context)!.numerosComplejos: kRutaNumerosComplejos,
      AppLocalizations.of(context)!.conjugadoDeUnNumeroComplejo:
          kRutaConjugadoNumerosComplejos,
      AppLocalizations.of(context)!.moduloYArgumentoDeUnNumeroComplejo:
          kRutaModuloyArgumentoNumerosComplejos,
      AppLocalizations.of(context)!.operacionesDeNumerosComplejos:
          kRutaOperacionesNumerosComplejos,
      AppLocalizations.of(context)!.propiedadesDeLosNumerosComplejos:
          kRutaPropiedadesNumerosComplejos,
      AppLocalizations.of(context)!.representacionesDeUnNumeroComplejo:
          kRutaRepresentacionesDeNumerosComplejos,

      //Algebra Lineal
      AppLocalizations.of(context)!.algebraLineal: kRutaAlgebraLinealMenu,
      AppLocalizations.of(context)!.determinantes:
          kRutaDeterminantesAlgebraLineal,
      AppLocalizations.of(context)!.matrices: kRutaMenuMatricesAlgebraLineal,
      AppLocalizations.of(context)!.matrizAdjunta: kRutaMatrizAdjunta,
      AppLocalizations.of(context)!.matrizIdentidad: kRutaMatrizIdentidad,
      AppLocalizations.of(context)!.matrizInversa: kRutaMatrizInversa,
      AppLocalizations.of(context)!.matrizOrtogonal: kRutaMatrizOrtogonal,
      AppLocalizations.of(context)!.matrizSimetrica: kRutaMatrizSimetrica,
      AppLocalizations.of(context)!.matrizTranspuesta: kRutaMatrizTranspuesta,
      AppLocalizations.of(context)!.matrizTriangular: kRutaMatrizTriangular,
      AppLocalizations.of(context)!.multiplicacionDeMatrices:
          kRutaMultiplicacionDeMatrices,
      AppLocalizations.of(context)!.propiedadesDeLasMatrices:
          kRutaPropiedadesDeLasMatrices,
      AppLocalizations.of(context)!.sumaYRestaDeMatrices:
          kRutaSumaRestaDeMatrices,
      AppLocalizations.of(context)!.puntoMedioEntreDosPuntos:
          kRutaPuntoMedioEntreDosPuntos,
      AppLocalizations.of(context)!.reglaCramer: kRutaReglaDeCramer,
      AppLocalizations.of(context)!.reglaSarrus: kRutaReglaDeSarrus,
      AppLocalizations.of(context)!.vectores: kRutaMenuVectores,
      AppLocalizations.of(context)!.anguloEntreVectores:
          kRutaAnguloEntreVectores,
      AppLocalizations.of(context)!.normalizacion: kRutaNormalizacion,
      AppLocalizations.of(context)!.operacionesConVectores:
          kRutaOperacionesConVectores,
      AppLocalizations.of(context)!.productoCruz: kRutaProductoCruz,
      AppLocalizations.of(context)!.productoPunto: kRutaProductoPunto,
      AppLocalizations.of(context)!.propiedadesDeLosVectores:
          kRutaPropiedadesDeLosVectores,
      AppLocalizations.of(context)!.proyeccionesDeVectores:
          kRutaProyeccionesDeVectores,
      AppLocalizations.of(context)!.vectorUnitario: kRutaVectorUnitario,
      AppLocalizations.of(context)!.vectoresYSuMagnitud:
          kRutaVectoresYSuMagnitud,

      //Calculo Diferencial
      AppLocalizations.of(context)!.calculoDiferencial: kRutaCalculoDiferencial,
      AppLocalizations.of(context)!.limites: kRutaLimites,
      AppLocalizations.of(context)!.propiedadesDeLosLimites:
          kRutaPropiedadesLimites,
      AppLocalizations.of(context)!.limitesTrigonometricos:
          kRutaLimitesTrigonometricos,
      AppLocalizations.of(context)!.derivacionBasica: kRutaDerivacionBasica,
      AppLocalizations.of(context)!.derivadasDeFuncionesTrigonometricas:
          kRutaFuncionesTrigonometricasDiferencial,
      AppLocalizations.of(context)!.derivadasDeFuncionesTrigonometricasInversas:
          kRutaFuncionesTrigonometricasInversasDiferencial,
      AppLocalizations.of(context)!
              .derivadasDeFuncionesTrigonometriasHiperbolicas:
          kRutaFuncionesTrigonometricasHiperbolicasDiferencial,
      AppLocalizations.of(context)!.derivadasDeFuncionesExponencialYLogaritmos:
          kRutaExponencialyLogaritmosDiferencial,

      //Calculo Integral
      AppLocalizations.of(context)!.calculoIntegral: kRutaCalculoIntegral,
      AppLocalizations.of(context)!.integracionBasica: kRutaIntegracionBasica,
      AppLocalizations.of(context)!.integralesDeFuncionesTrigonometricas:
          kRutaFuncionesTrigonometricasIntegral,
      AppLocalizations.of(context)!
              .integralesDeFuncionesTrigonometricasInversas:
          kRutaFuncionesTrigonometricasInversasIntegral,
      AppLocalizations.of(context)!
              .integralesDeFuncionesTrigonometricasHiperbolicas:
          kRutaFuncionesHiperbolicasIntegral,
      AppLocalizations.of(context)!.integralesDelExponencialYLogaritmos:
          kRutaFuncionesExponencialyLogaritmosIntegral,
      AppLocalizations.of(context)!.integralesExtras: kRutaIntegralesExtras,

      //Calculo Multivariable
      AppLocalizations.of(context)!.calculoMultivariable:
          kRutaMenuCalculoMultivariable,
      AppLocalizations.of(context)!.areaBajoCurva: kRutaAreaBajoLaCurva,
      AppLocalizations.of(context)!.areaSuperficieRevolucion:
          kRutaAreaDeUnaSuperficieDeRevolucion,
      AppLocalizations.of(context)!.cambioVariable: kRutaCambioDeVariables,
      AppLocalizations.of(context)!.derivadasDireccionales:
          kRutaDerivadasDireccionales,
      AppLocalizations.of(context)!.derivadasParciales: kRutaDerivadasParciales,
      AppLocalizations.of(context)!.diferencialTotal: kRutaDiferencialTotal,
      AppLocalizations.of(context)!.funcionesVectoriales:
          kRutaMenuFuncionesVectoriales,
      AppLocalizations.of(context)!.derivadasFuncionesVectoriales:
          kRutaDerivadaFuncionesVectoriales,
      AppLocalizations.of(context)!
              .limitesDerivadasIntegralesFuncionesVectoriales:
          kRutaLimiteIntegralDerivadaFuncionVectorial,
      AppLocalizations.of(context)!.gradienteFuncion:
          kRutaGradienteDeUnaFuncion,
      AppLocalizations.of(context)!.identidadesVectoriales:
          kRutaIdentidadesVectoriales,
      AppLocalizations.of(context)!.integralCoordenadasCilindricas:
          kRutaIntegralEnCoordenadasCilindricas,
      AppLocalizations.of(context)!.integralesLinea: kRutaIntegralesDeLinea,
      AppLocalizations.of(context)!.longitudArco: kRutaLongitudDeArco,
      AppLocalizations.of(context)!.operadoresDiferenciales:
          kRutaOperadoresDiferenciales,
      AppLocalizations.of(context)!.teoremaFubini: kRutaTeoremaDeFubini,
      AppLocalizations.of(context)!.teoremaIntegrales: kRutaTeoremaIntegrales,

      //Ecuaciones Diferenciales
      AppLocalizations.of(context)!.ecuacionesDiferenciales:
          kRutaMenuEcuacionesDiferenciales,
      AppLocalizations.of(context)!.constanteDeIntegracion:
          kRutaConstantesDeIntegracion,
      AppLocalizations.of(context)!.ecuacionDiferencialCoeficientesConstantes:
          kRutaEcuacionDiferencialConCoeficientesConstantes,
      AppLocalizations.of(context)!.ecuacionDiferencialRectasNoParalelas:
          kRutaEcuacionDiferencialDeRectasNoParalelas,
      AppLocalizations.of(context)!.ecuacionDiferencialRectasParalelas:
          kRutaEcuacionDiferencialDeRectasParalelas,
      AppLocalizations.of(context)!.ecuacionDiferencialExacta:
          kRutaEcuacionDiferencialExacta,
      AppLocalizations.of(context)!.ecuacionDiferencialHomogenea:
          kRutaEcuacionDiferencialHomogenea,
      AppLocalizations.of(context)!.ecuacionDiferencialLinealOrdenSuperior:
          kRutaEcuacionDiferencialLinealDeOrdenSuperior,
      AppLocalizations.of(context)!.ecuacionDiferencialLinealPrimerOrden:
          kRutaEcuacionDiferencialLinealDePrimerOrden,
      AppLocalizations.of(context)!.ecuacionDiferencialSeparable:
          kRutaEcuacionDiferencialSeparable,

      //Geometria
      AppLocalizations.of(context)!.geometria: kRutaMenuGeometria,
      AppLocalizations.of(context)!.angulosEnUnPoligono:
          kRutaAngulosEnUnPoligono,
      AppLocalizations.of(context)!.areas: kRutaMenuAreasGeometria,
      AppLocalizations.of(context)!.areaPerimetroCuadrilateros:
          kRutaAreaYPerimetroDeCuadrilateros,
      AppLocalizations.of(context)!.areaPerimetroTriangulos:
          kRutaAreaYPerimetroDeTriangulos,
      AppLocalizations.of(context)!.areaPerimetroCirculo:
          kRutaAreaYPerimetroDelCirculo,
      AppLocalizations.of(context)!.circunferencia: kRutaCircunferencia,
      AppLocalizations.of(context)!.distanciaDeUnPuntoAUnaRecta:
          kRutaDistanciaDeUnPuntoAUnaRecta,
      AppLocalizations.of(context)!.distanciaEntreDosPuntos:
          kRutaDistanciaEntreDosPuntos,
      AppLocalizations.of(context)!.ecuacionRecta: kRutaEcuacionDeLaRecta,
      AppLocalizations.of(context)!.elipseConCentroDiferenteDelOrigen:
          kRutaElipseConCentroDiferenteDelOrigen,
      AppLocalizations.of(context)!.elipseConCentroEnElOrigen:
          kRutaElipseConCentroEnElOrigen,
      AppLocalizations.of(context)!.hiperbola: kRutaHiperbola,
      AppLocalizations.of(context)!.parabolaConVerticeEnElOrigen:
          kRutaParabolaConVerticeEnElOrigen,
      AppLocalizations.of(context)!.parabolaConVerticeEnElOrigen:
          kRutaParabolaConVerticeDiferenteDelOrigen,
      AppLocalizations.of(context)!.puntoMedioEntreDosPuntos:
          kRutaPuntoMedioEntreDosPuntosGeometria,
      AppLocalizations.of(context)!.volumenDeCuerposGeometricos:
          kRutaVolumenDeCuerposGeometricos,

      //Matematicas Discretas
      AppLocalizations.of(context)!.matematicasDiscretas:
          kRutaMenuMatematicasDiscretas,
      AppLocalizations.of(context)!.bicondicional: kRutaBicondicional,
      AppLocalizations.of(context)!.condicional: kRutaCondicional,
      AppLocalizations.of(context)!.conectoresLogicos: kRutaConectoresLogicos,
      AppLocalizations.of(context)!.conjuncion: kRutaConjuncion,
      AppLocalizations.of(context)!.disyuncion: kRutaDisyuncion,
      AppLocalizations.of(context)!.leyesDeLaLogicaProposicional:
          kRutaLeyesDeLaLogicaProposicional,
      AppLocalizations.of(context)!.leyesDeLaTeoriaDeConjuntos:
          kRutaLeyesDeLaTeoriaDeConjuntos,
      AppLocalizations.of(context)!.leyesDelAlgebraDeBoole:
          kRutaLeyesDelAlgebraDeBoole,
      AppLocalizations.of(context)!.negacion: kRutaNegacion,

      //Matematicas Financieras
      AppLocalizations.of(context)!.matematicasFinancieras:
          kRutaMenuMatematicasFinancieras,
      AppLocalizations.of(context)!.amortizacion: kRutaAmortizacion,
      AppLocalizations.of(context)!.anualidadAnticipadaSimpleYCierta:
          kRutaAnualidadAnticipadaSimpleYCierta,
      AppLocalizations.of(context)!.anualidadVencidaSimpleYCierta:
          kRutaAnualidadVencidaSimpleYCierta,
      AppLocalizations.of(context)!.descuentoCompuesto: kRutaDescuentoCompuesto,
      AppLocalizations.of(context)!.descuentoSimple: kRutaDescuentoSimple,
      AppLocalizations.of(context)!.interesCompuesto: kRutaInteresCompuesto,
      AppLocalizations.of(context)!.interesSimple: kRutaInteresSimple,
      AppLocalizations.of(context)!.saldoInsoluto: kRutaSaldoInsoluto,
      AppLocalizations.of(context)!.tasaInteresGlobal: kRutaTasaDeInteresGlobal,
      AppLocalizations.of(context)!.tasaEfectiva: kRutaTasaEfectiva,

      //Probabilidad y Estadistica
      AppLocalizations.of(context)!.probabilidadEstadistica:
          kRutaMenuProbabilidadYEstadistica,
      AppLocalizations.of(context)!.distribuciones: kRutaMenuDistribuciones,
      AppLocalizations.of(context)!.distribucionBinomial:
          kRutaDistribucionBinomial,
      AppLocalizations.of(context)!.distribucionPoisson:
          kRutaDistribucionDePoisson,
      AppLocalizations.of(context)!.distribucionExponencial:
          kRutaDistribucionExponencial,
      AppLocalizations.of(context)!.distribucionGeometrica:
          kRutaDistribucionGeometrica,
      AppLocalizations.of(context)!.distribucionHipergeometrica:
          kRutaDistribucionHipergeometrica,
      AppLocalizations.of(context)!.distribucionNormal: kRutaDistribucionNormal,
      AppLocalizations.of(context)!.distribucionTStudent:
          kRutaDistribucionTDeStudent,
      AppLocalizations.of(context)!.medidas: kRutaMenuMedidas,
      AppLocalizations.of(context)!.dispersionParaDatosNoAgrupados:
          kRutaMedidasDeDispersionParaDatosNoAgrupados,
      AppLocalizations.of(context)!.posicionParaDatosNoAgrupados:
          kRutaMedidasDePosicionParaDatosNoAgrupados,
      AppLocalizations.of(context)!.tendenciaCentralParaDatosAgrupados:
          kRutaMedidasDeTendenciaCentralParaDatosAgrupados,
      AppLocalizations.of(context)!.tendenciaCentralParaDatosNoAgrupados:
          kRutaMedidasDeTendenciaCentralParaDatosNoAgrupados,
      AppLocalizations.of(context)!.combinacionesYPermutaciones:
          kRutaCombinacionesYPermutaciones,
      AppLocalizations.of(context)!.cuantilesParaDatosAgrupados:
          kRutaCuantilesParaDatosAgrupados,
      AppLocalizations.of(context)!.estadisticaInferencial:
          kRutaEstadisticaInferencial,
      AppLocalizations.of(context)!.intervalosDeConfianza:
          kRutaIntervalosDeConfianza,
      AppLocalizations.of(context)!.mediaGeometrica: kRutaMediaGeometrica,
      AppLocalizations.of(context)!.momentosEstadisticos:
          kRutaMomentosEstadisticos,
      AppLocalizations.of(context)!.probabilidad: kRutaProbabilidad,
      AppLocalizations.of(context)!.tamanioMuestral: kRutaTamanioMuestral,

      //Series de Fourier
      AppLocalizations.of(context)!.seriesFourier: kRutaMenuSeriesDeFourier,
      AppLocalizations.of(context)!.simetrias: kRutaMenuSimetrias,
      AppLocalizations.of(context)!.simetriaMediaOnda: kRutaSimetriaDeMediaOnda,
      AppLocalizations.of(context)!.simetriaCuartoOndaImpar:
          kRutaSimetriaDeUnCuartoDeOndaImpar,
      AppLocalizations.of(context)!.simetriaCuartoOndaPar:
          kRutaSimetriaDeUnCuartoDeOndaPar,
      AppLocalizations.of(context)!.simetriaImpar: kRutaSimetriaImpar,
      AppLocalizations.of(context)!.simetriaPar: kRutaSimetriaPar,
      AppLocalizations.of(context)!.transformadas: kRutaMenuTransformadas,
      AppLocalizations.of(context)!.transformadaDeFourier:
          kRutaTransformadaDeFourier,
      AppLocalizations.of(context)!.transformadaDeLaplace:
          kRutaTransformadaDeLaplace,
      AppLocalizations.of(context)!.transformadasBasicasDeFourier:
          kRutaTransformadasBasicasDeFourier,
      AppLocalizations.of(context)!.transformadasDeFourier:
          kRutaTransformadasDeFourier,
      AppLocalizations.of(context)!.transformadasDeLaplace:
          kRutaTransformadasDeLaplace,
      AppLocalizations.of(context)!.convolucion: kRutaConvolucion,
      AppLocalizations.of(context)!.formaComplejaDeLasSeriesDeFourier:
          kRutaFormaComplejaDeLasSeriesDeFourier,
      AppLocalizations.of(context)!
              .formulasOperacionalesDeLaTransformadaDeLaplace:
          kRutaFormulasOperacionalesDeLaTransformadaDeLaplace,
      AppLocalizations.of(context)!.funcionImpulsoUnitario:
          kRutaFuncionImpulsoUnitario,
      AppLocalizations.of(context)!.funcionUnitariaDeHeaviside:
          kRutaFuncionUnitariaDeHeaviside,
      AppLocalizations.of(context)!.serieYCoeficientesDeFourier:
          kRutaSerieYCoeficientesDeFourier,
      AppLocalizations.of(context)!.transformadaSenoYCosenoDeFourier:
          kRutaTransformadaSenoYCosenoDeFourier,

      //Trigonometria
      AppLocalizations.of(context)!.trigonometria: kRutaMenuTrigonometria,
      AppLocalizations.of(context)!.formulasDeBessel: kRutaMenuFormulasBessel,
      AppLocalizations.of(context)!.teoremaDeLaCotangente:
          kRutaTeoremaDeLaCotangente,
      AppLocalizations.of(context)!.teoremaDelCosenoParaAngulos:
          kRutaTeoremaDelCosenoParaAngulos,
      AppLocalizations.of(context)!.teoremaDelCosenoParaLados:
          kRutaTeoremaDelCosenoParaLados,
      AppLocalizations.of(context)!.teoremaDelSeno: kRutaTeoremaDelSeno,
      AppLocalizations.of(context)!.identidadesTrigonometricas:
          kRutaMenuIdentidadesTrigonometricas,
      AppLocalizations.of(context)!.anguloDobleYMedio:
          kRutaIdentidadesTrigonometricasDeAnguloDobleYMedio,
      AppLocalizations.of(context)!.deSumaAProductoYViceversa:
          kRutaIdentidadesTrigonometricasDeSumaAProductoYViceversa,
      AppLocalizations.of(context)!.deSumaYRestaDeAngulos:
          kRutaIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
      AppLocalizations.of(context)!.identidadesTrigonometricasExtras:
          kRutaIdentidadesTrigonometricasExtras,
      AppLocalizations.of(context)!.identidadesTrigonometricas:
          kRutaIdentidadesTrigonometricasFundamentales,
      AppLocalizations.of(context)!.funcionesTrigonometricasDeAngulosNotables:
          kRutaFuncionesTrigonometricasDeAngulosNotables,
      AppLocalizations.of(context)!.leyDeProyecciones: kRutaLeyDeProyecciones,
      AppLocalizations.of(context)!.medicionYClasificacionDeAngulos:
          kRutaMedicionYClasificacionDeAngulos,
      AppLocalizations.of(context)!.teoremaDePitagoras: kRutaTeoremaDePitagoras,
      AppLocalizations.of(context)!.trigonometriaEsferica:
          kRutaMenuTrigonometriaEsferica,
      AppLocalizations.of(context)!.analogiasDeGaussDelambre:
          kRutaAnalogiasDeGaussDelambre,
      AppLocalizations.of(context)!.analogiasDeNeper: kRutaAnalogiasDeNeper,
      AppLocalizations.of(context)!.funcionesDelAnguloMitad:
          kRutaFuncionesDelAnguloMitad,
      AppLocalizations.of(context)!.valoresDeSenoYCoseno:
          kRutaValoresDeSenoYCoseno,
      AppLocalizations.of(context)!.leyDeSenosCosenosYTangente:
          kRutaLeyesDeSenosCosenosTangentes,
      AppLocalizations.of(context)!.superficieDeUnTrianguloYUnPoligonoEsferico:
          kRutaSuperficieDeUnTrianguloYUnPoligonoEsferico,
    };
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : kColorFondo),
        onPressed: () {
          if (query.isNotEmpty) {
            query = '';
          } else {
            close(context, null);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : kColorFondo,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> searchResults = getSearchResults(context);
    Map<dynamic, String> searchResultss = getSearchResultss(context);
    List<String> suggestions = searchResults.where((String suggestion) {
      return suggestion
          .toLowerCase()
          .contains(removeDiacritics(query.toLowerCase()));
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(
            suggestion,
            style: GoogleFonts.poppins(
              color: kColorBlanco,
            ),
          ),
          onTap: () {
            query = suggestion;
            showResults(context);
            Navigator.pushNamed(context, searchResultss[query]!);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchResults = getSearchResults(context);
    Map<dynamic, String> searchResultss = getSearchResultss(context);
    if (query.isEmpty) {
      return const Center(
        child: Opacity(
          opacity: 0.2,
          child: FadeInImage(
            height: 300.0,
            width: 300.0,
            placeholder: AssetImage(kUrlImagenGifCarga),
            image: NetworkImage(kUrlImagenCapdesisTexto),
          ),
        ),
      );
    }
    List<String> suggestions = searchResults.where((String suggestion) {
      return suggestion
          .toLowerCase()
          .contains(removeDiacritics(query.toLowerCase()));
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(
            suggestion,
            style: GoogleFonts.poppins(color: kColorBlanco),
          ),
          onTap: () {
            query = suggestion;
            showResults(context);
            Navigator.pushNamed(context, searchResultss[query]!);
          },
        );
      },
    );
  }
}
