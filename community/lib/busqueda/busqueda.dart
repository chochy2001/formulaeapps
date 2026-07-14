import 'package:flutter/material.dart';

import '../constantes/export_constantes.dart';

class Busqueda extends StatefulWidget {
  const Busqueda({super.key});

  @override
  State<Busqueda> createState() => _BusquedaState();
}

class _BusquedaState extends State<Busqueda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            /* Boton de Generales*/
            const SizedBox(height: 20),
            BotonesMenu(
              ruta: kRutaGenerales,
              textoBoton: AppLocalizations.of(context)!.generales,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            //Propiedades Logaritmos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.propiedadesLogaritmos,
              ruta: kRutaPropiedadesLogaritmos,
            ),
            //Funciones Trigonometricas
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.funcionesTrigonometricas,
              ruta: kRutaFuncionesTrigonometricasGenerales,
            ),
            //Identidades Trigonometricas
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.identidadesTrigonometricas,
              ruta: kRutaIdentidadesTrigonometricas,
            ),
            //Trigonometricas Hiperbolicas
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.trigonometricasHiperbolicas,
              ruta: kRutaTrigonometricasHiperbolicas,
            ),
            //Identidades Hiperbolicas
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.identidadesHiperbolicas,
              ruta: kRutaIdentidadesHiperbolicas,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            /*Boton de Algebra*/
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.algebra,
              ruta: kRutaMenuAlgebra,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            //SolucionEcuaciones
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.solucionEcuaciones,
              ruta: kRutaSolucionEcuaciones,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.ecuacionesDePrimerGrado,
              ruta: kRutaEcuacionesDePrimerGrado,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.ecuacionesDeSegundoGrado,
              ruta: kRutaEcuacionesDeSegundoGrado,
            ),
            //Ecuaciones Lineales
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.ecuacionesLineales,
              ruta: kRutaEcuacionesLineales,
            ),
            //Formula General
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.formulaGeneral,
              ruta: kRutaFormulaGeneral,
            ),
            //Formulas de Productos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.formulaProductos,
              ruta: kRutaFormulasDeProductos,
            ),
            //Formulas de Factorizacion
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.formulasFactorizacion,
              ruta: kRutaFormulasDeFactorizacion,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            //Numeros complejos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.numerosComplejos,
              ruta: kRutaNumerosComplejos,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            //Conjugados de numeros complejos
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.conjugadoDeUnNumeroComplejo,
              ruta: kRutaConjugadoNumerosComplejos,
            ),
            //Modulo y Argumento numeros complejos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .moduloYArgumentoDeUnNumeroComplejo,
              ruta: kRutaModuloyArgumentoNumerosComplejos,
            ),
            //Operaciones de Numeros complejos
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.operacionesDeNumerosComplejos,
              ruta: kRutaOperacionesNumerosComplejos,
            ),
            //Propiedades Números Complejos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .propiedadesDeLosNumerosComplejos,
              ruta: kRutaPropiedadesNumerosComplejos,
            ),
            //Representaciones de Numeros complejos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .representacionesDeUnNumeroComplejo,
              ruta: kRutaRepresentacionesDeNumerosComplejos,
            ),
            //Operaciones con Fracciones Algebraicas
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .operacionesFraccionesAlgebraicas,
              ruta: kRutaOperacionesFraccionesAlgebraicas,
            ),
            //Propiedades de los Exponentes
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.operacionesPolinomios,
              ruta: kRutaOperacionesConPolinomios,
            ),
            //Propiedades de las Desigualdades
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.propiedadesExponentes,
              ruta: kRutaPropiedadesDeLosExponentes,
            ),
            //Propiedades de los radicales
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.propiedadesDesigualdades,
              ruta: kRutaPropiedadesDesigualdad,
            ),
            //Serie taylor y MaClaurin
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.propiedadesRadicales,
              ruta: kRutaPropiedadesRadicales,
            ),
            //Serie de Taylor y MaClaurin
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.serieTaylorMaclaurin,
              ruta: kRutaSerieTaylorMaClaurin,
            ),
            //Teorema de la Sumatoria
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.teoremaSumatoria,
              ruta: kRutaTeoremaSumatorias,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            /*Boton de Algebra Lineal*/
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.algebraLineal,
              ruta: kRutaMenuAlgebra,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            //Ecuaciones Lineales
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.determinantes,
              ruta: kRutaDeterminantesAlgebraLineal,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            //Formulas de Productos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.matrices,
              ruta: kRutaMenuMatricesAlgebraLineal,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            //Ecuaciones Lineales
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.matrizAdjunta,
              ruta: kRutaMatrizAdjunta,
            ),
            //Formula General
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.matrizIdentidad,
              ruta: kRutaMatrizIdentidad,
            ),
            //Formulas de Productos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.matrizInversa,
              ruta: kRutaMatrizInversa,
            ),
            //Formulas de Factorizacion
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.matrizOrtogonal,
              ruta: kRutaMatrizOrtogonal,
            ),
            //Numeros complejos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.matrizSimetrica,
              ruta: kRutaMatrizSimetrica,
            ),
            //Operaciones con Fracciones Algebraicas
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.matrizTranspuesta,
              ruta: kRutaMatrizTranspuesta,
            ),
            //Propiedades de los Exponentes
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.matrizTriangular,
              ruta: kRutaMatrizTriangular,
            ),
            //Propiedades de las Desigualdades
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.multiplicacionDeMatrices,
              ruta: kRutaMultiplicacionDeMatrices,
            ),
            //Propiedades de los radicales
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.propiedadesDeLasMatrices,
              ruta: kRutaPropiedadesDeLasMatrices,
            ),
            //Serie taylor y MaClaurin
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.sumaYRestaDeMatrices,
              ruta: kRutaSumaRestaDeMatrices,
            ),
            //Formula General
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.puntoMedioEntreDosPuntos,
              ruta: kRutaPuntoMedioEntreDosPuntos,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.reglaCramer,
              ruta: kRutaReglaDeCramer,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.reglaSarrus,
              ruta: kRutaReglaDeSarrus,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            //Teorema de la Sumatoria
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.vectores,
              ruta: kRutaMenuVectores,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            //Ecuaciones Lineales
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.anguloEntreVectores,
              ruta: kRutaAnguloEntreVectores,
            ),
            //Formulas de Productos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.normalizacion,
              ruta: kRutaNormalizacion,
            ),
            //Formula General
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.operacionesConVectores,
              ruta: kRutaOperacionesConVectores,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.productoCruz,
              ruta: kRutaProductoCruz,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.productoPunto,
              ruta: kRutaProductoPunto,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.propiedadesDeLosVectores,
              ruta: kRutaPropiedadesDeLosVectores,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.proyeccionesDeVectores,
              ruta: kRutaProyeccionesDeVectores,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.vectorUnitario,
              ruta: kRutaVectorUnitario,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.vectoresYSuMagnitud,
              ruta: kRutaVectoresYSuMagnitud,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            /*Boton de Calculo Diferencial*/
            BotonesMenu(
              ruta: kRutaCalculoDiferencial,
              textoBoton: AppLocalizations.of(context)!.calculoDiferencial,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            //Limites
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.limites,
              ruta: kRutaLimites,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            //Propiedades de los Limites
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.propiedadesDeLosLimites,
              ruta: kRutaPropiedadesLimites,
            ),
            //Limites Trigonometricos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.limitesTrigonometricos,
              ruta: kRutaLimitesTrigonometricos,
            ),
            //Derivacion Basica
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.derivacionBasica,
              ruta: kRutaDerivacionBasica,
            ),
            //Funciones Trigonometricas
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.funcionesTrigonometricas,
              ruta: kRutaFuncionesTrigonometricasDiferencial,
            ),
            //Trigonometricas Inversas
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.trigonometricasInversas,
              ruta: kRutaFuncionesTrigonometricasInversasDiferencial,
            ),
            //Trigonometricas Hiperbólicas
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.trigonometricasHiperbolicas,
              ruta: kRutaFuncionesTrigonometricasHiperbolicasDiferencial,
            ),
            //Exponencial y Logaritmos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.exponencialLogaritmos,
              ruta: kRutaExponencialyLogaritmosDiferencial,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            /*Boton de Calculo Integral*/
            BotonesMenu(
              ruta: kRutaCalculoIntegral,
              textoBoton: AppLocalizations.of(context)!.calculoIntegral,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            //Integracion Básica
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.integracionBasica,
              ruta: kRutaIntegracionBasica,
            ),
            //Funciones Trigonometricas Integral
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.funcionesTrigonometricas,
              ruta: kRutaFuncionesTrigonometricasIntegral,
            ),
            //trigonometricas inversas Integral
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.trigonometricasInversas,
              ruta: kRutaFuncionesTrigonometricasInversasIntegral,
            ),
            //Funciones Hiperbolicas Integral
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.trigonometricasHiperbolicas,
              ruta: kRutaFuncionesHiperbolicasIntegral,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.exponencialLogaritmos,
              ruta: kRutaFuncionesExponencialyLogaritmosIntegral,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.integralesExtras,
              ruta: kRutaIntegralesExtras,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            /*Boton de Calculo Multivariable*/
            BotonesMenu(
              ruta: kRutaMenuCalculoMultivariable,
              textoBoton: AppLocalizations.of(context)!.calculoMultivariable,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.areaBajoCurva,
              ruta: kRutaAreaBajoLaCurva,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.areaSuperficieRevolucion,
              ruta: kRutaAreaDeUnaSuperficieDeRevolucion,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.cambioVariable,
              ruta: kRutaCambioDeVariables,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.derivadasDireccionales,
              ruta: kRutaDerivadasDireccionales,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.derivadasParciales,
              ruta: kRutaDerivadasParciales,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.diferencialTotal,
              ruta: kRutaDiferencialTotal,
            ),
            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.funcionesVectoriales,
              ruta: kRutaMenuFuncionesVectoriales,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.derivadasFuncionesVectoriales,
              ruta: kRutaDerivadaFuncionesVectoriales,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .limitesDerivadasIntegralesFuncionesVectoriales,
              ruta: kRutaLimiteIntegralDerivadaFuncionVectorial,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.gradienteFuncion,
              ruta: kRutaGradienteDeUnaFuncion,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.identidadesVectoriales,
              ruta: kRutaIdentidadesVectoriales,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.integralCoordenadasCilindricas,
              ruta: kRutaIntegralEnCoordenadasCilindricas,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.integralesLinea,
              ruta: kRutaIntegralesDeLinea,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.longitudArco,
              ruta: kRutaLongitudDeArco,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.operadoresDiferenciales,
              ruta: kRutaOperadoresDiferenciales,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.teoremaFubini,
              ruta: kRutaTeoremaDeFubini,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.teoremaIntegrales,
              ruta: kRutaTeoremaIntegrales,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            /*Boton de Ecuaciones Diferenciales*/
            BotonesMenu(
              ruta: kRutaMenuEcuacionesDiferenciales,
              textoBoton: AppLocalizations.of(context)!.ecuacionesDiferenciales,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.constantesDeIntegracion,
              ruta: kRutaConstantesDeIntegracion,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .ecuacionDiferencialCoeficientesConstantes,
              ruta: kRutaEcuacionDiferencialConCoeficientesConstantes,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .ecuacionDiferencialRectasNoParalelas,
              ruta: kRutaEcuacionDiferencialDeRectasNoParalelas,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .ecuacionDiferencialRectasParalelas,
              ruta: kRutaEcuacionDiferencialDeRectasParalelas,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.ecuacionDiferencialExacta,
              ruta: kRutaEcuacionDiferencialExacta,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.ecuacionDiferencialHomogenea,
              ruta: kRutaEcuacionDiferencialHomogenea,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .ecuacionDiferencialLinealOrdenSuperior,
              ruta: kRutaEcuacionDiferencialLinealDeOrdenSuperior,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .ecuacionDiferencialLinealPrimerOrden,
              ruta: kRutaEcuacionDiferencialLinealDePrimerOrden,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.ecuacionDiferencialSeparable,
              ruta: kRutaEcuacionDiferencialSeparable,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
//Boton de Geometria
            BotonesMenu(
              ruta: kRutaMenuGeometria,
              textoBoton: AppLocalizations.of(context)!.geometria,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

//Propiedades Logaritmos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.angulosEnUnPoligono,
              ruta: kRutaAngulosEnUnPoligono,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.areas,
              ruta: kRutaMenuAreasGeometria,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.areaPerimetroCuadrilateros,
              ruta: kRutaAreaYPerimetroDeCuadrilateros,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.areaPerimetroTriangulos,
              ruta: kRutaAreaYPerimetroDeTriangulos,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.areaPerimetroCirculo,
              ruta: kRutaAreaYPerimetroDelCirculo,
            ),
//Funciones Trigonométricas
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.circunferencia,
              ruta: kRutaCircunferencia,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.distanciaDeUnPuntoAUnaRecta,
              ruta: kRutaDistanciaDeUnPuntoAUnaRecta,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.distanciaEntreDosPuntos,
              ruta: kRutaDistanciaEntreDosPuntos,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.ecuacionDeLaRecta,
              ruta: kRutaEcuacionDeLaRecta,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .elipseConCentroDiferenteDelOrigen,
              ruta: kRutaElipseConCentroDiferenteDelOrigen,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .elipseConCentroDiferenteDelOrigen,
              ruta: kRutaElipseConCentroEnElOrigen,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.hiperbola,
              ruta: kRutaHiperbola,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .parabolaConVerticeDiferenteDelOrigen,
              ruta: kRutaParabolaConVerticeDiferenteDelOrigen,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.parabolaConVerticeEnElOrigen,
              ruta: kRutaParabolaConVerticeEnElOrigen,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.puntoMedioEntreDosPuntos,
              ruta: kRutaPuntoMedioEntreDosPuntosGeometria,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.volumenDeCuerposGeometricos,
              ruta: kRutaVolumenDeCuerposGeometricos,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            //Boton Matematicas Discretas
            //Botón Matemáticas Discretas
            BotonesMenu(
              ruta: kRutaMenuMatematicasDiscretas,
              textoBoton: AppLocalizations.of(context)!.matematicasDiscretas,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

//Bicondicional
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.bicondicional,
              ruta: kRutaBicondicional,
            ),
//Condicional
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.condicional,
              ruta: kRutaCondicional,
            ),
//Conectores Lógicos
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.conectoresLogicos,
              ruta: kRutaConectoresLogicos,
            ),
//Conjunción
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.conjuncion,
              ruta: kRutaConjuncion,
            ),
//Disyunción
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.disyuncion,
              ruta: kRutaDisyuncion,
            ),
//Leyes de la Lógica Proposicional
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.leyesDeLaLogicaProposicional,
              ruta: kRutaLeyesDeLaLogicaProposicional,
            ),
//Leyes de la Teoría de Conjuntos
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.leyesDeLaTeoriaDeConjuntos,
              ruta: kRutaLeyesDeLaTeoriaDeConjuntos,
            ),
//Leyes del Álgebra de Boole
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.leyesDelAlgebraDeBoole,
              ruta: kRutaLeyesDelAlgebraDeBoole,
            ),
//Negación
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.negacion,
              ruta: kRutaNegacion,
            ),
            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

//Botón Matemáticas Financieras
            BotonesMenu(
              ruta: kRutaMenuMatematicasFinancieras,
              textoBoton: AppLocalizations.of(context)!.matematicasFinancieras,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

//Amortización
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.amortizacion,
              ruta: kRutaAmortizacion,
            ),
//Anualidad Anticipada Simple y Cierta
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .anualidadAnticipadaSimpleYCierta,
              ruta: kRutaAnualidadAnticipadaSimpleYCierta,
            ),
//Anualidad Vencida Simple y Cierta
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.anualidadVencidaSimpleYCierta,
              ruta: kRutaAnualidadVencidaSimpleYCierta,
            ),
//Descuento Compuesto
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.descuentoCompuesto,
              ruta: kRutaDescuentoCompuesto,
            ),
//Descuento Simple
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.descuentoSimple,
              ruta: kRutaDescuentoSimple,
            ),
//Interés Compuesto
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.interesCompuesto,
              ruta: kRutaInteresCompuesto,
            ),
//Interés Simple
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.interesSimple,
              ruta: kRutaInteresSimple,
            ),
            //Leyes de la Teoria de Conjuntos
            //Saldo Insoluto
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.saldoInsoluto,
              ruta: kRutaSaldoInsoluto,
            ),
//Leyes del Álgebra de Boole
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.tasaDeInteresGlobal,
              ruta: kRutaTasaDeInteresGlobal,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.tasaEfectiva,
              ruta: kRutaTasaEfectiva,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            /*Boton de Probabilidad y Estadistica*/
            BotonesMenu(
              ruta: kRutaMenuProbabilidadYEstadistica,
              textoBoton: AppLocalizations.of(context)!.probabilidadEstadistica,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.combinacionesYPermutaciones,
              ruta: kRutaCombinacionesYPermutaciones,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.cuantilesParaDatosAgrupados,
              ruta: kRutaCuantilesParaDatosAgrupados,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.distribuciones,
              ruta: kRutaMenuDistribuciones,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.distribucionBinomial,
              ruta: kRutaDistribucionBinomial,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.distribucionPoisson,
              ruta: kRutaDistribucionDePoisson,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.distribucionExponencial,
              ruta: kRutaDistribucionExponencial,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.distribucionGeometrica,
              ruta: kRutaDistribucionGeometrica,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.distribucionHipergeometrica,
              ruta: kRutaDistribucionHipergeometrica,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.distribucionNormal,
              ruta: kRutaDistribucionNormal,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.distribucionTStudent,
              ruta: kRutaDistribucionTDeStudent,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.estadisticaInferencial,
              ruta: kRutaEstadisticaInferencial,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.intervalosDeConfianza,
              ruta: kRutaIntervalosDeConfianza,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.mediaGeometrica,
              ruta: kRutaMediaGeometrica,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.medidas,
              ruta: kRutaMenuMedidas,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.dispersionParaDatosNoAgrupados,
              ruta: kRutaMedidasDeDispersionParaDatosNoAgrupados,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.posicionParaDatosNoAgrupados,
              ruta: kRutaMedidasDePosicionParaDatosNoAgrupados,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .tendenciaCentralParaDatosAgrupados,
              ruta: kRutaMedidasDeTendenciaCentralParaDatosAgrupados,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .tendenciaCentralParaDatosNoAgrupados,
              ruta: kRutaMedidasDeTendenciaCentralParaDatosNoAgrupados,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.momentoEstadistico,
              ruta: kRutaMomentosEstadisticos,
            ),

            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.probabilidad,
              ruta: kRutaProbabilidad,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.tamanioMuestral,
              ruta: kRutaTamanioMuestral,
            ),
            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              ruta: kRutaMenuSeriesDeFourier,
              textoBoton: AppLocalizations.of(context)!.seriesFourier,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.convolucion,
              ruta: kRutaConvolucion,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .formaComplejaDeLasSeriesDeFourier,
              ruta: kRutaFormaComplejaDeLasSeriesDeFourier,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .formulasOperacionalesDeLaTransformadaDeLaplace,
              ruta: kRutaFormulasOperacionalesDeLaTransformadaDeLaplace,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.funcionImpulsoUnitario,
              ruta: kRutaFuncionImpulsoUnitario,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.funcionUnitariaDeHeaviside,
              ruta: kRutaFuncionUnitariaDeHeaviside,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.serieYCoeficientesDeFourier,
              ruta: kRutaSerieYCoeficientesDeFourier,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.simetrias,
              ruta: kRutaMenuSimetrias,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.simetriaMediaOnda,
              ruta: kRutaSimetriaDeMediaOnda,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.simetriaDeUnCuartoDeOndaImpar,
              ruta: kRutaSimetriaDeUnCuartoDeOndaImpar,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.simetriaCuartoOndaPar,
              ruta: kRutaSimetriaDeUnCuartoDeOndaPar,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.simetriaImpar,
              ruta: kRutaSimetriaImpar,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.simetriaPar,
              ruta: kRutaSimetriaPar,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.transformadas,
              ruta: kRutaMenuTransformadas,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.transformadasDeFourier,
              ruta: kRutaTransformadaDeFourier,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.transformadaDeLaplace,
              ruta: kRutaTransformadaDeLaplace,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .transformadaSenoYCosenoDeFourier,
              ruta: kRutaTransformadaSenoYCosenoDeFourier,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.transformadasBasicasDeFourier,
              ruta: kRutaTransformadasBasicasDeFourier,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.transformadasDeFourier,
              ruta: kRutaTransformadasDeFourier,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.transformadasDeLaplace,
              ruta: kRutaTransformadasDeLaplace,
            ),

            const SizedBox(height: 20),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            /*Boton de Trigonometria*/
            BotonesMenu(
              ruta: kRutaMenuTrigonometria,
              textoBoton: AppLocalizations.of(context)!.trigonometria,
            ),

            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.formulasDeBessel,
              ruta: kRutaMenuFormulasBessel,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.teoremaDeLaCotangente,
              ruta: kRutaTeoremaDeLaCotangente,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.teoremaDelCosenoParaAngulos,
              ruta: kRutaTeoremaDelCosenoParaAngulos,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.teoremaDelCosenoParaLados,
              ruta: kRutaTeoremaDelCosenoParaLados,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.teoremaDelSeno,
              ruta: kRutaTeoremaDelSeno,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.funcionesTrigonometricas,
              ruta: kRutaFuncionesTrigonometricas,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .funcionesTrigonometricasDeAngulosNotables,
              ruta: kRutaFuncionesTrigonometricasDeAngulosNotables,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.identidadesTrigonometricas,
              ruta: kRutaMenuIdentidadesTrigonometricas,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.deAnguloDobleYMedio,
              ruta: kRutaIdentidadesTrigonometricasDeAnguloDobleYMedio,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.deSumaAProductoYViceversa,
              ruta: kRutaIdentidadesTrigonometricasDeSumaAProductoYViceversa,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.deSumaYRestaDeAngulos,
              ruta: kRutaIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.extras,
              ruta: kRutaIdentidadesTrigonometricasExtras,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.fundamentales,
              ruta: kRutaIdentidadesTrigonometricasFundamentales,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.leyDeProyecciones,
              ruta: kRutaLeyDeProyecciones,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.leyDeSenosCosenosYTangente,
              ruta: kRutaLeyesDeSenosCosenosTangentes,
            ),
            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.medicionYClasificacionDeAngulos,
              ruta: kRutaMedicionYClasificacionDeAngulos,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!
                  .superficieDeUnTrianguloYUnPoligonoEsferico,
              ruta: kRutaSuperficieDeUnTrianguloYUnPoligonoEsferico,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.teoremaDePitagoras,
              ruta: kRutaTeoremaDePitagoras,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.trigonometriaEsferica,
              ruta: kRutaMenuTrigonometriaEsferica,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),

            BotonesMenu(
              textoBoton:
                  AppLocalizations.of(context)!.analogiasDeGaussDelambre,
              ruta: kRutaAnalogiasDeGaussDelambre,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.analogiasDeNeper,
              ruta: kRutaAnalogiasDeNeper,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.funcionesDelAnguloMitad,
              ruta: kRutaFuncionesDelAnguloMitad,
            ),
            BotonesMenu(
              textoBoton: AppLocalizations.of(context)!.valoresDeSenoYCoseno,
              ruta: kRutaValoresDeSenoYCoseno,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              ruta: kRutaMenuCampoYPotencialElectricos,
              textoBoton:
                  AppLocalizations.of(context)!.campoYPotencialElectricos,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              ruta: kRutaElectricidad,
              textoBoton: AppLocalizations.of(context)!.electricidad,
            ),
            BotonesMenu(
              ruta: kRutaCargaElectrica,
              textoBoton: AppLocalizations.of(context)!.cargaElectrica,
            ),
            BotonesMenu(
              ruta: kRutaCargaProtonElectron,
              textoBoton:
                  AppLocalizations.of(context)!.cargaElectricaProtonElectron,
            ),
            BotonesMenu(
              ruta: kRutaDistribucionesDeCargaElectrica,
              textoBoton:
                  AppLocalizations.of(context)!.distribucionesCargaElectrica,
            ),
            BotonesMenu(
              ruta: kRutaLeyDeCoulomb,
              textoBoton: AppLocalizations.of(context)!.leyCoulomb,
            ),
            BotonesMenu(
              ruta: kRutaPrincipioDeSuperposicion,
              textoBoton: AppLocalizations.of(context)!.principioSuperposicion,
            ),
            BotonesMenu(
              ruta: kRutaCampoElectrico,
              textoBoton: AppLocalizations.of(context)!.campoElectrico,
            ),
            BotonesMenu(
              ruta: kRutaCampoElectricoOriginadoPorDistribucionesDeCarga,
              textoBoton: AppLocalizations.of(context)!
                  .campoElectricoDistribucionesCarga,
            ),
            BotonesMenu(
              ruta: kRutaFlujoDeUnCampoVectorial,
              textoBoton:
                  AppLocalizations.of(context)!.flujoElectricoCampoVectorial,
            ),
            BotonesMenu(
              ruta: kRutaLeyDeGauss,
              textoBoton: AppLocalizations.of(context)!.leyGauss,
            ),
            BotonesMenu(
              ruta: kRutaEnergiaPotencialElectrica,
              textoBoton:
                  AppLocalizations.of(context)!.energiaPotencialElectrica,
            ),
            BotonesMenu(
              ruta: kRutaCalculoDeDiferenciasDePotencial,
              textoBoton:
                  AppLocalizations.of(context)!.calculoDiferenciasPotencial,
            ),
            BotonesMenu(
              ruta: kRutaTeoremaDeLaDivergencia,
              textoBoton: AppLocalizations.of(context)!.teoremaDivergencia,
            ),
            BotonesMenu(
              ruta: kRutaTeoremaDelRotacional,
              textoBoton: AppLocalizations.of(context)!.teoremaRotacional,
            ),
            BotonesMenu(
              ruta: kRutaCirculacionDelCampoElectrostatico,
              textoBoton:
                  AppLocalizations.of(context)!.circulacionCampoElectrostatico,
            ),
            BotonesMenu(
              ruta: kRutaRotacionalDelCampoElectrostatico,
              textoBoton:
                  AppLocalizations.of(context)!.rotacionalCampoElectrostatico,
            ),
            BotonesMenu(
              ruta: kRutaOperadorGradiente,
              textoBoton: AppLocalizations.of(context)!.operadorGradiente,
            ),
            BotonesMenu(
              ruta: kRutaGradienteDeUnaFuncionEscalar,
              textoBoton: AppLocalizations.of(context)!.gradienteFuncionEscalar,
            ),
            BotonesMenu(
              ruta: kRutaGradienteDePotencialElectrico,
              textoBoton:
                  AppLocalizations.of(context)!.gradientePotencialElectrico,
            ),
            BotonesMenu(
              ruta: kRutaLeyDeGaussEnFormaDiferencial,
              textoBoton:
                  AppLocalizations.of(context)!.leyGaussFormaDiferencial,
            ),
            BotonesMenu(
              ruta: kRutaEcuacionDePoissonYLaplace,
              textoBoton: AppLocalizations.of(context)!.ecuacionPoissonLaplace,
            ),
            BotonesMenu(
              ruta: kRutaSuperficiesEquipotenciales,
              textoBoton:
                  AppLocalizations.of(context)!.superficiesEquipotenciales,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              ruta: kRutaMenuCapacitanciaYDielectricos,
              textoBoton:
                  AppLocalizations.of(context)!.capacitanciaDielectricos,
            ),
            const Divider(
              color: kColorTextoBotones,
              thickness: 0.2,
            ),
            BotonesMenu(
              ruta: kRutaCapacitor,
              textoBoton: AppLocalizations.of(context)!.capacitor,
            ),
            BotonesMenu(
              ruta: kRutaCargaDeUnCapacitor,
              textoBoton: AppLocalizations.of(context)!.cargaCapacitor,
            ),
            BotonesMenu(
              ruta: kRutaDefinicionDeCapacitancia,
              textoBoton: AppLocalizations.of(context)!.definicionCapacitancia,
            ),
            BotonesMenu(
              ruta: kRutaGraficaDeCapacitancia,
              textoBoton: AppLocalizations.of(context)!.graficaCapacitancia,
            ),
            BotonesMenu(
              ruta: kRutaSimbologiaCapacitores,
              textoBoton: AppLocalizations.of(context)!.simbologiaCapacitores,
            ),
            BotonesMenu(
              ruta: kRutaCapacitorDePlacasPlanasYParalelas,
              textoBoton:
                  AppLocalizations.of(context)!.capacitorPlacasPlanasParalelas,
            ),
            BotonesMenu(
              ruta: kRutaEnergiaYCapacitancia,
              textoBoton: AppLocalizations.of(context)!.energiaCapacitancia,
            ),
            BotonesMenu(
              ruta: kRutaEnergiaAlmacenadaPorUnCapacitor,
              textoBoton:
                  AppLocalizations.of(context)!.energiaAlmacenadaCapacitor,
            ),
            BotonesMenu(
              ruta: kRutaConexionEnSerieCapacitor,
              textoBoton: AppLocalizations.of(context)!.conexionSerieCapacitor,
            ),
            BotonesMenu(
              ruta: kRutaConexionEnParaleloCapacitor,
              textoBoton:
                  AppLocalizations.of(context)!.conexionParaleloCapacitor,
            ),
            BotonesMenu(
              ruta: kRutaPolarizacion,
              textoBoton: AppLocalizations.of(context)!.polarizacion,
            ),
            BotonesMenu(
              ruta: kRutaPolarizacionYCargaInducida,
              textoBoton:
                  AppLocalizations.of(context)!.polarizacionCargaInducida,
            ),
            BotonesMenu(
              ruta: kRutaConstantesDielectricas,
              textoBoton: AppLocalizations.of(context)!.constantesDielectricas,
            ),
            BotonesMenu(
              ruta: kRutaRigidezDielectrica,
              textoBoton: AppLocalizations.of(context)!.rigidezDielectrica,
            ),
            BotonesMenu(
              ruta: kRutaVectorDeDesplazamientoElectrico,
              textoBoton:
                  AppLocalizations.of(context)!.vectorDesplazamientoElectrico,
            ),
            BotonesMenu(
              ruta: kRutaRepresentacionDeLosVectoresElectricos,
              textoBoton: AppLocalizations.of(context)!
                  .representacionVectoresElectricos,
            ),
          ],
        ),
      ),
    );
  }
}
