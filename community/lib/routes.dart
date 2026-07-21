import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../chat_gpt/export_chat_gpt.dart';
import '../menus/export_menus.dart';
import '../screens_personalizados/configuracion.dart';
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
import '../widgets_personalizados/export_widgets_personalizados.dart';
import 'Favorites/favorites_screen.dart';
import 'menu.dart';

//Trigonometria
Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
  kRutaMenu: (context) => const Menu(),
  kRutaChatGPT: (context) => const ChatScreen(),
  kRutaFavorites: (context) => const FavoritesScreen(),
  kRutaPreguntasFrecuentes: (context) => const PreguntasFrecuentes(),
  kRutaCalculoIntegral: (context) => const CalculoIntegral(),
  kRutaCalculoDiferencial: (context) => const CalculoDiferencial(),
  kRutaGenerales: (context) => const Generales(),

  //Algebra
  kRutaMenuAlgebra: (context) => const MenuAlgebra(),
  kRutaPropiedadesDeLosExponentes: (context) =>
      const PropiedadesDeLosExponentes(),
  kRutaEcuacionesLineales: (context) => const EcuacionesLineales(),
  kRutaFormulaGeneral: (context) => const FormulaGeneral(),
  kRutaFormulasDeProductos: (context) => const FormulasDeProductos(),
  kRutaFormulasDeFactorizacion: (context) => const FormulasDeFactorizacion(),
  kRutaNumerosComplejos: (context) => const NumerosComplejos(),
  kRutaOperacionesFraccionesAlgebraicas: (context) =>
      const OperacionesFraccionesAlgebraicas(),
  kRutaOperacionesConPolinomios: (context) => const OperacionesConPolinomios(),
  kRutaPropiedadesDesigualdad: (context) => const PropiedadesDesigualdad(),
  kRutaPropiedadesRadicales: (context) => const PropiedadesRadicales(),
  kRutaSerieTaylorMaClaurin: (context) => const SerieTaylorMaClaurin(),
  kRutaTeoremaSumatorias: (context) => const TeoremaSumatorias(),
  kRutaEcuacionesDePrimerGrado: (context) => const EcuacionesDePrimerGrado(),
  kRutaEcuacionesDeSegundoGrado: (context) => const EcuacionesDeSegundoGrado(),
  kRutaSolucionEcuaciones: (context) => const SolucionEcuaciones(),

  //Numeros Complejos
  kRutaConjugadoNumerosComplejos: (context) =>
      const ConjugadoNumerosComplejos(),
  kRutaModuloyArgumentoNumerosComplejos: (context) =>
      const ModuloyArgumentoNumerosComplejos(),
  kRutaOperacionesNumerosComplejos: (context) =>
      const OperacionesNumerosComplejos(),
  kRutaPropiedadesNumerosComplejos: (context) =>
      const PropiedadesNumerosComplejos(),
  kRutaRepresentacionesDeNumerosComplejos: (context) =>
      const RepresentacionesDeNumerosComplejos(),

  //Ejercicios Algebra
  kRutaPropiedadesDeLosExponentesEjercicios: (context) =>
      const PropiedadesDeLosExponentesEjercicios(),

  //Algebra Lineal
  kRutaAlgebraLinealMenu: (context) => const AlgebraLinealMenu(),
  kRutaDeterminantesAlgebraLineal: (context) =>
      const DeterminantesAlgebraLineal(),
  kRutaReglaDeCramer: (context) => const ReglaDeCramer(),
  kRutaReglaDeSarrus: (context) => const ReglaDeSarrus(),

  //Matrices
  kRutaMatrizAdjunta: (context) => const MatrizAdjunta(),
  kRutaMatrizIdentidad: (context) => const MatrizIdentidad(),
  kRutaMatrizInversa: (context) => const MatrizInversa(),
  kRutaMatrizOrtogonal: (context) => const MatrizOrtogonal(),
  kRutaMatrizSimetrica: (context) => const MatrizSimetrica(),
  kRutaMatrizTranspuesta: (context) => const MatrizTranspuesta(),
  kRutaMatrizTriangular: (context) => const MatrizTriangular(),
  kRutaMenuMatricesAlgebraLineal: (context) => const MenuMatricesLineal(),
  kRutaMultiplicacionDeMatrices: (context) => const MultiplicacionDeMatrices(),
  kRutaPropiedadesDeLasMatrices: (context) => const PropiedadesDeLasMatrices(),
  kRutaSumaRestaDeMatrices: (context) => const SumaRestaDeMatrices(),
  //Vectores
  kRutaMenuVectores: (context) => const MenuVectoresLineal(),
  kRutaAnguloEntreVectores: (context) => const AnguloEntreVectores(),
  kRutaNormalizacion: (context) => const Normalizacion(),
  kRutaOperacionesConVectores: (context) => const OperacionesConVectores(),
  kRutaProductoCruz: (context) => const ProductoCruz(),
  kRutaProductoPunto: (context) => const ProductoPunto(),
  kRutaPropiedadesDeLosVectores: (context) => const PropiedadesDeLosVectores(),
  kRutaProyeccionesDeVectores: (context) => const ProyeccionesDeVectores(),
  kRutaVectorUnitario: (context) => const VectorUnitario(),
  kRutaVectoresYSuMagnitud: (context) => const VectoresYSuMagnitud(),

  //General
  kRutaPropiedadesLogaritmos: (context) =>
      const PropiedadesLogaritmosGenerales(),
  kRutaFuncionesTrigonometricasGenerales: (context) =>
      const FuncionesTrigonometricasGenerales(),
  kRutaIdentidadesTrigonometricas: (context) =>
      const IdentidadesTrigonometricasGenerales(),
  kRutaTrigonometricasHiperbolicas: (context) =>
      const TrigonometricasHiperbolicasGenerales(),
  kRutaIdentidadesHiperbolicas: (context) =>
      const IdentidadesHiperbolicasGenerales(),

  //Calculo Diferencial
  kRutaLimites: (context) => const MenuLimites(),
  kRutaPropiedadesLimites: (context) => const PropiedadesLimites(),
  kRutaLimitesTrigonometricos: (context) => const LimitesTrigonometricos(),
  kRutaDerivacionBasica: (context) => const DerivacionBasicaDiferencial(),
  kRutaFuncionesTrigonometricasDiferencial: (context) =>
      const FuncionesTrigonometricasDiferencial(),
  kRutaFuncionesTrigonometricasInversasDiferencial: (context) =>
      const TrigonometricasInversasDiferencial(),
  kRutaFuncionesTrigonometricasHiperbolicasDiferencial: (context) =>
      const TrigonometricasHiperbolicasDiferencial(),
  kRutaExponencialyLogaritmosDiferencial: (context) =>
      const ExponencialyLogaritmosDiferencial(),

  //Calculo Integral
  kRutaIntegracionBasica: (context) => const IntegracionBasicaIntegral(),
  kRutaFuncionesTrigonometricasIntegral: (context) =>
      const FuncionesTrigonometricasIntegral(),
  kRutaFuncionesTrigonometricasInversasIntegral: (context) =>
      const TrigonometricasInversasIntegral(),
  kRutaFuncionesHiperbolicasIntegral: (context) =>
      const FuncionesHiperbolicasIntegral(),
  kRutaFuncionesExponencialyLogaritmosIntegral: (context) =>
      const ExponencialyLogaritmoIntegral(),
  kRutaIntegralesExtras: (context) => const IntegralesExtraIntegral(),

  //Calculo Multivariable
  kRutaMenuCalculoMultivariable: (context) => const MenuCalculoMultivariable(),
  kRutaMenuFuncionesVectoriales: (context) => const MenuFuncionesVectoriales(),
  kRutaLimiteIntegralDerivadaFuncionVectorial: (context) =>
      const LimiteDerivadaIntegralFuncionesVectoriales(),
  kRutaDerivadaFuncionesVectoriales: (context) =>
      const DerivadaFuncionesVectoriales(),
  kRutaAreaBajoLaCurva: (context) => const AreaBajoLaCurva(),
  kRutaAreaDeUnaSuperficieDeRevolucion: (context) =>
      const AreaDeUnaSuperficieDeRevolucion(),
  kRutaCambioDeVariables: (context) => const CambioDeVariables(),
  kRutaDerivadasDireccionales: (context) => const DerivadasDireccionales(),
  kRutaDerivadasParciales: (context) => const DerivadasParciales(),
  kRutaDiferencialTotal: (context) => const DiferencialTotal(),
  kRutaGradienteDeUnaFuncion: (context) => const GradienteDeUnaFuncion(),
  kRutaIdentidadesVectoriales: (context) => const IdentidadesVectoriales(),
  kRutaIntegralEnCoordenadasCilindricas: (context) =>
      const IntegralEnCoordenadasCilindricas(),
  kRutaIntegralesDeLinea: (context) => const IntegralesDeLinea(),
  kRutaLongitudDeArco: (context) => const LongitudDeArco(),
  kRutaOperadoresDiferenciales: (context) => const OperadoresDiferenciales(),
  kRutaTeoremaDeFubini: (context) => const TeoremaDeFubini(),
  kRutaTeoremaIntegrales: (context) => const TeoremaIntegrales(),

  //Ecuaciones Diferenciales
  kRutaConstantesDeIntegracion: (context) => const ConstantesDeIntegracion(),
  kRutaEcuacionDiferencialConCoeficientesConstantes: (context) =>
      const EcuacionDiferencialConCoeficientesConstantes(),
  kRutaEcuacionDiferencialDeRectasNoParalelas: (context) =>
      const EcuacionDiferencialDeRectasNoParalelas(),
  kRutaEcuacionDiferencialDeRectasParalelas: (context) =>
      const EcuacionDiferencialDeRectasParalelas(),
  kRutaEcuacionDiferencialExacta: (context) =>
      const EcuacionDiferencialExacta(),
  kRutaEcuacionDiferencialHomogenea: (context) =>
      const EcuacionDiferencialHomogenea(),
  kRutaEcuacionDiferencialLinealDeOrdenSuperior: (context) =>
      const EcuacionDiferencialLinealDeOrdenSuperior(),
  kRutaEcuacionDiferencialLinealDePrimerOrden: (context) =>
      const EcuacionDiferencialLinealDePrimerOrden(),
  kRutaEcuacionDiferencialSeparable: (context) =>
      const EcuacionDiferencialSeparable(),
  kRutaMenuEcuacionesDiferenciales: (context) =>
      const MenuEcuacionesDiferenciales(),

  //Electricidad y Magnetismo
  kRutaMenuElectricidadYMagnetismo: (context) =>
      const MenuElectricidadYMagnetismo(),
  kRutaMenuCampoYPotencialElectricos: (context) =>
      const MenuCampoYPotencialElectricos(),
  kRutaMenuCapacitanciaYDielectricos: (context) =>
      const MenuCapacitanciaYDielectricos(),
  kRutaElectricidad: (context) => const Electricidad(),
  kRutaCargaElectrica: (context) => const CargaElectrica(),
  kRutaCargaProtonElectron: (context) => const CargaProtonElectron(),
  kRutaDistribucionesDeCargaElectrica: (context) =>
      const DistribucionesDeCargaElectrica(),
  kRutaLeyDeCoulomb: (context) => const LeyDeCoulomb(),
  kRutaPrincipioDeSuperposicion: (context) => const PrincipioDeSuperposicion(),
  kRutaCampoElectrico: (context) => const CampoElectrico(),
  kRutaCampoElectricoOriginadoPorDistribucionesDeCarga: (context) =>
      const CampoElectricoOriginadoPorDistribucionesDeCarga(),
  kRutaFlujoDeUnCampoVectorial: (context) => const FlujoDeUnCampoVectorial(),
  kRutaLeyDeGauss: (context) => const LeyDeGauss(),
  kRutaEnergiaPotencialElectrica: (context) =>
      const EnergiaPotencialElectrica(),
  kRutaCalculoDeDiferenciasDePotencial: (context) =>
      const CalculoDeDiferenciasDePotencial(),
  kRutaTeoremaDeLaDivergencia: (context) => const TeoremaDeLaDivergencia(),
  kRutaTeoremaDelRotacional: (context) => const TeoremaDelRotacional(),
  kRutaCirculacionDelCampoElectrostatico: (context) =>
      const CirculacionDelCampoElectrostatico(),
  kRutaRotacionalDelCampoElectrostatico: (context) =>
      const RotacionalDelCampoElectrostatico(),
  kRutaOperadorGradiente: (context) => const OperadorGradiente(),
  kRutaGradienteDeUnaFuncionEscalar: (context) =>
      const GradienteDeUnaFuncionEscalar(),
  kRutaGradienteDePotencialElectrico: (context) =>
      const GradienteDePotencialElectrico(),
  kRutaLeyDeGaussEnFormaDiferencial: (context) =>
      const LeyDeGaussEnFormaDiferencial(),
  kRutaEcuacionDePoissonYLaplace: (context) =>
      const EcuacionDePoissonYLaplace(),
  kRutaSuperficiesEquipotenciales: (context) =>
      const SuperficiesEquipotenciales(),
  kRutaCapacitor: (context) => const Capacitor(),
  kRutaCargaDeUnCapacitor: (context) => const CargaDeUnCapacitor(),
  kRutaDefinicionDeCapacitancia: (context) => const DefinicionDeCapacitancia(),
  kRutaGraficaDeCapacitancia: (context) => const GraficaDeCapacitancia(),
  kRutaSimbologiaCapacitores: (context) => const SimbologiaCapacitores(),
  kRutaCapacitorDePlacasPlanasYParalelas: (context) =>
      const CapacitorDePlacasPlanasYParalelas(),
  kRutaEnergiaYCapacitancia: (context) => const EnergiaYCapacitancia(),
  kRutaEnergiaAlmacenadaPorUnCapacitor: (context) =>
      const EnergiaAlmacenadaPorUnCapacitor(),
  kRutaConexionEnSerieCapacitor: (context) => const ConexionEnSerieCapacitor(),
  kRutaConexionEnParaleloCapacitor: (context) =>
      const ConexionEnParaleloCapacitor(),
  kRutaPolarizacion: (context) => const Polarizacion(),
  kRutaPolarizacionYCargaInducida: (context) =>
      const PolarizacionYCargaInducida(),
  kRutaConstantesDielectricas: (context) => const ConstantesDielectricas(),
  kRutaRigidezDielectrica: (context) => const RigidezDielectrica(),
  kRutaVectorDeDesplazamientoElectrico: (context) =>
      const VectorDeDesplazamientoElectrico(),
  kRutaRepresentacionDeLosVectoresElectricos: (context) =>
      const RepresentacionDeLosVectoresElectricos(),
  kRutaMenuCircuitosElectricos: (context) => const MenuCircuitosElectricos(),
  kRutaConductividadYResistividad: (context) =>
      const ConductividadYResistividad(),
  kRutaLeyDeOhm: (context) => const LeyDeOhm(),
  kRutaEcuacionDeOhm: (context) => const EcuacionDeOhm(),
  kRutaResistividadYTemperatura: (context) => const ResistividadYTemperatura(),
  kRutaEfectoJoule: (context) => const EfectoJoule(),
  kRutaResistorSimbologiaBasica: (context) => const ResistorSimbologiaBasica(),
  kRutaResistorLinealYNoLineal: (context) => const ResistorLinealYNoLineal(),
  kRutaConexionEnSerieResistor: (context) => const ConexionEnSerieResistor(),
  kRutaConexionEnParaleloResistor: (context) =>
      const ConexionEnParaleloResistor(),
  kRutaFuenteDeFuerzaElectromotriz: (context) =>
      const FuenteDeFuerzaElectromotrizFem(),
  kRutaElementosCapacitorYResistor: (context) =>
      const ElementosCapacitorYResistor(),
  kRutaElementosFem: (context) => const ElementosFem(),
  kRutaTeoriaDeCircuitos: (context) => const TeoriaDeCircuitos(),
  kRutaLeyDeVoltajesDeKirchhoff: (context) => const LeyDeVoltajesDeKirchhoff(),
  kRutaLeyDeCorrientesDeKirchhoff: (context) =>
      const LeyDeCorrientesDeKirchhoff(),
  kRutaReglasParaLVKyLCK: (context) => const ReglasParaLVKyLCK(),
  kRutaCircuitoRCyVoltajeContinuo: (context) =>
      const CircuitoRCyVoltajeContinuo(),
  kRutaLeyesDeKirchhoffCircuitoRC: (context) =>
      const LeyesDeKirchhoffCircuitoRC(),
  kRutaMenuMagnetostatica: (context) => const MenuMagnetostatica(),
  kRutaOrigenDeCampoMagnetico: (context) => const OrigenDeCampoMagnetico(),
  kRutaFuerzaMagneticaComoVectorSobreCargasEnMovimiento: (context) =>
      const FuerzaMagneticaComoVectorSobreCargasEnMovimiento(),
  kRutaDefinicionDeCampoMagnetico: (context) =>
      const DefinicionDeCampoMagnetico(),
  kRutaFuerzaDeLorentz: (context) => const FuerzaDeLorentz(),
  kRutaLeyDeBiotSavart: (context) => const LeyDeBiotSavart(),
  kRutaSegmentoConductorRecto: (context) => const SegmentoConductorRecto(),
  kRutaEspiraEnFormaDeCircunferencia: (context) =>
      const EspiraEnFormaDeCircunferencia(),

  kRutaEspiraCuadrada: (context) => const EspiraCuadrada(),
  kRutaBobina: (context) => const Bobina(),
  kRutaSolenoide: (context) => const Solenoide(),
  kRutaCirculacionDeUnCampoVectorial: (context) =>
      const CirculacionDeUnCampoVectorial(),
  kRutaCampoMagneticoAPartirDeLeyDeAmpere: (context) =>
      const CampoMagneticoAPartirDeLeyDeAmpere(),
  kRutaLeyDeAmpereEnFormaDiferencial: (context) =>
      const LeyDeAmpereEnFormaDiferencial(),
  kRutaNomenclaturaBasicaEmpleadaEnCircuitos: (context) =>
      const NomenclaturaBasicaEmpleadaEnCircuitos(),
  kRutaFlujoMagnetico: (context) => const FlujoMagnetico(),
  kRutaMotorDeCorrienteDirecta: (context) => const MotorDeCorrienteDirecta(),
  kRutaGeneradorHomopolar: (context) => const GeneradorHomopolar(),
  kRutaInductanciaPropia: (context) => const InductanciaPropia(),
  kRutaInductanciaMutua: (context) => const InductanciaMutua(),
  kRutaMenuInduccionElectromagnetica: (context) =>
      const MenuInduccionElectromagnetica(),
  kRutaInductanciaPropiaDeUnSolenoide: (context) =>
      const InductanciaPropiaDeUnSolenoide(),
  kRutaInductanciaParaUnToroide: (context) => const InductanciaParaUnToroide(),
  kRutaInductanciaMutuaEntreDosSolenoidesCoaxiales: (context) =>
      const InductanciaMutuaEntreDosSolenoidesCoaxiales(),
  kRutaLeyDeInduccionDeFaraday: (context) =>
      const LeyDeInduccionDeFaradayEnergiaEnUnInductor(),
  kRutaEnergiaAlmacenadaEnUnCampoMagnetico: (context) =>
      const EnergiaAlmacenadaEnUnCampoMagnetico(),
  kRutaInductor: (context) => const Inductor(),
  kRutaInductorEnSerie: (context) => const InductoresEnSerie(),
  kRutaPortadoresDeCargaLibre: (context) => const PortadoresDeCargaLibre(),
  kRutaMovimientoDePortadoresDeCargaLibre: (context) =>
      const MovimientoDePortadoresDeCargaLibreYDensidadDeCorriente(),
  kRutaDensidadDeCorrienteYCorrienteElectrica: (context) =>
      const DensidadDeCorrienteYCorrienteElectrica(),
  kRutaTiposDeCorrienteElectrica: (context) =>
      const TiposDeCorrienteElectrica(),

  //Probabilidad y Estadistica
  kRutaCombinacionesYPermutaciones: (context) =>
      const CombinacionesYPermutaciones(),
  kRutaCuantilesParaDatosAgrupados: (context) =>
      const CuantilesParaDatosAgrupados(),
  kRutaEstadisticaInferencial: (context) => const EstadisticaInferencial(),
  kRutaIntervalosDeConfianza: (context) => const IntervalosDeConfianza(),
  kRutaMediaGeometrica: (context) => const MediaGeometrica(),
  kRutaMenuProbabilidadYEstadistica: (context) =>
      const MenuProbabilidadYEstadistica(),
  kRutaMomentosEstadisticos: (context) => const MomentosEstadisticos(),
  kRutaProbabilidad: (context) => const Probabilidad(),
  kRutaTamanioMuestral: (context) => const TamanioMuestral(),

  //Distribuciones
  kRutaDistribucionBinomial: (context) => const DistribucionBinomial(),
  kRutaDistribucionDePoisson: (context) => const DistribucionDePoisson(),
  kRutaDistribucionExponencial: (context) => const DistribucionExponencial(),
  kRutaDistribucionGeometrica: (context) => const DistribucionGeometrica(),
  kRutaDistribucionHipergeometrica: (context) =>
      const DistribucionHipergeometrica(),
  kRutaDistribucionNormal: (context) => const DistribucionNormal(),
  kRutaDistribucionTDeStudent: (context) => const DistribucionTDeStudent(),
  kRutaMenuDistribuciones: (context) => const MenuDistribuciones(),

  //Medidas
  kRutaMedidasDeDispersionParaDatosNoAgrupados: (context) =>
      const MedidasDeDispersionParaDatosNoAgrupados(),
  kRutaMedidasDePosicionParaDatosNoAgrupados: (context) =>
      const MedidasDePosicionParaDatosNoAgrupados(),
  kRutaMedidasDeTendenciaCentralParaDatosAgrupados: (context) =>
      const MedidasDeTendenciaCentralParaDatosAgrupados(),
  kRutaMedidasDeTendenciaCentralParaDatosNoAgrupados: (context) =>
      const MedidasDeTendenciaCentralParaDatosNoAgrupados(),
  kRutaMenuMedidas: (context) => const MenuMedidas(),

  //Series de Fourier
  kRutaConvolucion: (context) => const Convolucion(),
  kRutaFormaComplejaDeLasSeriesDeFourier: (context) =>
      const FormaComplejaDeLasSeriesDeFourier(),
  kRutaFormulasOperacionalesDeLaTransformadaDeLaplace: (context) =>
      const FormulasOperacionalesDeLaTransformadaDeLaplace(),
  kRutaFuncionImpulsoUnitario: (context) => const FuncionImpulsoUnitario(),
  kRutaFuncionUnitariaDeHeaviside: (context) =>
      const FuncionUnitariaDeHeaviside(),
  kRutaMenuSeriesDeFourier: (context) => const MenuSeriesDeFourier(),
  kRutaSerieYCoeficientesDeFourier: (context) =>
      const SerieYCoeficientesDeFourier(),

  //Simetrias
  kRutaSimetriaDeMediaOnda: (context) => const SimetriaDeMediaOnda(),
  kRutaSimetriaDeUnCuartoDeOndaImpar: (context) =>
      const SimetriaDeUnCuartoDeOndaImpar(),
  kRutaMenuSimetrias: (context) => const MenuSimetrias(),
  kRutaSimetriaDeUnCuartoDeOndaPar: (context) =>
      const SimetriaDeUnCuartoDeOndaPar(),
  kRutaSimetriaImpar: (context) => const SimetriaImpar(),
  kRutaSimetriaPar: (context) => const SimetriaPar(),

  //Transformadas
  kRutaMenuTransformadas: (context) => const MenuTransformadas(),
  kRutaTransformadaDeFourier: (context) => const TransformadaDeFourier(),
  kRutaTransformadaDeLaplace: (context) => const TransformadaDeLaplace(),
  kRutaTransformadaSenoYCosenoDeFourier: (context) =>
      const TransformadaSenoYCosenoDeFourier(),
  kRutaTransformadasBasicasDeFourier: (context) =>
      const TransformadasBasicasDeFourier(),
  kRutaTransformadasDeFourier: (context) => const TransformadasDeFourier(),
  kRutaTransformadasDeLaplace: (context) => const TransformadasDeLaplace(),

  //Trigonometria
  kRutaFuncionesTrigonometricas: (context) => const FuncionesTrigonometricas(),
  kRutaFuncionesTrigonometricasDeAngulosNotables: (context) =>
      const FuncionesTrigonometricasDeAngulosNotables(),
  kRutaLeyDeProyecciones: (context) => const LeyDeProyecciones(),
  kRutaLeyesDeSenosCosenosTangentes: (context) =>
      const LeyesDeSenosCosenosTangentes(),
  kRutaMedicionYClasificacionDeAngulos: (context) =>
      const MedicionYClasificacionDeAngulos(),
  kRutaMenuTrigonometria: (context) => const MenuTrigonometria(),
  kRutaSuperficieDeUnTrianguloYUnPoligonoEsferico: (context) =>
      const SuperficieDeUnTrianguloYUnPoligonoEsferico(),
  kRutaTeoremaDePitagoras: (context) => const TeoremaDePitagoras(),
  kRutaValoresDeSenoYCoseno: (context) => const ValoresDeSenoYCoseno(),

  //Formulas de Bessel
  kRutaMenuFormulasBessel: (context) => const MenuFormulasBessel(),
  kRutaTeoremaDelCosenoParaAngulos: (context) =>
      const TeoremaDelCosenoParaAngulos(),
  kRutaTeoremaDeLaCotangente: (context) => const TeoremaDeLaCotangente(),
  kRutaTeoremaDelCosenoParaLados: (context) =>
      const TeoremaDelCosenoParaLados(),
  kRutaTeoremaDelSeno: (context) => const TeoremaDelSeno(),

  //Identidades Trigonometricas
  kRutaIdentidadesTrigonometricasDeAnguloDobleYMedio: (context) =>
      const IdentidadesTrigonometricasDeAnguloDobleYMedio(),
  kRutaIdentidadesTrigonometricasDeSumaAProductoYViceversa: (context) =>
      const IdentidadesTrigonometricasDeSumaAProductoYViceversa(),
  kRutaIdentidadesTrigonometricasDeSumaYRestaDeAngulos: (context) =>
      const IdentidadesTrigonometricasDeSumaYRestaDeAngulos(),
  kRutaIdentidadesTrigonometricasExtras: (context) =>
      const IdentidadesTrigonometricasExtras(),
  kRutaIdentidadesTrigonometricasFundamentales: (context) =>
      const IdentidadesTrigonometricasFundamentales(),
  kRutaMenuIdentidadesTrigonometricas: (context) =>
      const MenuIdentidadesTrigonometricas(),

  //Trigonometria Esferica
  kRutaAnalogiasDeGaussDelambre: (context) => const AnalogiasDeGaussDelambre(),
  kRutaAnalogiasDeNeper: (context) => const AnalogiasDeNeper(),
  kRutaFuncionesDelAnguloMitad: (context) => const FuncionesDelAnguloMitad(),
  kRutaMenuTrigonometriaEsferica: (context) =>
      const MenuTrigonometriaEsferica(),

  //Matemáticas Discretas
  kRutaBicondicional: (context) => const BicondicionalMatematicasDiscretas(),
  kRutaCondicional: (context) => const CondicionalMatematicasDiscretas(),
  kRutaConectoresLogicos: (context) => const ConectoresLogicos(),
  kRutaConjuncion: (context) => const ConjuncionMatematicasDiscretas(),
  kRutaDisyuncion: (context) => const DisyuncionMatematicasDiscretas(),
  kRutaLeyesDeLaLogicaProposicional: (context) =>
      const LeyesDeLaLogicaProposicional(),
  kRutaLeyesDeLaTeoriaDeConjuntos: (context) =>
      const LeyesDeLaTeoriaDeConjuntos(),
  kRutaLeyesDelAlgebraDeBoole: (context) => const LeyesDelAlgebraDeBoole(),
  kRutaNegacion: (context) => const Negacion(),
  kRutaMenuMatematicasDiscretas: (context) => const MenuMatematicasDiscretas(),

  //Matematicas Financieras
  kRutaAmortizacion: (context) => const Amortizacion(),
  kRutaAnualidadAnticipadaSimpleYCierta: (context) =>
      const AnualidadAnticipadaSimpleYCierta(),
  kRutaAnualidadVencidaSimpleYCierta: (context) =>
      const AnualidadVencidaSimpleYCierta(),
  kRutaDescuentoCompuesto: (context) => const DescuentoCompuesto(),
  kRutaDescuentoSimple: (context) => const DescuentoSimple(),
  kRutaInteresCompuesto: (context) => const InteresCompuesto(),
  kRutaInteresSimple: (context) => const InteresSimple(),
  kRutaMenuMatematicasFinancieras: (context) =>
      const MenuMatematicasFinancieras(),
  kRutaSaldoInsoluto: (context) => const SaldoInsoluto(),
  kRutaTasaDeInteresGlobal: (context) => const TasaDeInteresGlobal(),
  kRutaTasaEfectiva: (context) => const TasaEfectiva(),

  //Geometria
  kRutaAreaYPerimetroDeCuadrilateros: (context) =>
      const AreaYPerimetroDeCuadrilateros(),
  kRutaAreaYPerimetroDeTriangulos: (context) =>
      const AreaYPerimetroDeTriangulos(),
  kRutaAreaYPerimetroDelCirculo: (context) => const AreaYPerimetroDelCirculo(),
  kRutaMenuAreasGeometria: (context) => const MenuAreasGeometria(),
  kRutaAngulosEnUnPoligono: (context) => const AngulosEnUnPoligono(),
  kRutaCircunferencia: (context) => const Circunferencia(),
  kRutaDistanciaDeUnPuntoAUnaRecta: (context) =>
      const DistanciaDeUnPuntoAUnaRecta(),
  kRutaDistanciaEntreDosPuntos: (context) => const DistanciaEntreDosPuntos(),
  kRutaEcuacionDeLaRecta: (context) => const EcuacionDeLaRecta(),
  kRutaElipseConCentroDiferenteDelOrigen: (context) =>
      const ElipseConCentroDiferenteDelOrigen(),
  kRutaElipseConCentroEnElOrigen: (context) =>
      const ElipseConCentroEnElOrigen(),
  kRutaHiperbola: (context) => const Hiperbola(),
  kRutaMenuGeometria: (context) => const MenuGeometria(),
  kRutaParabolaConVerticeDiferenteDelOrigen: (context) =>
      const ParabolaConVerticeDiferenteDelOrigen(),
  kRutaParabolaConVerticeEnElOrigen: (context) =>
      const ParabolaConVerticeEnElOrigen(),
  kRutaVolumenDeCuerposGeometricos: (context) =>
      const VolumenDeCuerposGeometricos(),
  //Drawer
  kRutaInformacion: (context) => const Informacion(),
  kRutaConfiguracion: (context) => const Configuracion(),
};
