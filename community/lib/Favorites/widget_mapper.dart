import 'package:flutter/material.dart';

import '../constantes/export_constantes.dart';
import '../secciones_app/algebra/export_algebra.dart';
import '../secciones_app/algebra_lineal/export_algebra_lineal.dart';
import '../secciones_app/calculo_diferencial/export_calculo_diferencial.dart';
import '../secciones_app/calculo_integral/export_calculo_integral.dart';
import '../secciones_app/calculo_multivariable/export_calculo_multivariable.dart';
import '../secciones_app/ecuaciones_diferenciales/export_ecuaciones_diferenciales.dart';
import '../secciones_app/ejercicios/export_ejercicios.dart';
import '../secciones_app/electricidad_y_magnetismo/export_electricidad_y_magnetismo.dart';
import '../secciones_app/generales/export_generales.dart';
import '../secciones_app/geometria/export_geometria.dart';
import '../secciones_app/matematicas_discretas/export_matematicas_discretas.dart';
import '../secciones_app/matematicas_financieras/export_matematicas_financieras.dart';
import '../secciones_app/probabilidad_y_estadistica/export_probabilidad_y_estadistica.dart';
import '../secciones_app/series_de_fourier/export_series_de_fourier.dart';
import '../secciones_app/trigonometria/export_trigonometria.dart';

final Map<String, WidgetBuilder> widgetTable = {
  //Algebra
  kWidgetFormulaGeneral: (context) => FormulaGeneral(),
  kWidgetEcuacionesDePrimerGrado: (context) => EcuacionesDePrimerGrado(),
  kWidgetEcuacionesDeSegundoGrado: (context) => EcuacionesDeSegundoGrado(),
  kWidgetPropiedadesDeLosExponentesEjercicios: (context) =>
      PropiedadesDeLosExponentesEjercicios(),
  kWidgetConjugadoDeUnNumeroComplejo: (context) => ConjugadoNumerosComplejos(),
  kWidgetModuloYArgumentoDeUnNumeroComplejo: (context) =>
      ModuloyArgumentoNumerosComplejos(),
  kWidgetOperacionesDeNumerosComplejos: (context) =>
      OperacionesNumerosComplejos(),
  kWidgetPropiedadesNumerosComplejos: (context) =>
      PropiedadesNumerosComplejos(),
  kWidgetRepresentacionesDeUnNumeroComplejo: (context) =>
      RepresentacionesDeNumerosComplejos(),
  kWidgetEcuacionesLineales: (context) => EcuacionesLineales(),
  kWidgetFormulasDeProductos: (context) => FormulasDeProductos(),
  kWidgetFormulasDeFactorizacion: (context) => FormulasDeFactorizacion(),
  kWidgetOperacionesConFraccionesAlgebraicas: (context) =>
      OperacionesFraccionesAlgebraicas(),
  kWidgetOperacionesPolinomios: (context) => OperacionesConPolinomios(),
  kWidgetPropiedadesDeLosExponentes: (context) => PropiedadesDeLosExponentes(),
  kWidgetPropiedadesDesigualdad: (context) => PropiedadesDesigualdad(),
  kWidgetPropiedadesRadicales: (context) => PropiedadesRadicales(),
  kWidgetSerieDeTaylorYMaClaurin: (context) => SerieTaylorMaClaurin(),
  kWidgetTeoremaDeSumatorias: (context) => TeoremaSumatorias(),
  //Algebra Lineal
  kWidgetMatrizAdjunta: (context) => MatrizAdjunta(),
  kWidgetMatrizidentidad: (context) => MatrizIdentidad(),
  kWidgetMatrizInversa: (context) => MatrizInversa(),
  kWidgetMatrizOrtogonal: (context) => MatrizOrtogonal(),
  kWidgetMatrizSimetrica: (context) => MatrizSimetrica(),
  kWidgetMatrizTranspuesta: (context) => MatrizTranspuesta(),
  kWidgetMatrizTriangular: (context) => MatrizTriangular(),
  kWidgetMultiplicacionDeMatrices: (context) => MultiplicacionDeMatrices(),
  kWidgetPropiedadesDeLasMatrices: (context) => PropiedadesDeLasMatrices(),
  kWidgetSumaRestaDeMatrices: (context) => SumaRestaDeMatrices(),
  kWidgetAnguloEntreVectores: (context) => AnguloEntreVectores(),
  kWidgetNormalizacion: (context) => Normalizacion(),
  kWidgetOperacionesConVectores: (context) => OperacionesConVectores(),
  kWidgetProductoCruz: (context) => ProductoCruz(),
  kWidgetProductoPunto: (context) => ProductoPunto(),
  kWidgetPropiedadesDeLosVectores: (context) => PropiedadesDeLosVectores(),
  kWidgetProyeccionesDeVectores: (context) => ProyeccionesDeVectores(),
  kWidgetVectorUnitario: (context) => VectorUnitario(),
  kWidgetVectoresYSuMagnitud: (context) => VectoresYSuMagnitud(),
  kWidgetDeterminantesAlgebraLineal: (context) => DeterminantesAlgebraLineal(),
  kWidgetReglaDeCramer: (context) => ReglaDeCramer(),
  kWidgetReglaDeSarrus: (context) => ReglaDeSarrus(),
  //Calculo Diferencial
  kWidgetLimitesTrigonometricos: (context) => LimitesTrigonometricos(),
  kWidgetPropiedadesLimites: (context) => PropiedadesLimites(),
  kWidgetDerivacionBasicaDiferencial: (context) =>
      DerivacionBasicaDiferencial(),
  kWidgetExponencialLogaritmos: (context) =>
      ExponencialyLogaritmosDiferencial(),
  kWidgetFuncionesTrigonometricasDiferencial: (context) =>
      FuncionesTrigonometricasDiferencial(),
  kWidgetFuncionesTrigonometricasInversasDiferencial: (context) =>
      TrigonometricasInversasDiferencial(),
  kWidgetFuncionesHiperbolicas: (context) =>
      TrigonometricasHiperbolicasDiferencial(),
  //Calculo Integral
  kWidgetExponencialLogaritmoIntegral: (context) =>
      ExponencialyLogaritmoIntegral(),
  kWidgetFuncionesHiperbolicasIntegral: (context) =>
      FuncionesHiperbolicasIntegral(),
  kWidgetFuncionesTrigonometricasIntegral: (context) =>
      FuncionesTrigonometricasIntegral(),
  kWidgetIntegracionBasica: (context) => IntegracionBasicaIntegral(),
  kWidgetIntegralesExtrasIntegral: (context) => IntegralesExtraIntegral(),
  kWidgetTrigonometricasInversasIntegral: (context) =>
      TrigonometricasInversasIntegral(),

  //Calculo Multivariable
  kWidgetDerivadaFuncionesVectoriales: (context) =>
      DerivadaFuncionesVectoriales(),
  kWidgetLimiteDerivadaIntegralFuncionesVectoriales: (context) =>
      LimiteDerivadaIntegralFuncionesVectoriales(),
  kWidgetAreaBajoLaCurva: (context) => AreaBajoLaCurva(),
  kWidgetAreaDeUnaSuperficieDeRevolucion: (context) =>
      AreaDeUnaSuperficieDeRevolucion(),
  kWidgetCambioDeVariables: (context) => CambioDeVariables(),
  kWidgetDerivadasDireccionales: (context) => DerivadasDireccionales(),
  kWidgetDerivadasParciales: (context) => DerivadasParciales(),
  kWidgetDiferencialTotal: (context) => DiferencialTotal(),
  kWidgetGradienteDeUnaFuncion: (context) => GradienteDeUnaFuncion(),
  kWidgetIdentidadesVectoriales: (context) => IdentidadesVectoriales(),
  kWidgetIntegralEnCoordenasCilindricas: (context) =>
      IntegralEnCoordenadasCilindricas(),
  kWidgetIntegralesDeLinea: (context) => IntegralesDeLinea(),
  kWidgetLongitudDeArco: (context) => LongitudDeArco(),
  kWidgetOperadoresDiferenciales: (context) => OperadoresDiferenciales(),
  kWidgetTeoremaDeFubini: (context) => TeoremaDeFubini(),
  kWidgetTeoremaIntegrales: (context) => TeoremaIntegrales(),

  //Ecuaciones Diferenciales
  kWidgetConstantesDeIntegracion: (context) => ConstantesDeIntegracion(),
  kWidgetEcuacionDiferencialConCoeficientesConstantes: (context) =>
      EcuacionDiferencialConCoeficientesConstantes(),
  kWidgetEcuacionDiferencialDeRectasNoParalelas: (context) =>
      EcuacionDiferencialDeRectasNoParalelas(),
  kWidgetEcuacionDiferencialDeRectasParalelas: (context) =>
      EcuacionDiferencialDeRectasParalelas(),
  kWidgetEcuacionDiferencialExacta: (context) => EcuacionDiferencialExacta(),
  kWidgetEcuacionDiferencialHomogenea: (context) =>
      EcuacionDiferencialHomogenea(),
  kWidgetEcuacionDiferencialLinealDeOrdenSuperior: (context) =>
      EcuacionDiferencialLinealDeOrdenSuperior(),
  kWidgetEcuacionDiferencialLinealDePrimerOrden: (context) =>
      EcuacionDiferencialLinealDePrimerOrden(),
  kWidgetEcuacionDiferencialSeparable: (context) =>
      EcuacionDiferencialSeparable(),
  //Electricidad y Magnetismo
  //Campo y potencial electricos
  kWidgetCalculoDeDiferenciasDePotencial: (context) =>
      CalculoDeDiferenciasDePotencial(),
  kWidgetCampoElectrico: (context) => CampoElectrico(),
  kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga: (context) =>
      CampoElectricoOriginadoPorDistribucionesDeCarga(),
  kWidgetCargaElectrica: (context) => CargaElectrica(),
  kWidgetCargaProtonyElectron: (context) => CargaProtonElectron(),
  kWidgetCirculacionDelCampoElectrostatico: (context) =>
      CirculacionDelCampoElectrostatico(),
  kWidgetDistribucionesDeCargaElectrica: (context) =>
      DistribucionesDeCargaElectrica(),
  kWidgetEcuacionDePossionYLaplace: (context) => EcuacionDePoissonYLaplace(),
  kWidgetElectricidad: (context) => Electricidad(),
  kWidgetEnergiaPotencialElectrica: (context) => EnergiaPotencialElectrica(),
  kWidgetFlujoElectricoDeUnCampoVectorial: (context) =>
      FlujoDeUnCampoVectorial(),
  kWidgetGradienteDePotencialElectrico: (context) =>
      GradienteDePotencialElectrico(),
  kWidgetGradienteDeUnaFuncionEscalar: (context) =>
      GradienteDeUnaFuncionEscalar(),
  kWidgetLeyDeCoulomb: (context) => LeyDeCoulomb(),
  kWidgetLeyDeGauss: (context) => LeyDeGauss(),
  kWidgetLeyDeGaussEnFormaDiferencial: (context) =>
      LeyDeGaussEnFormaDiferencial(),
  kWidgetOperadorGradiente: (context) => OperadorGradiente(),
  kWidgetPrincipioDeSuperposicion: (context) => PrincipioDeSuperposicion(),
  kWidgetRotacionalDelCampoElectrostatico: (context) =>
      RotacionalDelCampoElectrostatico(),
  kWidgetSuperficiesEquipotenciales: (context) => SuperficiesEquipotenciales(),
  kWidgetTeoremaDeLaDivergencia: (context) => TeoremaDeLaDivergencia(),
  kWidgetTeoremaDelRotacional: (context) => TeoremaDelRotacional(),
  //Capacitancia y Dielectricos

  kWidgetCapacitor: (context) => Capacitor(),
  kWidgetCapacitorDePlacasPlanasYParalelas: (context) =>
      CapacitorDePlacasPlanasYParalelas(),
  kWidgetCargaDeUnCapacitor: (context) => CargaDeUnCapacitor(),
  kWidgetGraficaDeCapacitancia: (context) => GraficaDeCapacitancia(),
  kWidgetConexionEnParaleloCapacitor: (context) =>
      ConexionEnParaleloCapacitor(),
  kWidgetConexionEnSerieCapacitor: (context) => ConexionEnSerieCapacitor(),
  kWidgetConstantesDielectricas: (context) => ConstantesDielectricas(),
  kWidgetDefinicionDeCapacitancia: (context) => DefinicionDeCapacitancia(),
  kWidgetEnergiaAlmacenadaPorUnCapacitor: (context) =>
      EnergiaAlmacenadaPorUnCapacitor(),
  kWidgetEnergiaYCapacitancia: (context) => EnergiaYCapacitancia(),
  kWidgetPolarizacion: (context) => Polarizacion(),
  kWidgetPolarizacionYCargaInducida: (context) => PolarizacionYCargaInducida(),
  kWidgetRepresentacionDeLosVectoresElectricos: (context) =>
      RepresentacionDeLosVectoresElectricos(),
  kWidgetRigidezDielectrica: (context) => RigidezDielectrica(),
  kWidgetSimbologiaCapacitores: (context) => SimbologiaCapacitores(),
  kWidgetVectorDeDesplazamientoElectrico: (context) =>
      VectorDeDesplazamientoElectrico(),
  //Circuitos Electricos
  kWidgetCircuitoRCyVoltajeContinuo: (context) => CircuitoRCyVoltajeContinuo(),
  kWidgetConductividadyResistividad: (context) => ConductividadYResistividad(),
  kWidgetConexionEnParaleloResistor: (context) => ConexionEnParaleloResistor(),
  kWidgetConexionEnSerieResistor: (context) => ConexionEnSerieResistor(),
  kWidgetDensidadDeCorrienteYCorrienteElectrica: (context) =>
      DensidadDeCorrienteYCorrienteElectrica(),
  kWidgetEcuacionDeOhm: (context) => EcuacionDeOhm(),
  kWidgetEfectoJoule: (context) => EfectoJoule(),
  kWidgetElementosCapacitorYResistor: (context) =>
      ElementosCapacitorYResistor(),
  kWidgetElementosFem: (context) => ElementosFem(),
  kWidgetFuenteDeFuerzaElectromotriz: (context) =>
      FuenteDeFuerzaElectromotrizFem(),
  kWidgetLeyDeCorrienteDeKirchhoff: (context) => LeyDeCorrientesDeKirchhoff(),
  kWidgetLeyDeOhm: (context) => LeyDeOhm(),
  kWidgetLeyDeVoltajesDeKirchhoff: (context) => LeyDeVoltajesDeKirchhoff(),
  kWidgetLeyesDeKirchhoffCircuitoRc: (context) => LeyesDeKirchhoffCircuitoRC(),
  kWidgetMovimientoDePortadoresDeCargaLibreYDensidadDeCorriente: (context) =>
      MovimientoDePortadoresDeCargaLibreYDensidadDeCorriente(),
  kWidgetNomenclaturaBasicaEmpleadaEnCircuitos: (context) =>
      NomenclaturaBasicaEmpleadaEnCircuitos(),
  kWidgetPortadoresDeCargaLibre: (context) => PortadoresDeCargaLibre(),
  kWidgetReglasParaLVKyLCK: (context) => ReglasParaLVKyLCK(),
  kWidgetResistividadYTemperatura: (context) => ResistividadYTemperatura(),
  kWidgetResistorLinealYNoLineal: (context) => ResistorLinealYNoLineal(),
  kWidgetResistorSimbologiaBasica: (context) => ResistorSimbologiaBasica(),
  kWidgetTeoriaDeCircuitos: (context) => TeoriaDeCircuitos(),
  kWidgetTiposDeCorrienteElectrica: (context) => TiposDeCorrienteElectrica(),
  //Induccion Electromagnetica

  kWidgetEnergiaAlmacenadaEnUnCampoMagnetico: (context) =>
      EnergiaAlmacenadaEnUnCampoMagnetico(),
  kWidgetInductanciaMutua: (context) => InductanciaMutua(),
  kWidgetInductanciaMutuaEntreDosSolenoidesCoaxiales: (context) =>
      InductanciaMutuaEntreDosSolenoidesCoaxiales(),
  kWidgetInductanciaParaUnToroide: (context) => InductanciaParaUnToroide(),
  kWidgetInductanciaPropia: (context) => InductanciaPropia(),
  kWidgetInductanciaPropiaDeUnSolenoide: (context) =>
      InductanciaPropiaDeUnSolenoide(),
  kWidgetInductor: (context) => Inductor(),
  kWidgetInductoresEnSerie: (context) => InductoresEnSerie(),
  kWidgetLeyDeFaradayYEnergiaEnUnInductor: (context) =>
      LeyDeInduccionDeFaradayEnergiaEnUnInductor(),
  kWidgetPrincipioDeOperacionDelGeneradorElectrico: (context) =>
      GeneradorHomopolar(),
  //Magnetostatica
  kWidgetBobina: (context) => Bobina(),
  kWidgetCampoMagneticoAPartirDeLeyDeAmpere: (context) =>
      CampoMagneticoAPartirDeLeyDeAmpere(),
  kWidgetCirculacionDeUnCampoVectorial: (context) =>
      CirculacionDeUnCampoVectorial(),
  kWidgetDefinicionDeCampoMagnetico: (context) => DefinicionDeCampoMagnetico(),
  kWidgetEspiraCuadrada: (context) => EspiraCuadrada(),
  kWidgetEspiraEnFormaDeCircunferencia: (context) =>
      EspiraEnFormaDeCircunferencia(),
  kWidgetFlujoMagnetico: (context) => FlujoMagnetico(),
  kWidgetFuerzaDeLorentz: (context) => FuerzaDeLorentz(),
  kWidgetFuerzaMagneticaComoVectorSobreCargasEnMovimiento: (context) =>
      FuerzaMagneticaComoVectorSobreCargasEnMovimiento(),
  kWidgetLeyDeAmpereEnFormaDiferencial: (context) =>
      LeyDeAmpereEnFormaDiferencial(),
  kWidgetLeyDeBiotSavart: (context) => LeyDeBiotSavart(),
  kWidgetMotorDeCorrienteDirecta: (context) => MotorDeCorrienteDirecta(),
  kWidgetOrigenDeCampoMagnetico: (context) => OrigenDeCampoMagnetico(),
  kWidgetSegmentoConductoRecto: (context) => SegmentoConductorRecto(),
  kWidgetSolenoide: (context) => Solenoide(),
  //Generales
  kWidgetFuncionesTrigonometricasGeneral: (context) =>
      FuncionesTrigonometricasGenerales(),
  kWidgetIdentidadesHiperbolicasGenerales: (context) =>
      IdentidadesHiperbolicasGenerales(),
  kWidgetIdentidadesTrigonometricasGenerales: (context) =>
      IdentidadesTrigonometricasGenerales(),
  kWidgetPropiedadesLogaritmosGenerales: (context) =>
      PropiedadesLogaritmosGenerales(),
  kWidgetTrigonometricasHiperbolicasGenerales: (context) =>
      TrigonometricasHiperbolicasGenerales(),

  //Geometria
  kWidgetAreaYPerimetroDeCuadrilateros: (context) =>
      AreaYPerimetroDeCuadrilateros(),
  kWidgetAreaYPerimetroDeTriangulos: (context) => AreaYPerimetroDeTriangulos(),
  kWidgetAreaYPerimetroDelCirculo: (context) => AreaYPerimetroDelCirculo(),
  kWidgetAngulosEnUnPoligono: (context) => AngulosEnUnPoligono(),
  kWidgetCircunferencia: (context) => Circunferencia(),
  kWidgetDistanciaDeUnPuntoAUnaRecta: (context) =>
      DistanciaDeUnPuntoAUnaRecta(),
  kWidgetDistanciaEntreDosPuntos: (context) => DistanciaEntreDosPuntos(),
  kWidgetEcuacionDeLaRecta: (context) => EcuacionDeLaRecta(),
  kWidgetElipseConCentroDiferenteDelOrigen: (context) =>
      ElipseConCentroDiferenteDelOrigen(),
  kWidgetElipseConCentroEnElOrigen: (context) => ElipseConCentroEnElOrigen(),
  kWidgetHiperbola: (context) => Hiperbola(),
  kWidgetParabolaConVerticeDiferenteDelOrigen: (context) =>
      ParabolaConVerticeDiferenteDelOrigen(),
  kWidgetParabolaConVerticeEnElOrigen: (context) =>
      ParabolaConVerticeEnElOrigen(),
  kWidgetVolumenDeCuerposGeometricos: (context) =>
      VolumenDeCuerposGeometricos(),
  //Matematicas Discretas
  kWidgetBicondicional: (context) => BicondicionalMatematicasDiscretas(),
  kWidgetCondicional: (context) => CondicionalMatematicasDiscretas(),
  kWidgetConectoresLogicos: (context) => ConectoresLogicos(),
  kWidgetConjuncion: (context) => ConjuncionMatematicasDiscretas(),
  kWidgetDisyuncion: (context) => DisyuncionMatematicasDiscretas(),
  kWidgetLeyesDeLaLogicaProposicional: (context) =>
      LeyesDeLaLogicaProposicional(),
  kWidgetLeyesDeLaTeoriaDeConjuntos: (context) => LeyesDeLaTeoriaDeConjuntos(),
  kWidgetLeyesDelAlgebraDeBoole: (context) => LeyesDelAlgebraDeBoole(),
  kWidgetNegacion: (context) => Negacion(),
  //Matematicas Financiera
  kWidgetAmortizacion: (context) => Amortizacion(),
  kWidgetAnualidadVencidaSimpleyCierta: (context) =>
      AnualidadVencidaSimpleYCierta(),
  kWidgetAnualidadAnticipadaSimpleyCierta: (context) =>
      AnualidadAnticipadaSimpleYCierta(),
  kWidgetDescuentoCompuesto: (context) => DescuentoCompuesto(),
  kWidgetDescuentoSimple: (context) => DescuentoSimple(),
  kWidgetInteresCompuesto: (context) => InteresCompuesto(),
  kWidgetInteresSimple: (context) => InteresSimple(),
  kWidgetSaldoInsoluto: (context) => SaldoInsoluto(),
  kWidgetTasaDeInteresGlobal: (context) => TasaDeInteresGlobal(),
  kWidgetTasaEfectiva: (context) => TasaEfectiva(),
  //Probabilidad y Estadistica
  kWidgetDistribucionBinomial: (context) => DistribucionBinomial(),
  kWidgetDistribucionDePoisson: (context) => DistribucionDePoisson(),
  kWidgetDistribucionExponencial: (context) => DistribucionExponencial(),
  kWidgetDistribucionGeometrica: (context) => DistribucionGeometrica(),
  kWidgetDistribucionHipergeometrica: (context) =>
      DistribucionHipergeometrica(),
  kWidgetDistribucionNormal: (context) => DistribucionNormal(),
  kWidgetDistribucionTDeStudent: (context) => DistribucionTDeStudent(),
  kWidgetMedidasDeDispersionParaDatosNoAgrupados: (context) =>
      MedidasDeDispersionParaDatosNoAgrupados(),
  kWidgetMedidasDePosicionParaDatosNoAgrupados: (context) =>
      MedidasDePosicionParaDatosNoAgrupados(),
  kWidgetMedidasDeTendenciaCentralParaDatosAgrupados: (context) =>
      MedidasDeTendenciaCentralParaDatosAgrupados(),
  kWidgetMedidasDeTendenciaCentralParaDatosNoAgrupados: (context) =>
      MedidasDeTendenciaCentralParaDatosNoAgrupados(),
  kWidgetCombinacionesYPermutaciones: (context) =>
      CombinacionesYPermutaciones(),
  kWidgetCuantilesParaDatosAgrupados: (context) =>
      CuantilesParaDatosAgrupados(),
  kWidgetEstadisticaInferencial: (context) => EstadisticaInferencial(),
  kWidgetIntervalosDeConfianza: (context) => IntervalosDeConfianza(),
  kWidgetMediaGeometrica: (context) => MediaGeometrica(),
  kWidgetMomentosEstadisticos: (context) => MomentosEstadisticos(),
  kWidgetProbabilidad: (context) => Probabilidad(),
  kWidgetTamanioMuestral: (context) => TamanioMuestral(),

  //Series de Fourier
  kWidgetSimetriaDeMediaOnda: (context) => SimetriaDeMediaOnda(),
  kWidgetSimetriaDeUnCuartoDeOndaImpar: (context) =>
      SimetriaDeUnCuartoDeOndaImpar(),
  kWidgetSimetriaDeUnCuartoDeOndaPar: (context) =>
      SimetriaDeUnCuartoDeOndaPar(),
  kWidgetSimetriaImpar: (context) => SimetriaImpar(),
  kWidgetSimetriaPar: (context) => SimetriaPar(),

  kWidgetTransformadaDeFourier: (context) => TransformadaDeFourier(),
  kWidgetTransformadaDeLaplace: (context) => TransformadaDeLaplace(),
  kWidgetTransformadaSenoYCosenoDeFourier: (context) =>
      TransformadaSenoYCosenoDeFourier(),
  kWidgetTransformadasBasicasDeFourier: (context) =>
      TransformadasBasicasDeFourier(),
  kWidgetTransformadasDeFourier: (context) => TransformadasDeFourier(),
  kWidgetTransformadasDeLaplace: (context) => TransformadasDeLaplace(),
  kWidgetConvolucion: (context) => Convolucion(),
  kWidgetFormaComplejaDeLasSeriesDeFourier: (context) =>
      FormaComplejaDeLasSeriesDeFourier(),
  kWidgetFuncionImpulsoUnitario: (context) => FuncionImpulsoUnitario(),
  kWidgetFuncionUnitariaDeHeaviside: (context) => FuncionUnitariaDeHeaviside(),
  kWidgetSerieYCoeficientesDeFourier: (context) =>
      SerieYCoeficientesDeFourier(),
  kWidgetFormulasOperacionalesDeLaTransformadaDeLaplace: (context) =>
      FormulasOperacionalesDeLaTransformadaDeLaplace(),
  //Trigonometria
  kWidgetTeoremaDeLaCotangente: (context) => TeoremaDeLaCotangente(),
  kWidgetTeoremaDelCosenoParaAngulos: (context) =>
      TeoremaDelCosenoParaAngulos(),
  kWidgetTeoremaDelCosenoParaLados: (context) => TeoremaDelCosenoParaLados(),
  kWidgetTeoremaDelSeno: (context) => TeoremaDelSeno(),

  kWidgetIdentidadesTrigonometricasDeAngulosDobleYMedio: (context) =>
      IdentidadesTrigonometricasDeAnguloDobleYMedio(),
  kWidgetIdentidadesTrigonometricasDeSumaAProductoYViceversa: (context) =>
      IdentidadesTrigonometricasDeSumaAProductoYViceversa(),
  kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos: (context) =>
      IdentidadesTrigonometricasDeSumaYRestaDeAngulos(),
  kWidgetIdentidadesTrigonometricasExtras: (context) =>
      IdentidadesTrigonometricasExtras(),
  kWidgetIdentidadesTrigonometricasFundamentales: (context) =>
      IdentidadesTrigonometricasFundamentales(),

  kWidgetAnalogiasDeGaussDelambre: (context) => AnalogiasDeGaussDelambre(),
  kWidgetAnalogiasDeNeper: (context) => AnalogiasDeNeper(),
  kWidgetFuncionesDelAnguloMitad: (context) => FuncionesDelAnguloMitad(),
  kWidgetFuncionesTrigonometricasTrigonometria: (context) =>
      FuncionesTrigonometricas(),
  kWidgetFuncionesTrigonometricasDeAngulosNotables: (context) =>
      FuncionesTrigonometricasDeAngulosNotables(),
  kWidgetLeyDeProyecciones: (context) => LeyDeProyecciones(),
  kWidgetLeyesDeSenosCosenosTangentes: (context) =>
      LeyesDeSenosCosenosTangentes(),
  kWidgetMedicionYClasificacionDeAngulos: (context) =>
      MedicionYClasificacionDeAngulos(),
  kWidgetSuperficieDeUnTrianguloYUnPoligonoEsferico: (context) =>
      SuperficieDeUnTrianguloYUnPoligonoEsferico(),
  kWidgetTeoremaDePitagoras: (context) => TeoremaDePitagoras(),
  kWidgetValoresDeSenoYCoseno: (context) => ValoresDeSenoYCoseno(),
};

Widget widgetMapper(String typeName, BuildContext context) {
  final builder = widgetTable[typeName];
  if (builder == null) {
    throw ArgumentError('Nombre invalido: $typeName');
  }
  return builder(context);
}
