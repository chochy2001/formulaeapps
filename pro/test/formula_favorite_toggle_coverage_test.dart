import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/chat_gpt/chats_provider.dart';
import 'package:formulae/chat_gpt/models_provider.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';
import 'package:formulae/widgets_personalizados/todo/task_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:formulae/secciones_app/electricidad_y_magnetismo/bateria_real_voltaje_en_terminales.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/ca_valores_eficaces_transformador.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/calculo_de_diferencias_de_potencial.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/campo_electrico.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/campo_electrico_originado_por_distribuciones_de_carga.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/carga_electrica.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/carga_proton_electron.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/circulacion_del_campo_electrostatico.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/distribuciones_de_carga_electrica.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/ecuacion_de_poisson_y_laplace.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/electricidad.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/energia_potencial_electrica.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/flujo_electrico_de_un_campo_vectorial.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/gradiente_de_potencial_electrico.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/gradiente_de_una_funcion_escalar.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/ley_de_coulomb.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/ley_de_gauss.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/ley_de_gauss_en_forma_diferencial.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/operador_gradiente.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/principio_de_superposicion.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/rotacional_del_campo_electrostatico.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/superficies_equipotenciales.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/teorema_de_la_divergencia.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/campo_y_potencia_electricos/teorema_del_rotacional.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/capacitor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/capacitor_de_placas_planas_y_paralelas.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/carga_de_un_capacitor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/conexion_en_paralelo_capacitor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/conexion_en_serie_capacitor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/constantes_dielectricas.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/definicion_de_capacitancia.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/energia_almacenada_por_un_capacitor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/energia_y_capacitancia.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/grafica_de_capacitancia.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/polarizacion.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/polarizacion_y_carga_inducida.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/representacion_de_los_vectores_electricos.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/rigidez_dielectrica.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/simbologia_capacitores.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitancia_y_dielectricos/vector_de_desplazamiento_electrico.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/capacitores_cilindrico_y_esferico.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuito_lr_en_serie.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/circuito_rc_y_voltaje_continuo.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/conductividad_y_resistividad.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/conexion_en_paralelo_resistor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/conexion_en_serie_resistor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/densidad_de_corriente_y_corriente_electrica.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/ecuacion_de_ohm.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/efecto_joule.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/elementos_capacitor_y_resistor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/elementos_fem.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/fuente_de_fuerza_electromotriz_fem.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/ley_de_corrientes_de_kirchhoff.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/ley_de_ohm.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/ley_de_voltajes_de_kirchhoff.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/leyes_de_kirchhoff_circuito_rc.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/nomenclatura_basica_empleada_en_circuitos.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/portadores_de_carga_libre.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/reglas_para_lvk_y_lck.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/resistividad_y_temperatura.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/resistor_lineal_y_no_lineal.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/resistor_simbologia_basica.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/teoria_de_circuitos.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/circuitos_electricos/tipos_de_corriente_electrica.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/fuerza_y_torca_magnetica.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/energia_almacenada_en_un_campo_magnetico.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/generador_homopolar.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_mutua.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_mutua_entre_dos_solenoide_coaxiales.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_para_un_toroide.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_propia.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/inductancia_propia_de_un_solenoide.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/inductor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/inductores_en_serie.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/induccion_electromagnetica/ley_de_faraday_y_energia_en_un_inductor.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/instrumentos_de_medicion_electrica.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/bobina.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/campo_magnetico_a_partir_de_ley_de_ampere.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/circulacion_de_un_campo_vectorial.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/definicion_de_campo_magnetico.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/descripcion_de_los_imanes_y_experimentos_de_oersted.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/espira_cuadrada.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/espira_en_forma_de_circunferencia.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/flujo_magnetico.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/fuerza_de_lorentz.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/fuerza_magnetica_como_vector_sobre_cargas_en_movimiento.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/ley_de_ampere_en_forma_diferencial.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/ley_de_biot_savart.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/motor_de_corriente_directa.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/segmento_conductor_recto.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/magnetostatica/solenoide.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/permeabilidad_magnetica_en_materiales.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/potencia_y_reactancias_en_ca.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/axiomas_de_probabilidad.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/combinaciones_y_permutaciones.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/cuantiles_para_datos_agrupados.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/desigualdad_de_chebyshev_y_convergencia.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_beta.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_binomial.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_de_bernoulli.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_de_cauchy.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_de_erlang.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_de_pascal.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_de_poisson.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_exponencial.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_geometrica.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_hipergeometrica.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_normal.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_t_de_student.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/distribuciones/distribucion_uniforme.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/esperanza_media_y_varianza.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/estadistica_inferencial.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/funciones_de_masa_densidad_y_acumulada.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/funciones_de_probabilidad_conjuntas_y_condicionales.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/intervalos_de_confianza.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/media_geometrica.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/medidas/medidas_de_dispersion_para_datos_no_agrupados.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/medidas/medidas_de_posicion_para_datos_no_agrupados.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/medidas/medidas_de_tendencia_central_para_datos_agrupados.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/medidas/medidas_de_tendencia_central_para_datos_no_agrupados.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/momentos_estadisticos.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/probabilidad.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/regresion_lineal.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/tamanio_muestral.dart';
import 'package:formulae/secciones_app/trigonometria/angulos_notables_grados_radianes.dart';
import 'package:formulae/secciones_app/trigonometria/circulo_unitario.dart';
import 'package:formulae/secciones_app/trigonometria/cotangente_de_suma_y_resta_de_angulos.dart';
import 'package:formulae/secciones_app/trigonometria/funciones_trigonometricas.dart';
import 'package:formulae/secciones_app/trigonometria/funciones_trigonometricas_de_angulos_notables.dart';
import 'package:formulae/secciones_app/trigonometria/identidades_de_angulo_triple_y_cuadruple.dart';
import 'package:formulae/secciones_app/trigonometria/identidades_de_reduccion_de_potencias.dart';
import 'package:formulae/secciones_app/trigonometria/identidades_fundamentales_formas_derivadas.dart';
import 'package:formulae/secciones_app/trigonometria/ley_de_proyecciones.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'formula favorite toggles add and remove across electricity and related screens',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(900, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final screens = <Widget>[
        const BateriaRealVoltajeEnTerminales(),
        const CaValoresEficacesTransformador(),
        const CapacitoresCilindricoYEsferico(),
        const CircuitoLrEnSerie(),
        const FuerzaYTorcaMagnetica(),
        const InstrumentosDeMedicionElectrica(),
        const PermeabilidadMagneticaEnMateriales(),
        const PotenciaYReactanciasEnCa(),
        const EnergiaAlmacenadaEnUnCampoMagnetico(),
        const GeneradorHomopolar(),
        const InductanciaMutua(),
        const InductanciaMutuaEntreDosSolenoidesCoaxiales(),
        const InductanciaParaUnToroide(),
        const InductanciaPropia(),
        const InductanciaPropiaDeUnSolenoide(),
        const Inductor(),
        const InductoresEnSerie(),
        const LeyDeInduccionDeFaradayEnergiaEnUnInductor(),
        const CircuitoRCyVoltajeContinuo(),
        const ConductividadYResistividad(),
        const ConexionEnParaleloResistor(),
        const ConexionEnSerieResistor(),
        const DensidadDeCorrienteYCorrienteElectrica(),
        const EcuacionDeOhm(),
        const EfectoJoule(),
        const ElementosCapacitorYResistor(),
        const ElementosFem(),
        const FuenteDeFuerzaElectromotrizFem(),
        const LeyDeCorrientesDeKirchhoff(),
        const LeyDeOhm(),
        const LeyDeVoltajesDeKirchhoff(),
        const LeyesDeKirchhoffCircuitoRC(),
        const NomenclaturaBasicaEmpleadaEnCircuitos(),
        const PortadoresDeCargaLibre(),
        const ReglasParaLVKyLCK(),
        const ResistividadYTemperatura(),
        const ResistorLinealYNoLineal(),
        const ResistorSimbologiaBasica(),
        const TeoriaDeCircuitos(),
        const TiposDeCorrienteElectrica(),
        const CalculoDeDiferenciasDePotencial(),
        const CampoElectrico(),
        const CampoElectricoOriginadoPorDistribucionesDeCarga(),
        const CargaElectrica(),
        const CargaProtonElectron(),
        const CirculacionDelCampoElectrostatico(),
        const DistribucionesDeCargaElectrica(),
        const EcuacionDePoissonYLaplace(),
        const Electricidad(),
        const EnergiaPotencialElectrica(),
        const FlujoDeUnCampoVectorial(),
        const GradienteDePotencialElectrico(),
        const GradienteDeUnaFuncionEscalar(),
        const LeyDeCoulomb(),
        const LeyDeGauss(),
        const LeyDeGaussEnFormaDiferencial(),
        const OperadorGradiente(),
        const PrincipioDeSuperposicion(),
        const RotacionalDelCampoElectrostatico(),
        const SuperficiesEquipotenciales(),
        const TeoremaDeLaDivergencia(),
        const TeoremaDelRotacional(),
        const Bobina(),
        const CampoMagneticoAPartirDeLeyDeAmpere(),
        const CirculacionDeUnCampoVectorial(),
        const DefinicionDeCampoMagnetico(),
        const OrigenDeCampoMagnetico(),
        const EspiraCuadrada(),
        const EspiraEnFormaDeCircunferencia(),
        const FlujoMagnetico(),
        const FuerzaDeLorentz(),
        const FuerzaMagneticaComoVectorSobreCargasEnMovimiento(),
        const LeyDeAmpereEnFormaDiferencial(),
        const LeyDeBiotSavart(),
        const MotorDeCorrienteDirecta(),
        const SegmentoConductorRecto(),
        const Solenoide(),
        const Capacitor(),
        const CapacitorDePlacasPlanasYParalelas(),
        const CargaDeUnCapacitor(),
        const ConexionEnParaleloCapacitor(),
        const ConexionEnSerieCapacitor(),
        const ConstantesDielectricas(),
        const DefinicionDeCapacitancia(),
        const EnergiaAlmacenadaPorUnCapacitor(),
        const EnergiaYCapacitancia(),
        const GraficaDeCapacitancia(),
        const Polarizacion(),
        const PolarizacionYCargaInducida(),
        const RepresentacionDeLosVectoresElectricos(),
        const RigidezDielectrica(),
        const SimbologiaCapacitores(),
        const VectorDeDesplazamientoElectrico(),
        const AxiomasDeProbabilidad(),
        const CombinacionesYPermutaciones(),
        const CuantilesParaDatosAgrupados(),
        const DesigualdadDeChebyshevYConvergencia(),
        const EsperanzaMediaYVarianza(),
        const EstadisticaInferencial(),
        const FuncionesDeMasaDensidadYAcumulada(),
        const FuncionesDeProbabilidadConjuntasYCondicionales(),
        const IntervalosDeConfianza(),
        const MediaGeometrica(),
        const MomentosEstadisticos(),
        const Probabilidad(),
        const RegresionLineal(),
        const TamanioMuestral(),
        const MedidasDeDispersionParaDatosNoAgrupados(),
        const MedidasDePosicionParaDatosNoAgrupados(),
        const MedidasDeTendenciaCentralParaDatosAgrupados(),
        const MedidasDeTendenciaCentralParaDatosNoAgrupados(),
        const DistribucionesDistribucionBeta(),
        const DistribucionBinomial(),
        const DistribucionesDistribucionDeBernoulli(),
        const DistribucionesDistribucionDeCauchy(),
        const DistribucionesDistribucionDeErlang(),
        const DistribucionesDistribucionDePascal(),
        const DistribucionDePoisson(),
        const DistribucionExponencial(),
        const DistribucionGeometrica(),
        const DistribucionHipergeometrica(),
        const DistribucionNormal(),
        const DistribucionTDeStudent(),
        const DistribucionesDistribucionUniforme(),
        const AngulosNotablesGradosRadianes(),
        const CirculoUnitario(),
        const CotangenteDeSumaYRestaDeAngulos(),
        const FuncionesTrigonometricas(),
        const FuncionesTrigonometricasDeAngulosNotables(),
        const IdentidadesDeAnguloTripleYCuadruple(),
        const IdentidadesDeReduccionDePotencias(),
        const IdentidadesFundamentalesFormasDerivadas(),
        const LeyDeProyecciones(),
      ];

      var toggled = 0;
      for (final screen in screens) {
        final favorites = FavoritesNotifier();
        await tester.pumpWidget(_harness(favorites: favorites, home: screen));
        await tester.pump();
        while (tester.takeException() != null) {}

        final border = find.byIcon(Icons.favorite_border);
        if (border.evaluate().isEmpty) {
          // Already favorited somehow — still try filled icon path.
          final filled = find.byIcon(Icons.favorite);
          if (filled.evaluate().isEmpty) continue;
          await tester.tap(filled.first);
          await tester.pump();
          while (tester.takeException() != null) {}
          continue;
        }

        expect(
          favorites.favorites,
          isEmpty,
          reason: '${screen.runtimeType} starts without favorites',
        );
        await tester.ensureVisible(border.first);
        await tester.tap(border.first);
        await tester.pump();
        while (tester.takeException() != null) {}
        expect(
          favorites.favorites,
          isNotEmpty,
          reason: '${screen.runtimeType} should add favorite',
        );

        final filled = find.byIcon(Icons.favorite);
        expect(
          filled,
          findsWidgets,
          reason: '${screen.runtimeType} should show filled favorite',
        );
        await tester.ensureVisible(filled.first);
        await tester.tap(filled.first);
        await tester.pump();
        while (tester.takeException() != null) {}
        expect(
          favorites.favorites,
          isEmpty,
          reason: '${screen.runtimeType} should remove favorite',
        );
        toggled += 1;
      }

      expect(
        toggled,
        greaterThanOrEqualTo(80),
        reason: 'expected most formula screens to expose a favorite toggle',
      );
    },
  );
}

Widget _harness({required Widget home, required FavoritesNotifier favorites}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(const Locale('es')),
      ),
      ChangeNotifierProvider<ModelsProvider>(create: (_) => ModelsProvider()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<TaskData>(create: (_) => TaskData()),
      ChangeNotifierProvider<FavoritesNotifier>.value(value: favorites),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: home,
    ),
  );
}
