import 'package:flutter/cupertino.dart';

import '../screens_personalizados/configuracion.dart';
import 'export_constantes.dart';

Map<String, Map<String, String>> urlPdfMap = {
  //todo cambiar los url y ponerlos en otro archivo y aqui agregar solo constantes como con las imagenes
  kWidgetFormulaGeneral: {
    'es': 'https://capdesis.com/sistema/formulae/algebra/Formula%20general.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/FormulageneralI.pdf',
  },
  kWidgetEcuacionesLineales: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/Ecuaciones%20lineales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/EcuacioneslinealesI.pdf',
  },
  kWidgetFormulasDeProductos: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/Formula%20de%20productos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/FormuladeproductosI.pdf',
  },
  kWidgetFormulasDeFactorizacion: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/Formula%20de%20factorizacion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/FormuladefactorizacionI.pdf',
  },
  kWidgetOperacionesConFraccionesAlgebraicas: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/Operaciones%20con%20fracciones%20algebraicas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/OperacionesconfraccionesalgebraicasI.pdf',
  },
  kWidgetOperacionesPolinomios: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/Operaciones%20con%20polinomios.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/OperacionesconpolinomiosI.pdf',
  },
  kWidgetPropiedadesDeLosExponentes: {
    'es':
        'https://capdesis.com/sistema/formulae/generales/leyes_de_los_exponentes.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/PropiedadesDeLosExponentes.pdf',
  },
  kWidgetPropiedadesDesigualdad: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/Propiedades%20de%20la%20desigualdad.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/PropiedadesdeladesigualdadI.pdf',
  },
  kWidgetPropiedadesRadicales: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/Propiedades%20de%20los%20radicales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/PropiedadesdelosradicalesI.pdf',
  },
  kWidgetSerieDeTaylorYMaClaurin: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/Serie%20de%20Taylor%20y%20MaClaurin.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/SeriedeTayloryMaClaurinI.pdf',
  },
  kWidgetTeoremaDeSumatorias: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/Teorema%20de%20la%20sumatoria.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/TeoremadelasumatoriaI.pdf',
  },
  kWidgetConjugadoDeUnNumeroComplejo: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/NumerosComplejos/Conjugado%20de%20un%20numero%20complejo.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/NumerosComplejos/ConjugadodeunnumerocomplejoI.pdf',
  },
  kWidgetModuloYArgumentoDeUnNumeroComplejo: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/NumerosComplejos/Modulo%20y%20argumento%20de%20un%20numero%20complejo.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/NumerosComplejos/ModuloyargumentodeunnumerocomplejoI.pdf',
  },
  kWidgetOperacionesDeNumerosComplejos: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/NumerosComplejos/Operaciones%20de%20numeros%20complejos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/NumerosComplejos/OperacionesdenumcomplejoI.pdf',
  },
  kWidgetPropiedadesNumerosComplejos: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/NumerosComplejos/propiedades%20de%20los%20numeros%20complejos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/NumerosComplejos/propiedadesdelosnumeroscomplejosI.pdf',
  },
  kWidgetRepresentacionesDeUnNumeroComplejo: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra/NumerosComplejos/Representaciones%20de%20un%20numero%20complejo.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra/NumerosComplejos/RepresentacionesdeunnumerocomplejoI.pdf',
  },
  kWidgetDeterminantesAlgebraLineal: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Determinantes.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/DeterminantesIngles.pdf',
  },
  kWidgetPuntoMedioEntreDosPuntos: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Punto_Medio_Entre_Dos_Puntos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/PuntoMedioEntreDosPuntosIngles.pdf',
  },
  kWidgetReglaDeCramer: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Regla_de_Cramer.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/RegladeCramerIngles.pdf',
  },
  kWidgetReglaDeSarrus: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Regla_de_Sarrus.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/RegladeSarrusIngles.pdf',
  },
  kWidgetMatrizAdjunta: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Matriz_Adjunta.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/MatrizAdjuntaIngles.pdf',
  },
  kWidgetMatrizidentidad: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Matriz_Identidad.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/MatrizIdentidadIngles.pdf',
  },
  kWidgetMatrizInversa: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Matriz_Inversa.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/MatrizInversaIngles.pdf',
  },
  kWidgetMatrizOrtogonal: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Matriz_Ortogonal.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/MatrizOrtogonalIngles.pdf',
  },
  kWidgetMatrizSimetrica: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Matriz_Simetrica.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/MatrizSimetricaIngles.pdf',
  },
  kWidgetMatrizTranspuesta: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Matriz_Transpuesta.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/MatrizTranspuestaIngles.pdf',
  },
  kWidgetMatrizTriangular: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Matriz_Triangular.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/MatrizTriangularIngles.pdf',
  },
  kWidgetMultiplicacionDeMatrices: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Multiplicacion_de_Matrices.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/MultiplicaciondeMatricesIngles.pdf',
  },
  kWidgetPropiedadesDeLasMatrices: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Propiedades_de_las_Matrices.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/PropiedadesdelasMatricesingles.pdf',
  },
  kWidgetSumaRestaDeMatrices: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Matrices/Suma_y%20_Resta_de_Matrices.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Matrices/SumayRestadeMatricesIngles.pdf',
  },
  kWidgetAnguloEntreVectores: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Vectores/Angulo_entre_Vectores.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Vectores/AnguloentreVectoresI.pdf',
  },
  kWidgetNormalizacion: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Vectores/Normalizacion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Vectores/NormalizacionI.pdf',
  },
  kWidgetOperacionesConVectores: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Vectores/Operaciones_con_Vectores.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Vectores/OperacionesconVectoresI.pdf',
  },
  kWidgetProductoCruz: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Vectores/Producto_Cruz.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Vectores/ProductoCruzI.pdf',
  },
  kWidgetProductoPunto: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Vectores/Producto_Punto.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Vectores/ProductoPuntoI.pdf',
  },
  kWidgetPropiedadesDeLosVectores: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Vectores/Propiedades_de_los_Vectores.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Vectores/PropiedadesdelosVectoresI.pdf',
  },
  kWidgetProyeccionesDeVectores: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Vectores/Proyecciones_de_Vectores.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Vectores/ProyeccionesdeVectoresI.pdf',
  },
  kWidgetVectorUnitario: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Vectores/Vector_Unitario.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Vectores/VectorUnitarioI.pdf',
  },
  kWidgetVectoresYSuMagnitud: {
    'es':
        'https://capdesis.com/sistema/formulae/algebra_lineal/Vectores/Vectores_y_su_Magnitud.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/algebra_lineal/Vectores/VectoresysuMagnitudI.pdf',
  },
  kWidgetDerivacionBasicaDiferencial: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_diferencial/Reglas%20B%c3%a1sicas%20de%20Derivaci%c3%b3n%20uPrima.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_diferencial/ReglasBasicasDeDerivacionI.pdf',
  },
  kWidgetExponencialLogaritmos: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_diferencial/Derivadas%20de%20Funciones%20Exponencial%20y%20Logaritmos%20uPrima.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_diferencial/ExponencialyLogaritmosI.pdf',
  },
  kWidgetFuncionesTrigonometricasDiferencial: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_diferencial/Derivadas%20de%20Funciones%20Trigonometricas%20uPrima.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_diferencial/FuncionesTrigonometricas.pdf',
  },
  kWidgetFuncionesTrigonometricasInversasDiferencial: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_diferencial/Derivadas%20de%20Funciones%20Trigonometricas%20Inversas%20uPrima.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_diferencial/TrigonometricasInversasUPrimaI.pdf',
  },
  kWidgetFuncionesHiperbolicas: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_diferencial/Derivadas%20de%20Funciones%20Trigonometricas%20Hiperbolicas%20uPrima.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_diferencial/TrigonometricasHiperbolasUPrimaI.pdf',
  },
  kWidgetLimitesTrigonometricos: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_diferencial/limites/LimitesTrigonometricos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_diferencial/limites/LimitesTrigonometricosI.pdf',
  },
  kWidgetPropiedadesLimites: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_diferencial/limites/PropiedadesDeLosLimites.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_diferencial/limites/PropiedadesDeLosLimitesI.pdf',
  },
  kWidgetExponencialLogaritmoIntegral: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_integral/Integrales%20del%20Exponencial%20y%20Logaritmos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_integral/IntegralesExponencialyLogaritmosI.pdf',
  },
  kWidgetFuncionesHiperbolicasIntegral: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_integral/Integrales%20de%20Funciones%20Trigonometricas%20Hiperbolicas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_integral/TrigonometricasHiperbolicasI.pdf',
  },
  kWidgetFuncionesTrigonometricasIntegral: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_integral/Integrales%20de%20Funciones%20Trigonometricas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_integral/FuncionesTrigonometricasI.pdf',
  },
  kWidgetIntegracionBasica: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_integral/Integrales%20B%c3%a1sicas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_integral/IntegralesBasicasI.pdf',
  },
  kWidgetIntegralesExtrasIntegral: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_integral/Integrales%20Extras.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_integral/IntegralesExtras.pdf',
  },
  kWidgetTrigonometricasInversasIntegral: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_integral/Integrales%20de%20Funciones%20Trigonometricas%20Inversas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_integral/TrigonometricasInversasI.pdf',
  },
  kWidgetAreaBajoLaCurva: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/AreaBajoLaCurva.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/AreaBajoLaCurvaI.pdf',
  },
  kWidgetAreaDeUnaSuperficieDeRevolucion: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/AreaDeUnaSuperficieDeRevolucion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/AreaDeUnaSuperficieDeRevolucionI.pdf',
  },
  kWidgetCambioDeVariables: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/CambioDeVariables.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/CambioDeVariablesI.pdf',
  },
  kWidgetDerivadasDireccionales: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/DerivadasDireccionales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/DerivadasDireccionalesI.pdf',
  },
  kWidgetDerivadasParciales: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/DerivadasParciales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/DerivadasParcialesI.pdf',
  },
  kWidgetDiferencialTotal: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/DiferencialTotal.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/DiferencialTotalI.pdf',
  },
  kWidgetGradienteDeUnaFuncion: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/GradienteDeUnaFuncion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/GradienteDeUnaFuncionI.pdf',
  },
  kWidgetIdentidadesVectoriales: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/IdentidadesVectoriales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/IdentidadesVectorialesI.pdf',
  },
  kWidgetIntegralEnCoordenasCilindricas: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/IntegralDeCoordenadasCilindricas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/IntegralDeCoordenadasCilindricasI.pdf',
  },
  kWidgetIntegralesDeLinea: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/IntegralesDeLinea.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/IntegralesDeLineaI.pdf',
  },
  kWidgetLongitudDeArco: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/LongitudDeArco.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/LongitudDeArcoI.pdf',
  },
  kWidgetOperadoresDiferenciales: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/OperadoresDiferenciales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/OperadoresDiferencialesI.pdf',
  },
  kWidgetTeoremaDeFubini: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/TeoremaDeFubini.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/TeoremaDeFubiniI.pdf',
  },
  kWidgetTeoremaIntegrales: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/TeoremaIntegrales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/TeoremaIntegralesi.pdf',
  },
  kWidgetDerivadaFuncionesVectoriales: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/funciones_vectoriales/DerivadaFuncionesVectoriales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/funciones_vectoriales/DerivadaFuncionesVectorialesI.pdf',
  },
  kWidgetLimiteDerivadaIntegralFuncionesVectoriales: {
    'es':
        'https://capdesis.com/sistema/formulae/calculo_multivariable/funciones_vectoriales/LimiteDerivadaEIntegral.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/calculo_multivariable/funciones_vectoriales/LimiteDerivadaEIntegralI.pdf',
  },
  kWidgetConstantesDeIntegracion: {
    'es':
        'https://capdesis.com/sistema/formulae/ecuaciones_diferenciales/Constante_de_integracion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/ecuaciones_diferenciales/ConstantedeintegracionI.pdf',
  },
  kWidgetEcuacionDiferencialConCoeficientesConstantes: {
    'es':
        'https://capdesis.com/sistema/formulae/ecuaciones_diferenciales/Ecuacion_diferencial_con_coeficientes_constantes.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/ecuaciones_diferenciales/EcuaciondiferencialconcoeficientesconstantesI.pdf',
  },
  kWidgetEcuacionDiferencialDeRectasNoParalelas: {
    'es':
        'https://capdesis.com/sistema/formulae/ecuaciones_diferenciales/Rectas_No_Paralelas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/ecuaciones_diferenciales/RectasNoParalelasI.pdf',
  },
  kWidgetEcuacionDiferencialDeRectasParalelas: {
    'es':
        'https://capdesis.com/sistema/formulae/ecuaciones_diferenciales/Rectas_Paralelas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/ecuaciones_diferenciales/RectasParalelasI.pdf',
  },
  kWidgetEcuacionDiferencialExacta: {
    'es':
        'https://capdesis.com/sistema/formulae/ecuaciones_diferenciales/Diferencial_total_de_una%20_funcion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/ecuaciones_diferenciales/DiferencialtotaldeunafuncionI.pdf',
  },
  kWidgetEcuacionDiferencialHomogenea: {
    'es':
        'https://capdesis.com/sistema/formulae/ecuaciones_diferenciales/Ecuacion_Diferencail_homogenea.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/ecuaciones_diferenciales/EcuacionDiferencailhomogeneaI.pdf',
  },
  kWidgetEcuacionDiferencialLinealDeOrdenSuperior: {
    'es':
        'https://capdesis.com/sistema/formulae/ecuaciones_diferenciales/Ecuacion_Diferencial_lineal_de_orden_superior.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/ecuaciones_diferenciales/EcuacionDiferencallinealdeordensuperiorI.pdf',
  },
  kWidgetEcuacionDiferencialLinealDePrimerOrden: {
    'es':
        'https://capdesis.com/sistema/formulae/ecuaciones_diferenciales/Ecuacion_Diferencial_lineal_de_primer_orden%20.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/ecuaciones_diferenciales/EcuacionDiferencallinealdeprimerordenI.pdf',
  },
  kWidgetEcuacionDiferencialSeparable: {
    'es':
        'https://capdesis.com/sistema/formulae/ecuaciones_diferenciales/Ecuacion_Diferencial_Separable.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/ecuaciones_diferenciales/EcuacionDiferenciallinealSeparableI.pdf',
  },
  //Electricidad y magnetismo
  //todo hacer pdf de electricidad y magnetismo
  kWidgetCalculoDeDiferenciasDePotencial: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/calculo_de_diferencias_de_potencial.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/calculo_de_diferencias_de_potencial.pdf',
  },
  kWidgetCampoElectrico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/campo_electrico.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/Campo_electrico.pdf',
  },
  kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/campo_electrico_originado_por_distribuciones_de_carga.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/Campo_electrico_originado_por_distribuciones_de_carga.pdf',
  },
  kWidgetCargaElectrica: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/carga_electrica.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/Carga_electrica.pdf',
  },
  kWidgetCargaProtonyElectron: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/carga_electrica_del_proton_y_el_electron.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/Carga_electrica_protones_electrones.pdf',
  },
  kWidgetCirculacionDelCampoElectrostatico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/circulacion_del_campo_electrostatico.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/circulacion_del_campo_electrostatico.pdf',
  },
  kWidgetDistribucionesDeCargaElectrica: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/distribuciones_de_carga_electrica.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/distribuciones_carga_electrica.pdf',
  },
  kWidgetEcuacionDePossionYLaplace: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/ecuacion_de_poisson_y_laplace.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/ecuacion_de_poisson_y_laplace.pdf',
  },
  kWidgetElectricidad: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/electricidad.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/Electricidad.pdf',
  },
  kWidgetEnergiaPotencialElectrica: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/energia_potencial_electrica.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/energia_potencial_electrica.pdf',
  },
  kWidgetFlujoElectricoDeUnCampoVectorial: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/flujo_electrico_de_un_campo_vectorial.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/Flujo_electrico_de_un_campo_vectorial.pdf',
  },
  kWidgetGradienteDePotencialElectrico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/gradiente_de_potencial_electrico.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/gradiente_de_potencial_electrico.pdf',
  },
  kWidgetGradienteDeUnaFuncionEscalar: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/gradiente_de_una_funcion_escalar.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/gradiente_de_una_funcion_escalar.pdf',
  },
  kWidgetLeyDeCoulomb: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/ley_de_coulomb.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/Ley_Coulomb.pdf',
  },
  kWidgetLeyDeGauss: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/ley_de_gauss.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/ley_de_gauss.pdf',
  },
  kWidgetLeyDeGaussEnFormaDiferencial: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/ley_de_gauss_en_forma_diferencial.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/ley_de_gauss_en_forma_diferencial.pdf',
  },
  kWidgetOperadorGradiente: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/operador_gradiente.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/operador_gradiente.pdf',
  },
  kWidgetPrincipioDeSuperposicion: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/principio_de_superposicion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/Principio_superposicion.pdf',
  },
  kWidgetRotacionalDelCampoElectrostatico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/rotacional_del_campo_electrostatico.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/rotacional_del_campo_electrostatico.pdf',
  },
  kWidgetSuperficiesEquipotenciales: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/superficies_equipotenciales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/superficies_equipotenciales.pdf',
  },
  kWidgetTeoremaDeLaDivergencia: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/teorema_de_la_divergencia.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/teorema_de_la_divergencia.pdf',
  },
  kWidgetTeoremaDelRotacional: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/campo_y_potencial_electricos/teorema_del_rotacional.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/campo_y_potencial_electrico/teorema_del_rotacional.pdf',
  },
  kWidgetCapacitor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/capacitor.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/capacitancia_y_dielectricos/capacitor.pdf',
  },
  kWidgetCapacitorDePlacasPlanasYParalelas: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/capacitor_de_placas_planas_y_paralelas.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetCargaDeUnCapacitor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/carga_de_un_capacitor.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/capacitancia_y_dielectricos/carga_de_un_capacitor.pdf',
  },
  kWidgetConexionEnParaleloCapacitor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/conexion_en_paralelo.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetConexionEnSerieCapacitor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/conexion_en_serie.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetConstantesDielectricas: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/constantes_dielectricas.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetDefinicionDeCapacitancia: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/definicion_de_capacitancia.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/capacitancia_y_dielectricos/definicion_capacitancia.pdf',
  },
  kWidgetEnergiaAlmacenadaPorUnCapacitor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/energia_almacenada_por_un_capacitor.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetEnergiaYCapacitancia: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/energia_y_capacitancia.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetGraficaDeCapacitancia: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/grafica_de_capacitancia.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/electricidad_y_magnetismo/capacitancia_y_dielectricos/grafica_de_capacitancia.pdf',
  },
  kWidgetPolarizacion: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/polarizacion.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetPolarizacionYCargaInducida: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/polarizacion_y_carga_inducida.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetRepresentacionDeLosVectoresElectricos: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/representacion_de_los_vectores_electricos.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetRigidezDielectrica: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/rigidez_dielectrica.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetSimbologiaCapacitores: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/simbologia_capacitores.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetVectorDeDesplazamientoElectrico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/capacitancia_y_dielectricos/vector_de_desplazamiento_electrico.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetCircuitoRCyVoltajeContinuo: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/circuito_rc_y_voltaje_continuo.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetConductividadyResistividad: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/conductividad_y_resistividad.pdf',
    'en': kPdfNoDisponibleIngles,
  },

  kWidgetConexionEnParaleloResistor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/resistor_conexion_en_paralelo.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetConexionEnSerieResistor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/resistor_conexion_en_serie.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetDensidadDeCorrienteYCorrienteElectrica: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/densidad_de_corriente_y_corriente_electrica.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetEcuacionDeOhm: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/ecuacion_de_ohm.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetEfectoJoule: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/efecto_joule.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetElementosCapacitorYResistor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/elementos_capacitor_y_resistor.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetElementosFem: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/elementos_fem.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetFuenteDeFuerzaElectromotriz: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/fuente_de_fuerza_electromotriz.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetLeyDeCorrienteDeKirchhoff: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/ley_de_corrientes_de_kichhoff.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetLeyDeOhm: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/ley_de_ohm.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetLeyDeVoltajesDeKirchhoff: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/ley_de_voltajes_de_kichhoff.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetLeyesDeKirchhoffCircuitoRc: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/leyes_de_kirchhoff_circuito_rc.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetMovimientoDePortadoresDeCargaLibreYDensidadDeCorriente: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/movimiento_de_portadores_de_carga_libre_y_densidad_de_corriente.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetNomenclaturaBasicaEmpleadaEnCircuitos: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/nomenclatura_basica_empleada_en_circuitos_electricos.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetPortadoresDeCargaLibre: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/portadores_de_carga_libre.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetReglasParaLVKyLCK: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/reglas_para_lvk_y_lck.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetResistividadYTemperatura: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/resistividad_y_temperatura.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetResistorLinealYNoLineal: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/resistor_lineal_y_no_lineal.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetResistorSimbologiaBasica: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/resistor_simbologia_basica.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetTeoriaDeCircuitos: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/teoria_de_circuitos.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetTiposDeCorrienteElectrica: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/circuitos_electricos/tipos_de_corriente_electrica.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetEnergiaAlmacenadaEnUnCampoMagnetico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/energia_almacenada_en_un_campo_magnetico.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetInductanciaMutua: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_mutua.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetInductanciaMutuaEntreDosSolenoidesCoaxiales: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_mutua_entre_dos_solenoides_coaxiales.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetInductanciaParaUnToroide: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_para_un_toroide.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetInductanciaPropia: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_propia.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetInductanciaPropiaDeUnSolenoide: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_propia_de_un_solenoide.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetInductor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/inductor.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetInductoresEnSerie: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/inductores_en_serie.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetLeyDeFaradayYEnergiaEnUnInductor: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/ley_de_faraday_y_energia_en_un_inductor.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetPrincipioDeOperacionDelGeneradorElectrico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/induccion_electromagnetica/principio_de_operacion_del_generador_electrico.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetBobina: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/bobina.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetCampoMagneticoAPartirDeLeyDeAmpere: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/campo_magnetico_a_partir_de_ley_de_amper.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetCirculacionDeUnCampoVectorial: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/circulacion_de_un_campo_vectorial.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetDefinicionDeCampoMagnetico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/definicion_de_campo_magnetico.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetEspiraCuadrada: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/espira_cuadrada.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetEspiraEnFormaDeCircunferencia: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/espira_en_forma_de_circunferencia.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetFlujoMagnetico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/flujo_magnetico.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetFuerzaDeLorentz: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/fuerza_de_lorentz.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetFuerzaMagneticaComoVectorSobreCargasEnMovimiento: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/fuerza_magnetica_como_vector_sobre_cargas_en_movimiento.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetLeyDeAmpereEnFormaDiferencial: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/ley_de_ampere_en_forma_diferencial_1.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetLeyDeBiotSavart: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/ley_de_biot_savart.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetMotorDeCorrienteDirecta: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/motor_de_corriente_directa.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetOrigenDeCampoMagnetico: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/origen_de_campo_magnetico.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetSegmentoConductoRecto: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/segmento_conductor_recto.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetSolenoide: {
    'es':
        'https://capdesis.com/sistema/formulae/electricidad_y_magnetismo/magnetostatica/solenoide.pdf',
    'en': kPdfNoDisponibleIngles,
  },
  kWidgetFuncionesTrigonometricasGeneral: {
    'es':
        'https://capdesis.com/sistema/formulae/generales/Funciones%20Trigonom%c3%a9tricas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/generales/FuncionesTrigonometricasI.pdf',
  },
  kWidgetIdentidadesHiperbolicasGenerales: {
    'es':
        'https://capdesis.com/sistema/formulae/generales/Identidades%20de%20Funciones%20Trigonom%c3%a9tricas%20Hiperb%c3%b3licas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/generales/IdentidadesdeFuncionesI.pdf',
  },
  kWidgetIdentidadesTrigonometricasGenerales: {
    'es':
        'https://capdesis.com/sistema/formulae/generales/Identidades%20Trigonom%c3%a9tricas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/generales/IdentidadesTrigonometricaI.pdf',
  },
  kWidgetPropiedadesLogaritmosGenerales: {
    'es':
        'https://capdesis.com/sistema/formulae/generales/Propiedades%20de%20los%20Logaritmos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/generales/PropiedadesDeLosLogaritmosI.pdf',
  },
  kWidgetTrigonometricasHiperbolicasGenerales: {
    'es':
        'https://capdesis.com/sistema/formulae/generales/Funciones%20Trigonom%c3%a9tricas%20Hiperb%c3%b3licas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/generales/FuncionesTrigonometricasHiperbolicasI.pdf',
  },
  kWidgetAngulosEnUnPoligono: {
    'es': 'https://capdesis.com/sistema/formulae/geometria/AnguloPoligono.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/AnguloPoligonoI.pdf',
  },
  kWidgetCircunferencia: {
    'es': 'https://capdesis.com/sistema/formulae/geometria/Circunferencia.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/CircunferenciaI.pdf',
  },
  kWidgetDistanciaDeUnPuntoAUnaRecta: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/DistanciaPuntoAUnaRecta.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/DistanciaPuntoAUnaRectaI.pdf',
  },
  kWidgetDistanciaEntreDosPuntos: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/DistanciaEntreDosPuntos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/DistanciaEntreDosPuntosI.pdf',
  },
  kWidgetEcuacionDeLaRecta: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/EcuacionDeLaRecta.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/EcuacionDeLaRectaI.pdf',
  },
  kWidgetElipseConCentroDiferenteDelOrigen: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/ElipseConCentroDiferenteDelOrigen.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/ElipseConCentroDiferenteDelOrigenI.pdf',
  },
  kWidgetElipseConCentroEnElOrigen: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/ElipseConCentroEnElOrigen.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/ElipseConCentroEnElOrigenI.pdf',
  },
  kWidgetHiperbola: {
    'es': 'https://capdesis.com/sistema/formulae/geometria/Hiperbola.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/HiperbolaI.pdf',
  },
  kWidgetParabolaConVerticeDiferenteDelOrigen: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/Parabolacon%20VerticeDiferente%20delOrigen.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/ParabolaconVerticeDiferentedelOrigenI.pdf',
  },
  kWidgetParabolaConVerticeEnElOrigen: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/Par%c3%a1bolaconV%c3%a9rticeenelOrigen.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/ParabolaconVerticeenelOrigenI.pdf',
  },
  //todo quedarme con solo un punto medio entre dos puntos
  /*
  kWidgetPuntoMedioEntreDosPuntos: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/PuntoMedioEntreDosPuntos.pdf',
    'en': '',
  },
   */
  kWidgetVolumenDeCuerposGeometricos: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/VolumenDeCuerposGeom%c3%a9tricos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/VolumenDeCuerposGeometricosI.pdf',
  },
  kWidgetAreaYPerimetroDeCuadrilateros: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/areas/AreaCuadrilateros.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/areas/AreaCuadrilaterosI.pdf',
  },
  kWidgetAreaYPerimetroDeTriangulos: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/areas/AreaTriangulos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/areas/AreaTriangulosI.pdf',
  },
  kWidgetAreaYPerimetroDelCirculo: {
    'es':
        'https://capdesis.com/sistema/formulae/geometria/areas/AreaCirculo.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/geometria/areas/AreaCirculoI.pdf',
  },
  kWidgetBicondicional: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_discretas/Bicondicional.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_discretas/BicondicionalI.pdf',
  },
  kWidgetCondicional: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_discretas/Condicional.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_discretas/CondicionalI.pdf',
  },
  kWidgetConectoresLogicos: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_discretas/Conectores_Logicos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_discretas/ConectoresLogicosI.pdf',
  },
  kWidgetConjuncion: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_discretas/Conjuncion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_discretas/ConjuncionI.pdf',
  },
  kWidgetDisyuncion: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_discretas/Disyuncion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_discretas/DisyuncionI.pdf',
  },
  kWidgetLeyesDeLaLogicaProposicional: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_discretas/Leyes_de_la_Logica_Poporsicional.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_discretas/LeyesdelaLogicaPoporsicionalI.pdf',
  },
  kWidgetLeyesDeLaTeoriaDeConjuntos: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_discretas/Leyes_de_la_Teoria_de_Conjuntos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_discretas/LeyesdelaTeoriadeConjuntosI.pdf',
  },
  kWidgetLeyesDelAlgebraDeBoole: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_discretas/Leyes_del_Algebra_de_Boole.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_discretas/LeyesdelAlgebradeBooleI.pdf',
  },
  kWidgetNegacion: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_discretas/Negacion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_discretas/NegacionI.pdf',
  },
  kWidgetAmortizacion: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Amortizacion.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/AmortizacionI.pdf',
  },
  kWidgetAnualidadAnticipadaSimpleyCierta: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Anualidad_Anticipada_Simple_y_Cierta.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/AnualidadAnticipadaSimpleyCiertaI.pdf',
  },
  kWidgetAnualidadVencidaSimpleyCierta: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Anualidad_Vencida_Simple_y_Cierta.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/AnualidadVencidaSimpleyCierta.pdf',
  },
  kWidgetDescuentoCompuesto: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Descuento_Compuesto.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/DescuentoCompuestoI.pdf',
  },
  kWidgetDescuentoSimple: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Descuento_Simple.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/DescuentoSimpleI.pdf',
  },
  kWidgetInteresCompuesto: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Interes_Compuesto.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/InteresCompuestoI.pdf',
  },
  kWidgetInteresSimple: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Interes_Simple.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/InteresSimpleI.pdf',
  },
  kWidgetSaldoInsoluto: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Saldo_Insoluto.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/SaldoInsolutoI.pdf',
  },
  kWidgetTasaDeInteresGlobal: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Tasa_de_Interes_Global.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/TasadeInteresGlobalI.pdf',
  },
  kWidgetTasaEfectiva: {
    'es':
        'https://capdesis.com/sistema/formulae/matematicas_financieras/Tasa_Efectiva.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/matematicas_financieras/TasaEfectivaI.pdf',
  },
  kWidgetCombinacionesYPermutaciones: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Combinaciones_y_Permutaciones.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/CombinacionesyPermutacionesI.pdf',
  },
  kWidgetCuantilesParaDatosAgrupados: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Cuantiles_para_Datos_Agrupados.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/CuantilesparaDatosAgrupadosI.pdf',
  },
  kWidgetEstadisticaInferencial: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Estadistica_Inferencial.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/EstadisticaInferencialI.pdf',
  },
  kWidgetIntervalosDeConfianza: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Intervalos_de_Confianza.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/IntervalosdeConfianzaI.pdf',
  },
  kWidgetMediaGeometrica: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Media_Geometrica.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/MediaGeometricaI.pdf',
  },
  kWidgetMomentosEstadisticos: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Momentos_Estadisticos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/MomentosEstadisticosI.pdf',
  },
  kWidgetProbabilidad: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Probabilidad.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/ProbabilidadI.pdf',
  },
  kWidgetTamanioMuestral: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Tama%c3%b1o_Muestral.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/TamanioMuestralI.pdf',
  },
  kWidgetDistribucionBinomial: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/distribuciones/Distribucion_Binominal.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/distribuciones/DistribucionBinominalI.pdf',
  },
  kWidgetDistribucionDePoisson: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/distribuciones/Distribucion%20_de_Poisson.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/distribuciones/DistribuciondePoissonI.pdf',
  },
  kWidgetDistribucionExponencial: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/distribuciones/Distribucion%20_Exponencial.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/distribuciones/DistribucionExponencialI.pdf',
  },
  kWidgetDistribucionGeometrica: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/distribuciones/Distribucion_Geometrica.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/distribuciones/DistribucionGeometricaI.pdf',
  },
  kWidgetDistribucionHipergeometrica: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/distribuciones/Distribucion_Hipergeometrica.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/distribuciones/DistribucionHipergeometricaI.pdf',
  },
  kWidgetDistribucionNormal: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/distribuciones/Distribucion_Normal.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/distribuciones/DistribucionNormalI.pdf',
  },
  kWidgetDistribucionTDeStudent: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/distribuciones/Distribucion_T_de_Student.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/distribuciones/DistribucionTdeStudentI.pdf',
  },
  kWidgetMedidasDeDispersionParaDatosNoAgrupados: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Medidas_de_Dispersion_para_Datos_no_Agrupados.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/MedidasdeDispersionparaDatosnoAgrupadosI.pdf',
  },
  kWidgetMedidasDePosicionParaDatosNoAgrupados: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Medidas_de_Posicion_para_Datos_No_Agrupados.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/MedidasdePosicionparaDatosNoAgrupadosI.pdf',
  },
  kWidgetMedidasDeTendenciaCentralParaDatosAgrupados: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Medidas_de_Tendencia_Central_para_Datos_Agrupados.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/MedidasdeTendenciaCentralparaDatosAgrupadosI.pdf',
  },
  kWidgetMedidasDeTendenciaCentralParaDatosNoAgrupados: {
    'es':
        'https://capdesis.com/sistema/formulae/probabilidad_y_estadistica/Medidas_de_Tendencia_Central_para_Datos%20_No_Agrupados.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/probabilidad_y_estadistica/MedidasdeTendenciaCentralparaDatosNoAgrupadosI.pdf',
  },
  kWidgetConvolucion: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/Convoluci%c3%b3n.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/ConvolucionI.pdf',
  },
  kWidgetFormaComplejaDeLasSeriesDeFourier: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/Forma_compleja.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/FormacomplejaI.pdf',
  },
  kWidgetFormulasOperacionalesDeLaTransformadaDeLaplace: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/Fórmulas_Operacionales_de_la_Transformada_de_Laplace.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/FormulasOperacionalesdelaTransformadadeLaplaceI.pdf',
  },
  kWidgetFuncionImpulsoUnitario: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/Funci%c3%b3n_Impulso_Unitario.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/FuncionImpulsoUnitarioI.pdf',
  },
  kWidgetFuncionUnitariaDeHeaviside: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/Funci%c3%b3n_Unitaria_de_Heaviside.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/FuncionUnitariadeHeaviside.pdf',
  },
  kWidgetSerieYCoeficientesDeFourier: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/Serie_y_Coeficientes_de_Fourier.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/SerieyCoeficientesdeFourierI.pdf',
  },
  kWidgetSimetriaDeMediaOnda: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/simetrias/Simetr%c3%ada_de_Media_Onda.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/simetrias/SimetriadeMediaOndaI.pdf',
  },
  kWidgetSimetriaDeUnCuartoDeOndaImpar: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/simetrias/Simetr%c3%ada_de_un_Cuarto_de_Onda%20_mpar.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/simetrias/SimetriadeunCuartodeOndaImparI.pdf',
  },
  kWidgetSimetriaDeUnCuartoDeOndaPar: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/simetrias/Simetr%c3%ada_de_un_Cuarto_de_Onda_Par.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/simetrias/SimetriadeunCuartodeOndaParI.pdf',
  },
  kWidgetSimetriaImpar: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/simetrias/Simetr%c3%ada_Impar.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/simetrias/SimetriaImparI.pdf',
  },
  kWidgetSimetriaPar: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/simetrias/Simetr%c3%ada_Par.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/simetrias/SimetriaParI.pdf',
  },
  kWidgetTransformadaDeFourier: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/transformadas/Transformada_de_Fourier.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/transformadas/TransformadadeFourierI.pdf',
  },
  kWidgetTransformadaDeLaplace: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/transformadas/Transformada_de_Laplace.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/transformadas/TransformadadeLaplaceI.pdf',
  },
  kWidgetTransformadaSenoYCosenoDeFourier: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/transformadas/Transformada_Seno_y_Coseno_de_Fourier.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/transformadas/TransformadaSenoyCosenodeFourierI.pdf',
  },
  kWidgetTransformadasBasicasDeFourier: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/transformadas/Transformadas_B%c3%a1sicas_de_Fourier.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/transformadas/TransformadasBasicasdeFourierI.pdf',
  },
  kWidgetTransformadasDeFourier: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/transformadas/Transformadas_de_Fourier.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/transformadas/TransformadasdeFourierI.pdf',
  },
  kWidgetTransformadasDeLaplace: {
    'es':
        'https://capdesis.com/sistema/formulae/series_fourier/transformadas/Transformadas_de_Laplace.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/series_fourier/transformadas/TransformadasdeLaplaceI.pdf',
  },
  kWidgetFuncionesTrigonometricasTrigonometria: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/FuncionesTrigonom%c3%a9tricas.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/FuncionesTrigonometricasI.pdf',
  },
  kWidgetFuncionesTrigonometricasDeAngulosNotables: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/FuncionesTrigonom%c3%a9tricasDe%c3%81ngulosNotables.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/FuncionesTrigonometricasDeAngulosNotablesI.pdf',
  },
  kWidgetLeyDeProyecciones: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/LeyDeProyecciones.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/LeyDeProyeccionesI.pdf',
  },
  kWidgetLeyesDeSenosCosenosTangentes: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/LeyesDeSenosCosenosyTangentes.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/LeyesDeSenosCosenosyTangentesI.pdf',
  },
  kWidgetMedicionYClasificacionDeAngulos: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/MedicionyClasificacionDeAngulos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/MedicionyClasificacionDeAngulosI.pdf',
  },
  kWidgetSuperficieDeUnTrianguloYUnPoligonoEsferico: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/SuperficieDeUnTri%c3%a1nguloyPoligonoEsf%c3%a9rico.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/SuperficieDeUnTrianguloyPoligonoEsfericoI.pdf',
  },
  kWidgetTeoremaDePitagoras: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/TeoremaDePit%c3%a1goras.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/TeoremaDePitagorasI.pdf',
  },
  kWidgetValoresDeSenoYCoseno: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/ValoresDelSenoyCoseno.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/ValoresDelSenoyCosenoI.pdf',
  },
  kWidgetTeoremaDeLaCotangente: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/TeoremaDeLaCotangente.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/TeoremaDeLaCotangenteI.pdf',
  },
  kWidgetTeoremaDelCosenoParaAngulos: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/TeoremaDelCosenoPara%c3%81ngulos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/TeoremaDelCosenoParaAngulosI.pdf',
  },
  kWidgetTeoremaDelCosenoParaLados: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/TeoremaDelCosenoParaLados.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/TeoremaDelCosenoParaLadosI.pdf',
  },
  kWidgetTeoremaDelSeno: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/TeoremaDelSeno.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/TeoremaDelSenoI.pdf',
  },
  kWidgetIdentidadesTrigonometricasDeAngulosDobleYMedio: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/identidades_trigonometricas/IdentidadesTrigonom%c3%a9tricasDeAnguloDobleMedio.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/identidades_trigonometricas/IdentidadesTrigonometricasDeAnguloDobleMedioI.pdf',
  },
  kWidgetIdentidadesTrigonometricasDeSumaAProductoYViceversa: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/identidades_trigonometricas/IdentidadesTrigonom%c3%a9tricasDeSumaAProducto.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/identidades_trigonometricas/IdentidadesTrigonometricasDeSumaAProductoI.pdf',
  },
  kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/identidades_trigonometricas/IdentidadesTrigonom%c3%a9tricasDeSumaYRestaDeAngulos.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/identidades_trigonometricas/IdentidadesTrigonometricasDeSumaYRestaDeAngulosI.pdf',
  },
  kWidgetIdentidadesTrigonometricasExtras: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/identidades_trigonometricas/IdentidadesTrigonom%c3%a9tricasExtras.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/identidades_trigonometricas/IdentidadesTrigonometricasExtrasI.pdf',
  },
  kWidgetIdentidadesTrigonometricasFundamentales: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/identidades_trigonometricas/IdentidadesTrigonom%c3%a9tricasFundamentales.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/identidades_trigonometricas/IdentidadesTrigonometricasFundamentalesI.pdf',
  },
  kWidgetAnalogiasDeGaussDelambre: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/trigonometria_esferica/Analog%c3%adasDeGaussDelambre.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/trigonometria_esferica/AnalogiasDeGaussDelambreI.pdf',
  },
  kWidgetAnalogiasDeNeper: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/trigonometria_esferica/Analog%c3%adasDeNeper.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/trigonometria_esferica/AnalogiasDeNeperI.pdf',
  },
  kWidgetFuncionesDelAnguloMitad: {
    'es':
        'https://capdesis.com/sistema/formulae/trigonometria/trigonometria_esferica/FuncionesDel%c3%81nguloMitad.pdf',
    'en':
        'https://capdesis.com/sistema/formulae_ingles/trigonometria/trigonometria_esferica/FuncionesDelAnguloMitadI.pdf',
  },
  kWidgetMejorarApp: {
    'es':
        'https://docs.google.com/forms/d/e/1FAIpQLSfBEsTqfWTMQ30lHn_MJflgrRnNrENgWnpBz8WLOIBh_h2zdw/viewform',
    'en': 'https://forms.gle/Duyf5WEYcwvepi368',
  },
};

String? getUrlPdfById(BuildContext context, String id) {
  Locale currentLocale =
      Provider.of<LocaleProvider>(context, listen: false).locale;
  return urlPdfMap[id]?[currentLocale.languageCode];
}
