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

import '../secciones_app/constantes_matematicas/export_constantes_matematicas.dart';
import '../secciones_app/conversion_de_unidades/export_conversion_de_unidades.dart';
import '../secciones_app/mecanica/export_mecanica.dart';
import '../secciones_app/numeros_reales_y_desigualdades/export_numeros_reales_y_desigualdades.dart';
import '../secciones_app/optica/export_optica.dart';
import '../secciones_app/termodinamica/export_termodinamica.dart';

final Map<String, WidgetBuilder> widgetTable = {
  //Nuevas formulas 2026-07
  kWidgetCoeficientesBinomiales: (context) => const CoeficientesBinomiales(),
  kWidgetPotenciasNEsimas: (context) => const PotenciasNEsimas(),
  kWidgetEcuacionCubica: (context) => const EcuacionCubica(),
  kWidgetEcuacionCuadraticaFormaMonicaVieta: (context) =>
      const EcuacionCuadraticaFormaMonicaVieta(),
  kWidgetNumerosComplejosFormaExponencialNumeroComplejo: (context) =>
      const NumerosComplejosFormaExponencialNumeroComplejo(),
  kWidgetNumerosComplejosRaicesEIgualdadNumerosComplejos: (context) =>
      const NumerosComplejosRaicesEIgualdadNumerosComplejos(),
  kWidgetPropiedadesLogaritmos: (context) => const PropiedadesLogaritmos(),
  kWidgetDeterminantesCramerSarrus: (context) =>
      const DeterminantesCramerSarrus(),
  kWidgetAlgebraLinealMatricesTiposDeMatrices: (context) =>
      const AlgebraLinealMatricesTiposDeMatrices(),
  kWidgetAlgebraLinealVectoresProductosBaseCanonica: (context) =>
      const AlgebraLinealVectoresProductosBaseCanonica(),
  kWidgetAlgebraLinealVectoresProductoEscalarTriple: (context) =>
      const AlgebraLinealVectoresProductoEscalarTriple(),
  kWidgetAlgebraLinealVectoresSumaVectoresComponentes: (context) =>
      const AlgebraLinealVectoresSumaVectoresComponentes(),
  kWidgetAlgebraLinealVectoresLeySenosCosenos: (context) =>
      const AlgebraLinealVectoresLeySenosCosenos(),
  kWidgetAlgebraLinealVectoresRazonesTrigonometricas: (context) =>
      const AlgebraLinealVectoresRazonesTrigonometricas(),
  kWidgetLimitesTeoremasLimites: (context) => const LimitesTeoremasLimites(),
  kWidgetLimitesLimitesInfinitos: (context) => const LimitesLimitesInfinitos(),
  kWidgetLimitesLimitesImportantes: (context) =>
      const LimitesLimitesImportantes(),
  kWidgetAsintotasHorizontalesOblicuas: (context) =>
      const AsintotasHorizontalesOblicuas(),
  kWidgetContinuidad: (context) => const Continuidad(),
  kWidgetReglaLhopital: (context) => const ReglaLhopital(),
  kWidgetDiferenciales: (context) => const Diferenciales(),
  kWidgetDerivadasAlgebraicasRadicales: (context) =>
      const DerivadasAlgebraicasRadicales(),
  kWidgetReglaCadenaFuncionInversa: (context) =>
      const ReglaCadenaFuncionInversa(),
  kWidgetDerivadasTrigonometricasComplementarias: (context) =>
      const DerivadasTrigonometricasComplementarias(),
  kWidgetDerivadasHiperbolicasInversas: (context) =>
      const DerivadasHiperbolicasInversas(),
  kWidgetDerivacionLogaritmica: (context) => const DerivacionLogaritmica(),
  kWidgetRazonCambioTangenteNormal: (context) =>
      const RazonCambioTangenteNormal(),
  kWidgetAplicacionFisicaDerivada: (context) =>
      const AplicacionFisicaDerivada(),
  kWidgetIntegralesInmediatasAdicionalesIntegral: (context) =>
      const IntegralesInmediatasAdicionalesIntegral(),
  kWidgetPotenciasReduccionTrigonometricasIntegral: (context) =>
      const PotenciasReduccionTrigonometricasIntegral(),
  kWidgetTrigonometricasRacionalesProductosIntegral: (context) =>
      const TrigonometricasRacionalesProductosIntegral(),
  kWidgetPotenciasReduccionHiperbolicasIntegral: (context) =>
      const PotenciasReduccionHiperbolicasIntegral(),
  kWidgetHiperbolicasInversasIntegral: (context) =>
      const HiperbolicasInversasIntegral(),
  kWidgetIntegralDefinidaPropiedadesIntegral: (context) =>
      const IntegralDefinidaPropiedadesIntegral(),
  kWidgetIntegracionNumericaIntegral: (context) =>
      const IntegracionNumericaIntegral(),
  kWidgetSustitucionTrigonometricaIntegral: (context) =>
      const SustitucionTrigonometricaIntegral(),
  kWidgetAreaLongitudArcoIntegral: (context) =>
      const AreaLongitudArcoIntegral(),
  kWidgetFraccionesParcialesIntegral: (context) =>
      const FraccionesParcialesIntegral(),
  kWidgetConstantesMatematicas: (context) => const ConstantesMatematicas(),
  kWidgetConstantesFisicasUniversales: (context) =>
      const ConstantesFisicasUniversales(),
  kWidgetConstantesElectromagneticas: (context) =>
      const ConstantesElectromagneticas(),
  kWidgetConstantesAtomicasMoleculares: (context) =>
      const ConstantesAtomicasMoleculares(),
  kWidgetConstantesTerrestresAstronomicas: (context) =>
      const ConstantesTerrestresAstronomicas(),
  kWidgetLongitudConversion: (context) => const LongitudConversion(),
  kWidgetSuperficieConversion: (context) => const SuperficieConversion(),
  kWidgetVolumenConversion: (context) => const VolumenConversion(),
  kWidgetMasaConversion: (context) => const MasaConversion(),
  kWidgetDensidadConversion: (context) => const DensidadConversion(),
  kWidgetPresionConversion: (context) => const PresionConversion(),
  kWidgetEnergiaConversion: (context) => const EnergiaConversion(),
  kWidgetPotenciaConversion: (context) => const PotenciaConversion(),
  kWidgetPotenciaYReactanciasEnCa: (context) =>
      const PotenciaYReactanciasEnCa(),
  kWidgetCaValoresEficacesTransformador: (context) =>
      const CaValoresEficacesTransformador(),
  kWidgetInstrumentosDeMedicionElectrica: (context) =>
      const InstrumentosDeMedicionElectrica(),
  kWidgetCircuitoLrEnSerie: (context) => const CircuitoLrEnSerie(),
  kWidgetFuerzaYTorcaMagnetica: (context) => const FuerzaYTorcaMagnetica(),
  kWidgetCapacitoresCilindricoYEsferico: (context) =>
      const CapacitoresCilindricoYEsferico(),
  kWidgetPermeabilidadMagneticaEnMateriales: (context) =>
      const PermeabilidadMagneticaEnMateriales(),
  kWidgetBateriaRealVoltajeEnTerminales: (context) =>
      const BateriaRealVoltajeEnTerminales(),
  kWidgetLaRectaYElTriangulo: (context) => const LaRectaYElTriangulo(),
  kWidgetTangentesYPropiedadesDeLasConicas: (context) =>
      const TangentesYPropiedadesDeLasConicas(),
  kWidgetHiperbolaEquilatera: (context) => const HiperbolaEquilatera(),
  kWidgetLaCurvaExponencial: (context) => const LaCurvaExponencial(),
  kWidgetAceleracionYMrua: (context) => const AceleracionYMrua(),
  kWidgetCaidaLibreYTiroVertical: (context) => const CaidaLibreYTiroVertical(),
  kWidgetMovimientoDeProyectiles: (context) => const MovimientoDeProyectiles(),
  kWidgetMovimientoCircularUniforme: (context) =>
      const MovimientoCircularUniforme(),
  kWidgetCinematicaAngular: (context) => const CinematicaAngular(),
  kWidgetAceleracionYFuerzaCentripeta: (context) =>
      const AceleracionYFuerzaCentripeta(),
  kWidgetLeyesDeNewton: (context) => const LeyesDeNewton(),
  kWidgetPesoYGravedad: (context) => const PesoYGravedad(),
  kWidgetCantidadDeMovimientoEImpulso: (context) =>
      const CantidadDeMovimientoEImpulso(),
  kWidgetFriccion: (context) => const Friccion(),
  kWidgetMovimientoArmonicoSimple: (context) =>
      const MovimientoArmonicoSimple(),
  kWidgetPenduloSimple: (context) => const PenduloSimple(),
  kWidgetEquilibrioDeCuerposRigidos: (context) =>
      const EquilibrioDeCuerposRigidos(),
  kWidgetMomentoDeTorsion: (context) => const MomentoDeTorsion(),
  kWidgetEficiencia: (context) => const Eficiencia(),
  kWidgetHidrostatica: (context) => const Hidrostatica(),
  kWidgetHidrodinamica: (context) => const Hidrodinamica(),
  kWidgetAxiomasDeCampoNumerosReales: (context) =>
      const AxiomasDeCampoNumerosReales(),
  kWidgetAxiomasDeOrdenYTeoremasReales: (context) =>
      const AxiomasDeOrdenYTeoremasReales(),
  kWidgetDesigualdadesTeoremasDeOrden: (context) =>
      const DesigualdadesTeoremasDeOrden(),
  kWidgetConjuntosEIntervalos: (context) => const ConjuntosEIntervalos(),
  kWidgetValorAbsoluto: (context) => const ValorAbsoluto(),
  kWidgetLeyDeLaIluminacion: (context) => const LeyDeLaIluminacion(),
  kWidgetReflexionYAumentoFormaNewtoniana: (context) =>
      const ReflexionYAumentoFormaNewtoniana(),
  kWidgetEcuacionDeLasLentesFormaGaussiana: (context) =>
      const EcuacionDeLasLentesFormaGaussiana(),
  kWidgetRefraccionDeLaLuzLeyDeSnell: (context) =>
      const RefraccionDeLaLuzLeyDeSnell(),
  kWidgetTiposDeLentesYMarchaDeRayos: (context) =>
      const TiposDeLentesYMarchaDeRayos(),
  kWidgetAxiomasDeProbabilidad: (context) => const AxiomasDeProbabilidad(),
  kWidgetFuncionesDeMasaDensidadYAcumulada: (context) =>
      const FuncionesDeMasaDensidadYAcumulada(),
  kWidgetFuncionesDeProbabilidadConjuntasYCondicionales: (context) =>
      const FuncionesDeProbabilidadConjuntasYCondicionales(),
  kWidgetEsperanzaMediaYVarianza: (context) => const EsperanzaMediaYVarianza(),
  kWidgetDistribucionesDistribucionDeBernoulli: (context) =>
      const DistribucionesDistribucionDeBernoulli(),
  kWidgetDistribucionesDistribucionDePascal: (context) =>
      const DistribucionesDistribucionDePascal(),
  kWidgetDistribucionesDistribucionBeta: (context) =>
      const DistribucionesDistribucionBeta(),
  kWidgetDistribucionesDistribucionDeCauchy: (context) =>
      const DistribucionesDistribucionDeCauchy(),
  kWidgetDistribucionesDistribucionDeErlang: (context) =>
      const DistribucionesDistribucionDeErlang(),
  kWidgetDistribucionesDistribucionUniforme: (context) =>
      const DistribucionesDistribucionUniforme(),
  kWidgetRegresionLineal: (context) => const RegresionLineal(),
  kWidgetDesigualdadDeChebyshevYConvergencia: (context) =>
      const DesigualdadDeChebyshevYConvergencia(),
  kWidgetTransferenciaDeCalor: (context) => const TransferenciaDeCalor(),
  kWidgetCapacidadCalorificaYCalorLatente: (context) =>
      const CapacidadCalorificaYCalorLatente(),
  kWidgetLeyesDeLosGases: (context) => const LeyesDeLosGases(),
  kWidgetCicloDeCarnotYLeyesDeLaTermodinamica: (context) =>
      const CicloDeCarnotYLeyesDeLaTermodinamica(),
  kWidgetTrabajoTermodinamico: (context) => const TrabajoTermodinamico(),
  kWidgetEntalpiaYEnergiaInterna: (context) => const EntalpiaYEnergiaInterna(),
  kWidgetDilatacionLineal: (context) => const DilatacionLineal(),
  kWidgetDilatacionSuperficialYVolumetrica: (context) =>
      const DilatacionSuperficialYVolumetrica(),
  kWidgetEntropiaYTeoriaCinetica: (context) => const EntropiaYTeoriaCinetica(),
  kWidgetProcesosTermodinamicos: (context) => const ProcesosTermodinamicos(),
  kWidgetCirculoUnitario: (context) => const CirculoUnitario(),
  kWidgetSignosDeFuncionesPorCuadrante: (context) =>
      const SignosDeFuncionesPorCuadrante(),
  kWidgetAngulosNotablesGradosRadianes: (context) =>
      const AngulosNotablesGradosRadianes(),
  kWidgetRelacionEntreFuncionesTrigonometricas: (context) =>
      const RelacionEntreFuncionesTrigonometricas(),
  kWidgetIdentidadesDeAnguloTripleYCuadruple: (context) =>
      const IdentidadesDeAnguloTripleYCuadruple(),
  kWidgetIdentidadesDeReduccionDePotencias: (context) =>
      const IdentidadesDeReduccionDePotencias(),
  kWidgetIdentidadesFundamentalesFormasDerivadas: (context) =>
      const IdentidadesFundamentalesFormasDerivadas(),
  kWidgetCotangenteDeSumaYRestaDeAngulos: (context) =>
      const CotangenteDeSumaYRestaDeAngulos(),
  kWidgetProductoDeCosenoPorSeno: (context) => const ProductoDeCosenoPorSeno(),
  //Algebra
  kWidgetFormulaGeneral: (context) => const FormulaGeneral(),
  kWidgetEcuacionesDePrimerGrado: (context) => const EcuacionesDePrimerGrado(),
  kWidgetEcuacionesDeSegundoGrado: (context) =>
      const EcuacionesDeSegundoGrado(),
  kWidgetPropiedadesDeLosExponentesEjercicios: (context) =>
      const PropiedadesDeLosExponentesEjercicios(),
  kWidgetConjugadoDeUnNumeroComplejo: (context) =>
      const ConjugadoNumerosComplejos(),
  kWidgetModuloYArgumentoDeUnNumeroComplejo: (context) =>
      const ModuloyArgumentoNumerosComplejos(),
  kWidgetOperacionesDeNumerosComplejos: (context) =>
      const OperacionesNumerosComplejos(),
  kWidgetPropiedadesNumerosComplejos: (context) =>
      const PropiedadesNumerosComplejos(),
  kWidgetRepresentacionesDeUnNumeroComplejo: (context) =>
      const RepresentacionesDeNumerosComplejos(),
  kWidgetEcuacionesLineales: (context) => const EcuacionesLineales(),
  kWidgetFormulasDeProductos: (context) => const FormulasDeProductos(),
  kWidgetFormulasDeFactorizacion: (context) => const FormulasDeFactorizacion(),
  kWidgetOperacionesConFraccionesAlgebraicas: (context) =>
      const OperacionesFraccionesAlgebraicas(),
  kWidgetOperacionesPolinomios: (context) => const OperacionesConPolinomios(),
  kWidgetPropiedadesDeLosExponentes: (context) =>
      const PropiedadesDeLosExponentes(),
  kWidgetPropiedadesDesigualdad: (context) => const PropiedadesDesigualdad(),
  kWidgetPropiedadesRadicales: (context) => const PropiedadesRadicales(),
  kWidgetSerieDeTaylorYMaClaurin: (context) => const SerieTaylorMaClaurin(),
  kWidgetTeoremaDeSumatorias: (context) => const TeoremaSumatorias(),
  //Algebra Lineal
  kWidgetMatrizAdjunta: (context) => const MatrizAdjunta(),
  kWidgetMatrizidentidad: (context) => const MatrizIdentidad(),
  kWidgetMatrizInversa: (context) => const MatrizInversa(),
  kWidgetMatrizOrtogonal: (context) => const MatrizOrtogonal(),
  kWidgetMatrizSimetrica: (context) => const MatrizSimetrica(),
  kWidgetMatrizTranspuesta: (context) => const MatrizTranspuesta(),
  kWidgetMatrizTriangular: (context) => const MatrizTriangular(),
  kWidgetMultiplicacionDeMatrices: (context) =>
      const MultiplicacionDeMatrices(),
  kWidgetPropiedadesDeLasMatrices: (context) =>
      const PropiedadesDeLasMatrices(),
  kWidgetSumaRestaDeMatrices: (context) => const SumaRestaDeMatrices(),
  kWidgetAnguloEntreVectores: (context) => const AnguloEntreVectores(),
  kWidgetNormalizacion: (context) => const Normalizacion(),
  kWidgetOperacionesConVectores: (context) => const OperacionesConVectores(),
  kWidgetProductoCruz: (context) => const ProductoCruz(),
  kWidgetProductoPunto: (context) => const ProductoPunto(),
  kWidgetPropiedadesDeLosVectores: (context) =>
      const PropiedadesDeLosVectores(),
  kWidgetProyeccionesDeVectores: (context) => const ProyeccionesDeVectores(),
  kWidgetVectorUnitario: (context) => const VectorUnitario(),
  kWidgetVectoresYSuMagnitud: (context) => const VectoresYSuMagnitud(),
  kWidgetDeterminantesAlgebraLineal: (context) =>
      const DeterminantesAlgebraLineal(),
  kWidgetPuntoMedioEntreDosPuntos: (context) =>
      const PuntoMedioEntreDosPuntos(),
  kWidgetReglaDeCramer: (context) => const ReglaDeCramer(),
  kWidgetReglaDeSarrus: (context) => const ReglaDeSarrus(),
  //Calculo Diferencial
  kWidgetLimitesTrigonometricos: (context) => const LimitesTrigonometricos(),
  kWidgetPropiedadesLimites: (context) => const PropiedadesLimites(),
  kWidgetDerivacionBasicaDiferencial: (context) =>
      const DerivacionBasicaDiferencial(),
  kWidgetExponencialLogaritmos: (context) =>
      const ExponencialyLogaritmosDiferencial(),
  kWidgetFuncionesTrigonometricasDiferencial: (context) =>
      const FuncionesTrigonometricasDiferencial(),
  kWidgetFuncionesTrigonometricasInversasDiferencial: (context) =>
      const TrigonometricasInversasDiferencial(),
  kWidgetFuncionesHiperbolicas: (context) =>
      const TrigonometricasHiperbolicasDiferencial(),
  //Calculo Integral
  kWidgetExponencialLogaritmoIntegral: (context) =>
      const ExponencialyLogaritmoIntegral(),
  kWidgetFuncionesHiperbolicasIntegral: (context) =>
      const FuncionesHiperbolicasIntegral(),
  kWidgetFuncionesTrigonometricasIntegral: (context) =>
      const FuncionesTrigonometricasIntegral(),
  kWidgetIntegracionBasica: (context) => const IntegracionBasicaIntegral(),
  kWidgetIntegralesExtrasIntegral: (context) => const IntegralesExtraIntegral(),
  kWidgetTrigonometricasInversasIntegral: (context) =>
      const TrigonometricasInversasIntegral(),

  //Calculo Multivariable
  kWidgetDerivadaFuncionesVectoriales: (context) =>
      const DerivadaFuncionesVectoriales(),
  kWidgetLimiteDerivadaIntegralFuncionesVectoriales: (context) =>
      const LimiteDerivadaIntegralFuncionesVectoriales(),
  kWidgetAreaBajoLaCurva: (context) => const AreaBajoLaCurva(),
  kWidgetAreaDeUnaSuperficieDeRevolucion: (context) =>
      const AreaDeUnaSuperficieDeRevolucion(),
  kWidgetCambioDeVariables: (context) => const CambioDeVariables(),
  kWidgetDerivadasDireccionales: (context) => const DerivadasDireccionales(),
  kWidgetDerivadasParciales: (context) => const DerivadasParciales(),
  kWidgetDiferencialTotal: (context) => const DiferencialTotal(),
  kWidgetGradienteDeUnaFuncion: (context) => const GradienteDeUnaFuncion(),
  kWidgetIdentidadesVectoriales: (context) => const IdentidadesVectoriales(),
  kWidgetIntegralEnCoordenasCilindricas: (context) =>
      const IntegralEnCoordenadasCilindricas(),
  kWidgetIntegralesDeLinea: (context) => const IntegralesDeLinea(),
  kWidgetLongitudDeArco: (context) => const LongitudDeArco(),
  kWidgetOperadoresDiferenciales: (context) => const OperadoresDiferenciales(),
  kWidgetTeoremaDeFubini: (context) => const TeoremaDeFubini(),
  kWidgetTeoremaIntegrales: (context) => const TeoremaIntegrales(),

  //Ecuaciones Diferenciales
  kWidgetConstantesDeIntegracion: (context) => const ConstantesDeIntegracion(),
  kWidgetEcuacionDiferencialConCoeficientesConstantes: (context) =>
      const EcuacionDiferencialConCoeficientesConstantes(),
  kWidgetEcuacionDiferencialDeRectasNoParalelas: (context) =>
      const EcuacionDiferencialDeRectasNoParalelas(),
  kWidgetEcuacionDiferencialDeRectasParalelas: (context) =>
      const EcuacionDiferencialDeRectasParalelas(),
  kWidgetEcuacionDiferencialExacta: (context) =>
      const EcuacionDiferencialExacta(),
  kWidgetEcuacionDiferencialHomogenea: (context) =>
      const EcuacionDiferencialHomogenea(),
  kWidgetEcuacionDiferencialLinealDeOrdenSuperior: (context) =>
      const EcuacionDiferencialLinealDeOrdenSuperior(),
  kWidgetEcuacionDiferencialLinealDePrimerOrden: (context) =>
      const EcuacionDiferencialLinealDePrimerOrden(),
  kWidgetEcuacionDiferencialSeparable: (context) =>
      const EcuacionDiferencialSeparable(),
  //Electricidad y Magnetismo
  //Campo y potencial electricos
  kWidgetCalculoDeDiferenciasDePotencial: (context) =>
      const CalculoDeDiferenciasDePotencial(),
  kWidgetCampoElectrico: (context) => const CampoElectrico(),
  kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga: (context) =>
      const CampoElectricoOriginadoPorDistribucionesDeCarga(),
  kWidgetCargaElectrica: (context) => const CargaElectrica(),
  kWidgetCargaProtonyElectron: (context) => const CargaProtonElectron(),
  kWidgetCirculacionDelCampoElectrostatico: (context) =>
      const CirculacionDelCampoElectrostatico(),
  kWidgetDistribucionesDeCargaElectrica: (context) =>
      const DistribucionesDeCargaElectrica(),
  kWidgetEcuacionDePossionYLaplace: (context) =>
      const EcuacionDePoissonYLaplace(),
  kWidgetElectricidad: (context) => const Electricidad(),
  kWidgetEnergiaPotencialElectrica: (context) =>
      const EnergiaPotencialElectrica(),
  kWidgetFlujoElectricoDeUnCampoVectorial: (context) =>
      const FlujoDeUnCampoVectorial(),
  kWidgetGradienteDePotencialElectrico: (context) =>
      const GradienteDePotencialElectrico(),
  kWidgetGradienteDeUnaFuncionEscalar: (context) =>
      const GradienteDeUnaFuncionEscalar(),
  kWidgetLeyDeCoulomb: (context) => const LeyDeCoulomb(),
  kWidgetLeyDeGauss: (context) => const LeyDeGauss(),
  kWidgetLeyDeGaussEnFormaDiferencial: (context) =>
      const LeyDeGaussEnFormaDiferencial(),
  kWidgetOperadorGradiente: (context) => const OperadorGradiente(),
  kWidgetPrincipioDeSuperposicion: (context) =>
      const PrincipioDeSuperposicion(),
  kWidgetRotacionalDelCampoElectrostatico: (context) =>
      const RotacionalDelCampoElectrostatico(),
  kWidgetSuperficiesEquipotenciales: (context) =>
      const SuperficiesEquipotenciales(),
  kWidgetTeoremaDeLaDivergencia: (context) => const TeoremaDeLaDivergencia(),
  kWidgetTeoremaDelRotacional: (context) => const TeoremaDelRotacional(),

  //Capacitancia y Dielectricos
  kWidgetCapacitor: (context) => const Capacitor(),
  kWidgetCapacitorDePlacasPlanasYParalelas: (context) =>
      const CapacitorDePlacasPlanasYParalelas(),
  kWidgetCargaDeUnCapacitor: (context) => const CargaDeUnCapacitor(),
  kWidgetGraficaDeCapacitancia: (context) => const GraficaDeCapacitancia(),
  kWidgetConexionEnParaleloCapacitor: (context) =>
      const ConexionEnParaleloCapacitor(),
  kWidgetConexionEnSerieCapacitor: (context) =>
      const ConexionEnSerieCapacitor(),
  kWidgetConstantesDielectricas: (context) => const ConstantesDielectricas(),
  kWidgetDefinicionDeCapacitancia: (context) =>
      const DefinicionDeCapacitancia(),
  kWidgetEnergiaAlmacenadaPorUnCapacitor: (context) =>
      const EnergiaAlmacenadaPorUnCapacitor(),
  kWidgetEnergiaYCapacitancia: (context) => const EnergiaYCapacitancia(),
  kWidgetPolarizacion: (context) => const Polarizacion(),
  kWidgetPolarizacionYCargaInducida: (context) =>
      const PolarizacionYCargaInducida(),
  kWidgetRepresentacionDeLosVectoresElectricos: (context) =>
      const RepresentacionDeLosVectoresElectricos(),
  kWidgetRigidezDielectrica: (context) => const RigidezDielectrica(),
  kWidgetSimbologiaCapacitores: (context) => const SimbologiaCapacitores(),
  kWidgetVectorDeDesplazamientoElectrico: (context) =>
      const VectorDeDesplazamientoElectrico(),
  //Circuitos Electricos
  kWidgetCircuitoRCyVoltajeContinuo: (context) =>
      const CircuitoRCyVoltajeContinuo(),
  kWidgetConductividadyResistividad: (context) =>
      const ConductividadYResistividad(),
  kWidgetConexionEnParaleloResistor: (context) =>
      const ConexionEnParaleloResistor(),
  kWidgetConexionEnSerieResistor: (context) => const ConexionEnSerieResistor(),
  kWidgetDensidadDeCorrienteYCorrienteElectrica: (context) =>
      const DensidadDeCorrienteYCorrienteElectrica(),
  kWidgetEcuacionDeOhm: (context) => const EcuacionDeOhm(),
  kWidgetEfectoJoule: (context) => const EfectoJoule(),
  kWidgetElementosCapacitorYResistor: (context) =>
      const ElementosCapacitorYResistor(),
  kWidgetElementosFem: (context) => const ElementosFem(),
  kWidgetFuenteDeFuerzaElectromotriz: (context) =>
      const FuenteDeFuerzaElectromotrizFem(),
  kWidgetLeyDeCorrienteDeKirchhoff: (context) =>
      const LeyDeCorrientesDeKirchhoff(),
  kWidgetLeyDeOhm: (context) => const LeyDeOhm(),
  kWidgetLeyDeVoltajesDeKirchhoff: (context) =>
      const LeyDeVoltajesDeKirchhoff(),
  kWidgetLeyesDeKirchhoffCircuitoRc: (context) =>
      const LeyesDeKirchhoffCircuitoRC(),
  kWidgetMovimientoDePortadoresDeCargaLibreYDensidadDeCorriente: (context) =>
      const MovimientoDePortadoresDeCargaLibreYDensidadDeCorriente(),
  kWidgetNomenclaturaBasicaEmpleadaEnCircuitos: (context) =>
      const NomenclaturaBasicaEmpleadaEnCircuitos(),
  kWidgetPortadoresDeCargaLibre: (context) => const PortadoresDeCargaLibre(),
  kWidgetReglasParaLVKyLCK: (context) => const ReglasParaLVKyLCK(),
  kWidgetResistividadYTemperatura: (context) =>
      const ResistividadYTemperatura(),
  kWidgetResistorLinealYNoLineal: (context) => const ResistorLinealYNoLineal(),
  kWidgetResistorSimbologiaBasica: (context) =>
      const ResistorSimbologiaBasica(),
  kWidgetTeoriaDeCircuitos: (context) => const TeoriaDeCircuitos(),
  kWidgetTiposDeCorrienteElectrica: (context) =>
      const TiposDeCorrienteElectrica(),

  //Induccion Electromagnetica
  kWidgetEnergiaAlmacenadaEnUnCampoMagnetico: (context) =>
      const EnergiaAlmacenadaEnUnCampoMagnetico(),
  kWidgetInductanciaMutua: (context) => const InductanciaMutua(),
  kWidgetInductanciaMutuaEntreDosSolenoidesCoaxiales: (context) =>
      const InductanciaMutuaEntreDosSolenoidesCoaxiales(),
  kWidgetInductanciaParaUnToroide: (context) =>
      const InductanciaParaUnToroide(),
  kWidgetInductanciaPropia: (context) => const InductanciaPropia(),
  kWidgetInductanciaPropiaDeUnSolenoide: (context) =>
      const InductanciaPropiaDeUnSolenoide(),
  kWidgetInductor: (context) => const Inductor(),
  kWidgetInductoresEnSerie: (context) => const InductoresEnSerie(),
  kWidgetLeyDeFaradayYEnergiaEnUnInductor: (context) =>
      const LeyDeInduccionDeFaradayEnergiaEnUnInductor(),
  kWidgetPrincipioDeOperacionDelGeneradorElectrico: (context) =>
      const GeneradorHomopolar(),
  //Magnetostatica
  kWidgetBobina: (context) => const Bobina(),
  kWidgetCampoMagneticoAPartirDeLeyDeAmpere: (context) =>
      const CampoMagneticoAPartirDeLeyDeAmpere(),
  kWidgetCirculacionDeUnCampoVectorial: (context) =>
      const CirculacionDeUnCampoVectorial(),
  kWidgetDefinicionDeCampoMagnetico: (context) =>
      const DefinicionDeCampoMagnetico(),
  kWidgetEspiraCuadrada: (context) => const EspiraCuadrada(),
  kWidgetEspiraEnFormaDeCircunferencia: (context) =>
      const EspiraEnFormaDeCircunferencia(),
  kWidgetFlujoMagnetico: (context) => const FlujoMagnetico(),
  kWidgetFuerzaDeLorentz: (context) => const FuerzaDeLorentz(),
  kWidgetFuerzaMagneticaComoVectorSobreCargasEnMovimiento: (context) =>
      const FuerzaMagneticaComoVectorSobreCargasEnMovimiento(),
  kWidgetLeyDeAmpereEnFormaDiferencial: (context) =>
      const LeyDeAmpereEnFormaDiferencial(),
  kWidgetLeyDeBiotSavart: (context) => const LeyDeBiotSavart(),
  kWidgetMotorDeCorrienteDirecta: (context) => const MotorDeCorrienteDirecta(),
  kWidgetOrigenDeCampoMagnetico: (context) => const OrigenDeCampoMagnetico(),
  kWidgetSegmentoConductoRecto: (context) => const SegmentoConductorRecto(),
  kWidgetSolenoide: (context) => const Solenoide(),
  //Generales
  kWidgetFuncionesTrigonometricasGeneral: (context) =>
      const FuncionesTrigonometricasGenerales(),
  kWidgetIdentidadesHiperbolicasGenerales: (context) =>
      const IdentidadesHiperbolicasGenerales(),
  kWidgetIdentidadesTrigonometricasGenerales: (context) =>
      const IdentidadesTrigonometricasGenerales(),
  kWidgetPropiedadesLogaritmosGenerales: (context) =>
      const PropiedadesLogaritmosGenerales(),
  kWidgetTrigonometricasHiperbolicasGenerales: (context) =>
      const TrigonometricasHiperbolicasGenerales(),

  //Geometria
  kWidgetAreaYPerimetroDeCuadrilateros: (context) =>
      const AreaYPerimetroDeCuadrilateros(),
  kWidgetAreaYPerimetroDeTriangulos: (context) =>
      const AreaYPerimetroDeTriangulos(),
  kWidgetAreaYPerimetroDelCirculo: (context) =>
      const AreaYPerimetroDelCirculo(),
  kWidgetAngulosEnUnPoligono: (context) => const AngulosEnUnPoligono(),
  kWidgetCircunferencia: (context) => const Circunferencia(),
  kWidgetDistanciaDeUnPuntoAUnaRecta: (context) =>
      const DistanciaDeUnPuntoAUnaRecta(),
  kWidgetDistanciaEntreDosPuntos: (context) => const DistanciaEntreDosPuntos(),
  kWidgetEcuacionDeLaRecta: (context) => const EcuacionDeLaRecta(),
  kWidgetElipseConCentroDiferenteDelOrigen: (context) =>
      const ElipseConCentroDiferenteDelOrigen(),
  kWidgetElipseConCentroEnElOrigen: (context) =>
      const ElipseConCentroEnElOrigen(),
  kWidgetHiperbola: (context) => const Hiperbola(),
  kWidgetParabolaConVerticeDiferenteDelOrigen: (context) =>
      const ParabolaConVerticeDiferenteDelOrigen(),
  kWidgetParabolaConVerticeEnElOrigen: (context) =>
      const ParabolaConVerticeEnElOrigen(),
  kWidgetPuntoMedioEntreDosPuntosGeometria: (context) =>
      const PuntoMedioEntreDosPuntos(),
  kWidgetVolumenDeCuerposGeometricos: (context) =>
      const VolumenDeCuerposGeometricos(),
  //Matematicas Discretas
  kWidgetBicondicional: (context) => const BicondicionalMatematicasDiscretas(),
  kWidgetCondicional: (context) => const CondicionalMatematicasDiscretas(),
  kWidgetConectoresLogicos: (context) => const ConectoresLogicos(),
  kWidgetConjuncion: (context) => const ConjuncionMatematicasDiscretas(),
  kWidgetDisyuncion: (context) => const DisyuncionMatematicasDiscretas(),
  kWidgetLeyesDeLaLogicaProposicional: (context) =>
      const LeyesDeLaLogicaProposicional(),
  kWidgetLeyesDeLaTeoriaDeConjuntos: (context) =>
      const LeyesDeLaTeoriaDeConjuntos(),
  kWidgetLeyesDelAlgebraDeBoole: (context) => const LeyesDelAlgebraDeBoole(),
  kWidgetNegacion: (context) => const Negacion(),
  //Matematicas Financiera
  kWidgetAmortizacion: (context) => const Amortizacion(),
  kWidgetAnualidadVencidaSimpleyCierta: (context) =>
      const AnualidadVencidaSimpleYCierta(),
  kWidgetAnualidadAnticipadaSimpleyCierta: (context) =>
      const AnualidadAnticipadaSimpleYCierta(),
  kWidgetDescuentoCompuesto: (context) => const DescuentoCompuesto(),
  kWidgetDescuentoSimple: (context) => const DescuentoSimple(),
  kWidgetInteresCompuesto: (context) => const InteresCompuesto(),
  kWidgetInteresSimple: (context) => const InteresSimple(),
  kWidgetSaldoInsoluto: (context) => const SaldoInsoluto(),
  kWidgetTasaDeInteresGlobal: (context) => const TasaDeInteresGlobal(),
  kWidgetTasaEfectiva: (context) => const TasaEfectiva(),
  //Probabilidad y Estadistica
  kWidgetDistribucionBinomial: (context) => const DistribucionBinomial(),
  kWidgetDistribucionDePoisson: (context) => const DistribucionDePoisson(),
  kWidgetDistribucionExponencial: (context) => const DistribucionExponencial(),
  kWidgetDistribucionGeometrica: (context) => const DistribucionGeometrica(),
  kWidgetDistribucionHipergeometrica: (context) =>
      const DistribucionHipergeometrica(),
  kWidgetDistribucionNormal: (context) => const DistribucionNormal(),
  kWidgetDistribucionTDeStudent: (context) => const DistribucionTDeStudent(),
  kWidgetMedidasDeDispersionParaDatosNoAgrupados: (context) =>
      const MedidasDeDispersionParaDatosNoAgrupados(),
  kWidgetMedidasDePosicionParaDatosNoAgrupados: (context) =>
      const MedidasDePosicionParaDatosNoAgrupados(),
  kWidgetMedidasDeTendenciaCentralParaDatosAgrupados: (context) =>
      const MedidasDeTendenciaCentralParaDatosAgrupados(),
  kWidgetMedidasDeTendenciaCentralParaDatosNoAgrupados: (context) =>
      const MedidasDeTendenciaCentralParaDatosNoAgrupados(),
  kWidgetCombinacionesYPermutaciones: (context) =>
      const CombinacionesYPermutaciones(),
  kWidgetCuantilesParaDatosAgrupados: (context) =>
      const CuantilesParaDatosAgrupados(),
  kWidgetEstadisticaInferencial: (context) => const EstadisticaInferencial(),
  kWidgetIntervalosDeConfianza: (context) => const IntervalosDeConfianza(),
  kWidgetMediaGeometrica: (context) => const MediaGeometrica(),
  kWidgetMomentosEstadisticos: (context) => const MomentosEstadisticos(),
  kWidgetProbabilidad: (context) => const Probabilidad(),
  kWidgetTamanioMuestral: (context) => const TamanioMuestral(),

  //Series de Fourier
  kWidgetSimetriaDeMediaOnda: (context) => const SimetriaDeMediaOnda(),
  kWidgetSimetriaDeUnCuartoDeOndaImpar: (context) =>
      const SimetriaDeUnCuartoDeOndaImpar(),
  kWidgetSimetriaDeUnCuartoDeOndaPar: (context) =>
      const SimetriaDeUnCuartoDeOndaPar(),
  kWidgetSimetriaImpar: (context) => const SimetriaImpar(),
  kWidgetSimetriaPar: (context) => const SimetriaPar(),

  kWidgetTransformadaDeFourier: (context) => const TransformadaDeFourier(),
  kWidgetTransformadaDeLaplace: (context) => const TransformadaDeLaplace(),
  kWidgetTransformadaSenoYCosenoDeFourier: (context) =>
      const TransformadaSenoYCosenoDeFourier(),
  kWidgetTransformadasBasicasDeFourier: (context) =>
      const TransformadasBasicasDeFourier(),
  kWidgetTransformadasDeFourier: (context) => const TransformadasDeFourier(),
  kWidgetTransformadasDeLaplace: (context) => const TransformadasDeLaplace(),
  kWidgetConvolucion: (context) => const Convolucion(),
  kWidgetFormaComplejaDeLasSeriesDeFourier: (context) =>
      const FormaComplejaDeLasSeriesDeFourier(),
  kWidgetFuncionImpulsoUnitario: (context) => const FuncionImpulsoUnitario(),
  kWidgetFuncionUnitariaDeHeaviside: (context) =>
      const FuncionUnitariaDeHeaviside(),
  kWidgetSerieYCoeficientesDeFourier: (context) =>
      const SerieYCoeficientesDeFourier(),
  kWidgetFormulasOperacionalesDeLaTransformadaDeLaplace: (context) =>
      const FormulasOperacionalesDeLaTransformadaDeLaplace(),
  //Trigonometria
  kWidgetTeoremaDeLaCotangente: (context) => const TeoremaDeLaCotangente(),
  kWidgetTeoremaDelCosenoParaAngulos: (context) =>
      const TeoremaDelCosenoParaAngulos(),
  kWidgetTeoremaDelCosenoParaLados: (context) =>
      const TeoremaDelCosenoParaLados(),
  kWidgetTeoremaDelSeno: (context) => const TeoremaDelSeno(),

  kWidgetIdentidadesTrigonometricasDeAngulosDobleYMedio: (context) =>
      const IdentidadesTrigonometricasDeAnguloDobleYMedio(),
  kWidgetIdentidadesTrigonometricasDeSumaAProductoYViceversa: (context) =>
      const IdentidadesTrigonometricasDeSumaAProductoYViceversa(),
  kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos: (context) =>
      const IdentidadesTrigonometricasDeSumaYRestaDeAngulos(),
  kWidgetIdentidadesTrigonometricasExtras: (context) =>
      const IdentidadesTrigonometricasExtras(),
  kWidgetIdentidadesTrigonometricasFundamentales: (context) =>
      const IdentidadesTrigonometricasFundamentales(),

  kWidgetAnalogiasDeGaussDelambre: (context) =>
      const AnalogiasDeGaussDelambre(),
  kWidgetAnalogiasDeNeper: (context) => const AnalogiasDeNeper(),
  kWidgetFuncionesDelAnguloMitad: (context) => const FuncionesDelAnguloMitad(),
  kWidgetFuncionesTrigonometricasTrigonometria: (context) =>
      const FuncionesTrigonometricas(),
  kWidgetFuncionesTrigonometricasDeAngulosNotables: (context) =>
      const FuncionesTrigonometricasDeAngulosNotables(),
  kWidgetLeyDeProyecciones: (context) => const LeyDeProyecciones(),
  kWidgetLeyesDeSenosCosenosTangentes: (context) =>
      const LeyesDeSenosCosenosTangentes(),
  kWidgetMedicionYClasificacionDeAngulos: (context) =>
      const MedicionYClasificacionDeAngulos(),
  kWidgetSuperficieDeUnTrianguloYUnPoligonoEsferico: (context) =>
      const SuperficieDeUnTrianguloYUnPoligonoEsferico(),
  kWidgetTeoremaDePitagoras: (context) => const TeoremaDePitagoras(),
  kWidgetValoresDeSenoYCoseno: (context) => const ValoresDeSenoYCoseno(),
};

Widget widgetMapper(String typeName, BuildContext context) {
  final builder = widgetTable[typeName];
  if (builder == null) {
    throw ArgumentError('Nombre invalido: $typeName');
  }
  return builder(context);
}
