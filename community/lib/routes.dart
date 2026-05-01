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
      kRutaChatGPT: (context) => ChatScreen(),
      kRutaFavorites: (context) => FavoritesScreen(),
      kRutaPreguntasFrecuentes: (context) => PreguntasFrecuentes(),
      kRutaCalculoIntegral: (context) => CalculoIntegral(),
      kRutaCalculoDiferencial: (context) => CalculoDiferencial(),
      kRutaGenerales: (context) => Generales(),

      //Algebra
      kRutaMenuAlgebra: (context) => MenuAlgebra(),
      kRutaPropiedadesDeLosExponentes: (context) =>
          PropiedadesDeLosExponentes(),
      kRutaEcuacionesLineales: (context) => EcuacionesLineales(),
      kRutaFormulaGeneral: (context) => FormulaGeneral(),
      kRutaFormulasDeProductos: (context) => FormulasDeProductos(),
      kRutaFormulasDeFactorizacion: (context) => FormulasDeFactorizacion(),
      kRutaNumerosComplejos: (context) => NumerosComplejos(),
      kRutaOperacionesFraccionesAlgebraicas: (context) =>
          OperacionesFraccionesAlgebraicas(),
      kRutaOperacionesConPolinomios: (context) => OperacionesConPolinomios(),
      kRutaPropiedadesDesigualdad: (context) => PropiedadesDesigualdad(),
      kRutaPropiedadesRadicales: (context) => PropiedadesRadicales(),
      kRutaSerieTaylorMaClaurin: (context) => SerieTaylorMaClaurin(),
      kRutaTeoremaSumatorias: (context) => TeoremaSumatorias(),
      kRutaEcuacionesDePrimerGrado: (context) => EcuacionesDePrimerGrado(),
      kRutaEcuacionesDeSegundoGrado: (context) => EcuacionesDeSegundoGrado(),
      kRutaSolucionEcuaciones: (context) => SolucionEcuaciones(),

      //Numeros Complejos
      kRutaConjugadoNumerosComplejos: (context) => ConjugadoNumerosComplejos(),
      kRutaModuloyArgumentoNumerosComplejos: (context) =>
          ModuloyArgumentoNumerosComplejos(),
      kRutaOperacionesNumerosComplejos: (context) =>
          OperacionesNumerosComplejos(),
      kRutaPropiedadesNumerosComplejos: (context) =>
          PropiedadesNumerosComplejos(),
      kRutaRepresentacionesDeNumerosComplejos: (context) =>
          RepresentacionesDeNumerosComplejos(),

      //Ejercicios Algebra
      kRutaPropiedadesDeLosExponentesEjercicios: (context) =>
          PropiedadesDeLosExponentesEjercicios(),

      //Algebra Lineal
      kRutaAlgebraLinealMenu: (context) => AlgebraLinealMenu(),
      kRutaDeterminantesAlgebraLineal: (context) =>
          DeterminantesAlgebraLineal(),
      kRutaReglaDeCramer: (context) => ReglaDeCramer(),
      kRutaReglaDeSarrus: (context) => ReglaDeSarrus(),

      //Matrices
      kRutaMatrizAdjunta: (context) => MatrizAdjunta(),
      kRutaMatrizIdentidad: (context) => MatrizIdentidad(),
      kRutaMatrizInversa: (context) => MatrizInversa(),
      kRutaMatrizOrtogonal: (context) => MatrizOrtogonal(),
      kRutaMatrizSimetrica: (context) => MatrizSimetrica(),
      kRutaMatrizTranspuesta: (context) => MatrizTranspuesta(),
      kRutaMatrizTriangular: (context) => MatrizTriangular(),
      kRutaMenuMatricesAlgebraLineal: (context) => MenuMatricesLineal(),
      kRutaMultiplicacionDeMatrices: (context) => MultiplicacionDeMatrices(),
      kRutaPropiedadesDeLasMatrices: (context) => PropiedadesDeLasMatrices(),
      kRutaSumaRestaDeMatrices: (context) => SumaRestaDeMatrices(),
      //Vectores
      kRutaMenuVectores: (context) => MenuVectoresLineal(),
      kRutaAnguloEntreVectores: (context) => AnguloEntreVectores(),
      kRutaNormalizacion: (context) => Normalizacion(),
      kRutaOperacionesConVectores: (context) => OperacionesConVectores(),
      kRutaProductoCruz: (context) => ProductoCruz(),
      kRutaProductoPunto: (context) => ProductoPunto(),
      kRutaPropiedadesDeLosVectores: (context) => PropiedadesDeLosVectores(),
      kRutaProyeccionesDeVectores: (context) => ProyeccionesDeVectores(),
      kRutaVectorUnitario: (context) => VectorUnitario(),
      kRutaVectoresYSuMagnitud: (context) => VectoresYSuMagnitud(),

      //General
      kRutaPropiedadesLogaritmos: (context) => PropiedadesLogaritmosGenerales(),
      kRutaFuncionesTrigonometricasGenerales: (context) =>
          FuncionesTrigonometricasGenerales(),
      kRutaIdentidadesTrigonometricas: (context) =>
          IdentidadesTrigonometricasGenerales(),
      kRutaTrigonometricasHiperbolicas: (context) =>
          TrigonometricasHiperbolicasGenerales(),
      kRutaIdentidadesHiperbolicas: (context) =>
          IdentidadesHiperbolicasGenerales(),

      //Calculo Diferencial
      kRutaLimites: (context) => MenuLimites(),
      kRutaPropiedadesLimites: (context) => PropiedadesLimites(),
      kRutaLimitesTrigonometricos: (context) => LimitesTrigonometricos(),
      kRutaDerivacionBasica: (context) => DerivacionBasicaDiferencial(),
      kRutaFuncionesTrigonometricasDiferencial: (context) =>
          FuncionesTrigonometricasDiferencial(),
      kRutaFuncionesTrigonometricasInversasDiferencial: (context) =>
          TrigonometricasInversasDiferencial(),
      kRutaFuncionesTrigonometricasHiperbolicasDiferencial: (context) =>
          TrigonometricasHiperbolicasDiferencial(),
      kRutaExponencialyLogaritmosDiferencial: (context) =>
          ExponencialyLogaritmosDiferencial(),

      //Calculo Integral
      kRutaIntegracionBasica: (context) => IntegracionBasicaIntegral(),
      kRutaFuncionesTrigonometricasIntegral: (context) =>
          FuncionesTrigonometricasIntegral(),
      kRutaFuncionesTrigonometricasInversasIntegral: (context) =>
          TrigonometricasInversasIntegral(),
      kRutaFuncionesHiperbolicasIntegral: (context) =>
          FuncionesHiperbolicasIntegral(),
      kRutaFuncionesExponencialyLogaritmosIntegral: (context) =>
          ExponencialyLogaritmoIntegral(),
      kRutaIntegralesExtras: (context) => IntegralesExtraIntegral(),

      //Calculo Multivariable
      kRutaMenuCalculoMultivariable: (context) => MenuCalculoMultivariable(),
      kRutaMenuFuncionesVectoriales: (context) => MenuFuncionesVectoriales(),
      kRutaLimiteIntegralDerivadaFuncionVectorial: (context) =>
          LimiteDerivadaIntegralFuncionesVectoriales(),
      kRutaDerivadaFuncionesVectoriales: (context) =>
          DerivadaFuncionesVectoriales(),
      kRutaAreaBajoLaCurva: (context) => AreaBajoLaCurva(),
      kRutaAreaDeUnaSuperficieDeRevolucion: (context) =>
          AreaDeUnaSuperficieDeRevolucion(),
      kRutaCambioDeVariables: (context) => CambioDeVariables(),
      kRutaDerivadasDireccionales: (context) => DerivadasDireccionales(),
      kRutaDerivadasParciales: (context) => DerivadasParciales(),
      kRutaDiferencialTotal: (context) => DiferencialTotal(),
      kRutaGradienteDeUnaFuncion: (context) => GradienteDeUnaFuncion(),
      kRutaIdentidadesVectoriales: (context) => IdentidadesVectoriales(),
      kRutaIntegralEnCoordenadasCilindricas: (context) =>
          IntegralEnCoordenadasCilindricas(),
      kRutaIntegralesDeLinea: (context) => IntegralesDeLinea(),
      kRutaLongitudDeArco: (context) => LongitudDeArco(),
      kRutaOperadoresDiferenciales: (context) => OperadoresDiferenciales(),
      kRutaTeoremaDeFubini: (context) => TeoremaDeFubini(),
      kRutaTeoremaIntegrales: (context) => TeoremaIntegrales(),

      //Ecuaciones Diferenciales
      kRutaConstantesDeIntegracion: (context) => ConstantesDeIntegracion(),
      kRutaEcuacionDiferencialConCoeficientesConstantes: (context) =>
          EcuacionDiferencialConCoeficientesConstantes(),
      kRutaEcuacionDiferencialDeRectasNoParalelas: (context) =>
          EcuacionDiferencialDeRectasNoParalelas(),
      kRutaEcuacionDiferencialDeRectasParalelas: (context) =>
          EcuacionDiferencialDeRectasParalelas(),
      kRutaEcuacionDiferencialExacta: (context) => EcuacionDiferencialExacta(),
      kRutaEcuacionDiferencialHomogenea: (context) =>
          EcuacionDiferencialHomogenea(),
      kRutaEcuacionDiferencialLinealDeOrdenSuperior: (context) =>
          EcuacionDiferencialLinealDeOrdenSuperior(),
      kRutaEcuacionDiferencialLinealDePrimerOrden: (context) =>
          EcuacionDiferencialLinealDePrimerOrden(),
      kRutaEcuacionDiferencialSeparable: (context) =>
          EcuacionDiferencialSeparable(),
      kRutaMenuEcuacionesDiferenciales: (context) =>
          MenuEcuacionesDiferenciales(),

      //Electricidad y Magnetismo
      kRutaMenuElectricidadYMagnetismo: (context) =>
          MenuElectricidadYMagnetismo(),
      kRutaMenuCampoYPotencialElectricos: (context) =>
          MenuCampoYPotencialElectricos(),
      kRutaMenuCapacitanciaYDielectricos: (context) =>
          MenuCapacitanciaYDielectricos(),
      kRutaElectricidad: (context) => Electricidad(),
      kRutaCargaElectrica: (context) => CargaElectrica(),
      kRutaCargaProtonElectron: (context) => CargaProtonElectron(),
      kRutaDistribucionesDeCargaElectrica: (context) =>
          DistribucionesDeCargaElectrica(),
      kRutaLeyDeCoulomb: (context) => LeyDeCoulomb(),
      kRutaPrincipioDeSuperposicion: (context) => PrincipioDeSuperposicion(),
      kRutaCampoElectrico: (context) => CampoElectrico(),
      kRutaCampoElectricoOriginadoPorDistribucionesDeCarga: (context) =>
          CampoElectricoOriginadoPorDistribucionesDeCarga(),
      kRutaFlujoDeUnCampoVectorial: (context) => FlujoDeUnCampoVectorial(),
      kRutaLeyDeGauss: (context) => LeyDeGauss(),
      kRutaEnergiaPotencialElectrica: (context) => EnergiaPotencialElectrica(),
      kRutaCalculoDeDiferenciasDePotencial: (context) =>
          CalculoDeDiferenciasDePotencial(),
      kRutaTeoremaDeLaDivergencia: (context) => TeoremaDeLaDivergencia(),
      kRutaTeoremaDelRotacional: (context) => TeoremaDelRotacional(),
      kRutaCirculacionDelCampoElectrostatico: (context) =>
          CirculacionDelCampoElectrostatico(),
      kRutaRotacionalDelCampoElectrostatico: (context) =>
          RotacionalDelCampoElectrostatico(),
      kRutaOperadorGradiente: (context) => OperadorGradiente(),
      kRutaGradienteDeUnaFuncionEscalar: (context) =>
          GradienteDeUnaFuncionEscalar(),
      kRutaGradienteDePotencialElectrico: (context) =>
          GradienteDePotencialElectrico(),
      kRutaLeyDeGaussEnFormaDiferencial: (context) =>
          LeyDeGaussEnFormaDiferencial(),
      kRutaEcuacionDePoissonYLaplace: (context) => EcuacionDePoissonYLaplace(),
      kRutaSuperficiesEquipotenciales: (context) =>
          SuperficiesEquipotenciales(),
      kRutaCapacitor: (context) => Capacitor(),
      kRutaCargaDeUnCapacitor: (context) => CargaDeUnCapacitor(),
      kRutaDefinicionDeCapacitancia: (context) => DefinicionDeCapacitancia(),
      kRutaGraficaDeCapacitancia: (context) => GraficaDeCapacitancia(),
      kRutaSimbologiaCapacitores: (context) => SimbologiaCapacitores(),
      kRutaCapacitorDePlacasPlanasYParalelas: (context) =>
          CapacitorDePlacasPlanasYParalelas(),
      kRutaEnergiaYCapacitancia: (context) => EnergiaYCapacitancia(),
      kRutaEnergiaAlmacenadaPorUnCapacitor: (context) =>
          EnergiaAlmacenadaPorUnCapacitor(),
      kRutaConexionEnSerieCapacitor: (context) => ConexionEnSerieCapacitor(),
      kRutaConexionEnParaleloCapacitor: (context) =>
          ConexionEnParaleloCapacitor(),
      kRutaPolarizacion: (context) => Polarizacion(),
      kRutaPolarizacionYCargaInducida: (context) =>
          PolarizacionYCargaInducida(),
      kRutaConstantesDielectricas: (context) => ConstantesDielectricas(),
      kRutaRigidezDielectrica: (context) => RigidezDielectrica(),
      kRutaVectorDeDesplazamientoElectrico: (context) =>
          VectorDeDesplazamientoElectrico(),
      kRutaRepresentacionDeLosVectoresElectricos: (context) =>
          RepresentacionDeLosVectoresElectricos(),
      kRutaMenuCircuitosElectricos: (context) => MenuCircuitosElectricos(),
      kRutaConductividadYResistividad: (context) =>
          ConductividadYResistividad(),
      kRutaLeyDeOhm: (context) => LeyDeOhm(),
      kRutaEcuacionDeOhm: (context) => EcuacionDeOhm(),
      kRutaResistividadYTemperatura: (context) => ResistividadYTemperatura(),
      kRutaEfectoJoule: (context) => EfectoJoule(),
      kRutaResistorSimbologiaBasica: (context) => ResistorSimbologiaBasica(),
      kRutaResistorLinealYNoLineal: (context) => ResistorLinealYNoLineal(),
      kRutaConexionEnSerieResistor: (context) => ConexionEnSerieResistor(),
      kRutaConexionEnParaleloResistor: (context) =>
          ConexionEnParaleloResistor(),
      kRutaFuenteDeFuerzaElectromotriz: (context) =>
          FuenteDeFuerzaElectromotrizFem(),
      kRutaElementosCapacitorYResistor: (context) =>
          ElementosCapacitorYResistor(),
      kRutaElementosFem: (context) => ElementosFem(),
      kRutaTeoriaDeCircuitos: (context) => TeoriaDeCircuitos(),
      kRutaLeyDeVoltajesDeKirchhoff: (context) => LeyDeVoltajesDeKirchhoff(),
      kRutaLeyDeCorrientesDeKirchhoff: (context) =>
          LeyDeCorrientesDeKirchhoff(),
      kRutaReglasParaLVKyLCK: (context) => ReglasParaLVKyLCK(),
      kRutaCircuitoRCyVoltajeContinuo: (context) =>
          CircuitoRCyVoltajeContinuo(),
      kRutaLeyesDeKirchhoffCircuitoRC: (context) =>
          LeyesDeKirchhoffCircuitoRC(),
      kRutaMenuMagnetostatica: (context) => MenuMagnetostatica(),
      kRutaOrigenDeCampoMagnetico: (context) => OrigenDeCampoMagnetico(),
      kRutaFuerzaMagneticaComoVectorSobreCargasEnMovimiento: (context) =>
          FuerzaMagneticaComoVectorSobreCargasEnMovimiento(),
      kRutaDefinicionDeCampoMagnetico: (context) =>
          DefinicionDeCampoMagnetico(),
      kRutaFuerzaDeLorentz: (context) => FuerzaDeLorentz(),
      kRutaLeyDeBiotSavart: (context) => LeyDeBiotSavart(),
      kRutaSegmentoConductorRecto: (context) => SegmentoConductorRecto(),
      kRutaEspiraEnFormaDeCircunferencia: (context) =>
          EspiraEnFormaDeCircunferencia(),

      kRutaEspiraCuadrada: (context) => EspiraCuadrada(),
      kRutaBobina: (context) => Bobina(),
      kRutaSolenoide: (context) => Solenoide(),
      kRutaCirculacionDeUnCampoVectorial: (context) =>
          CirculacionDeUnCampoVectorial(),
      kRutaCampoMagneticoAPartirDeLeyDeAmpere: (context) =>
          CampoMagneticoAPartirDeLeyDeAmpere(),
      kRutaLeyDeAmpereEnFormaDiferencial: (context) =>
          LeyDeAmpereEnFormaDiferencial(),
      kRutaNomenclaturaBasicaEmpleadaEnCircuitos: (context) =>
          NomenclaturaBasicaEmpleadaEnCircuitos(),
      kRutaFlujoMagnetico: (context) => FlujoMagnetico(),
      kRutaMotorDeCorrienteDirecta: (context) => MotorDeCorrienteDirecta(),
      kRutaGeneradorHomopolar: (context) => GeneradorHomopolar(),
      kRutaInductanciaPropia: (context) => InductanciaPropia(),
      kRutaInductanciaMutua: (context) => InductanciaMutua(),
      kRutaMenuInduccionElectromagnetica: (context) =>
          MenuInduccionElectromagnetica(),
      kRutaInductanciaPropiaDeUnSolenoide: (context) =>
          InductanciaPropiaDeUnSolenoide(),
      kRutaInductanciaParaUnToroide: (context) => InductanciaParaUnToroide(),
      kRutaInductanciaMutuaEntreDosSolenoidesCoaxiales: (context) =>
          InductanciaMutuaEntreDosSolenoidesCoaxiales(),
      kRutaLeyDeInduccionDeFaraday: (context) =>
          LeyDeInduccionDeFaradayEnergiaEnUnInductor(),
      kRutaEnergiaAlmacenadaEnUnCampoMagnetico: (context) =>
          EnergiaAlmacenadaEnUnCampoMagnetico(),
      kRutaInductor: (context) => Inductor(),
      kRutaInductorEnSerie: (context) => InductoresEnSerie(),
      kRutaPortadoresDeCargaLibre: (context) => PortadoresDeCargaLibre(),
      kRutaMovimientoDePortadoresDeCargaLibre: (context) =>
          MovimientoDePortadoresDeCargaLibreYDensidadDeCorriente(),
      kRutaDensidadDeCorrienteYCorrienteElectrica: (context) =>
          DensidadDeCorrienteYCorrienteElectrica(),
      kRutaTiposDeCorrienteElectrica: (context) => TiposDeCorrienteElectrica(),

      //Probabilidad y Estadistica

      kRutaCombinacionesYPermutaciones: (context) =>
          CombinacionesYPermutaciones(),
      kRutaCuantilesParaDatosAgrupados: (context) =>
          CuantilesParaDatosAgrupados(),
      kRutaEstadisticaInferencial: (context) => EstadisticaInferencial(),
      kRutaIntervalosDeConfianza: (context) => IntervalosDeConfianza(),
      kRutaMediaGeometrica: (context) => MediaGeometrica(),
      kRutaMenuProbabilidadYEstadistica: (context) =>
          MenuProbabilidadYEstadistica(),
      kRutaMomentosEstadisticos: (context) => MomentosEstadisticos(),
      kRutaProbabilidad: (context) => Probabilidad(),
      kRutaTamanioMuestral: (context) => TamanioMuestral(),
      //Distribuciones

      kRutaDistribucionBinomial: (context) => DistribucionBinomial(),
      kRutaDistribucionDePoisson: (context) => DistribucionDePoisson(),
      kRutaDistribucionExponencial: (context) => DistribucionExponencial(),
      kRutaDistribucionGeometrica: (context) => DistribucionGeometrica(),
      kRutaDistribucionHipergeometrica: (context) =>
          DistribucionHipergeometrica(),
      kRutaDistribucionNormal: (context) => DistribucionNormal(),
      kRutaDistribucionTDeStudent: (context) => DistribucionTDeStudent(),
      kRutaMenuDistribuciones: (context) => MenuDistribuciones(),
      //Medidas

      kRutaMedidasDeDispersionParaDatosNoAgrupados: (context) =>
          MedidasDeDispersionParaDatosNoAgrupados(),
      kRutaMedidasDePosicionParaDatosNoAgrupados: (context) =>
          MedidasDePosicionParaDatosNoAgrupados(),
      kRutaMedidasDeTendenciaCentralParaDatosAgrupados: (context) =>
          MedidasDeTendenciaCentralParaDatosAgrupados(),
      kRutaMedidasDeTendenciaCentralParaDatosNoAgrupados: (context) =>
          MedidasDeTendenciaCentralParaDatosNoAgrupados(),
      kRutaMenuMedidas: (context) => MenuMedidas(),

      //Series de Fourier

      kRutaConvolucion: (context) => Convolucion(),
      kRutaFormaComplejaDeLasSeriesDeFourier: (context) =>
          FormaComplejaDeLasSeriesDeFourier(),
      kRutaFormulasOperacionalesDeLaTransformadaDeLaplace: (context) =>
          FormulasOperacionalesDeLaTransformadaDeLaplace(),
      kRutaFuncionImpulsoUnitario: (context) => FuncionImpulsoUnitario(),
      kRutaFuncionUnitariaDeHeaviside: (context) =>
          FuncionUnitariaDeHeaviside(),
      kRutaMenuSeriesDeFourier: (context) => MenuSeriesDeFourier(),
      kRutaSerieYCoeficientesDeFourier: (context) =>
          SerieYCoeficientesDeFourier(),
      //Simetrias

      kRutaSimetriaDeMediaOnda: (context) => SimetriaDeMediaOnda(),
      kRutaSimetriaDeUnCuartoDeOndaImpar: (context) =>
          SimetriaDeUnCuartoDeOndaImpar(),
      kRutaMenuSimetrias: (context) => MenuSimetrias(),
      kRutaSimetriaDeUnCuartoDeOndaPar: (context) =>
          SimetriaDeUnCuartoDeOndaPar(),
      kRutaSimetriaImpar: (context) => SimetriaImpar(),
      kRutaSimetriaPar: (context) => SimetriaPar(),
      //Transformadas

      kRutaMenuTransformadas: (context) => MenuTransformadas(),
      kRutaTransformadaDeFourier: (context) => TransformadaDeFourier(),
      kRutaTransformadaDeLaplace: (context) => TransformadaDeLaplace(),
      kRutaTransformadaSenoYCosenoDeFourier: (context) =>
          TransformadaSenoYCosenoDeFourier(),
      kRutaTransformadasBasicasDeFourier: (context) =>
          TransformadasBasicasDeFourier(),
      kRutaTransformadasDeFourier: (context) => TransformadasDeFourier(),
      kRutaTransformadasDeLaplace: (context) => TransformadasDeLaplace(),

      //Trigonometria
      kRutaFuncionesTrigonometricas: (context) => FuncionesTrigonometricas(),
      kRutaFuncionesTrigonometricasDeAngulosNotables: (context) =>
          FuncionesTrigonometricasDeAngulosNotables(),
      kRutaLeyDeProyecciones: (context) => LeyDeProyecciones(),
      kRutaLeyesDeSenosCosenosTangentes: (context) =>
          LeyesDeSenosCosenosTangentes(),
      kRutaMedicionYClasificacionDeAngulos: (context) =>
          MedicionYClasificacionDeAngulos(),
      kRutaMenuTrigonometria: (context) => MenuTrigonometria(),
      kRutaSuperficieDeUnTrianguloYUnPoligonoEsferico: (context) =>
          SuperficieDeUnTrianguloYUnPoligonoEsferico(),
      kRutaTeoremaDePitagoras: (context) => TeoremaDePitagoras(),
      kRutaValoresDeSenoYCoseno: (context) => ValoresDeSenoYCoseno(),

      //Formulas de Bessel
      kRutaMenuFormulasBessel: (context) => MenuFormulasBessel(),
      kRutaTeoremaDelCosenoParaAngulos: (context) =>
          TeoremaDelCosenoParaAngulos(),
      kRutaTeoremaDeLaCotangente: (context) => TeoremaDeLaCotangente(),
      kRutaTeoremaDelCosenoParaLados: (context) => TeoremaDelCosenoParaLados(),
      kRutaTeoremaDelSeno: (context) => TeoremaDelSeno(),

      //Identidades Trigonometricas
      kRutaIdentidadesTrigonometricasDeAnguloDobleYMedio: (context) =>
          IdentidadesTrigonometricasDeAnguloDobleYMedio(),
      kRutaIdentidadesTrigonometricasDeSumaAProductoYViceversa: (context) =>
          IdentidadesTrigonometricasDeSumaAProductoYViceversa(),
      kRutaIdentidadesTrigonometricasDeSumaYRestaDeAngulos: (context) =>
          IdentidadesTrigonometricasDeSumaYRestaDeAngulos(),
      kRutaIdentidadesTrigonometricasExtras: (context) =>
          IdentidadesTrigonometricasExtras(),
      kRutaIdentidadesTrigonometricasFundamentales: (context) =>
          IdentidadesTrigonometricasFundamentales(),
      kRutaMenuIdentidadesTrigonometricas: (context) =>
          MenuIdentidadesTrigonometricas(),

      //Trigonometria Esferica
      kRutaAnalogiasDeGaussDelambre: (context) => AnalogiasDeGaussDelambre(),
      kRutaAnalogiasDeNeper: (context) => AnalogiasDeNeper(),
      kRutaFuncionesDelAnguloMitad: (context) => FuncionesDelAnguloMitad(),
      kRutaMenuTrigonometriaEsferica: (context) => MenuTrigonometriaEsferica(),

      //Matemáticas Discretas
      kRutaBicondicional: (context) => BicondicionalMatematicasDiscretas(),
      kRutaCondicional: (context) => CondicionalMatematicasDiscretas(),
      kRutaConectoresLogicos: (context) => ConectoresLogicos(),
      kRutaConjuncion: (context) => ConjuncionMatematicasDiscretas(),
      kRutaDisyuncion: (context) => DisyuncionMatematicasDiscretas(),
      kRutaLeyesDeLaLogicaProposicional: (context) =>
          LeyesDeLaLogicaProposicional(),
      kRutaLeyesDeLaTeoriaDeConjuntos: (context) =>
          LeyesDeLaTeoriaDeConjuntos(),
      kRutaLeyesDelAlgebraDeBoole: (context) => LeyesDelAlgebraDeBoole(),
      kRutaNegacion: (context) => Negacion(),
      kRutaMenuMatematicasDiscretas: (context) => MenuMatematicasDiscretas(),

      //Matematicas Financieras
      kRutaAmortizacion: (context) => Amortizacion(),
      kRutaAnualidadAnticipadaSimpleYCierta: (context) =>
          AnualidadAnticipadaSimpleYCierta(),
      kRutaAnualidadVencidaSimpleYCierta: (context) =>
          AnualidadVencidaSimpleYCierta(),
      kRutaDescuentoCompuesto: (context) => DescuentoCompuesto(),
      kRutaDescuentoSimple: (context) => DescuentoSimple(),
      kRutaInteresCompuesto: (context) => InteresCompuesto(),
      kRutaInteresSimple: (context) => InteresSimple(),
      kRutaMenuMatematicasFinancieras: (context) =>
          MenuMatematicasFinancieras(),
      kRutaSaldoInsoluto: (context) => SaldoInsoluto(),
      kRutaTasaDeInteresGlobal: (context) => TasaDeInteresGlobal(),
      kRutaTasaEfectiva: (context) => TasaEfectiva(),

      //Geometria
      kRutaAreaYPerimetroDeCuadrilateros: (context) =>
          AreaYPerimetroDeCuadrilateros(),
      kRutaAreaYPerimetroDeTriangulos: (context) =>
          AreaYPerimetroDeTriangulos(),
      kRutaAreaYPerimetroDelCirculo: (context) => AreaYPerimetroDelCirculo(),
      kRutaMenuAreasGeometria: (context) => MenuAreasGeometria(),
      kRutaAngulosEnUnPoligono: (context) => AngulosEnUnPoligono(),
      kRutaCircunferencia: (context) => Circunferencia(),
      kRutaDistanciaDeUnPuntoAUnaRecta: (context) =>
          DistanciaDeUnPuntoAUnaRecta(),
      kRutaDistanciaEntreDosPuntos: (context) => DistanciaEntreDosPuntos(),
      kRutaEcuacionDeLaRecta: (context) => EcuacionDeLaRecta(),
      kRutaElipseConCentroDiferenteDelOrigen: (context) =>
          ElipseConCentroDiferenteDelOrigen(),
      kRutaElipseConCentroEnElOrigen: (context) => ElipseConCentroEnElOrigen(),
      kRutaHiperbola: (context) => Hiperbola(),
      kRutaMenuGeometria: (context) => MenuGeometria(),
      kRutaParabolaConVerticeDiferenteDelOrigen: (context) =>
          ParabolaConVerticeDiferenteDelOrigen(),
      kRutaParabolaConVerticeEnElOrigen: (context) =>
          ParabolaConVerticeEnElOrigen(),
      kRutaVolumenDeCuerposGeometricos: (context) =>
          VolumenDeCuerposGeometricos(),
      //Drawer
      kRutaInformacion: (context) => Informacion(),
      kRutaConfiguracion: (context) => Configuracion(),
    };
