import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @generales.
  ///
  /// In es, this message translates to:
  /// **'Generales'**
  String get generales;

  /// No description provided for @algebra.
  ///
  /// In es, this message translates to:
  /// **'Álgebra'**
  String get algebra;

  /// No description provided for @algebraLineal.
  ///
  /// In es, this message translates to:
  /// **'Álgebra Lineal'**
  String get algebraLineal;

  /// No description provided for @calculoDiferencial.
  ///
  /// In es, this message translates to:
  /// **'Cálculo Diferencial'**
  String get calculoDiferencial;

  /// No description provided for @calculoIntegral.
  ///
  /// In es, this message translates to:
  /// **'Cálculo Integral'**
  String get calculoIntegral;

  /// No description provided for @calculoMultivariable.
  ///
  /// In es, this message translates to:
  /// **'Cálculo Multivariable'**
  String get calculoMultivariable;

  /// No description provided for @ecuacionesDiferenciales.
  ///
  /// In es, this message translates to:
  /// **'Ecuaciones Diferenciales'**
  String get ecuacionesDiferenciales;

  /// No description provided for @electricidadMagnetismo.
  ///
  /// In es, this message translates to:
  /// **'Electricidad y Magnetismo'**
  String get electricidadMagnetismo;

  /// No description provided for @geometria.
  ///
  /// In es, this message translates to:
  /// **'Geometría'**
  String get geometria;

  /// No description provided for @matematicasDiscretas.
  ///
  /// In es, this message translates to:
  /// **'Matemáticas Discretas'**
  String get matematicasDiscretas;

  /// No description provided for @matematicasFinancieras.
  ///
  /// In es, this message translates to:
  /// **'Matemáticas Financieras'**
  String get matematicasFinancieras;

  /// No description provided for @probabilidadEstadistica.
  ///
  /// In es, this message translates to:
  /// **'Probabilidad y Estadística'**
  String get probabilidadEstadistica;

  /// No description provided for @seriesFourier.
  ///
  /// In es, this message translates to:
  /// **'Series de Fourier'**
  String get seriesFourier;

  /// No description provided for @trigonometria.
  ///
  /// In es, this message translates to:
  /// **'Trigonometría'**
  String get trigonometria;

  /// No description provided for @solucionEcuaciones.
  ///
  /// In es, this message translates to:
  /// **'Solución de Ecuaciones'**
  String get solucionEcuaciones;

  /// No description provided for @ecuacionesLineales.
  ///
  /// In es, this message translates to:
  /// **'Ecuaciones Lineales'**
  String get ecuacionesLineales;

  /// No description provided for @formulaGeneral.
  ///
  /// In es, this message translates to:
  /// **'Fórmula General'**
  String get formulaGeneral;

  /// No description provided for @formulaProductos.
  ///
  /// In es, this message translates to:
  /// **'Fórmula de Productos'**
  String get formulaProductos;

  /// No description provided for @formulasFactorizacion.
  ///
  /// In es, this message translates to:
  /// **'Fórmulas de Factorización'**
  String get formulasFactorizacion;

  /// No description provided for @numerosComplejos.
  ///
  /// In es, this message translates to:
  /// **'Números Complejos'**
  String get numerosComplejos;

  /// No description provided for @operacionesFraccionesAlgebraicas.
  ///
  /// In es, this message translates to:
  /// **'Operaciones con Fracciones Algebraicas'**
  String get operacionesFraccionesAlgebraicas;

  /// No description provided for @operacionesPolinomios.
  ///
  /// In es, this message translates to:
  /// **'Operaciones con Polinomios'**
  String get operacionesPolinomios;

  /// No description provided for @propiedadesExponentes.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de los Exponentes'**
  String get propiedadesExponentes;

  /// No description provided for @propiedadesDesigualdades.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de las Desigualdades'**
  String get propiedadesDesigualdades;

  /// No description provided for @propiedadesRadicales.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de los Radicales'**
  String get propiedadesRadicales;

  /// No description provided for @serieTaylorMaclaurin.
  ///
  /// In es, this message translates to:
  /// **'Serie de Taylor y Maclaurin'**
  String get serieTaylorMaclaurin;

  /// No description provided for @teoremaSumatoria.
  ///
  /// In es, this message translates to:
  /// **'Teorema de la Sumatoria'**
  String get teoremaSumatoria;

  /// No description provided for @determinantes.
  ///
  /// In es, this message translates to:
  /// **'Determinantes'**
  String get determinantes;

  /// No description provided for @matrices.
  ///
  /// In es, this message translates to:
  /// **'Matrices'**
  String get matrices;

  /// No description provided for @reglaCramer.
  ///
  /// In es, this message translates to:
  /// **'Regla de Cramer'**
  String get reglaCramer;

  /// No description provided for @reglaSarrus.
  ///
  /// In es, this message translates to:
  /// **'Regla de Sarrus'**
  String get reglaSarrus;

  /// No description provided for @vectores.
  ///
  /// In es, this message translates to:
  /// **'Vectores'**
  String get vectores;

  /// No description provided for @areasGeometria.
  ///
  /// In es, this message translates to:
  /// **'Áreas en Geometría'**
  String get areasGeometria;

  /// No description provided for @areaPerimetroCuadrilateros.
  ///
  /// In es, this message translates to:
  /// **'Área y Perímetro de Cuadriláteros'**
  String get areaPerimetroCuadrilateros;

  /// No description provided for @areaPerimetroTriangulos.
  ///
  /// In es, this message translates to:
  /// **'Área y Perímetro de Triángulos'**
  String get areaPerimetroTriangulos;

  /// No description provided for @areaPerimetroCirculo.
  ///
  /// In es, this message translates to:
  /// **'Área y Perímetro del Círculo'**
  String get areaPerimetroCirculo;

  /// No description provided for @limites.
  ///
  /// In es, this message translates to:
  /// **'Límites'**
  String get limites;

  /// No description provided for @derivacionBasica.
  ///
  /// In es, this message translates to:
  /// **'Derivación Básica'**
  String get derivacionBasica;

  /// No description provided for @funcionesTrigonometricas.
  ///
  /// In es, this message translates to:
  /// **'Funciones Trigonométricas'**
  String get funcionesTrigonometricas;

  /// No description provided for @trigonometricasInversas.
  ///
  /// In es, this message translates to:
  /// **'Trigonométricas Inversas'**
  String get trigonometricasInversas;

  /// No description provided for @trigonometricasHiperbolicas.
  ///
  /// In es, this message translates to:
  /// **'Trigonométricas Hiperbólicas'**
  String get trigonometricasHiperbolicas;

  /// No description provided for @exponencialLogaritmos.
  ///
  /// In es, this message translates to:
  /// **'Exponencial y Logaritmos'**
  String get exponencialLogaritmos;

  /// No description provided for @integracionBasica.
  ///
  /// In es, this message translates to:
  /// **'Integración Básica'**
  String get integracionBasica;

  /// No description provided for @integralesExtras.
  ///
  /// In es, this message translates to:
  /// **'Integrales Extras'**
  String get integralesExtras;

  /// No description provided for @areaBajoCurva.
  ///
  /// In es, this message translates to:
  /// **'Área Bajo la Curva'**
  String get areaBajoCurva;

  /// No description provided for @areaSuperficieRevolucion.
  ///
  /// In es, this message translates to:
  /// **'Área de una Superficie de Revolución'**
  String get areaSuperficieRevolucion;

  /// No description provided for @cambioVariable.
  ///
  /// In es, this message translates to:
  /// **'Cambio de Variable'**
  String get cambioVariable;

  /// No description provided for @derivadasDireccionales.
  ///
  /// In es, this message translates to:
  /// **'Derivadas Direccionales'**
  String get derivadasDireccionales;

  /// No description provided for @derivadasParciales.
  ///
  /// In es, this message translates to:
  /// **'Derivadas Parciales'**
  String get derivadasParciales;

  /// No description provided for @diferencialTotal.
  ///
  /// In es, this message translates to:
  /// **'Diferencial Total'**
  String get diferencialTotal;

  /// No description provided for @gradienteFuncion.
  ///
  /// In es, this message translates to:
  /// **'Gradiente de una Función'**
  String get gradienteFuncion;

  /// No description provided for @identidadesVectoriales.
  ///
  /// In es, this message translates to:
  /// **'Identidades Vectoriales'**
  String get identidadesVectoriales;

  /// No description provided for @integralCoordenadasCilindricas.
  ///
  /// In es, this message translates to:
  /// **'Integral en Coordenadas Cilíndricas'**
  String get integralCoordenadasCilindricas;

  /// No description provided for @integralesLinea.
  ///
  /// In es, this message translates to:
  /// **'Integrales de Línea'**
  String get integralesLinea;

  /// No description provided for @longitudArco.
  ///
  /// In es, this message translates to:
  /// **'Longitud de Arco'**
  String get longitudArco;

  /// No description provided for @operadoresDiferenciales.
  ///
  /// In es, this message translates to:
  /// **'Operadores Diferenciales'**
  String get operadoresDiferenciales;

  /// No description provided for @teoremaFubini.
  ///
  /// In es, this message translates to:
  /// **'Teorema de Fubini'**
  String get teoremaFubini;

  /// No description provided for @teoremaIntegrales.
  ///
  /// In es, this message translates to:
  /// **'Teorema de Integrales'**
  String get teoremaIntegrales;

  /// No description provided for @configuracion.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get configuracion;

  /// No description provided for @desarrolladoPor.
  ///
  /// In es, this message translates to:
  /// **'Desarrollada por CAPDESIS S.A. DE C.V.'**
  String get desarrolladoPor;

  /// No description provided for @contacto.
  ///
  /// In es, this message translates to:
  /// **'Contacto: formulae@capdesis.com'**
  String get contacto;

  /// No description provided for @politicaPrivacidad.
  ///
  /// In es, this message translates to:
  /// **'Política de Privacidad'**
  String get politicaPrivacidad;

  /// No description provided for @aceptar.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get aceptar;

  /// No description provided for @terminosUso.
  ///
  /// In es, this message translates to:
  /// **'Términos de Uso (EULA)'**
  String get terminosUso;

  /// No description provided for @cancelarSuscripciones.
  ///
  /// In es, this message translates to:
  /// **'Cancelar suscripciones'**
  String get cancelarSuscripciones;

  /// No description provided for @instrucciones.
  ///
  /// In es, this message translates to:
  /// **'Da clic en \'Visitar web\' y sigue las instrucciones'**
  String get instrucciones;

  /// No description provided for @visitarWeb.
  ///
  /// In es, this message translates to:
  /// **'Visitar Web'**
  String get visitarWeb;

  /// No description provided for @seleccionarIdioma.
  ///
  /// In es, this message translates to:
  /// **'Seleccione un idioma'**
  String get seleccionarIdioma;

  /// No description provided for @cambiarIdioma.
  ///
  /// In es, this message translates to:
  /// **'Cambiar Idioma'**
  String get cambiarIdioma;

  /// No description provided for @idiomaEspaniol.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get idiomaEspaniol;

  /// No description provided for @idiomaIngles.
  ///
  /// In es, this message translates to:
  /// **'Inglés'**
  String get idiomaIngles;

  /// No description provided for @terminosDeServicio.
  ///
  /// In es, this message translates to:
  /// **'Términos de Uso (EULA) para la aplicación Formulae Fecha de entrada en vigor: 20 de abril de 2023 1. Aceptación de los Términos de Uso Al descargar, instalar, acceder o utilizar la aplicación Formulae (en adelante, la \"Aplicación\"), usted acepta estar vinculado por estos Términos de Uso (en adelante, los \"Términos\"). Si no está de acuerdo con estos Términos, no debe descargar, instalar, acceder ni utilizar la Aplicación. 2. Licencia CAPDESIS (en adelante, \"nosotros\" o \"nuestro\") le otorga una licencia limitada, no exclusiva, intransferible y revocable para descargar, instalar y utilizar la Aplicación en su dispositivo para su uso personal y no comercial. Esta licencia se rige por estos Términos. 3. Restricciones de uso Al utilizar la Aplicación, usted se compromete a no: - Utilizar la Aplicación con fines ilegales, fraudulentos o malintencionados. - Copiar, modificar, adaptar, redistribuir, descompilar, realizar ingeniería inversa o crear obras derivadas de la Aplicación. - Eliminar, alterar o modificar cualquier aviso de derechos de autor, marca comercial u otros avisos de propiedad intelectual contenidos en la Aplicación. - Alquilar, prestar, sublicenciar, vender o transferir la Aplicación a terceros. 4. Propiedad intelectual La Aplicación y todos los derechos de autor, marcas registradas, patentes y otros derechos de propiedad intelectual relacionados con ella son propiedad exclusiva de CAPDESIS y/o sus licenciantes. Todos los derechos no otorgados expresamente en estos Términos están reservados. 5. Actualizaciones y cambios Nos reservamos el derecho, a nuestra entera discreción, de actualizar, modificar o descontinuar la Aplicación o cualquier parte de ella en cualquier momento y sin previo aviso. Al continuar utilizando la Aplicación después de cualquier cambio, usted acepta estar vinculado por la versión actualizada de estos Términos. 6. Exención de garantías y limitación de responsabilidad La Aplicación se proporciona \"tal cual\" y \"según esté disponible\", sin garantías expresas o implícitas de ningún tipo. En la medida máxima permitida por la ley, no seremos responsables de ningún daño directo, indirecto, incidental, especial, consecuente o punitivo, incluyendo, entre otros, la pérdida de datos, beneficios o interrupción del negocio, que resulte del uso o la imposibilidad de utilizar la Aplicación. 7. Ley aplicable y jurisdicción Estos Términos se regirán e interpretarán de acuerdo con las leyes de México, sin tener en cuenta sus disposiciones sobre conflicto de leyes. Cualquier disputa o reclamación relacionada con estos Términos o el uso de la Aplicación se someterá a la jurisdicción exclusiva de los tribunales de Ciudad de México, México. 8. Contáctenos Si tiene alguna pregunta o comentario sobre estos Términos, comuníquese con nosotros en formulae@capdesis.com 9. Términos adicionales Si alguna disposición de estos Términos se considera inválida o inaplicable por un tribunal de jurisdicción competente, las disposiciones restantes de estos Términos seguirán siendo válidas y aplicables en la medida máxima permitida por la ley. 10. Cambios en los Términos Nos reservamos el derecho, a nuestra entera discreción, de modificar o reemplazar estos Términos en cualquier momento. Si una revisión es importante, nos esforzaremos por proporcionar un aviso con al menos 30 días de anticipación al inicio de los nuevos términos. Lo que constituye un cambio importante será determinado a nuestra entera discreción. Al continuar accediendo o utilizando nuestra Aplicación después de que esas revisiones entren en vigor, usted acepta estar vinculado por los términos revisados. Si no está de acuerdo con los nuevos términos, en su totalidad o en parte, deje de usar la Aplicación y elimínela de sus dispositivos. 11. Terminación Podemos suspender, deshabilitar o eliminar su acceso a la Aplicación, en nuestra entera discreción y sin previo aviso ni responsabilidad, por cualquier motivo, incluidos, entre otros, si consideramos que ha violado estos Términos. Al finalizar su acceso a la Aplicación, su derecho a utilizar la Aplicación cesará inmediatamente. Todas las disposiciones de estos Términos que, por su naturaleza, deban sobrevivir a la terminación, sobrevivirán a la terminación, incluidas, entre otras, las disposiciones sobre propiedad, exenciones de garantía, indemnización y limitaciones de responsabilidad. 12. Indemnización Usted acepta defender, indemnizar y mantener indemne a CAPDESIS, sus empleados, directores, funcionarios, agentes, licenciantes y proveedores de cualquier reclamo, responsabilidad, daño, juicio, premio, pérdida, costo, gasto o tarifa (incluidos los honorarios razonables de abogados) que surjan de o se relacionen con su violación de estos Términos o su uso de la Aplicación, incluidos, entre otros, cualquier uso de los contenidos, servicios y productos de la Aplicación que no estén expresamente autorizados en estos Términos o su uso de cualquier información obtenida de la Aplicación. 13. Ley aplicable y jurisdicción Estos Términos y cualquier disputa o reclamo que surja de o esté relacionado con ellos, su objeto o su formación (incluidos los litigios o reclamaciones no contractuales) se regirán e interpretarán de acuerdo con las leyes de México, sin tener en cuenta sus disposiciones sobre conflicto de leyes. Usted acepta irrevocablemente que los tribunales de México tendrán jurisdicción exclusiva para resolver cualquier disputa o reclamo que surja de o esté relacionado con estos Términos o su objeto o formación (incluidos los litigios o reclamaciones no contractuales). 14. Renuncia y divisibilidad Ninguna renuncia por parte de CAPDESIS a cualquier término o condición establecida en estos Términos se considerará una renuncia adicional o continua a dicho término o condición o una renuncia a cualquier otro término o condición, y cualquier falta de CAPDESIS para hacer valer un derecho o disposición en virtud de estos Términos no constituirá una renuncia a dicho derecho o disposición. Si algún tribunal de jurisdicción competente considera que alguna disposición de estos Términos es inválida, ilegal o inaplicable por cualquier motivo, dicha disposición se eliminará o limitará en la medida mínima necesaria para que las disposiciones restantes de los Términos continúen vigentes y aplicables. 15. Acuerdo completo Estos Términos y nuestra Política de Privacidad constituyen el único y completo acuerdo entre usted y CAPDESIS en relación con la Aplicación y sustituyen todos los acuerdos, entendimientos, promesas y garantías anteriores y contemporáneos, escritos u orales, en relación con la Aplicación. 16. Información de contacto Si tiene alguna pregunta o comentario sobre estos Términos o desea ejercer sus derechos en virtud de estos Términos, comuníquese con nosotros en: CAPDESIS formulae@capdesis.com Última actualización: 20 de abril de 2023'**
  String get terminosDeServicio;

  /// No description provided for @politicaDePrivacidad.
  ///
  /// In es, this message translates to:
  /// **'Política de Privacidad de Formulae 1. Introducción CAPDESIS (\"nosotros\", \"nos\" o \"nuestro\") se compromete a proteger y respetar su privacidad. Esta Política de Privacidad describe cómo recopilamos, utilizamos y protegemos la información personal que nos proporciona al utilizar la aplicación Formulae (\"Aplicación\"). Lea atentamente esta Política de Privacidad para comprender nuestras prácticas relacionadas con su información personal y cómo la tratamos. Al utilizar nuestra Aplicación, usted acepta la recopilación, el uso y la divulgación de su información personal de acuerdo con esta Política de Privacidad. 2. Información que recopilamos Podemos recopilar y procesar la siguiente información personal sobre usted: - Información que proporciona al registrarse y utilizar la Aplicación, como su nombre, dirección de correo electrónico y número de teléfono. - Información técnica, incluidos el tipo de dispositivo que utiliza, la dirección IP, el sistema operativo y la información de navegación. - Información sobre su uso de la Aplicación, como las funciones que utiliza y las interacciones que realiza dentro de la Aplicación. 3. Uso de la información recopilada Utilizamos la información que recopilamos sobre usted para los siguientes propósitos: - Proporcionar, mantener y mejorar la Aplicación y sus características. - Responder a sus preguntas, comentarios y solicitudes de soporte. - Personalizar su experiencia en la Aplicación y mejorar su interacción con la misma. - Proteger nuestra Aplicación, a nosotros mismos y a nuestros usuarios, y cumplir con todas las leyes y regulaciones aplicables. - Enviarle comunicaciones relacionadas con la Aplicación, como actualizaciones, notificaciones y mensajes de servicio. 4. Divulgación de su información No compartimos su información personal con terceros, excepto en las siguientes circunstancias: - Con su consentimiento previo. - Cuando sea necesario para cumplir con una obligación legal o proteger nuestros derechos o los de otros usuarios. - Cuando sea necesario para prestar servicios o realizar funciones en nuestro nombre, como proveedores de servicios de alojamiento, análisis y soporte técnico. 5. Seguridad de la información Tomamos medidas razonables para proteger su información personal de pérdida, robo, uso indebido, acceso no autorizado, divulgación, alteración y destrucción. Sin embargo, tenga en cuenta que ninguna medida de seguridad es perfecta y, por lo tanto, no podemos garantizar la seguridad total de su información personal. 6. Retención de datos Retendremos su información personal durante el tiempo que sea necesario para cumplir con los propósitos descritos en esta Política de Privacidad, a menos que la ley exija o permita un período de retención más largo. 7. Sus derechos Usted tiene derecho a acceder, actualizar, corregir, eliminar o restringir el uso de su información personal que tenemos. Puede ejercer estos derechos poniéndose en contacto con nosotros utilizando la información de contacto proporcionada al final de esta Política de Privacidad. 8. Cambios en esta Política de Privacidad Nos reservamos el derecho de modificar esta Política de Privacidad en cualquier momento. Si hacemos cambios en esta Política de Privacidad, publicaremos la política actualizada en la Aplicación y actualizaremos la fecha de \"Última actualización\" en la parte superior de este documento. Le recomendamos que revise periódicamente esta Política de Privacidad para mantenerse informado sobre nuestras prácticas de privacidad. 9. Transferencia internacional de datos Dado que CAPDESIS se encuentra en México, tenga en cuenta que la información que recopilamos, incluida su información personal, puede ser transferida, almacenada y procesada en México u otros países fuera de su país de residencia. Al utilizar nuestra Aplicación, usted acepta la transferencia de su información a México y a otros países que pueden tener leyes de protección de datos diferentes a las de su país de residencia. 10. Enlaces a sitios web de terceros Nuestra Aplicación puede contener enlaces a sitios web de terceros. No somos responsables de las prácticas de privacidad de estos sitios web de terceros. Le recomendamos que lea las políticas de privacidad de los sitios web de terceros a los que acceda a través de nuestra Aplicación. 11. Menores de edad Nuestra Aplicación no está dirigida a menores de 13 años, y no recopilamos intencionalmente información personal de menores de 13 años. Si somos informados de que hemos recopilado información personal de un menor de 13 años, tomaremos medidas para eliminar dicha información de nuestros sistemas. 12. Contáctenos Si tiene preguntas o inquietudes sobre esta Política de Privacidad o nuestras prácticas de privacidad, por favor contáctenos en: CAPDESIS Dirección: Ciudad de México, México Correo electrónico: formulae@capdesis.com Última actualización: 20 de abril de 2023'**
  String get politicaDePrivacidad;

  /// No description provided for @descargarImprimirPDF.
  ///
  /// In es, this message translates to:
  /// **'Descargar/Imprimir/Compartir PDF'**
  String get descargarImprimirPDF;

  /// No description provided for @verPDF.
  ///
  /// In es, this message translates to:
  /// **'Ver PDF'**
  String get verPDF;

  /// No description provided for @electricidad.
  ///
  /// In es, this message translates to:
  /// **'Electricidad'**
  String get electricidad;

  /// No description provided for @cargaElectrica.
  ///
  /// In es, this message translates to:
  /// **'Carga eléctrica'**
  String get cargaElectrica;

  /// No description provided for @cargaElectricaProtonElectron.
  ///
  /// In es, this message translates to:
  /// **'Carga eléctrica de protones y electrones'**
  String get cargaElectricaProtonElectron;

  /// No description provided for @distribucionesCargaElectrica.
  ///
  /// In es, this message translates to:
  /// **'Distribuciones de carga eléctrica'**
  String get distribucionesCargaElectrica;

  /// No description provided for @leyCoulomb.
  ///
  /// In es, this message translates to:
  /// **'Ley de Coulomb'**
  String get leyCoulomb;

  /// No description provided for @principioSuperposicion.
  ///
  /// In es, this message translates to:
  /// **'Principio de superposición'**
  String get principioSuperposicion;

  /// No description provided for @campoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Campo eléctrico'**
  String get campoElectrico;

  /// No description provided for @campoElectricoDistribucionesCarga.
  ///
  /// In es, this message translates to:
  /// **'Campo eléctrico originado por distribuciones de carga'**
  String get campoElectricoDistribucionesCarga;

  /// No description provided for @flujoElectricoCampoVectorial.
  ///
  /// In es, this message translates to:
  /// **'Flujo eléctrico de un campo vectorial'**
  String get flujoElectricoCampoVectorial;

  /// No description provided for @energiaPotencialElectrica.
  ///
  /// In es, this message translates to:
  /// **'Energía potencial eléctrica'**
  String get energiaPotencialElectrica;

  /// No description provided for @calculoDiferenciasPotencial.
  ///
  /// In es, this message translates to:
  /// **'Cálculo de diferencias de potencial'**
  String get calculoDiferenciasPotencial;

  /// No description provided for @teoremaDivergencia.
  ///
  /// In es, this message translates to:
  /// **'Teorema de la divergencia (Teorema de Gauss)'**
  String get teoremaDivergencia;

  /// No description provided for @teoremaRotacional.
  ///
  /// In es, this message translates to:
  /// **'Teorema del rotacional (Teorema de Stokes)'**
  String get teoremaRotacional;

  /// No description provided for @circulacionCampoElectrostatico.
  ///
  /// In es, this message translates to:
  /// **'Circulación del campo electrostático'**
  String get circulacionCampoElectrostatico;

  /// No description provided for @rotacionalCampoElectrostatico.
  ///
  /// In es, this message translates to:
  /// **'Rotacional del campo electrostático'**
  String get rotacionalCampoElectrostatico;

  /// No description provided for @operadorGradiente.
  ///
  /// In es, this message translates to:
  /// **'Operador gradiente'**
  String get operadorGradiente;

  /// No description provided for @gradienteFuncionEscalar.
  ///
  /// In es, this message translates to:
  /// **'Gradiente de una función escalar'**
  String get gradienteFuncionEscalar;

  /// No description provided for @gradientePotencialElectrico.
  ///
  /// In es, this message translates to:
  /// **'Gradiente de potencial eléctrico'**
  String get gradientePotencialElectrico;

  /// No description provided for @ecuacionPoissonLaplace.
  ///
  /// In es, this message translates to:
  /// **'Ecuación de Poisson y Laplace'**
  String get ecuacionPoissonLaplace;

  /// No description provided for @superficiesEquipotenciales.
  ///
  /// In es, this message translates to:
  /// **'Superficies equipotenciales'**
  String get superficiesEquipotenciales;

  /// No description provided for @capacitanciaDielectricos.
  ///
  /// In es, this message translates to:
  /// **'Capacitancia y Dieléctricos'**
  String get capacitanciaDielectricos;

  /// No description provided for @capacitor.
  ///
  /// In es, this message translates to:
  /// **'Capacitor'**
  String get capacitor;

  /// No description provided for @cargaCapacitor.
  ///
  /// In es, this message translates to:
  /// **'Carga de un capacitor'**
  String get cargaCapacitor;

  /// No description provided for @definicionCapacitancia.
  ///
  /// In es, this message translates to:
  /// **'Definición de capacitancia'**
  String get definicionCapacitancia;

  /// No description provided for @graficaCapacitancia.
  ///
  /// In es, this message translates to:
  /// **'Gráfica de capacitancia'**
  String get graficaCapacitancia;

  /// No description provided for @simbologiaCapacitores.
  ///
  /// In es, this message translates to:
  /// **'Simbología de capacitores'**
  String get simbologiaCapacitores;

  /// No description provided for @capacitorPlacasPlanasParalelas.
  ///
  /// In es, this message translates to:
  /// **'Capacitor de placas planas y paralelas'**
  String get capacitorPlacasPlanasParalelas;

  /// No description provided for @energiaCapacitancia.
  ///
  /// In es, this message translates to:
  /// **'Energía y capacitancia'**
  String get energiaCapacitancia;

  /// No description provided for @energiaAlmacenadaCapacitor.
  ///
  /// In es, this message translates to:
  /// **'Energía almacenada por un capacitor'**
  String get energiaAlmacenadaCapacitor;

  /// No description provided for @conexionSerieCapacitor.
  ///
  /// In es, this message translates to:
  /// **'Conexión en serie de capacitores'**
  String get conexionSerieCapacitor;

  /// No description provided for @conexionParaleloCapacitor.
  ///
  /// In es, this message translates to:
  /// **'Conexión en paralelo de capacitores'**
  String get conexionParaleloCapacitor;

  /// No description provided for @polarizacion.
  ///
  /// In es, this message translates to:
  /// **'Polarización'**
  String get polarizacion;

  /// No description provided for @polarizacionCargaInducida.
  ///
  /// In es, this message translates to:
  /// **'Polarización y carga inducida'**
  String get polarizacionCargaInducida;

  /// No description provided for @constantesDielectricas.
  ///
  /// In es, this message translates to:
  /// **'Constantes dieléctricas'**
  String get constantesDielectricas;

  /// No description provided for @rigidezDielectrica.
  ///
  /// In es, this message translates to:
  /// **'Rigidez dieléctrica'**
  String get rigidezDielectrica;

  /// No description provided for @vectorDesplazamientoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Vector de desplazamiento eléctrico'**
  String get vectorDesplazamientoElectrico;

  /// No description provided for @representacionVectoresElectricos.
  ///
  /// In es, this message translates to:
  /// **'Representación de los vectores eléctricos'**
  String get representacionVectoresElectricos;

  /// No description provided for @circuitosElectricos.
  ///
  /// In es, this message translates to:
  /// **'Circuitos eléctricos'**
  String get circuitosElectricos;

  /// No description provided for @portadoresCargaLibre.
  ///
  /// In es, this message translates to:
  /// **'Portadores de carga libre'**
  String get portadoresCargaLibre;

  /// No description provided for @movimientoPortadoresCargaLibreDensidadCorriente.
  ///
  /// In es, this message translates to:
  /// **'Movimiento de portadores de carga libre y densidad de corriente'**
  String get movimientoPortadoresCargaLibreDensidadCorriente;

  /// No description provided for @densidadCorrienteCorrienteElectrica.
  ///
  /// In es, this message translates to:
  /// **'Densidad de corriente y corriente eléctrica'**
  String get densidadCorrienteCorrienteElectrica;

  /// No description provided for @tiposCorrienteElectrica.
  ///
  /// In es, this message translates to:
  /// **'Tipos de corriente eléctrica'**
  String get tiposCorrienteElectrica;

  /// No description provided for @conductividadResistividad.
  ///
  /// In es, this message translates to:
  /// **'Conductividad y resistividad'**
  String get conductividadResistividad;

  /// No description provided for @leyOhm.
  ///
  /// In es, this message translates to:
  /// **'Ley de Ohm'**
  String get leyOhm;

  /// No description provided for @ecuacionOhm.
  ///
  /// In es, this message translates to:
  /// **'Ecuación de Ohm'**
  String get ecuacionOhm;

  /// No description provided for @resistividadTemperatura.
  ///
  /// In es, this message translates to:
  /// **'Resistividad y temperatura'**
  String get resistividadTemperatura;

  /// No description provided for @efectoJoule.
  ///
  /// In es, this message translates to:
  /// **'Efecto Joule'**
  String get efectoJoule;

  /// No description provided for @resistorSimbologiaBasica.
  ///
  /// In es, this message translates to:
  /// **'Resistor: Simbología básica'**
  String get resistorSimbologiaBasica;

  /// No description provided for @resistorLinealNoLineal.
  ///
  /// In es, this message translates to:
  /// **'Resistor: Lineal y no lineal'**
  String get resistorLinealNoLineal;

  /// No description provided for @conexionSerieResistor.
  ///
  /// In es, this message translates to:
  /// **'Conexión en serie: Resistor'**
  String get conexionSerieResistor;

  /// No description provided for @conexionParaleloResistor.
  ///
  /// In es, this message translates to:
  /// **'Conexión en paralelo: Resistor'**
  String get conexionParaleloResistor;

  /// No description provided for @fuenteFuerzaElectromotriz.
  ///
  /// In es, this message translates to:
  /// **'Fuente de fuerza electromotriz'**
  String get fuenteFuerzaElectromotriz;

  /// No description provided for @elementosCapacitorResistor.
  ///
  /// In es, this message translates to:
  /// **'Elementos: Capacitor y resistor'**
  String get elementosCapacitorResistor;

  /// No description provided for @elementosFuerzaElectromotriz.
  ///
  /// In es, this message translates to:
  /// **'Elementos: Fuerza electromotriz'**
  String get elementosFuerzaElectromotriz;

  /// No description provided for @teoriaCircuitos.
  ///
  /// In es, this message translates to:
  /// **'Teoría de circuitos'**
  String get teoriaCircuitos;

  /// No description provided for @leyVoltajesKirchhoff.
  ///
  /// In es, this message translates to:
  /// **'Ley de voltajes de Kirchhoff'**
  String get leyVoltajesKirchhoff;

  /// No description provided for @leyCorrientesKirchhoff.
  ///
  /// In es, this message translates to:
  /// **'Ley de corrientes de Kirchhoff'**
  String get leyCorrientesKirchhoff;

  /// No description provided for @reglasLVKLCK.
  ///
  /// In es, this message translates to:
  /// **'Reglas para LVK y LCK'**
  String get reglasLVKLCK;

  /// No description provided for @circuitoRCVoltajeContinuo.
  ///
  /// In es, this message translates to:
  /// **'Circuito RC y voltaje continuo'**
  String get circuitoRCVoltajeContinuo;

  /// No description provided for @leyesKirchhoffCircuitoRC.
  ///
  /// In es, this message translates to:
  /// **'Leyes de Kirchhoff: Circuito RC'**
  String get leyesKirchhoffCircuitoRC;

  /// No description provided for @nomenclaturaBasicaCircuitos.
  ///
  /// In es, this message translates to:
  /// **'Nomenclatura básica empleada en circuitos'**
  String get nomenclaturaBasicaCircuitos;

  /// No description provided for @distribuciones.
  ///
  /// In es, this message translates to:
  /// **'Distribuciones'**
  String get distribuciones;

  /// No description provided for @distribucionBinomial.
  ///
  /// In es, this message translates to:
  /// **'Distribución binomial'**
  String get distribucionBinomial;

  /// No description provided for @distribucionPoisson.
  ///
  /// In es, this message translates to:
  /// **'Distribución de Poisson'**
  String get distribucionPoisson;

  /// No description provided for @distribucionExponencial.
  ///
  /// In es, this message translates to:
  /// **'Distribución exponencial'**
  String get distribucionExponencial;

  /// No description provided for @distribucionGeometrica.
  ///
  /// In es, this message translates to:
  /// **'Distribución geométrica'**
  String get distribucionGeometrica;

  /// No description provided for @distribucionHipergeometrica.
  ///
  /// In es, this message translates to:
  /// **'Distribución hipergeométrica'**
  String get distribucionHipergeometrica;

  /// No description provided for @distribucionNormal.
  ///
  /// In es, this message translates to:
  /// **'Distribución normal'**
  String get distribucionNormal;

  /// No description provided for @distribucionTStudent.
  ///
  /// In es, this message translates to:
  /// **'Distribución t de Student'**
  String get distribucionTStudent;

  /// No description provided for @constantesDeIntegracion.
  ///
  /// In es, this message translates to:
  /// **'Constantes de integración'**
  String get constantesDeIntegracion;

  /// No description provided for @ecuacionDiferencialCoeficientesConstantes.
  ///
  /// In es, this message translates to:
  /// **'Ecuación diferencial con coeficientes constantes'**
  String get ecuacionDiferencialCoeficientesConstantes;

  /// No description provided for @ecuacionDiferencialRectasNoParalelas.
  ///
  /// In es, this message translates to:
  /// **'Ecuación diferencial de rectas no paralelas'**
  String get ecuacionDiferencialRectasNoParalelas;

  /// No description provided for @ecuacionDiferencialRectasParalelas.
  ///
  /// In es, this message translates to:
  /// **'Ecuación diferencial de rectas paralelas'**
  String get ecuacionDiferencialRectasParalelas;

  /// No description provided for @ecuacionDiferencialExacta.
  ///
  /// In es, this message translates to:
  /// **'Ecuación diferencial exacta'**
  String get ecuacionDiferencialExacta;

  /// No description provided for @ecuacionDiferencialHomogenea.
  ///
  /// In es, this message translates to:
  /// **'Ecuación diferencial homogénea'**
  String get ecuacionDiferencialHomogenea;

  /// No description provided for @ecuacionDiferencialLinealOrdenSuperior.
  ///
  /// In es, this message translates to:
  /// **'Ecuación diferencial lineal de orden superior'**
  String get ecuacionDiferencialLinealOrdenSuperior;

  /// No description provided for @ecuacionDiferencialLinealPrimerOrden.
  ///
  /// In es, this message translates to:
  /// **'Ecuación diferencial lineal de primer orden'**
  String get ecuacionDiferencialLinealPrimerOrden;

  /// No description provided for @ecuacionDiferencialSeparable.
  ///
  /// In es, this message translates to:
  /// **'Ecuación diferencial separable'**
  String get ecuacionDiferencialSeparable;

  /// No description provided for @campoYPotencialElectricos.
  ///
  /// In es, this message translates to:
  /// **'Campo y potencial eléctricos'**
  String get campoYPotencialElectricos;

  /// No description provided for @capacitanciaYDielectricos.
  ///
  /// In es, this message translates to:
  /// **'Capacitancia y dieléctricos'**
  String get capacitanciaYDielectricos;

  /// No description provided for @magnetostatica.
  ///
  /// In es, this message translates to:
  /// **'Magnetostática'**
  String get magnetostatica;

  /// No description provided for @induccionElectromagnetica.
  ///
  /// In es, this message translates to:
  /// **'Inducción electromagnética'**
  String get induccionElectromagnetica;

  /// No description provided for @teoremaDeLaCotangente.
  ///
  /// In es, this message translates to:
  /// **'Teorema de la cotangente'**
  String get teoremaDeLaCotangente;

  /// No description provided for @teoremaDelCosenoParaAngulos.
  ///
  /// In es, this message translates to:
  /// **'Teorema del coseno para ángulos'**
  String get teoremaDelCosenoParaAngulos;

  /// No description provided for @teoremaDelCosenoParaLados.
  ///
  /// In es, this message translates to:
  /// **'Teorema del coseno para lados'**
  String get teoremaDelCosenoParaLados;

  /// No description provided for @teoremaDelSeno.
  ///
  /// In es, this message translates to:
  /// **'Teorema del seno'**
  String get teoremaDelSeno;

  /// No description provided for @funcionesVectoriales.
  ///
  /// In es, this message translates to:
  /// **'Funciones vectoriales'**
  String get funcionesVectoriales;

  /// No description provided for @derivadasFuncionesVectoriales.
  ///
  /// In es, this message translates to:
  /// **'Derivadas de funciones vectoriales'**
  String get derivadasFuncionesVectoriales;

  /// No description provided for @limitesDerivadasIntegralesFuncionesVectoriales.
  ///
  /// In es, this message translates to:
  /// **'Límites, derivadas, integrales de funciones vectoriales'**
  String get limitesDerivadasIntegralesFuncionesVectoriales;

  /// No description provided for @propiedadesLogaritmos.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de logaritmos'**
  String get propiedadesLogaritmos;

  /// No description provided for @identidadesHiperbolicas.
  ///
  /// In es, this message translates to:
  /// **'Identidades hiperbólicas'**
  String get identidadesHiperbolicas;

  /// No description provided for @angulosEnUnPoligono.
  ///
  /// In es, this message translates to:
  /// **'Ángulos en un polígono'**
  String get angulosEnUnPoligono;

  /// No description provided for @areas.
  ///
  /// In es, this message translates to:
  /// **'Áreas'**
  String get areas;

  /// No description provided for @circunferencia.
  ///
  /// In es, this message translates to:
  /// **'Circunferencia'**
  String get circunferencia;

  /// No description provided for @distanciaDeUnPuntoAUnaRecta.
  ///
  /// In es, this message translates to:
  /// **'Distancia de un punto a una recta'**
  String get distanciaDeUnPuntoAUnaRecta;

  /// No description provided for @distanciaEntreDosPuntos.
  ///
  /// In es, this message translates to:
  /// **'Distancia entre dos puntos'**
  String get distanciaEntreDosPuntos;

  /// No description provided for @ecuacionDeLaRecta.
  ///
  /// In es, this message translates to:
  /// **'Ecuación de la recta'**
  String get ecuacionDeLaRecta;

  /// No description provided for @elipseConCentroDiferenteDelOrigen.
  ///
  /// In es, this message translates to:
  /// **'Elipse con centro diferente del origen'**
  String get elipseConCentroDiferenteDelOrigen;

  /// No description provided for @elipseConCentroEnElOrigen.
  ///
  /// In es, this message translates to:
  /// **'Elipse con centro en el origen'**
  String get elipseConCentroEnElOrigen;

  /// No description provided for @hiperbola.
  ///
  /// In es, this message translates to:
  /// **'Hipérbola'**
  String get hiperbola;

  /// No description provided for @parabolaConVerticeDiferenteDelOrigen.
  ///
  /// In es, this message translates to:
  /// **'Parábola con vértice diferente del origen'**
  String get parabolaConVerticeDiferenteDelOrigen;

  /// No description provided for @parabolaConVerticeEnElOrigen.
  ///
  /// In es, this message translates to:
  /// **'Parábola con vértice en el origen'**
  String get parabolaConVerticeEnElOrigen;

  /// No description provided for @puntoMedioEntreDosPuntos.
  ///
  /// In es, this message translates to:
  /// **'Punto medio entre dos puntos'**
  String get puntoMedioEntreDosPuntos;

  /// No description provided for @volumenDeCuerposGeometricos.
  ///
  /// In es, this message translates to:
  /// **'Volumen de cuerpos geométricos'**
  String get volumenDeCuerposGeometricos;

  /// No description provided for @deAnguloDobleYMedio.
  ///
  /// In es, this message translates to:
  /// **'De ángulo doble y medio'**
  String get deAnguloDobleYMedio;

  /// No description provided for @deSumaAProductoYViceversa.
  ///
  /// In es, this message translates to:
  /// **'De suma a producto y viceversa'**
  String get deSumaAProductoYViceversa;

  /// No description provided for @deSumaYRestaDeAngulos.
  ///
  /// In es, this message translates to:
  /// **'De suma y resta de ángulos'**
  String get deSumaYRestaDeAngulos;

  /// No description provided for @extras.
  ///
  /// In es, this message translates to:
  /// **'Extras'**
  String get extras;

  /// No description provided for @fundamentales.
  ///
  /// In es, this message translates to:
  /// **'Fundamentales'**
  String get fundamentales;

  /// No description provided for @generadorHomopolar.
  ///
  /// In es, this message translates to:
  /// **'Generador homopolar'**
  String get generadorHomopolar;

  /// No description provided for @inductanciaPropia.
  ///
  /// In es, this message translates to:
  /// **'Inductancia propia'**
  String get inductanciaPropia;

  /// No description provided for @inductanciaMutua.
  ///
  /// In es, this message translates to:
  /// **'Inductancia mutua'**
  String get inductanciaMutua;

  /// No description provided for @inductanciaPropiaDeUnSolenoide.
  ///
  /// In es, this message translates to:
  /// **'Inductancia propia de un solenoide'**
  String get inductanciaPropiaDeUnSolenoide;

  /// No description provided for @inductanciaParaUnToroide.
  ///
  /// In es, this message translates to:
  /// **'Inductancia para un toroide'**
  String get inductanciaParaUnToroide;

  /// No description provided for @inductanciaMutuaEntreDosSolenoidesCoaxiales.
  ///
  /// In es, this message translates to:
  /// **'Inductancia mutua entre dos solenoides coaxiales'**
  String get inductanciaMutuaEntreDosSolenoidesCoaxiales;

  /// No description provided for @leyDeInduccionDeFaradayYEnergisEnUnInductor.
  ///
  /// In es, this message translates to:
  /// **'Ley de inducción de Faraday y energía en un inductor'**
  String get leyDeInduccionDeFaradayYEnergisEnUnInductor;

  /// No description provided for @energiaAlmacenadaEnUnCampoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'Energía almacenada en un campo magnético'**
  String get energiaAlmacenadaEnUnCampoMagnetico;

  /// No description provided for @inductor.
  ///
  /// In es, this message translates to:
  /// **'Inductor'**
  String get inductor;

  /// No description provided for @inductoresEnSerie.
  ///
  /// In es, this message translates to:
  /// **'Inductores en serie'**
  String get inductoresEnSerie;

  /// No description provided for @propiedadesDeLosLimites.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de los límites'**
  String get propiedadesDeLosLimites;

  /// No description provided for @limitesTrigonometricos.
  ///
  /// In es, this message translates to:
  /// **'Límites trigonométricos'**
  String get limitesTrigonometricos;

  /// No description provided for @descripcionDeLosImanesYExperimentosDeOersted.
  ///
  /// In es, this message translates to:
  /// **'Descripción de los imanes y experimentos de Oersted'**
  String get descripcionDeLosImanesYExperimentosDeOersted;

  /// No description provided for @fuerzaMagneticaComoVectorSobreCargasEnMovimiento.
  ///
  /// In es, this message translates to:
  /// **'Fuerza magnética, como vector, sobre cargas en movimiento'**
  String get fuerzaMagneticaComoVectorSobreCargasEnMovimiento;

  /// No description provided for @definicionDeCampoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'Definición de campo magnético'**
  String get definicionDeCampoMagnetico;

  /// No description provided for @fuerzaDeLorentz.
  ///
  /// In es, this message translates to:
  /// **'Fuerza de Lorentz'**
  String get fuerzaDeLorentz;

  /// No description provided for @leyDeBiotSavart.
  ///
  /// In es, this message translates to:
  /// **'Ley de Biot-Savart'**
  String get leyDeBiotSavart;

  /// No description provided for @segmentoConductorRecto.
  ///
  /// In es, this message translates to:
  /// **'Segmento conductor recto'**
  String get segmentoConductorRecto;

  /// No description provided for @espiraEnFormaDeCircunferencia.
  ///
  /// In es, this message translates to:
  /// **'Espira en forma de circunferencia'**
  String get espiraEnFormaDeCircunferencia;

  /// No description provided for @espiraCuadrada.
  ///
  /// In es, this message translates to:
  /// **'Espira cuadrada'**
  String get espiraCuadrada;

  /// No description provided for @bobina.
  ///
  /// In es, this message translates to:
  /// **'Bobina'**
  String get bobina;

  /// No description provided for @solenoide.
  ///
  /// In es, this message translates to:
  /// **'Solenoide'**
  String get solenoide;

  /// No description provided for @circulacionDeUnCampoVectorial.
  ///
  /// In es, this message translates to:
  /// **'Circulación de un campo vectorial'**
  String get circulacionDeUnCampoVectorial;

  /// No description provided for @campoMagneticoAPartirDeLeyDeAmpere.
  ///
  /// In es, this message translates to:
  /// **'Campo magnético a partir de la Ley de Ampère'**
  String get campoMagneticoAPartirDeLeyDeAmpere;

  /// No description provided for @flujoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'Flujo magnético'**
  String get flujoMagnetico;

  /// No description provided for @motorDeCorrienteDirecta.
  ///
  /// In es, this message translates to:
  /// **'Motor de corriente directa'**
  String get motorDeCorrienteDirecta;

  /// No description provided for @bicondicional.
  ///
  /// In es, this message translates to:
  /// **'Bicondicional'**
  String get bicondicional;

  /// No description provided for @condicional.
  ///
  /// In es, this message translates to:
  /// **'Condicional'**
  String get condicional;

  /// No description provided for @conectoresLogicos.
  ///
  /// In es, this message translates to:
  /// **'Conectores lógicos'**
  String get conectoresLogicos;

  /// No description provided for @conjuncion.
  ///
  /// In es, this message translates to:
  /// **'Conjunción'**
  String get conjuncion;

  /// No description provided for @disyuncion.
  ///
  /// In es, this message translates to:
  /// **'Disyunción'**
  String get disyuncion;

  /// No description provided for @leyesDeLaLogicaProposicional.
  ///
  /// In es, this message translates to:
  /// **'Leyes de la lógica proposicional'**
  String get leyesDeLaLogicaProposicional;

  /// No description provided for @leyesDeLaTeoriaDeConjuntos.
  ///
  /// In es, this message translates to:
  /// **'Leyes de la teoría de conjuntos'**
  String get leyesDeLaTeoriaDeConjuntos;

  /// No description provided for @leyesDelAlgebraDeBoole.
  ///
  /// In es, this message translates to:
  /// **'Leyes del álgebra de Boole'**
  String get leyesDelAlgebraDeBoole;

  /// No description provided for @negacion.
  ///
  /// In es, this message translates to:
  /// **'Negación'**
  String get negacion;

  /// No description provided for @anualidadAnticipadaSimpleYCierta.
  ///
  /// In es, this message translates to:
  /// **'Anualidad anticipada simple y cierta'**
  String get anualidadAnticipadaSimpleYCierta;

  /// No description provided for @anualidadVencidaSimpleYCierta.
  ///
  /// In es, this message translates to:
  /// **'Anualidad vencida simple y cierta'**
  String get anualidadVencidaSimpleYCierta;

  /// No description provided for @descuentoCompuesto.
  ///
  /// In es, this message translates to:
  /// **'Descuento compuesto'**
  String get descuentoCompuesto;

  /// No description provided for @descuentoSimple.
  ///
  /// In es, this message translates to:
  /// **'Descuento simple'**
  String get descuentoSimple;

  /// No description provided for @interesCompuesto.
  ///
  /// In es, this message translates to:
  /// **'Interés compuesto'**
  String get interesCompuesto;

  /// No description provided for @interesSimple.
  ///
  /// In es, this message translates to:
  /// **'Interés simple'**
  String get interesSimple;

  /// No description provided for @tasaDeInteresGlobal.
  ///
  /// In es, this message translates to:
  /// **'Tasa de interés global'**
  String get tasaDeInteresGlobal;

  /// No description provided for @matrizAdjunta.
  ///
  /// In es, this message translates to:
  /// **'Matriz adjunta'**
  String get matrizAdjunta;

  /// No description provided for @matrizIdentidad.
  ///
  /// In es, this message translates to:
  /// **'Matriz identidad'**
  String get matrizIdentidad;

  /// No description provided for @matrizInversa.
  ///
  /// In es, this message translates to:
  /// **'Matriz inversa'**
  String get matrizInversa;

  /// No description provided for @matrizOrtogonal.
  ///
  /// In es, this message translates to:
  /// **'Matriz ortogonal'**
  String get matrizOrtogonal;

  /// No description provided for @matrizSimetrica.
  ///
  /// In es, this message translates to:
  /// **'Matriz simétrica'**
  String get matrizSimetrica;

  /// No description provided for @matrizTranspuesta.
  ///
  /// In es, this message translates to:
  /// **'Matriz transpuesta'**
  String get matrizTranspuesta;

  /// No description provided for @matrizTriangular.
  ///
  /// In es, this message translates to:
  /// **'Matriz triangular'**
  String get matrizTriangular;

  /// No description provided for @multiplicacionDeMatrices.
  ///
  /// In es, this message translates to:
  /// **'Multiplicación de matrices'**
  String get multiplicacionDeMatrices;

  /// No description provided for @propiedadesDeLasMatrices.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de las matrices'**
  String get propiedadesDeLasMatrices;

  /// No description provided for @sumaYRestaDeMatrices.
  ///
  /// In es, this message translates to:
  /// **'Suma y resta de matrices'**
  String get sumaYRestaDeMatrices;

  /// No description provided for @medidas.
  ///
  /// In es, this message translates to:
  /// **'Medidas'**
  String get medidas;

  /// No description provided for @dispersionParaDatosNoAgrupados.
  ///
  /// In es, this message translates to:
  /// **'Dispersión para datos no agrupados'**
  String get dispersionParaDatosNoAgrupados;

  /// No description provided for @posicionParaDatosNoAgrupados.
  ///
  /// In es, this message translates to:
  /// **'Posición para datos no agrupados'**
  String get posicionParaDatosNoAgrupados;

  /// No description provided for @tendenciaCentralParaDatosAgrupados.
  ///
  /// In es, this message translates to:
  /// **'Tendencia central para datos agrupados'**
  String get tendenciaCentralParaDatosAgrupados;

  /// No description provided for @tendenciaCentralParaDatosNoAgrupados.
  ///
  /// In es, this message translates to:
  /// **'Tendencia central para datos no agrupados'**
  String get tendenciaCentralParaDatosNoAgrupados;

  /// No description provided for @conjugadoDeUnNumeroComplejo.
  ///
  /// In es, this message translates to:
  /// **'Conjugado de un número complejo'**
  String get conjugadoDeUnNumeroComplejo;

  /// No description provided for @moduloYArgumentoDeUnNumeroComplejo.
  ///
  /// In es, this message translates to:
  /// **'Módulo y argumento de un número complejo'**
  String get moduloYArgumentoDeUnNumeroComplejo;

  /// No description provided for @operacionesDeNumerosComplejos.
  ///
  /// In es, this message translates to:
  /// **'Operaciones de números complejos'**
  String get operacionesDeNumerosComplejos;

  /// No description provided for @propiedadesDeLosNumerosComplejos.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de los números complejos'**
  String get propiedadesDeLosNumerosComplejos;

  /// No description provided for @representacionesDeUnNumeroComplejo.
  ///
  /// In es, this message translates to:
  /// **'Representaciones de un número complejo'**
  String get representacionesDeUnNumeroComplejo;

  /// No description provided for @combinacionesYPermutaciones.
  ///
  /// In es, this message translates to:
  /// **'Combinaciones y permutaciones'**
  String get combinacionesYPermutaciones;

  /// No description provided for @cuantilesParaDatosAgrupados.
  ///
  /// In es, this message translates to:
  /// **'Cuantiles para datos agrupados'**
  String get cuantilesParaDatosAgrupados;

  /// No description provided for @estadisticaInferencial.
  ///
  /// In es, this message translates to:
  /// **'Estadística inferencial'**
  String get estadisticaInferencial;

  /// No description provided for @intervalosDeConfianza.
  ///
  /// In es, this message translates to:
  /// **'Intervalos de confianza'**
  String get intervalosDeConfianza;

  /// No description provided for @mediaGeometrica.
  ///
  /// In es, this message translates to:
  /// **'Media geométrica'**
  String get mediaGeometrica;

  /// No description provided for @momentosEstadisticos.
  ///
  /// In es, this message translates to:
  /// **'Momentos estadísticos'**
  String get momentosEstadisticos;

  /// No description provided for @probabilidad.
  ///
  /// In es, this message translates to:
  /// **'Probabilidad'**
  String get probabilidad;

  /// No description provided for @tamanioMuestral.
  ///
  /// In es, this message translates to:
  /// **'Tamaño muestral'**
  String get tamanioMuestral;

  /// No description provided for @convolucion.
  ///
  /// In es, this message translates to:
  /// **'Convolución'**
  String get convolucion;

  /// No description provided for @formaComplejaDeLasSeriesDeFourier.
  ///
  /// In es, this message translates to:
  /// **'Forma compleja de las series de Fourier'**
  String get formaComplejaDeLasSeriesDeFourier;

  /// No description provided for @formulasOperacionalesDeLaTransformadaDeLaplace.
  ///
  /// In es, this message translates to:
  /// **'Fórmulas operacionales de la Transformada de Laplace'**
  String get formulasOperacionalesDeLaTransformadaDeLaplace;

  /// No description provided for @funcionImpulsoUnitario.
  ///
  /// In es, this message translates to:
  /// **'Función impulso unitario'**
  String get funcionImpulsoUnitario;

  /// No description provided for @funcionUnitariaDeHeaviside.
  ///
  /// In es, this message translates to:
  /// **'Función unitaria de Heaviside'**
  String get funcionUnitariaDeHeaviside;

  /// No description provided for @serieYCoeficientesDeFourier.
  ///
  /// In es, this message translates to:
  /// **'Serie y coeficientes de Fourier'**
  String get serieYCoeficientesDeFourier;

  /// No description provided for @transformadas.
  ///
  /// In es, this message translates to:
  /// **'Transformadas'**
  String get transformadas;

  /// No description provided for @simetrias.
  ///
  /// In es, this message translates to:
  /// **'Simetrías'**
  String get simetrias;

  /// No description provided for @simetriaDeMediaOnda.
  ///
  /// In es, this message translates to:
  /// **'Simetría de media onda'**
  String get simetriaDeMediaOnda;

  /// No description provided for @simetriaDeUnCuartoDeOndaImpar.
  ///
  /// In es, this message translates to:
  /// **'Simetría de un cuarto de onda impar'**
  String get simetriaDeUnCuartoDeOndaImpar;

  /// No description provided for @simetriaDeUnCuartoDeOndaPar.
  ///
  /// In es, this message translates to:
  /// **'Simetría de un cuarto de onda par'**
  String get simetriaDeUnCuartoDeOndaPar;

  /// No description provided for @simetriaImpar.
  ///
  /// In es, this message translates to:
  /// **'Simetría impar'**
  String get simetriaImpar;

  /// No description provided for @simetriaPar.
  ///
  /// In es, this message translates to:
  /// **'Simetría par'**
  String get simetriaPar;

  /// No description provided for @ecuacionesDePrimerGrado.
  ///
  /// In es, this message translates to:
  /// **'Ecuaciones de primer grado'**
  String get ecuacionesDePrimerGrado;

  /// No description provided for @ecuacionesDeSegundoGrado.
  ///
  /// In es, this message translates to:
  /// **'Ecuaciones de segundo grado'**
  String get ecuacionesDeSegundoGrado;

  /// No description provided for @transformadaDeFourier.
  ///
  /// In es, this message translates to:
  /// **'Transformada de Fourier'**
  String get transformadaDeFourier;

  /// No description provided for @transformadaDeLaplace.
  ///
  /// In es, this message translates to:
  /// **'Transformada de Laplace'**
  String get transformadaDeLaplace;

  /// No description provided for @transformadaSenoYCosenoDeFourier.
  ///
  /// In es, this message translates to:
  /// **'Transformada seno y coseno de Fourier'**
  String get transformadaSenoYCosenoDeFourier;

  /// No description provided for @transformadasBasicasDeFourier.
  ///
  /// In es, this message translates to:
  /// **'Transformadas básicas de Fourier'**
  String get transformadasBasicasDeFourier;

  /// No description provided for @transformadasDeFourier.
  ///
  /// In es, this message translates to:
  /// **'Transformadas de Fourier'**
  String get transformadasDeFourier;

  /// No description provided for @transformadasDeLaplace.
  ///
  /// In es, this message translates to:
  /// **'Transformadas de Laplace'**
  String get transformadasDeLaplace;

  /// No description provided for @formulasDeBessel.
  ///
  /// In es, this message translates to:
  /// **'Fórmulas de Bessel'**
  String get formulasDeBessel;

  /// No description provided for @funcionesTrigonometricasDeAngulosNotables.
  ///
  /// In es, this message translates to:
  /// **'Funciones trigonométricas de ángulos notables'**
  String get funcionesTrigonometricasDeAngulosNotables;

  /// No description provided for @identidadesTrigonometricas.
  ///
  /// In es, this message translates to:
  /// **'Identidades trigonométricas'**
  String get identidadesTrigonometricas;

  /// No description provided for @identidadesTrigonometricasExtras.
  ///
  /// In es, this message translates to:
  /// **'Identidades trigonométricas Extras'**
  String get identidadesTrigonometricasExtras;

  /// No description provided for @leyDeProyecciones.
  ///
  /// In es, this message translates to:
  /// **'Ley de proyecciones'**
  String get leyDeProyecciones;

  /// No description provided for @leyDeSenosCosenosYTangente.
  ///
  /// In es, this message translates to:
  /// **'Ley de senos, cosenos y tangente'**
  String get leyDeSenosCosenosYTangente;

  /// No description provided for @medicionYClasificacionDeAngulos.
  ///
  /// In es, this message translates to:
  /// **'Medición y clasificación de ángulos'**
  String get medicionYClasificacionDeAngulos;

  /// No description provided for @superficieDeUnTrianguloYUnPoligonoEsferico.
  ///
  /// In es, this message translates to:
  /// **'Superficie de un triángulo y un polígono esférico'**
  String get superficieDeUnTrianguloYUnPoligonoEsferico;

  /// No description provided for @teoremaDePitagoras.
  ///
  /// In es, this message translates to:
  /// **'Teorema de Pitágoras'**
  String get teoremaDePitagoras;

  /// No description provided for @trigonometriaEsferica.
  ///
  /// In es, this message translates to:
  /// **'Trigonometría esférica'**
  String get trigonometriaEsferica;

  /// No description provided for @valoresDeSenoYCoseno.
  ///
  /// In es, this message translates to:
  /// **'Valores de seno y coseno'**
  String get valoresDeSenoYCoseno;

  /// No description provided for @analogiasDeGaussDelambre.
  ///
  /// In es, this message translates to:
  /// **'Analogías de Gauss Delambre'**
  String get analogiasDeGaussDelambre;

  /// No description provided for @analogiasDeNeper.
  ///
  /// In es, this message translates to:
  /// **'Analogías de Neper'**
  String get analogiasDeNeper;

  /// No description provided for @funcionesDelAnguloMitad.
  ///
  /// In es, this message translates to:
  /// **'Funciones del ángulo mitad'**
  String get funcionesDelAnguloMitad;

  /// No description provided for @anguloEntreVectores.
  ///
  /// In es, this message translates to:
  /// **'Ángulo entre vectores'**
  String get anguloEntreVectores;

  /// No description provided for @normalizacion.
  ///
  /// In es, this message translates to:
  /// **'Normalización'**
  String get normalizacion;

  /// No description provided for @operacionesConVectores.
  ///
  /// In es, this message translates to:
  /// **'Operaciones con vectores'**
  String get operacionesConVectores;

  /// No description provided for @productoCruz.
  ///
  /// In es, this message translates to:
  /// **'Producto cruz'**
  String get productoCruz;

  /// No description provided for @productoPunto.
  ///
  /// In es, this message translates to:
  /// **'Producto punto'**
  String get productoPunto;

  /// No description provided for @propiedadesDeLosVectores.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de los vectores'**
  String get propiedadesDeLosVectores;

  /// No description provided for @proyeccionesDeVectores.
  ///
  /// In es, this message translates to:
  /// **'Proyecciones de vectores'**
  String get proyeccionesDeVectores;

  /// No description provided for @vectorUnitario.
  ///
  /// In es, this message translates to:
  /// **'Vector unitario'**
  String get vectorUnitario;

  /// No description provided for @vectoresYSuMagnitud.
  ///
  /// In es, this message translates to:
  /// **'Vectores y su magnitud'**
  String get vectoresYSuMagnitud;

  /// No description provided for @solucion.
  ///
  /// In es, this message translates to:
  /// **'Solución'**
  String get solucion;

  /// No description provided for @lasSolucionesSonImaginarias.
  ///
  /// In es, this message translates to:
  /// **'Las soluciones son imaginarias'**
  String get lasSolucionesSonImaginarias;

  /// No description provided for @formulaAplicada.
  ///
  /// In es, this message translates to:
  /// **'Fórmula aplicada'**
  String get formulaAplicada;

  /// No description provided for @soluciones.
  ///
  /// In es, this message translates to:
  /// **'Soluciones'**
  String get soluciones;

  /// No description provided for @propiedadesDelConjugado.
  ///
  /// In es, this message translates to:
  /// **'Propiedades del conjugado'**
  String get propiedadesDelConjugado;

  /// No description provided for @conjugado.
  ///
  /// In es, this message translates to:
  /// **'Conjugado'**
  String get conjugado;

  /// No description provided for @numeroComplejo.
  ///
  /// In es, this message translates to:
  /// **'Número complejo'**
  String get numeroComplejo;

  /// No description provided for @modulo.
  ///
  /// In es, this message translates to:
  /// **'Módulo'**
  String get modulo;

  /// No description provided for @argumento.
  ///
  /// In es, this message translates to:
  /// **'Argumento'**
  String get argumento;

  /// No description provided for @propiedadesDelValorAbsoluto.
  ///
  /// In es, this message translates to:
  /// **'Propiedades del valor absoluto'**
  String get propiedadesDelValorAbsoluto;

  /// No description provided for @enFormaBinomica.
  ///
  /// In es, this message translates to:
  /// **'En forma binómica'**
  String get enFormaBinomica;

  /// No description provided for @adicion.
  ///
  /// In es, this message translates to:
  /// **'Adición'**
  String get adicion;

  /// No description provided for @sustraccion.
  ///
  /// In es, this message translates to:
  /// **'Sustracción'**
  String get sustraccion;

  /// No description provided for @multiplicacion.
  ///
  /// In es, this message translates to:
  /// **'Multiplicación'**
  String get multiplicacion;

  /// No description provided for @division.
  ///
  /// In es, this message translates to:
  /// **'División'**
  String get division;

  /// No description provided for @enFormaPolar.
  ///
  /// In es, this message translates to:
  /// **'En forma polar'**
  String get enFormaPolar;

  /// No description provided for @potencia.
  ///
  /// In es, this message translates to:
  /// **'Potencia'**
  String get potencia;

  /// No description provided for @raices.
  ///
  /// In es, this message translates to:
  /// **'Raíces'**
  String get raices;

  /// No description provided for @moduloDeLasRaices.
  ///
  /// In es, this message translates to:
  /// **'Módulo de las raíces'**
  String get moduloDeLasRaices;

  /// No description provided for @argumentosDeLasRaices.
  ///
  /// In es, this message translates to:
  /// **'Argumentos de las raíces'**
  String get argumentosDeLasRaices;

  /// No description provided for @desdeKHastaN.
  ///
  /// In es, this message translates to:
  /// **'Desde k = 0 hasta k = n-1'**
  String get desdeKHastaN;

  /// No description provided for @propiedades.
  ///
  /// In es, this message translates to:
  /// **'Propiedades'**
  String get propiedades;

  /// No description provided for @potenciasDeLaUnidadImaginaria.
  ///
  /// In es, this message translates to:
  /// **'Potencias de la unidad imaginaria'**
  String get potenciasDeLaUnidadImaginaria;

  /// No description provided for @formaPolar.
  ///
  /// In es, this message translates to:
  /// **'Forma polar'**
  String get formaPolar;

  /// No description provided for @propiedadAditivaDeLaIgualdad.
  ///
  /// In es, this message translates to:
  /// **'Propiedad aditiva de la igualdad'**
  String get propiedadAditivaDeLaIgualdad;

  /// No description provided for @propiedadMultiplicativaDeLaIgualdad.
  ///
  /// In es, this message translates to:
  /// **'Propiedad multiplicativa de la igualdad'**
  String get propiedadMultiplicativaDeLaIgualdad;

  /// No description provided for @ecuacionesConValorAbsoluto.
  ///
  /// In es, this message translates to:
  /// **'Ecuaciones con valor absoluto'**
  String get ecuacionesConValorAbsoluto;

  /// No description provided for @caracteristicas.
  ///
  /// In es, this message translates to:
  /// **'Características'**
  String get caracteristicas;

  /// No description provided for @si.
  ///
  /// In es, this message translates to:
  /// **'Si'**
  String get si;

  /// No description provided for @lasRaicesSonRealesEIguales.
  ///
  /// In es, this message translates to:
  /// **'Las raíces son reales e iguales'**
  String get lasRaicesSonRealesEIguales;

  /// No description provided for @lasRaicesNoSonReales.
  ///
  /// In es, this message translates to:
  /// **'Las raíces no son reales (tienen solución imaginaria)'**
  String get lasRaicesNoSonReales;

  /// No description provided for @lasRaicesSonRealesYDeDiferenteValor.
  ///
  /// In es, this message translates to:
  /// **'Las raíces son reales y de diferente valor'**
  String get lasRaicesSonRealesYDeDiferenteValor;

  /// No description provided for @propiedadTransitiva.
  ///
  /// In es, this message translates to:
  /// **'Propiedad transitiva'**
  String get propiedadTransitiva;

  /// No description provided for @propiedadDeLaNoNegatividad.
  ///
  /// In es, this message translates to:
  /// **'Propiedad de la no negatividad'**
  String get propiedadDeLaNoNegatividad;

  /// No description provided for @propiedadDelReciproco.
  ///
  /// In es, this message translates to:
  /// **'Propiedad del recíproco'**
  String get propiedadDelReciproco;

  /// No description provided for @propiedadesDeLosRadicales.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de los radicales'**
  String get propiedadesDeLosRadicales;

  /// No description provided for @seriesDeTaylorYMaclaurin.
  ///
  /// In es, this message translates to:
  /// **'Series de Taylor y Maclaurin'**
  String get seriesDeTaylorYMaclaurin;

  /// No description provided for @serieDeTaylor.
  ///
  /// In es, this message translates to:
  /// **'Serie de Taylor'**
  String get serieDeTaylor;

  /// No description provided for @serieDeMaclaurin.
  ///
  /// In es, this message translates to:
  /// **'Serie de Maclaurin'**
  String get serieDeMaclaurin;

  /// No description provided for @serieDePotencias.
  ///
  /// In es, this message translates to:
  /// **'Serie de potencias'**
  String get serieDePotencias;

  /// No description provided for @teoremaDeSumatorias.
  ///
  /// In es, this message translates to:
  /// **'Teorema de sumatorias'**
  String get teoremaDeSumatorias;

  /// No description provided for @matrizTranspuestaDeCofactoresDeA.
  ///
  /// In es, this message translates to:
  /// **'Matriz transpuesta de cofactores de A'**
  String get matrizTranspuestaDeCofactoresDeA;

  /// No description provided for @elCofactorSeDefineComo.
  ///
  /// In es, this message translates to:
  /// **'El cofactor se define como'**
  String get elCofactorSeDefineComo;

  /// No description provided for @matrizIdentidadI.
  ///
  /// In es, this message translates to:
  /// **'Matriz identidad (I)'**
  String get matrizIdentidadI;

  /// No description provided for @propiedadesDeLaMatrizIdentidad.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de la matriz identidad'**
  String get propiedadesDeLaMatrizIdentidad;

  /// No description provided for @laDiagonalPrincipalEstaCompuestaPorUnos.
  ///
  /// In es, this message translates to:
  /// **'La diagonal principal está compuesta por unos'**
  String get laDiagonalPrincipalEstaCompuestaPorUnos;

  /// No description provided for @propiedadesDeLaMatrizInversa.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de la matriz inversa'**
  String get propiedadesDeLaMatrizInversa;

  /// No description provided for @propiedadesDeLaMatrizOrtogonal.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de la matriz ortogonal'**
  String get propiedadesDeLaMatrizOrtogonal;

  /// No description provided for @laInversaDeUnaOrtogonalEsUnaMatrizOrtogonal.
  ///
  /// In es, this message translates to:
  /// **'La inversa de una ortogonal es una matriz ortogonal. El producto de dos ortogonales es una matriz ortogonal'**
  String get laInversaDeUnaOrtogonalEsUnaMatrizOrtogonal;

  /// No description provided for @propiedadesDeLaMatrizSimetrica.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de la matriz simétrica'**
  String get propiedadesDeLaMatrizSimetrica;

  /// No description provided for @losElementosArribaYAbajoDeLaDiagonalSonLosMismos.
  ///
  /// In es, this message translates to:
  /// **'Los elementos arriba y abajo de la diagonal son los mismos'**
  String get losElementosArribaYAbajoDeLaDiagonalSonLosMismos;

  /// No description provided for @propiedadesDeLaMatrizTranspuesta.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de la matriz transpuesta'**
  String get propiedadesDeLaMatrizTranspuesta;

  /// No description provided for @seCambianLasFilasPorLasColumnas.
  ///
  /// In es, this message translates to:
  /// **'Se cambian las filas por las columnas'**
  String get seCambianLasFilasPorLasColumnas;

  /// No description provided for @propiedadesDeLaMatrizTriangular.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de la matriz triangular'**
  String get propiedadesDeLaMatrizTriangular;

  /// No description provided for @ejerciciosPropiedadesDeLosExponentes.
  ///
  /// In es, this message translates to:
  /// **'Ejercicios propiedades de los exponentes'**
  String get ejerciciosPropiedadesDeLosExponentes;

  /// No description provided for @derivadasDeFuncionesExponencialYLogaritmos.
  ///
  /// In es, this message translates to:
  /// **'Derivadas de Funciones Exponencial y Logaritmos'**
  String get derivadasDeFuncionesExponencialYLogaritmos;

  /// No description provided for @derivadasDeFuncionesTrigonometricas.
  ///
  /// In es, this message translates to:
  /// **'Derivadas de Funciones Trigonométricas'**
  String get derivadasDeFuncionesTrigonometricas;

  /// No description provided for @derivadasDeFuncionesTrigonometricasInversas.
  ///
  /// In es, this message translates to:
  /// **'Derivadas de Funciones Trigonométricas Inversas'**
  String get derivadasDeFuncionesTrigonometricasInversas;

  /// No description provided for @derivadasDeFuncionesTrigonometriasHiperbolicas.
  ///
  /// In es, this message translates to:
  /// **'Derivadas de Funciones Trigonométrias Hiperbólicas'**
  String get derivadasDeFuncionesTrigonometriasHiperbolicas;

  /// No description provided for @integralesDelExponencialYLogaritmos.
  ///
  /// In es, this message translates to:
  /// **'Integrales del Exponencial y Logaritmos'**
  String get integralesDelExponencialYLogaritmos;

  /// No description provided for @integralesDeFuncionesTrigonometricasHiperbolicas.
  ///
  /// In es, this message translates to:
  /// **'Integrales de Funciones Trigonométricas Hiperbolicas'**
  String get integralesDeFuncionesTrigonometricasHiperbolicas;

  /// No description provided for @integralesDeFuncionesTrigonometricas.
  ///
  /// In es, this message translates to:
  /// **'Integrales de Funciones Trigonométricas'**
  String get integralesDeFuncionesTrigonometricas;

  /// No description provided for @integralesDeFuncionesTrigonometricasInversas.
  ///
  /// In es, this message translates to:
  /// **'Integrales de Funciones Trigonométricas Inversas'**
  String get integralesDeFuncionesTrigonometricasInversas;

  /// No description provided for @derivadaFuncionesVectoriales.
  ///
  /// In es, this message translates to:
  /// **'Derivada Funciones Vectoriales'**
  String get derivadaFuncionesVectoriales;

  /// No description provided for @preguntasFrecuentes.
  ///
  /// In es, this message translates to:
  /// **'Preguntas frecuentes'**
  String get preguntasFrecuentes;

  /// No description provided for @informacion.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get informacion;

  /// No description provided for @verApp.
  ///
  /// In es, this message translates to:
  /// **'Ver app'**
  String get verApp;

  /// No description provided for @compartirApp.
  ///
  /// In es, this message translates to:
  /// **'Compartir app'**
  String get compartirApp;

  /// No description provided for @paginaWeb.
  ///
  /// In es, this message translates to:
  /// **'Página web'**
  String get paginaWeb;

  /// No description provided for @mejorarApp.
  ///
  /// In es, this message translates to:
  /// **'Mejorar app'**
  String get mejorarApp;

  /// No description provided for @menu.
  ///
  /// In es, this message translates to:
  /// **'Menú'**
  String get menu;

  /// No description provided for @tareas.
  ///
  /// In es, this message translates to:
  /// **'Tareas'**
  String get tareas;

  /// No description provided for @busqueda.
  ///
  /// In es, this message translates to:
  /// **'Búsqueda'**
  String get busqueda;

  /// No description provided for @suscribeteParaAcceder.
  ///
  /// In es, this message translates to:
  /// **'Suscríbete para acceder'**
  String get suscribeteParaAcceder;

  /// No description provided for @chatIlimitadoPremium.
  ///
  /// In es, this message translates to:
  /// **'Chat ilimitado premium'**
  String get chatIlimitadoPremium;

  /// No description provided for @eliminarTodasLasTareas.
  ///
  /// In es, this message translates to:
  /// **'Eliminar todas las tareas'**
  String get eliminarTodasLasTareas;

  /// No description provided for @estasSeguroDeEliminarTodasLasTareas.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de eliminar TODAS las tareas?'**
  String get estasSeguroDeEliminarTodasLasTareas;

  /// No description provided for @cancelar.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancelar;

  /// No description provided for @eliminarDeFavoritos.
  ///
  /// In es, this message translates to:
  /// **'Eliminar de favoritos'**
  String get eliminarDeFavoritos;

  /// No description provided for @estasSeguroQueDeseasEliminarTodosLosFavoritos.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro que deseas eliminar TODOS los favoritos?'**
  String get estasSeguroQueDeseasEliminarTodosLosFavoritos;

  /// No description provided for @comoPonerNumerosNegativos.
  ///
  /// In es, this message translates to:
  /// **'Cómo poner números negativos'**
  String get comoPonerNumerosNegativos;

  /// No description provided for @lasFormulasSeVenCortadas.
  ///
  /// In es, this message translates to:
  /// **'Las fórmulas se ven cortadas'**
  String get lasFormulasSeVenCortadas;

  /// No description provided for @resultadoNan.
  ///
  /// In es, this message translates to:
  /// **'Resultado NaN'**
  String get resultadoNan;

  /// No description provided for @comoTrabajarConLosPdf.
  ///
  /// In es, this message translates to:
  /// **'Cómo trabajar con los PDF'**
  String get comoTrabajarConLosPdf;

  /// No description provided for @noCarganLosVideos.
  ///
  /// In es, this message translates to:
  /// **'No cargan los vídeos'**
  String get noCarganLosVideos;

  /// No description provided for @noCarganLosPdf.
  ///
  /// In es, this message translates to:
  /// **'No cargan los PDF'**
  String get noCarganLosPdf;

  /// No description provided for @notas.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get notas;

  /// No description provided for @indiceDeLaRaiz.
  ///
  /// In es, this message translates to:
  /// **'Índice de la raíz'**
  String get indiceDeLaRaiz;

  /// No description provided for @parteReal.
  ///
  /// In es, this message translates to:
  /// **'Parte real'**
  String get parteReal;

  /// No description provided for @parteImaginaria.
  ///
  /// In es, this message translates to:
  /// **'Parte imaginaria'**
  String get parteImaginaria;

  /// No description provided for @propiedadesExponentesTexto.
  ///
  /// In es, this message translates to:
  /// **'Las propiedades de los exponentes permiten simplificar y reducir operaciones en la multiplicación y división con potencias.'**
  String get propiedadesExponentesTexto;

  /// No description provided for @nVeces.
  ///
  /// In es, this message translates to:
  /// **'n veces'**
  String get nVeces;

  /// No description provided for @aDiferenteDeCero.
  ///
  /// In es, this message translates to:
  /// **'a diferente de 0'**
  String get aDiferenteDeCero;

  /// No description provided for @ejercicios.
  ///
  /// In es, this message translates to:
  /// **'Ejercicios'**
  String get ejercicios;

  /// No description provided for @pregunta.
  ///
  /// In es, this message translates to:
  /// **'Pregunta'**
  String get pregunta;

  /// No description provided for @verLosEjercicios.
  ///
  /// In es, this message translates to:
  /// **'Ver los ejercicios'**
  String get verLosEjercicios;

  /// No description provided for @cerrar.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get cerrar;

  /// No description provided for @pregunta1.
  ///
  /// In es, this message translates to:
  /// **'pregunta 1'**
  String get pregunta1;

  /// No description provided for @pregunta2.
  ///
  /// In es, this message translates to:
  /// **'pregunta 2'**
  String get pregunta2;

  /// No description provided for @pregunta3.
  ///
  /// In es, this message translates to:
  /// **'pregunta 3'**
  String get pregunta3;

  /// No description provided for @pregunta4.
  ///
  /// In es, this message translates to:
  /// **'pregunta 4'**
  String get pregunta4;

  /// No description provided for @pregunta5.
  ///
  /// In es, this message translates to:
  /// **'pregunta 5'**
  String get pregunta5;

  /// No description provided for @pregunta6.
  ///
  /// In es, this message translates to:
  /// **'pregunta 6'**
  String get pregunta6;

  /// No description provided for @pregunta7.
  ///
  /// In es, this message translates to:
  /// **'pregunta 7'**
  String get pregunta7;

  /// No description provided for @pregunta8.
  ///
  /// In es, this message translates to:
  /// **'pregunta 8'**
  String get pregunta8;

  /// No description provided for @pregunta9.
  ///
  /// In es, this message translates to:
  /// **'pregunta 9'**
  String get pregunta9;

  /// No description provided for @pregunta10.
  ///
  /// In es, this message translates to:
  /// **'pregunta 10'**
  String get pregunta10;

  /// No description provided for @pregunta11.
  ///
  /// In es, this message translates to:
  /// **'pregunta 11'**
  String get pregunta11;

  /// No description provided for @pregunta12.
  ///
  /// In es, this message translates to:
  /// **'pregunta 12'**
  String get pregunta12;

  /// No description provided for @pregunta13.
  ///
  /// In es, this message translates to:
  /// **'pregunta 13'**
  String get pregunta13;

  /// No description provided for @pregunta14.
  ///
  /// In es, this message translates to:
  /// **'pregunta 14'**
  String get pregunta14;

  /// No description provided for @pregunta15.
  ///
  /// In es, this message translates to:
  /// **'pregunta 15'**
  String get pregunta15;

  /// No description provided for @respuesta1.
  ///
  /// In es, this message translates to:
  /// **'respuesta 1'**
  String get respuesta1;

  /// No description provided for @respuesta2.
  ///
  /// In es, this message translates to:
  /// **'respuesta 2'**
  String get respuesta2;

  /// No description provided for @respuesta3.
  ///
  /// In es, this message translates to:
  /// **'respuesta 3'**
  String get respuesta3;

  /// No description provided for @respuesta4.
  ///
  /// In es, this message translates to:
  /// **'respuesta 4'**
  String get respuesta4;

  /// No description provided for @respuesta5.
  ///
  /// In es, this message translates to:
  /// **'respuesta 5'**
  String get respuesta5;

  /// No description provided for @respuesta6.
  ///
  /// In es, this message translates to:
  /// **'respuesta 6'**
  String get respuesta6;

  /// No description provided for @respuesta7.
  ///
  /// In es, this message translates to:
  /// **'respuesta 7'**
  String get respuesta7;

  /// No description provided for @respuesta8.
  ///
  /// In es, this message translates to:
  /// **'respuesta 8'**
  String get respuesta8;

  /// No description provided for @respuesta9.
  ///
  /// In es, this message translates to:
  /// **'respuesta 9'**
  String get respuesta9;

  /// No description provided for @respuesta10.
  ///
  /// In es, this message translates to:
  /// **'respuesta 10'**
  String get respuesta10;

  /// No description provided for @respuesta11.
  ///
  /// In es, this message translates to:
  /// **'respuesta 11'**
  String get respuesta11;

  /// No description provided for @respuesta12.
  ///
  /// In es, this message translates to:
  /// **'respuesta 12'**
  String get respuesta12;

  /// No description provided for @respuesta13.
  ///
  /// In es, this message translates to:
  /// **'respuesta 13'**
  String get respuesta13;

  /// No description provided for @respuesta14.
  ///
  /// In es, this message translates to:
  /// **'respuesta 14'**
  String get respuesta14;

  /// No description provided for @respuesta15.
  ///
  /// In es, this message translates to:
  /// **'respuesta 15'**
  String get respuesta15;

  /// No description provided for @pista.
  ///
  /// In es, this message translates to:
  /// **'Pista'**
  String get pista;

  /// No description provided for @respuesta.
  ///
  /// In es, this message translates to:
  /// **'Respuesta'**
  String get respuesta;

  /// No description provided for @ocultarMostrarRespuestas.
  ///
  /// In es, this message translates to:
  /// **'ocultar/mostrar respuestas'**
  String get ocultarMostrarRespuestas;

  /// No description provided for @desigualdadSumaResta.
  ///
  /// In es, this message translates to:
  /// **'El sentido de la desigualdad no cambia si se suma o se resta un número a sus dos miembros'**
  String get desigualdadSumaResta;

  /// No description provided for @desigualdadMultiplicaDivide.
  ///
  /// In es, this message translates to:
  /// **'El sentido de la desigualdad no cambia si se multiplica o se divide un número positivo a sus dos miembros'**
  String get desigualdadMultiplicaDivide;

  /// No description provided for @exponentes.
  ///
  /// In es, this message translates to:
  /// **'exponentes'**
  String get exponentes;

  /// No description provided for @numerosEnterosPositivos.
  ///
  /// In es, this message translates to:
  /// **'Numeros enteros positivos'**
  String get numerosEnterosPositivos;

  /// No description provided for @constantes.
  ///
  /// In es, this message translates to:
  /// **'constantes'**
  String get constantes;

  /// No description provided for @mostrar.
  ///
  /// In es, this message translates to:
  /// **'mostrar'**
  String get mostrar;

  /// No description provided for @ocultar.
  ///
  /// In es, this message translates to:
  /// **'ocultar'**
  String get ocultar;

  /// No description provided for @catetoOpuesto.
  ///
  /// In es, this message translates to:
  /// **'cateto opuesto'**
  String get catetoOpuesto;

  /// No description provided for @catetoAdyacente.
  ///
  /// In es, this message translates to:
  /// **'cateto adyacente'**
  String get catetoAdyacente;

  /// No description provided for @hipotenusa.
  ///
  /// In es, this message translates to:
  /// **'hipotenusa'**
  String get hipotenusa;

  /// No description provided for @logaritmoIgualACero.
  ///
  /// In es, this message translates to:
  /// **'logaritmo igual a cero'**
  String get logaritmoIgualACero;

  /// No description provided for @logaritmoConBaseDiez.
  ///
  /// In es, this message translates to:
  /// **'logaritmo con base diez'**
  String get logaritmoConBaseDiez;

  /// No description provided for @logaritmoDeUno.
  ///
  /// In es, this message translates to:
  /// **'logaritmo de uno'**
  String get logaritmoDeUno;

  /// No description provided for @sumaDeLogaritmos.
  ///
  /// In es, this message translates to:
  /// **'suma de logaritmos'**
  String get sumaDeLogaritmos;

  /// No description provided for @restaDeLogaritmos.
  ///
  /// In es, this message translates to:
  /// **'resta de logaritmos'**
  String get restaDeLogaritmos;

  /// No description provided for @productoDeLogaritmos.
  ///
  /// In es, this message translates to:
  /// **'producto de logaritmos'**
  String get productoDeLogaritmos;

  /// No description provided for @cocienteDeLogaritmos.
  ///
  /// In es, this message translates to:
  /// **'cociente de logaritmos'**
  String get cocienteDeLogaritmos;

  /// No description provided for @potenciaDeLogaritmos.
  ///
  /// In es, this message translates to:
  /// **'potencia de logaritmos'**
  String get potenciaDeLogaritmos;

  /// No description provided for @logaritmoNatural.
  ///
  /// In es, this message translates to:
  /// **'logaritmo natural'**
  String get logaritmoNatural;

  /// No description provided for @logaritmoConCambioDeBase.
  ///
  /// In es, this message translates to:
  /// **'logaritmo con cambio de base'**
  String get logaritmoConCambioDeBase;

  /// No description provided for @logaritmoDeUnaRaiz.
  ///
  /// In es, this message translates to:
  /// **'logaritmo de una raiz'**
  String get logaritmoDeUnaRaiz;

  /// No description provided for @explicacionLogaritmo.
  ///
  /// In es, this message translates to:
  /// **'El logaritmo de un número, en una base dada, es el exponente al cual se debe elevar la base para obtener el número'**
  String get explicacionLogaritmo;

  /// No description provided for @ejemplo.
  ///
  /// In es, this message translates to:
  /// **'ejemplo'**
  String get ejemplo;

  /// No description provided for @identidadesBasicas.
  ///
  /// In es, this message translates to:
  /// **'Identidades basicas'**
  String get identidadesBasicas;

  /// No description provided for @identidadesPitagoricas.
  ///
  /// In es, this message translates to:
  /// **'identidades pitagoricas'**
  String get identidadesPitagoricas;

  /// No description provided for @identidadesReciprocas.
  ///
  /// In es, this message translates to:
  /// **'identidades reciprocas'**
  String get identidadesReciprocas;

  /// No description provided for @identidadesPorCociente.
  ///
  /// In es, this message translates to:
  /// **'identidades por cociente'**
  String get identidadesPorCociente;

  /// No description provided for @parEImpar.
  ///
  /// In es, this message translates to:
  /// **'par e impar'**
  String get parEImpar;

  /// No description provided for @suplementoComplemento.
  ///
  /// In es, this message translates to:
  /// **'suplemento, complemento'**
  String get suplementoComplemento;

  /// No description provided for @anguloDobleYMedio.
  ///
  /// In es, this message translates to:
  /// **'angulo doble y medio'**
  String get anguloDobleYMedio;

  /// No description provided for @sumaYResta.
  ///
  /// In es, this message translates to:
  /// **'suma y resta'**
  String get sumaYResta;

  /// No description provided for @sumaAProductoYViceversa.
  ///
  /// In es, this message translates to:
  /// **'suma a producto y viceversa'**
  String get sumaAProductoYViceversa;

  /// No description provided for @seno.
  ///
  /// In es, this message translates to:
  /// **'Seno'**
  String get seno;

  /// No description provided for @coseno.
  ///
  /// In es, this message translates to:
  /// **'Coseno'**
  String get coseno;

  /// No description provided for @tangente.
  ///
  /// In es, this message translates to:
  /// **'Tangente'**
  String get tangente;

  /// No description provided for @cosecante.
  ///
  /// In es, this message translates to:
  /// **'Cosecante'**
  String get cosecante;

  /// No description provided for @secante.
  ///
  /// In es, this message translates to:
  /// **'Secante'**
  String get secante;

  /// No description provided for @cotangente.
  ///
  /// In es, this message translates to:
  /// **'Cotangente'**
  String get cotangente;

  /// No description provided for @masMenos.
  ///
  /// In es, this message translates to:
  /// **'más / menos'**
  String get masMenos;

  /// No description provided for @interpretacionMasMenos.
  ///
  /// In es, this message translates to:
  /// **'Se puede emplear junto con ± en expresiones tales como «x ± y ∓ z»,que se puede interpretar como «x + y − z» o bien «x − y + z», pero de ninguna manera como «x + y + z» ni como «x − y − z».'**
  String get interpretacionMasMenos;

  /// No description provided for @senoHiperbolico.
  ///
  /// In es, this message translates to:
  /// **'Seno hiperbolico'**
  String get senoHiperbolico;

  /// No description provided for @cosenoHiperbolico.
  ///
  /// In es, this message translates to:
  /// **'Coseno hiperbolico'**
  String get cosenoHiperbolico;

  /// No description provided for @tangenteHiperbolica.
  ///
  /// In es, this message translates to:
  /// **'Tangente hiperbolica'**
  String get tangenteHiperbolica;

  /// No description provided for @cotangenteHiperbolica.
  ///
  /// In es, this message translates to:
  /// **'Cotangente hiperbolica'**
  String get cotangenteHiperbolica;

  /// No description provided for @secanteHiperbolica.
  ///
  /// In es, this message translates to:
  /// **'Secante hiperbolica'**
  String get secanteHiperbolica;

  /// No description provided for @cosecanteHiperbolica.
  ///
  /// In es, this message translates to:
  /// **'Cosecante hiperbolica'**
  String get cosecanteHiperbolica;

  /// No description provided for @dominio.
  ///
  /// In es, this message translates to:
  /// **'Dominio'**
  String get dominio;

  /// No description provided for @imagen.
  ///
  /// In es, this message translates to:
  /// **'Imagen'**
  String get imagen;

  /// No description provided for @explicacionDominio.
  ///
  /// In es, this message translates to:
  /// **'El conjunto de partida o el conjunto de los valores que puede tomarla Variable Independiente (x), es el Dominio de la Función.'**
  String get explicacionDominio;

  /// No description provided for @explicacionImagen.
  ///
  /// In es, this message translates to:
  /// **'El conjunto de valores que puede tomar la Variable Dependiente (y) ó (f(x)) se llama Imagen, Rango o Recorrido de la Función, está incluido en el conjunto de llegada.'**
  String get explicacionImagen;

  /// No description provided for @porCofactores.
  ///
  /// In es, this message translates to:
  /// **'Por cofactores'**
  String get porCofactores;

  /// No description provided for @definicionCofactor.
  ///
  /// In es, this message translates to:
  /// **'Se le asigna el signo de acuerdo con la fórmula del cofactor. El cofactor se define como'**
  String get definicionCofactor;

  /// No description provided for @submatriz.
  ///
  /// In es, this message translates to:
  /// **'La submatriz obtenida de eliminar la i-ésima fila y la j-ésima columna de A'**
  String get submatriz;

  /// No description provided for @posicion.
  ///
  /// In es, this message translates to:
  /// **'Posición'**
  String get posicion;

  /// No description provided for @menorDeA.
  ///
  /// In es, this message translates to:
  /// **'El menor de A'**
  String get menorDeA;

  /// No description provided for @obtenerSubmatriz.
  ///
  /// In es, this message translates to:
  /// **'Donde Mij es la submatriz obtenida de eliminar la i-ésima fila y la j-ésima columna de A'**
  String get obtenerSubmatriz;

  /// No description provided for @maneraDeObtenerla.
  ///
  /// In es, this message translates to:
  /// **'Manera de obtenerla'**
  String get maneraDeObtenerla;

  /// No description provided for @propiedadesMatrizSimetrica.
  ///
  /// In es, this message translates to:
  /// **'1) La inversa es una matriz simétrica. 2) La adjunta es una matriz simétrica. 3) La suma de simétricas es una matriz simétrica'**
  String get propiedadesMatrizSimetrica;

  /// No description provided for @propiedadesMatrizTriangular.
  ///
  /// In es, this message translates to:
  /// **'Propiedades de la matriz triangular'**
  String get propiedadesMatrizTriangular;

  /// No description provided for @matrizTriangularSuperior.
  ///
  /// In es, this message translates to:
  /// **'Matriz Triangular Superior'**
  String get matrizTriangularSuperior;

  /// No description provided for @matrizTriangularInferior.
  ///
  /// In es, this message translates to:
  /// **'Matriz Triangular Inferior'**
  String get matrizTriangularInferior;

  /// No description provided for @caracteristicasMatrizTriangular.
  ///
  /// In es, this message translates to:
  /// **'1) La transpuesta de una triangular superior es una triangular inferior y viceversa. \n\n2) La inversa de una triangular superior es una triangular superior. \n\n3) El producto de triangulares superiores es una triangular superior \n\n4) Los valores propios son la diagonal de la matriz'**
  String get caracteristicasMatrizTriangular;

  /// No description provided for @sea.
  ///
  /// In es, this message translates to:
  /// **'Sea'**
  String get sea;

  /// No description provided for @multiplicacionEscalar.
  ///
  /// In es, this message translates to:
  /// **'Multiplicación por un escalar k'**
  String get multiplicacionEscalar;

  /// No description provided for @productoMatrices.
  ///
  /// In es, this message translates to:
  /// **'Producto de dos matrices'**
  String get productoMatrices;

  /// No description provided for @condicionProductoMatrices.
  ///
  /// In es, this message translates to:
  /// **'El número de columnas de la primera matriz debe ser igual al número de filas de la segunda'**
  String get condicionProductoMatrices;

  /// No description provided for @definicionABC.
  ///
  /// In es, this message translates to:
  /// **'Sean A,B y C matrices mxn y sean a,b y c escalares'**
  String get definicionABC;

  /// No description provided for @sean.
  ///
  /// In es, this message translates to:
  /// **'Sean'**
  String get sean;

  /// No description provided for @matrizResultante.
  ///
  /// In es, this message translates to:
  /// **'Es la matriz resultante de sustituir la j-ésima columna de A por el vector columna b'**
  String get matrizResultante;

  /// No description provided for @incognita.
  ///
  /// In es, this message translates to:
  /// **'Incógnita'**
  String get incognita;

  /// No description provided for @determinante.
  ///
  /// In es, this message translates to:
  /// **'Determinante'**
  String get determinante;

  /// No description provided for @soloAplicaMatrices.
  ///
  /// In es, this message translates to:
  /// **'Solo aplica a matrices 3x3'**
  String get soloAplicaMatrices;

  /// No description provided for @norma.
  ///
  /// In es, this message translates to:
  /// **'Norma'**
  String get norma;

  /// No description provided for @vectorNormalizado.
  ///
  /// In es, this message translates to:
  /// **'Vector normalizado'**
  String get vectorNormalizado;

  /// No description provided for @escalar.
  ///
  /// In es, this message translates to:
  /// **'Un escalar'**
  String get escalar;

  /// No description provided for @sumaResta.
  ///
  /// In es, this message translates to:
  /// **'Suma y resta'**
  String get sumaResta;

  /// No description provided for @vectoresParalelosSi.
  ///
  /// In es, this message translates to:
  /// **'Son vectores paralelos si'**
  String get vectoresParalelosSi;

  /// No description provided for @productoCruzDeterminante.
  ///
  /// In es, this message translates to:
  /// **'El determinante se obtiene con el producto cruz'**
  String get productoCruzDeterminante;

  /// No description provided for @propiedadesProductoCruz.
  ///
  /// In es, this message translates to:
  /// **'Propiedades del producto cruz'**
  String get propiedadesProductoCruz;

  /// No description provided for @escalares.
  ///
  /// In es, this message translates to:
  /// **'Escalares'**
  String get escalares;

  /// No description provided for @vectoresOrtogonales.
  ///
  /// In es, this message translates to:
  /// **'Cuando el producto punto entre dos vectores es igual a cero, son vectores ortogonales'**
  String get vectoresOrtogonales;

  /// No description provided for @vectorProyeccion.
  ///
  /// In es, this message translates to:
  /// **'Vector proyección de u sobre v'**
  String get vectorProyeccion;

  /// No description provided for @componenteEscalar.
  ///
  /// In es, this message translates to:
  /// **'Componente escalar de u en dirección de v'**
  String get componenteEscalar;

  /// No description provided for @vectoresUnitariosBasicos.
  ///
  /// In es, this message translates to:
  /// **'Vectores unitarios básicos'**
  String get vectoresUnitariosBasicos;

  /// No description provided for @vectorUnitarioDireccionV.
  ///
  /// In es, this message translates to:
  /// **'Vector unitario en la dirección de v'**
  String get vectorUnitarioDireccionV;

  /// No description provided for @expresionComponentes.
  ///
  /// In es, this message translates to:
  /// **'Expresión en componentes'**
  String get expresionComponentes;

  /// No description provided for @magnitudVector.
  ///
  /// In es, this message translates to:
  /// **'Magnitud del vector v = PQ'**
  String get magnitudVector;

  /// No description provided for @puntoInicial.
  ///
  /// In es, this message translates to:
  /// **'Con punto inicial'**
  String get puntoInicial;

  /// No description provided for @puntoFinal.
  ///
  /// In es, this message translates to:
  /// **'Punto final'**
  String get puntoFinal;

  /// No description provided for @entonces.
  ///
  /// In es, this message translates to:
  /// **'Entonces'**
  String get entonces;

  /// No description provided for @limiteslaterales.
  ///
  /// In es, this message translates to:
  /// **'Límites Laterales'**
  String get limiteslaterales;

  /// No description provided for @limitesalinfinito.
  ///
  /// In es, this message translates to:
  /// **'Límites al Infinito'**
  String get limitesalinfinito;

  /// No description provided for @siysolosi.
  ///
  /// In es, this message translates to:
  /// **'Si y Solo Si'**
  String get siysolosi;

  /// No description provided for @derivaciondeunaconstante.
  ///
  /// In es, this message translates to:
  /// **'Derivación de una Constante'**
  String get derivaciondeunaconstante;

  /// No description provided for @derivadadeunavariable.
  ///
  /// In es, this message translates to:
  /// **'Derivada de una Variable'**
  String get derivadadeunavariable;

  /// No description provided for @derivadaconstanteporvariable.
  ///
  /// In es, this message translates to:
  /// **'Derivada Constante por Variable'**
  String get derivadaconstanteporvariable;

  /// No description provided for @derivadaexponente.
  ///
  /// In es, this message translates to:
  /// **'Derivada Exponente'**
  String get derivadaexponente;

  /// No description provided for @derivadaconstanteporexponente.
  ///
  /// In es, this message translates to:
  /// **'Derivada Constante por Exponente'**
  String get derivadaconstanteporexponente;

  /// No description provided for @derivadaconstanteporfuncioncompuesta.
  ///
  /// In es, this message translates to:
  /// **'Derivada Constante por Función Compuesta'**
  String get derivadaconstanteporfuncioncompuesta;

  /// No description provided for @derivadafuncioncompuestaconexponente.
  ///
  /// In es, this message translates to:
  /// **'Derivada Función Compuesta con Exponente'**
  String get derivadafuncioncompuestaconexponente;

  /// No description provided for @derivadadelproductodedosfuncionescompuestas.
  ///
  /// In es, this message translates to:
  /// **'Derivada del Producto de Dos Funciones Compuestas'**
  String get derivadadelproductodedosfuncionescompuestas;

  /// No description provided for @derivadadelcocientedefuncionescompuestas.
  ///
  /// In es, this message translates to:
  /// **'Derivada del Cociente de Funciones Compuestas'**
  String get derivadadelcocientedefuncionescompuestas;

  /// No description provided for @derivadadelproductodenfuncionescompuestas.
  ///
  /// In es, this message translates to:
  /// **'Derivada del Producto de n Funciones Compuestas'**
  String get derivadadelproductodenfuncionescompuestas;

  /// No description provided for @derivadadelasumadefuncionescompuestas.
  ///
  /// In es, this message translates to:
  /// **'Derivada de la Suma de Funciones Compuestas'**
  String get derivadadelasumadefuncionescompuestas;

  /// No description provided for @constante.
  ///
  /// In es, this message translates to:
  /// **'Constante'**
  String get constante;

  /// No description provided for @variable.
  ///
  /// In es, this message translates to:
  /// **'Variable'**
  String get variable;

  /// No description provided for @funcioncompuesta.
  ///
  /// In es, this message translates to:
  /// **'Función Compuesta'**
  String get funcioncompuesta;

  /// No description provided for @integraldex.
  ///
  /// In es, this message translates to:
  /// **'Integral de x'**
  String get integraldex;

  /// No description provided for @integraldeconstanteporx.
  ///
  /// In es, this message translates to:
  /// **'Integral de Constante por x'**
  String get integraldeconstanteporx;

  /// No description provided for @variableconexponenten.
  ///
  /// In es, this message translates to:
  /// **'Variable con Exponente n'**
  String get variableconexponenten;

  /// No description provided for @varibaleconexponentemenos1.
  ///
  /// In es, this message translates to:
  /// **'Variable con Exponente -1'**
  String get varibaleconexponentemenos1;

  /// No description provided for @variableconexponentemenosn.
  ///
  /// In es, this message translates to:
  /// **'Variable con Exponente -n'**
  String get variableconexponentemenosn;

  /// No description provided for @integraldeuncociente.
  ///
  /// In es, this message translates to:
  /// **'Integral de un Cociente'**
  String get integraldeuncociente;

  /// No description provided for @exponentefraccionario.
  ///
  /// In es, this message translates to:
  /// **'Exponente Fraccionario'**
  String get exponentefraccionario;

  /// No description provided for @sumadefunciones.
  ///
  /// In es, this message translates to:
  /// **'Suma de Funciones'**
  String get sumadefunciones;

  /// No description provided for @productoconstanteyfuncion.
  ///
  /// In es, this message translates to:
  /// **'Producto Constante y Función'**
  String get productoconstanteyfuncion;

  /// No description provided for @integracionporpartes.
  ///
  /// In es, this message translates to:
  /// **'Integración por Partes'**
  String get integracionporpartes;

  /// No description provided for @silacurvaestadadaporlasecuacionesparametricas.
  ///
  /// In es, this message translates to:
  /// **'Si la Curva está Dada por las Ecuaciones Paramétricas'**
  String get silacurvaestadadaporlasecuacionesparametricas;

  /// No description provided for @alrededordelejex.
  ///
  /// In es, this message translates to:
  /// **'Alrededor del Eje x'**
  String get alrededordelejex;

  /// No description provided for @alrededordelejey.
  ///
  /// In es, this message translates to:
  /// **'Alrededor del Eje y'**
  String get alrededordelejey;

  /// No description provided for @jacobiano.
  ///
  /// In es, this message translates to:
  /// **'Jacobiano'**
  String get jacobiano;

  /// No description provided for @coordenadasRectangularesapolares.
  ///
  /// In es, this message translates to:
  /// **'Coordenadas Rectangulares a Polares'**
  String get coordenadasRectangularesapolares;

  /// No description provided for @coordenadasCartesianasacilindricas.
  ///
  /// In es, this message translates to:
  /// **'Coordenadas Cartesianas a Cilíndricas'**
  String get coordenadasCartesianasacilindricas;

  /// No description provided for @eljacobianodelasfunciones.
  ///
  /// In es, this message translates to:
  /// **'El Jacobiano de las Funciones'**
  String get eljacobianodelasfunciones;

  /// No description provided for @esr.
  ///
  /// In es, this message translates to:
  /// **'Es r'**
  String get esr;

  /// No description provided for @unafunciondedosvariables.
  ///
  /// In es, this message translates to:
  /// **'Una Función de Dos Variables'**
  String get unafunciondedosvariables;

  /// No description provided for @unvectorunitario.
  ///
  /// In es, this message translates to:
  /// **'Un Vector Unitario'**
  String get unvectorunitario;

  /// No description provided for @notacion.
  ///
  /// In es, this message translates to:
  /// **'Notación'**
  String get notacion;

  /// No description provided for @elsubindiceindicarespectodequevariablesevaaderivar.
  ///
  /// In es, this message translates to:
  /// **'El Subíndice Indica Respecto de Qué Variable se Va a Derivar'**
  String get elsubindiceindicarespectodequevariablesevaaderivar;

  /// No description provided for @funcionesVectorialesDiferenciablesDeT.
  ///
  /// In es, this message translates to:
  /// **'Funciones Vectoriales Diferenciables de T'**
  String get funcionesVectorialesDiferenciablesDeT;

  /// No description provided for @unVectorConstante.
  ///
  /// In es, this message translates to:
  /// **'Un Vector Constante'**
  String get unVectorConstante;

  /// No description provided for @unaFuncionEscalarDerivable.
  ///
  /// In es, this message translates to:
  /// **'Una Función Escalar Derivable'**
  String get unaFuncionEscalarDerivable;

  /// No description provided for @unaFuncionVectorial.
  ///
  /// In es, this message translates to:
  /// **'Una Función Vectorial'**
  String get unaFuncionVectorial;

  /// No description provided for @limite.
  ///
  /// In es, this message translates to:
  /// **'Límite'**
  String get limite;

  /// No description provided for @derivada.
  ///
  /// In es, this message translates to:
  /// **'Derivada'**
  String get derivada;

  /// No description provided for @integral.
  ///
  /// In es, this message translates to:
  /// **'Integral'**
  String get integral;

  /// No description provided for @coordenadasCartesianaACilindricas.
  ///
  /// In es, this message translates to:
  /// **'Coordenadas Cartesianas a Cilíndricas'**
  String get coordenadasCartesianaACilindricas;

  /// No description provided for @coordenadasCartesianaAEsfericas.
  ///
  /// In es, this message translates to:
  /// **'Coordenadas Cartesianas a Esféricas'**
  String get coordenadasCartesianaAEsfericas;

  /// No description provided for @deCamposEscalares.
  ///
  /// In es, this message translates to:
  /// **'De Campos Escalares'**
  String get deCamposEscalares;

  /// No description provided for @deCamposVectoriales.
  ///
  /// In es, this message translates to:
  /// **'De Campos Vectoriales'**
  String get deCamposVectoriales;

  /// No description provided for @seaElCampo.
  ///
  /// In es, this message translates to:
  /// **'Sea el Campo'**
  String get seaElCampo;

  /// No description provided for @curvaDeDosDimensiones.
  ///
  /// In es, this message translates to:
  /// **'Curva de Dos Dimensiones'**
  String get curvaDeDosDimensiones;

  /// No description provided for @curvaDeTresDimensiones.
  ///
  /// In es, this message translates to:
  /// **'Curva de Tres Dimensiones'**
  String get curvaDeTresDimensiones;

  /// No description provided for @funcionVectorialDeLasVariables.
  ///
  /// In es, this message translates to:
  /// **'Función Vectorial de las Variables'**
  String get funcionVectorialDeLasVariables;

  /// No description provided for @divergencia.
  ///
  /// In es, this message translates to:
  /// **'Divergencia'**
  String get divergencia;

  /// No description provided for @componentesDe.
  ///
  /// In es, this message translates to:
  /// **'Componentes de'**
  String get componentesDe;

  /// No description provided for @rotacional.
  ///
  /// In es, this message translates to:
  /// **'Rotacional'**
  String get rotacional;

  /// No description provided for @laplaciano.
  ///
  /// In es, this message translates to:
  /// **'Laplaciano'**
  String get laplaciano;

  /// No description provided for @funcionEscalar.
  ///
  /// In es, this message translates to:
  /// **'Función Escalar'**
  String get funcionEscalar;

  /// No description provided for @laplacianoDeUnCampoVectorial.
  ///
  /// In es, this message translates to:
  /// **'Laplaciano de un Campo Vectorial'**
  String get laplacianoDeUnCampoVectorial;

  /// No description provided for @teoremaDeStokes.
  ///
  /// In es, this message translates to:
  /// **'Teorema de Stokes'**
  String get teoremaDeStokes;

  /// No description provided for @teoremaDeGreen.
  ///
  /// In es, this message translates to:
  /// **'Teorema de Green'**
  String get teoremaDeGreen;

  /// No description provided for @constanteCualquiera.
  ///
  /// In es, this message translates to:
  /// **'Constante Cualquiera'**
  String get constanteCualquiera;

  /// No description provided for @constanteDeIntegracion.
  ///
  /// In es, this message translates to:
  /// **'Constante de Integración'**
  String get constanteDeIntegracion;

  /// No description provided for @homogenea.
  ///
  /// In es, this message translates to:
  /// **'Homogénea'**
  String get homogenea;

  /// No description provided for @seObtienenLasRaicesDeLaEcuacion.
  ///
  /// In es, this message translates to:
  /// **'Se Obtienen las Raíces de la Ecuación'**
  String get seObtienenLasRaicesDeLaEcuacion;

  /// No description provided for @caso1RaicesYDiferentes.
  ///
  /// In es, this message translates to:
  /// **'Caso 1 - Raíces Reales y Diferentes'**
  String get caso1RaicesYDiferentes;

  /// No description provided for @caso2RaicesRealesYRepetidas.
  ///
  /// In es, this message translates to:
  /// **'Caso 2 - Raíces Reales y Repetidas'**
  String get caso2RaicesRealesYRepetidas;

  /// No description provided for @caso3RaicesComplejas.
  ///
  /// In es, this message translates to:
  /// **'Caso 3 - Raíces Complejas'**
  String get caso3RaicesComplejas;

  /// No description provided for @caso4RaicesComplejasYRepetidas.
  ///
  /// In es, this message translates to:
  /// **'Caso 4 - Raíces Complejas y Repetidas'**
  String get caso4RaicesComplejasYRepetidas;

  /// No description provided for @operadorQueSignificaDerivada.
  ///
  /// In es, this message translates to:
  /// **'Operador que Significa Derivada'**
  String get operadorQueSignificaDerivada;

  /// No description provided for @ordenDeLaEcuacionSusRaicesSeran.
  ///
  /// In es, this message translates to:
  /// **'Orden de la Ecuación sus Raíces Serán'**
  String get ordenDeLaEcuacionSusRaicesSeran;

  /// No description provided for @seSustituyePor.
  ///
  /// In es, this message translates to:
  /// **'Se Sustituye Por'**
  String get seSustituyePor;

  /// No description provided for @tomamosDeCadaCoeficienteLosTerminosDeH.
  ///
  /// In es, this message translates to:
  /// **'Tomamos de Cada Coeficiente los Términos de H'**
  String get tomamosDeCadaCoeficienteLosTerminosDeH;

  /// No description provided for @kYLaConstante.
  ///
  /// In es, this message translates to:
  /// **'K y la Constante'**
  String get kYLaConstante;

  /// No description provided for @losIgualamosACero.
  ///
  /// In es, this message translates to:
  /// **'Los Igualamos a Cero'**
  String get losIgualamosACero;

  /// No description provided for @posteriormenteSeResuelvePorHomogeneasYAlFinalSeRegresaASusValoresOriginales.
  ///
  /// In es, this message translates to:
  /// **'Posteriormente se Resuelve por Homogéneas y al Final se Regresa a sus Valores Originales'**
  String
      get posteriormenteSeResuelvePorHomogeneasYAlFinalSeRegresaASusValoresOriginales;

  /// No description provided for @alResolverPorHomogeneasSeSustituyenLasVariablesPor.
  ///
  /// In es, this message translates to:
  /// **'Al Resolver por Homogéneas se Sustituyen las Variables Por'**
  String get alResolverPorHomogeneasSeSustituyenLasVariablesPor;

  /// No description provided for @puedenTenerLaForma.
  ///
  /// In es, this message translates to:
  /// **'Pueden Tener la Forma'**
  String get puedenTenerLaForma;

  /// No description provided for @yaHechaLaSustitucionDeLasVariablesAsiComoDelDiferencial.
  ///
  /// In es, this message translates to:
  /// **'Ya Hecha la Sustitución de las Variables Así Como del Diferencial'**
  String get yaHechaLaSustitucionDeLasVariablesAsiComoDelDiferencial;

  /// No description provided for @seResuelvePorVariablesSeparablesYAlFinalSeRegresanSusValoresOriginales.
  ///
  /// In es, this message translates to:
  /// **'Se Resuelve por Variables Separables y al Final se Regresan sus Valores Originales'**
  String
      get seResuelvePorVariablesSeparablesYAlFinalSeRegresanSusValoresOriginales;

  /// No description provided for @seHacenDeLaFormaDeLasRestantesUtilizandolaSustitucion.
  ///
  /// In es, this message translates to:
  /// **'Se Hacen de la Forma de las Restantes Utilizando la Sustitución'**
  String get seHacenDeLaFormaDeLasRestantesUtilizandolaSustitucion;

  /// No description provided for @seUsaLaSustitucionDelDiferencialEnElCoeficienteMasSencillo.
  ///
  /// In es, this message translates to:
  /// **'Se Usa la Sustitución del Diferencial en el Coeficiente Más Sencillo'**
  String get seUsaLaSustitucionDelDiferencialEnElCoeficienteMasSencillo;

  /// No description provided for @coeficientesDeDx.
  ///
  /// In es, this message translates to:
  /// **'Coeficientes de Dx'**
  String get coeficientesDeDx;

  /// No description provided for @coeficienteDeDy.
  ///
  /// In es, this message translates to:
  /// **'Coeficiente de Dy'**
  String get coeficienteDeDy;

  /// No description provided for @esExactaSi.
  ///
  /// In es, this message translates to:
  /// **'Es Exacta Si'**
  String get esExactaSi;

  /// No description provided for @paraHacerlaExacta.
  ///
  /// In es, this message translates to:
  /// **'Para Hacerla Exacta'**
  String get paraHacerlaExacta;

  /// No description provided for @posteriormenteSeSustituyenCadaUnaEnSuRespectivaIntegralYSeIgualaACParaObtenerLaSolucionGeneral.
  ///
  /// In es, this message translates to:
  /// **'Posteriormente se Sustituyen Cada Una en su Respectiva Integral y se Iguala a C para Obtener la Solución General'**
  String
      get posteriormenteSeSustituyenCadaUnaEnSuRespectivaIntegralYSeIgualaACParaObtenerLaSolucionGeneral;

  /// No description provided for @elFactorIntegrantePuedeDependerDeCualquieraDeLasDosVariablesEstoSeDeterminaALaHoraDeIntegrarDondeNosDamosCuentaCualEsMasSencilla.
  ///
  /// In es, this message translates to:
  /// **'El Factor Integrante Puede Depender de Cualquiera de las Dos Variables Esto se Determina a la Hora de Integrar donde nos Damos Cuenta Cuál es Más Sencilla'**
  String
      get elFactorIntegrantePuedeDependerDeCualquieraDeLasDosVariablesEstoSeDeterminaALaHoraDeIntegrarDondeNosDamosCuentaCualEsMasSencilla;

  /// No description provided for @podemosSaberSiEsHomogeneaSiElOrdenDeTodosLosTerminosDeLaEcuacionEsElMismoAlSustituirTEnXY.
  ///
  /// In es, this message translates to:
  /// **'Podemos Saber Si es Homogénea Si el Orden de Todos los Términos de la Ecuación es el Mismo al Sustituir T en X y Y'**
  String
      get podemosSaberSiEsHomogeneaSiElOrdenDeTodosLosTerminosDeLaEcuacionEsElMismoAlSustituirTEnXY;

  /// No description provided for @sustitucionDeLasVariables.
  ///
  /// In es, this message translates to:
  /// **'Sustitución de las Variables'**
  String get sustitucionDeLasVariables;

  /// No description provided for @seResuelvePorSeparacionDeVariablesYPosteriormenteSeDevuelvenASusValoresOriginales.
  ///
  /// In es, this message translates to:
  /// **'Se Resuelve por Separación de Variables y Posteriormente se Devuelven a sus Valores Originales'**
  String
      get seResuelvePorSeparacionDeVariablesYPosteriormenteSeDevuelvenASusValoresOriginales;

  /// No description provided for @seUtilizaLaSustitucionDiferencialQueTengaElCoeficienteMasSencillo.
  ///
  /// In es, this message translates to:
  /// **'Se Utiliza la Sustitución Diferencial que Tenga el Coeficiente Más Sencillo'**
  String get seUtilizaLaSustitucionDiferencialQueTengaElCoeficienteMasSencillo;

  /// No description provided for @variacionDeParametros.
  ///
  /// In es, this message translates to:
  /// **'Variación de Parámetros'**
  String get variacionDeParametros;

  /// No description provided for @solucionHomogenea.
  ///
  /// In es, this message translates to:
  /// **'Solución Homogénea'**
  String get solucionHomogenea;

  /// No description provided for @solucionParticular.
  ///
  /// In es, this message translates to:
  /// **'Solución Particular'**
  String get solucionParticular;

  /// No description provided for @seResuelveElSistemaDeEcuaciones.
  ///
  /// In es, this message translates to:
  /// **'Se Resuelve el Sistema de Ecuaciones'**
  String get seResuelveElSistemaDeEcuaciones;

  /// No description provided for @solucionGeneral.
  ///
  /// In es, this message translates to:
  /// **'Solución General'**
  String get solucionGeneral;

  /// No description provided for @ecuacionDiferencialReducibleALineal.
  ///
  /// In es, this message translates to:
  /// **'Ecuación Diferencial Reducible a Lineal'**
  String get ecuacionDiferencialReducibleALineal;

  /// No description provided for @ecuacionDiferencialReducidaALineal.
  ///
  /// In es, this message translates to:
  /// **'Ecuación Diferencial Reducida a Lineal'**
  String get ecuacionDiferencialReducidaALineal;

  /// No description provided for @seRegresanLosValoresOriginalesAZ.
  ///
  /// In es, this message translates to:
  /// **'Se Regresan los Valores Originales a Z'**
  String get seRegresanLosValoresOriginalesAZ;

  /// No description provided for @funcionesDeXSePonenConSuRespectivoSigno.
  ///
  /// In es, this message translates to:
  /// **'Funciones de X se Ponen con su Respectivo Signo'**
  String get funcionesDeXSePonenConSuRespectivoSigno;

  /// No description provided for @seHaceLaSustitucionDe.
  ///
  /// In es, this message translates to:
  /// **'Se Hace la Sustitución de'**
  String get seHaceLaSustitucionDe;

  /// No description provided for @factorIntegrante.
  ///
  /// In es, this message translates to:
  /// **'Factor Integrante'**
  String get factorIntegrante;

  /// No description provided for @variablesSeparadas.
  ///
  /// In es, this message translates to:
  /// **'Variables Separadas'**
  String get variablesSeparadas;

  /// No description provided for @seIntegraDeAmbosLadosParaObtenerLaSolucionGeneral.
  ///
  /// In es, this message translates to:
  /// **'Se Integra de Ambos Lados para Obtener la Solución General'**
  String get seIntegraDeAmbosLadosParaObtenerLaSolucionGeneral;

  /// No description provided for @elFactorIntegranteEsIgualAlInversoDeLaMultiplicacionDeLosFactoresQueNoContienenLaVariableDelDiferencialSeMultiplicaPorAmbosLados.
  ///
  /// In es, this message translates to:
  /// **'El Factor Integrante es Igual al Inverso de la Multiplicación de los Factores que No Contienen la Variable del Diferencial, Se Multiplica por Ambos Lados'**
  String
      get elFactorIntegranteEsIgualAlInversoDeLaMultiplicacionDeLosFactoresQueNoContienenLaVariableDelDiferencialSeMultiplicaPorAmbosLados;

  /// No description provided for @diferenciaPotencial.
  ///
  /// In es, this message translates to:
  /// **'Diferencia de Potencial'**
  String get diferenciaPotencial;

  /// No description provided for @cargaPuntual.
  ///
  /// In es, this message translates to:
  /// **'Carga Puntual'**
  String get cargaPuntual;

  /// No description provided for @lineaInfinita.
  ///
  /// In es, this message translates to:
  /// **'Línea Infinita'**
  String get lineaInfinita;

  /// No description provided for @superficieInfinita.
  ///
  /// In es, this message translates to:
  /// **'Superficie Infinita'**
  String get superficieInfinita;

  /// No description provided for @placasConductoras.
  ///
  /// In es, this message translates to:
  /// **'Dos Placas Conductoras, Paralelas y Cargas Iguales de Signo Contrario'**
  String get placasConductoras;

  /// No description provided for @definicionElectricidad.
  ///
  /// In es, this message translates to:
  /// **'Definición de Electricidad'**
  String get definicionElectricidad;

  /// No description provided for @origenElectricidad.
  ///
  /// In es, this message translates to:
  /// **'El Término Electricidad proviene del Vocablo Griego \'Elektron\' (Ámbar). La Palabra debe su Origen a los Primeros Materiales Utilizados al Observar la Existencia de una Fuerza Eléctrica. Actualmente se trata de una Ciencia, Rama de la Física, que Estudia a la Carga Eléctrica y su Interacción con Otras, así como su Efecto en el Medio que le Rodea.'**
  String get origenElectricidad;

  /// No description provided for @conceptoCarga.
  ///
  /// In es, this message translates to:
  /// **'El Concepto Actual de Carga Eléctrica ha Sido Construido con el Paso de los Años a Partir de una Serie de Descubrimientos:'**
  String get conceptoCarga;

  /// No description provided for @efectosAmbar.
  ///
  /// In es, this message translates to:
  /// **'600 A.C. Efectos Atractivos en Ámbar Frotado con Piel - Tales de Mileto'**
  String get efectosAmbar;

  /// No description provided for @postulacionSustancia.
  ///
  /// In es, this message translates to:
  /// **'1600. Postulación de la Existencia de una Sustancia (\'Electrón\') Responsable de dicho Fenómeno (\'Electricidad\') - William Gilbert'**
  String get postulacionSustancia;

  /// No description provided for @tiposSustancia.
  ///
  /// In es, this message translates to:
  /// **'1752. Postulación de la Existencia de dos Tipos de Sustancia, Carga Eléctrica Positiva y Carga Eléctrica Negativa (Convención) - Benjamin Franklin'**
  String get tiposSustancia;

  /// No description provided for @descubrimientoElectron.
  ///
  /// In es, this message translates to:
  /// **'1897. Descubrimiento del Electrón en Experimentos con Tubos de Rayos Catódicos - Joseph John Thomson'**
  String get descubrimientoElectron;

  /// No description provided for @donde.
  ///
  /// In es, this message translates to:
  /// **'donde'**
  String get donde;

  /// No description provided for @sustituyenIntegral.
  ///
  /// In es, this message translates to:
  /// **'Posteriormente se sustituyen cada una en su respectiva integral y se iguala a C para obtener la solución general.'**
  String get sustituyenIntegral;

  /// No description provided for @integranDiferenciales.
  ///
  /// In es, this message translates to:
  /// **'Se integran ambos diferenciales y se suma a cada uno la constante de la variable que es diferente a la del diferencial (c(x) o c(y)).'**
  String get integranDiferenciales;

  /// No description provided for @variableConstante.
  ///
  /// In es, this message translates to:
  /// **'La variable se toma como constante a la hora de integrar. Después se encuentran los valores de cada constante igualándolas a la solución de la Integral del otro diferencial y quitando los términos que se repiten en ambas soluciones'**
  String get variableConstante;

  /// No description provided for @convencionFranklin.
  ///
  /// In es, this message translates to:
  /// **'Convención de Benjamín Franklin'**
  String get convencionFranklin;

  /// No description provided for @procesoCarga.
  ///
  /// In es, this message translates to:
  /// **'Es un proceso de carga por fricción, la barra de vidrio adquiere carga positiva después de haberse frotado con tela de seda, y la barra de ebonita adquiere carga negativa después de haberse frotado con piel de conejo.'**
  String get procesoCarga;

  /// No description provided for @dosTiposCarga.
  ///
  /// In es, this message translates to:
  /// **'En la naturaleza existen dos tipos de carga eléctrica denominados positiva y negativa. Cargas de un mismo signo se repelen y cargas de signos opuestos se atraen.'**
  String get dosTiposCarga;

  /// No description provided for @definicionCarga.
  ///
  /// In es, this message translates to:
  /// **'Definición de carga eléctrica'**
  String get definicionCarga;

  /// No description provided for @cargaElectrostatica.
  ///
  /// In es, this message translates to:
  /// **'La Carga Eléctrica es una propiedad de la materia que explica el origen de las interacciones electrostáticas (fuerzas eléctricas).'**
  String get cargaElectrostatica;

  /// No description provided for @propiedadCarga.
  ///
  /// In es, this message translates to:
  /// **'La Carga Eléctrica es una propiedad que cuantifica la ganancia o pérdida de electrones.'**
  String get propiedadCarga;

  /// No description provided for @produccionCarga.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo se produce carga eléctrica?'**
  String get produccionCarga;

  /// No description provided for @principioConservacion.
  ///
  /// In es, this message translates to:
  /// **'El Principio de Conservación de la Carga Eléctrica establece que no hay destrucción ni creación neta de carga eléctrica, en todo proceso eléctrico la carga total de un sistema aislado se conserva.'**
  String get principioConservacion;

  /// No description provided for @transferenciaCarga.
  ///
  /// In es, this message translates to:
  /// **'Formalmente no es posible crear o destruir carga eléctrica, sin embargo es posible realizar transferencia de carga de un cuerpo a otro mediante diferentes procesos de carga y descarga.'**
  String get transferenciaCarga;

  /// No description provided for @procesosTransferencia.
  ///
  /// In es, this message translates to:
  /// **'Procesos de transferencia de carga'**
  String get procesosTransferencia;

  /// No description provided for @procesosCarga.
  ///
  /// In es, this message translates to:
  /// **'1) Procesos de Carga: Transferencia de carga por contacto, por frotamiento y por inducción.'**
  String get procesosCarga;

  /// No description provided for @procesosDescarga.
  ///
  /// In es, this message translates to:
  /// **'2) Procesos de Descarga: Conexión a tierra, ionización y viento eléctrico.'**
  String get procesosDescarga;

  /// No description provided for @clasificacionMateriales.
  ///
  /// In es, this message translates to:
  /// **'Clasificación de los materiales (electricidad)'**
  String get clasificacionMateriales;

  /// No description provided for @materialConductor.
  ///
  /// In es, this message translates to:
  /// **'Material Conductor: Es cualquier sustancia con un gran número de portadores de carga libre, es capaz de transportar un gran número de ellos. Ejemplo: Metales, gases ionizados, electrolitos.'**
  String get materialConductor;

  /// No description provided for @materialDielectrico.
  ///
  /// In es, this message translates to:
  /// **'Material Dieléctrico (Aislante o Semiconductor): Es cualquier sustancia que no posee portadores de carga libre o posee un número muy reducido de ellos, esta sustancia no puede transportar portadores de carga libre. Ejemplo: Plástico, aceite, gases nobles.'**
  String get materialDielectrico;

  /// No description provided for @cargaElectron.
  ///
  /// In es, this message translates to:
  /// **'Carga del Electrón'**
  String get cargaElectron;

  /// No description provided for @cargaProton.
  ///
  /// In es, this message translates to:
  /// **'Carga del Protón'**
  String get cargaProton;

  /// No description provided for @unidadCarga.
  ///
  /// In es, this message translates to:
  /// **'Unidad de Medida de Carga Eléctrica (SI)'**
  String get unidadCarga;

  /// No description provided for @naturalezaCarga.
  ///
  /// In es, this message translates to:
  /// **'La Carga Eléctrica Posee una Naturaleza Discreta (Número Entero de Electrones) sin embargo no siempre se presenta en forma de carga puntual (la dimensión de la carga es despreciable en comparación a las dimensiones físicas del problema).'**
  String get naturalezaCarga;

  /// No description provided for @distribucionCarga.
  ///
  /// In es, this message translates to:
  /// **'En Muchas Ocasiones la Carga Eléctrica se Presenta en Forma de una Distribución Continua de Carga a lo Largo de una Línea, Superficie o Volumen, Obien en Formas Complejas como Densidades Electrónicas en Átomos o en Orbitales Moleculares.'**
  String get distribucionCarga;

  /// No description provided for @densidadLineal.
  ///
  /// In es, this message translates to:
  /// **'Densidad Lineal de Carga'**
  String get densidadLineal;

  /// No description provided for @densidadSuperficial.
  ///
  /// In es, this message translates to:
  /// **'Densidad Superficial de Carga'**
  String get densidadSuperficial;

  /// No description provided for @densidadVolumetrica.
  ///
  /// In es, this message translates to:
  /// **'Densidad Volumétrica de Carga'**
  String get densidadVolumetrica;

  /// No description provided for @leyCoulombTexto.
  ///
  /// In es, this message translates to:
  /// **'La Ley de Coulomb Establece que entre un Par de Cargas Puntuales se Ejerce una Fuerza Eléctrica Repulsiva o atractiva, proporcional al Producto de las Cargas, inversamente proporcional al Cuadrado de la Distancia de Separación entre Ellas y que Actúa sobre el Vector que las Une.'**
  String get leyCoulombTexto;

  /// No description provided for @unidadFuerza.
  ///
  /// In es, this message translates to:
  /// **'Unidad de Medida de Fuerza (SI)'**
  String get unidadFuerza;

  /// No description provided for @constanteCoulomb.
  ///
  /// In es, this message translates to:
  /// **'Constante de Coulomb'**
  String get constanteCoulomb;

  /// No description provided for @permitividadVacio.
  ///
  /// In es, this message translates to:
  /// **'Permitividad Eléctrica del Vacío'**
  String get permitividadVacio;

  /// No description provided for @principioSuperposicionTexto.
  ///
  /// In es, this message translates to:
  /// **'El Principio de Superposición Establece que en un Sistema de Cargas, La Fuerza Eléctrica Que Se Ejerce Entre un Par de Cargas No Dependerá de la Presencia o Ausencia de Cargas Adicionales, Por lo Tanto La Fuerza Eléctrica Total en una Carga Puede Calcularse Considerando la Contribución Entre Pares de Cargas y Posteriormente a través de una Suma Vectorial.'**
  String get principioSuperposicionTexto;

  /// No description provided for @flujoCampoVectorial.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de un Campo Vectorial Puede Entenderse Como una Medida del Flujo o de la Penetración de los Vectores Asociados al Campo Vectorial a Través de un Elemento de Superficie Fijo e Imaginario'**
  String get flujoCampoVectorial;

  /// No description provided for @flujoCampoVectorialSuperficie.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de un Campo Vectorial es una Medida del Número de Líneas del Campo Vectorial que Atraviesan la Superficie de Área A'**
  String get flujoCampoVectorialSuperficie;

  /// No description provided for @flujoCampoVectorialDiscreto.
  ///
  /// In es, this message translates to:
  /// **'Flujo del Campo Vectorial Respecto a un Número Discreto de Superficies'**
  String get flujoCampoVectorialDiscreto;

  /// No description provided for @flujoCampoVectorialContinuo.
  ///
  /// In es, this message translates to:
  /// **'Flujo del Campo Vectorial Respecto a una Superficie Continua'**
  String get flujoCampoVectorialContinuo;

  /// No description provided for @flujoCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico Puede Entenderse Como una Medida del Flujo o de la Penetración de los Vectores del Campo Eléctrico a Través de un Elemento de Superficie Fijo e Imaginario'**
  String get flujoCampoElectrico;

  /// No description provided for @flujoCampoElectricoSuperficie.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico es una Medida del Número de Líneas del Campo Eléctrico que Atraviesan una Superficie Dada'**
  String get flujoCampoElectricoSuperficie;

  /// No description provided for @integralFlujo.
  ///
  /// In es, this message translates to:
  /// **'La Integral Requiere de una Función Continua Definida en la Superficie Imaginaria, si la Función no es Continua en Toda la Superficie, el Flujo se Obtiene a Partir de la Suma de Integrales Definidas en Intervalos con Funciones Continuas'**
  String get integralFlujo;

  /// No description provided for @terminosDiferenciales.
  ///
  /// In es, this message translates to:
  /// **'En Términos de Diferenciales'**
  String get terminosDiferenciales;

  /// No description provided for @campoElectrostaticoConservativo.
  ///
  /// In es, this message translates to:
  /// **'El Campo Electrostático es Conservativo'**
  String get campoElectrostaticoConservativo;

  /// No description provided for @rotacionalGradiente.
  ///
  /// In es, this message translates to:
  /// **'El Rotacional del Gradiente de una Función Escalar'**
  String get rotacionalGradiente;

  /// No description provided for @campoElectricoGradiente.
  ///
  /// In es, this message translates to:
  /// **'El Campo Eléctrico se Puede Escribir Como el Gradiente de una Función Escalar'**
  String get campoElectricoGradiente;

  /// No description provided for @flujoCampoElectricoSuperficieGaussiana.
  ///
  /// In es, this message translates to:
  /// **'Flujo de Campo Eléctrico Respecto a Una Superficie Continua y Cerrada (Gaussiana)'**
  String get flujoCampoElectricoSuperficieGaussiana;

  /// No description provided for @superficieGaussiana.
  ///
  /// In es, this message translates to:
  /// **'Superficie Gaussiana'**
  String get superficieGaussiana;

  /// No description provided for @leyDeGauss.
  ///
  /// In es, this message translates to:
  /// **'Ley de Gauss'**
  String get leyDeGauss;

  /// No description provided for @leyDeGaussProporcional.
  ///
  /// In es, this message translates to:
  /// **'La Ley de Gauss Establece que el Flujo Eléctrico en una Superficie Cerrada alrededor de una Carga es Proporcional a la Carga Encerrada'**
  String get leyDeGaussProporcional;

  /// No description provided for @notasImportantes.
  ///
  /// In es, this message translates to:
  /// **'Notas Importantes'**
  String get notasImportantes;

  /// No description provided for @flujoCampoElectricoCero.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico es Cero si la Superficie Gaussiana no Contiene Fuentes (Cargas Positivas) o Sumideros (Cargas Negativas)'**
  String get flujoCampoElectricoCero;

  /// No description provided for @flujoCampoElectricoPositivoNegativo.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico Será Positivo si la Superficie Gaussiana Contiene Fuentes. El Flujo Eléctrico Será Negativo si la Superficie Gaussiana Contiene Sumideros'**
  String get flujoCampoElectricoPositivoNegativo;

  /// No description provided for @distribucionCargasSuperficieGaussiana.
  ///
  /// In es, this message translates to:
  /// **'En el Caso de una Distribución de Cargas Encerradas Por una Superficie Gaussiana, el Flujo Eléctrico Dependerá de la Magnitud y Distribución Espacial de la Carga Neta Encerrada'**
  String get distribucionCargasSuperficieGaussiana;

  /// No description provided for @aplicacionesLeyDeGauss.
  ///
  /// In es, this message translates to:
  /// **'Aplicaciones de la Ley de Gauss'**
  String get aplicacionesLeyDeGauss;

  /// No description provided for @campoElectricoCargaPuntual.
  ///
  /// In es, this message translates to:
  /// **'Campo Eléctrico de una Carga Puntual'**
  String get campoElectricoCargaPuntual;

  /// No description provided for @diferenciaDePotencial.
  ///
  /// In es, this message translates to:
  /// **'Diferencia de Potencial'**
  String get diferenciaDePotencial;

  /// No description provided for @placasConductorasParalelasCargadas.
  ///
  /// In es, this message translates to:
  /// **'Dos Placas Conductoras, Paralelas y Cargas Iguales de Signo Contrario'**
  String get placasConductorasParalelasCargadas;

  /// No description provided for @campoElectricoFuerzaElectrostatica.
  ///
  /// In es, this message translates to:
  /// **'El Campo Eléctrico es una Región en el Espacio en donde al colocar una Carga de Prueba q0 ésta experimentará una Fuerza de Tipo Electrostática'**
  String get campoElectricoFuerzaElectrostatica;

  /// No description provided for @campoElectricoFuerzaPorUnidadCarga.
  ///
  /// In es, this message translates to:
  /// **'El Campo Eléctrico en un Punto En El Espacio Se Define Como La Fuerza Por Unidad De Carga'**
  String get campoElectricoFuerzaPorUnidadCarga;

  /// No description provided for @campoElectricoOriginadoCargaPuntual.
  ///
  /// In es, this message translates to:
  /// **'Campo Eléctrico Originado Por Una Carga Puntual'**
  String get campoElectricoOriginadoCargaPuntual;

  /// No description provided for @distribucionDiscretaCargasPuntuales.
  ///
  /// In es, this message translates to:
  /// **'Distribución Discreta de Cargas Puntuales'**
  String get distribucionDiscretaCargasPuntuales;

  /// No description provided for @discoCargaUniforme.
  ///
  /// In es, this message translates to:
  /// **'Disco con Carga Uniforme'**
  String get discoCargaUniforme;

  /// No description provided for @segmentoLinea.
  ///
  /// In es, this message translates to:
  /// **'Segmento de Línea'**
  String get segmentoLinea;

  /// No description provided for @ecuacionPoisson.
  ///
  /// In es, this message translates to:
  /// **'Ecuación de Poisson'**
  String get ecuacionPoisson;

  /// No description provided for @ecuacionLaplace.
  ///
  /// In es, this message translates to:
  /// **'Ecuación de Laplace'**
  String get ecuacionLaplace;

  /// No description provided for @operadorLaplaciano.
  ///
  /// In es, this message translates to:
  /// **'Operador Laplaciano'**
  String get operadorLaplaciano;

  /// No description provided for @fuerzaCampoElectricoFuerzaContraria.
  ///
  /// In es, this message translates to:
  /// **'La Carga q Experimentará una Fuerza debido a la Presencia del Campo Eléctrico, para Mantenerla en la Posición Fija, se Debe Aplicar una Fuerza de la Misma Magnitud pero en Sentido Contrario'**
  String get fuerzaCampoElectricoFuerzaContraria;

  /// No description provided for @trabajoCargaPuntoBPuntoA.
  ///
  /// In es, this message translates to:
  /// **'Para llevar la Carga de Punto B al Punto A se Debe Realizar un Trabajo'**
  String get trabajoCargaPuntoBPuntoA;

  /// No description provided for @trabajoVariacionEnergiaPotencial.
  ///
  /// In es, this message translates to:
  /// **'En el Caso de Un Campo Conservativo (Como lo es el Campo Electrostático) el Trabajo Realizado es Igual a la Variación de Energía Potencial (Energía Potencial Eléctrica)'**
  String get trabajoVariacionEnergiaPotencial;

  /// No description provided for @energiaPotencialElectricaCargaPuntoA.
  ///
  /// In es, this message translates to:
  /// **'Representa la Energía Potencial Eléctrica de la Carga q en el Punto A. A la energía Potencial Eléctrica por Unidad de Carga se le Conoce como Potencial Eléctrico'**
  String get energiaPotencialElectricaCargaPuntoA;

  /// No description provided for @restaDosPotencialesElectricos.
  ///
  /// In es, this message translates to:
  /// **'La Resta de Dos Potenciales Eléctricos se Denomina Diferencia de Potencial'**
  String get restaDosPotencialesElectricos;

  /// No description provided for @unidadMedidaEnergiaPotencialElectricaSI.
  ///
  /// In es, this message translates to:
  /// **'Unidad de medida de energía potencial eléctrica (SI)'**
  String get unidadMedidaEnergiaPotencialElectricaSI;

  /// No description provided for @flujoCampoVectorialSuperficieFijaImaginaria.
  ///
  /// In es, this message translates to:
  /// **'El flujo de un Campo Vectorial puede entenderse como una Medida del Flujo o de la Penetración de los Vectores asociados al Campo Vectorial a través de un Elemento de Superficie Fijo e Imaginario'**
  String get flujoCampoVectorialSuperficieFijaImaginaria;

  /// No description provided for @flujoCampoVectorialSuperficieAreaA.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de un Campo Vectorial es una Medida del Número de Líneas del Campo Vectorial que atraviesan la Superficie de Área A'**
  String get flujoCampoVectorialSuperficieAreaA;

  /// No description provided for @flujoCampoVectorialRespectoSuperficie.
  ///
  /// In es, this message translates to:
  /// **'Flujo del Campo Vectorial respecto a la Superficie'**
  String get flujoCampoVectorialRespectoSuperficie;

  /// No description provided for @flujoCampoVectorialRespectoSuperficiesDiscretas.
  ///
  /// In es, this message translates to:
  /// **'Flujo del Campo Vectorial Respecto a un Número Discreto de Superficies'**
  String get flujoCampoVectorialRespectoSuperficiesDiscretas;

  /// No description provided for @flujoCampoElectricoSuperficieFijaImaginaria.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico puede Entenderse como una medida del Flujo o de la Penetración de los Vectores del Campo Eléctrico a través de un Elemento de Superficie Fijo e Imaginario'**
  String get flujoCampoElectricoSuperficieFijaImaginaria;

  /// No description provided for @flujoCampoElectricoSuperficieDada.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico es una Medida del Número de Líneas del Campo Eléctrico que atraviesan una Superficie Dada'**
  String get flujoCampoElectricoSuperficieDada;

  /// No description provided for @integralFuncionContinuaSuperficieImaginaria.
  ///
  /// In es, this message translates to:
  /// **'La Integral Requiere de una Función Continua Definida en la Superficie Imaginaria, si la Función no es Continua en toda la Superficie, el Flujo se obtiene a partir de la Suma de Integrales Definidas en Intervalos con Funciones Continuas'**
  String get integralFuncionContinuaSuperficieImaginaria;

  /// No description provided for @diferenciaPotencialCampoElectricoyCampo.
  ///
  /// In es, this message translates to:
  /// **'Diferencia de Potencial y Campo Eléctrico'**
  String get diferenciaPotencialCampoElectricoyCampo;

  /// No description provided for @rotacionalGradienteFuncionEscalar.
  ///
  /// In es, this message translates to:
  /// **'El Rotacional del Gradietne de Una Función Escalar'**
  String get rotacionalGradienteFuncionEscalar;

  /// No description provided for @campoElectricoGradienteFuncionEscalar.
  ///
  /// In es, this message translates to:
  /// **'El Campo Eléctrico se puede escribir como el gradiente de una función escalar'**
  String get campoElectricoGradienteFuncionEscalar;

  /// No description provided for @flujoCampoElectricoSuperficieContinuaCerradaGaussiana.
  ///
  /// In es, this message translates to:
  /// **'Flujo de Campo Eléctrico Respecto a Una Superficie Continua y Cerrada (Gaussiana)'**
  String get flujoCampoElectricoSuperficieContinuaCerradaGaussiana;

  /// No description provided for @leyGauss.
  ///
  /// In es, this message translates to:
  /// **'Ley de Gauss'**
  String get leyGauss;

  /// No description provided for @leyGaussFlujoElectricoCargaEncerrada.
  ///
  /// In es, this message translates to:
  /// **'La Ley de Gauss Establece que el Flujo Eléctrico en una Superficie Cerrada alrededor de una Carga es Proporcional a la Carga Encerrada'**
  String get leyGaussFlujoElectricoCargaEncerrada;

  /// No description provided for @flujoCampoElectricoCeroSuperficieGaussiana.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico es Cero si la Superficie Gaussiana no Contiene Fuentes (Cargas Positivas) o Sumideros (Cargas Negativas)'**
  String get flujoCampoElectricoCeroSuperficieGaussiana;

  /// No description provided for @flujoCampoElectricoPositivoSuperficieGaussianaFuentes.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico será Positivo si la Superficie Gaussiana Contiene Fuentes. El Flujo Eléctrico será Negativo si la Superficie Gaussiana Contiene Sumideros'**
  String get flujoCampoElectricoPositivoSuperficieGaussianaFuentes;

  /// No description provided for @unidadMedidaFlujoElectricoSI.
  ///
  /// In es, this message translates to:
  /// **'Unidad de Medida de Flujo Eléctrico (SI)'**
  String get unidadMedidaFlujoElectricoSI;

  /// No description provided for @aplicacionesLeyGauss.
  ///
  /// In es, this message translates to:
  /// **'Aplicaciones de la Ley de Gauss'**
  String get aplicacionesLeyGauss;

  /// No description provided for @campoElectricoLineaInfinitaCarga.
  ///
  /// In es, this message translates to:
  /// **'Campo Eléctrico de una Línea Infinita de Carga'**
  String get campoElectricoLineaInfinitaCarga;

  /// No description provided for @unidadMedidaCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Unidad de medida de campo eléctrico (SI)'**
  String get unidadMedidaCampoElectrico;

  /// No description provided for @esquemasCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Esquemas de campo eléctrico'**
  String get esquemasCampoElectrico;

  /// No description provided for @representacionCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'El Campo Eléctrico se Representa Mediante Un Conjunto De Líneas Denominadas Líneas De Campo Eléctrico, Estas Poseen Las Siguientes Propiedades:'**
  String get representacionCampoElectrico;

  /// No description provided for @tangenteLineasCampo.
  ///
  /// In es, this message translates to:
  /// **'La Tangente A La Línes Del Campo Eléctrico Que Cruza Un Punto Cualquiera Del Espacio Denota La Dirección Del Campo Eléctrico En Ese Punto.'**
  String get tangenteLineasCampo;

  /// No description provided for @lineasCampoPerpendiculares.
  ///
  /// In es, this message translates to:
  /// **'Las líneas de Campo Eléctrico Son Perpendiculaes A La Superficie Que Las Genera.'**
  String get lineasCampoPerpendiculares;

  /// No description provided for @lineasCampoContinuas.
  ///
  /// In es, this message translates to:
  /// **'Las Líneas De Campo Eléctrico Son Continuas Y Nunca Se Cruzan.'**
  String get lineasCampoContinuas;

  /// No description provided for @lineasCampoComienzanCargas.
  ///
  /// In es, this message translates to:
  /// **'Las Líneas de Campo Eléctrico Comienzan en las Cargas Positivas y Terminan en las Negativas.'**
  String get lineasCampoComienzanCargas;

  /// No description provided for @magnitudCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'La Magnitud del Campo Eléctrico En Una Región Del Espacio Es Proporcional Al Número De Líneas De Campo Eléctrico En Esa Región.'**
  String get magnitudCampoElectrico;

  /// No description provided for @distribucionDiscretaCargas.
  ///
  /// In es, this message translates to:
  /// **'Distribución Discreta de Cargas Puntuales'**
  String get distribucionDiscretaCargas;

  /// No description provided for @circulacionCampoElectrostaticoCero.
  ///
  /// In es, this message translates to:
  /// **'La Circulación del Campo Electrostático es siempre cero.'**
  String get circulacionCampoElectrostaticoCero;

  /// No description provided for @fuerzaCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'La Carga q Experimentará una Fuerza debido a la Presencia del Campo Eléctrico, para Mantenerla en la Posición Fija, se Debe Aplicar una Fuerza de la Misma Magnitud pero en Sentido Contrario.'**
  String get fuerzaCampoElectrico;

  /// No description provided for @trabajoCarga.
  ///
  /// In es, this message translates to:
  /// **'Para llevar la Carga de Punto B al Punto A se Debe Realizar un Trabajo.'**
  String get trabajoCarga;

  /// No description provided for @campoConservativo.
  ///
  /// In es, this message translates to:
  /// **'En el Caso de Un Campo Conservativo (Como lo es el Campo Electrostático) el Trabajo Realizado es Igual a la Variación de Energía Potencial (Energía Potencial Eléctrica).'**
  String get campoConservativo;

  /// No description provided for @energiaPotencialElectricaTexto.
  ///
  /// In es, this message translates to:
  /// **'Representa la Energía Potencial Eléctrica de la Carga q en el Punto A. A la energía Potencial Eléctrica por Unidad de Carga se le Conoce como Potencial Eléctrico.'**
  String get energiaPotencialElectricaTexto;

  /// No description provided for @diferenciaPotencialTexto.
  ///
  /// In es, this message translates to:
  /// **'La Resta de Dos Potenciales Eléctricos se Denomina Diferencia de Potencial.'**
  String get diferenciaPotencialTexto;

  /// No description provided for @unidadEnergiaPotencial.
  ///
  /// In es, this message translates to:
  /// **'Unidad de medida de energía potencial eléctrica (SI)'**
  String get unidadEnergiaPotencial;

  /// No description provided for @flujoCampoVectorialNumeroLineas.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de un Campo Vectorial es una Medida del Número de Líneas del Campo Vectorial que atraviesan la Superficie de Área A.'**
  String get flujoCampoVectorialNumeroLineas;

  /// No description provided for @flujoCampoVectorialSuperficiesDiscretas.
  ///
  /// In es, this message translates to:
  /// **'Flujo del Campo Vectorial Respecto a un Número Discreto de Superficies'**
  String get flujoCampoVectorialSuperficiesDiscretas;

  /// No description provided for @flujoCampoVectorialSuperficieContinua.
  ///
  /// In es, this message translates to:
  /// **'Flujo del Campo Vectorial Respecto a una Superficie Continua'**
  String get flujoCampoVectorialSuperficieContinua;

  /// No description provided for @flujoCampoElectricoEntenderse.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico puede Entenderse como una medida del Flujo o de la Penetración de los Vectores del Campo Eléctrico a través de un Elemento de Superficie Fijo e Imaginario.'**
  String get flujoCampoElectricoEntenderse;

  /// No description provided for @flujoCampoElectricoNumeroLineas.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Eléctrico es una Media del Número de Líneas del Campo Eléctrico que atraviesan una Superficies Dada.'**
  String get flujoCampoElectricoNumeroLineas;

  /// No description provided for @integralFuncionContinua.
  ///
  /// In es, this message translates to:
  /// **'La Integral Requiere de una Función Continua Definida en la Superficie Imaginaria, si la Función no es Continua en toda la Superficie, el Flujo se obtiene a partir de la Suma de Integrales Definidas en Intervalos con Funciones Continuas.'**
  String get integralFuncionContinua;

  /// No description provided for @diferenciaPotencialCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Diferencia de Potencial y Campo Eléctrico'**
  String get diferenciaPotencialCampoElectrico;

  /// No description provided for @gradientePotencialCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Gradiente de Potencial y Campo Eléctrico'**
  String get gradientePotencialCampoElectrico;

  /// No description provided for @leyGaussFormaIntegral.
  ///
  /// In es, this message translates to:
  /// **'Ley de Gauss en Forma Integral'**
  String get leyGaussFormaIntegral;

  /// No description provided for @teoremaDivergenciaDensidadVolumetricaCarga.
  ///
  /// In es, this message translates to:
  /// **'Teorema de la Divergencia y Densidad Volumétrica de Carga'**
  String get teoremaDivergenciaDensidadVolumetricaCarga;

  /// No description provided for @leyGaussPrimeraLeyMaxwell.
  ///
  /// In es, this message translates to:
  /// **'Ley de Gauss\nPrimera Ley de Maxwell'**
  String get leyGaussPrimeraLeyMaxwell;

  /// No description provided for @leyGaussFormaDiferencial.
  ///
  /// In es, this message translates to:
  /// **'Ley de Gauss en Forma Diferencial'**
  String get leyGaussFormaDiferencial;

  /// No description provided for @operadorGradienteFuncion.
  ///
  /// In es, this message translates to:
  /// **'El Operador Gradiente De Una Función Evaluado en un Punto Arbitrario Indica la Dirección en la que la Función Varía Más Rápidamente.'**
  String get operadorGradienteFuncion;

  /// No description provided for @operadorGradienteDerivadasDireccionales.
  ///
  /// In es, this message translates to:
  /// **'El Operador Gradiente Representa el Conjunto de Derivadas Direccionales Con Respecto a las Coordenadas de un Sistema de Referencia Dado.'**
  String get operadorGradienteDerivadasDireccionales;

  /// No description provided for @operadorGradienteDiferencialTotal.
  ///
  /// In es, this message translates to:
  /// **'El Operador Gradiente Se Utiliza para Obtener el Diferencial Total de una Función en un Sistema de Coordenadas Generalizado.'**
  String get operadorGradienteDiferencialTotal;

  /// No description provided for @rotacionalCampoElectrostaticoCero.
  ///
  /// In es, this message translates to:
  /// **'El Rotacional Del Campo Electrostático SIEMPRE es Cero.'**
  String get rotacionalCampoElectrostaticoCero;

  /// No description provided for @campoElectrostaticoFuerzasConservativas.
  ///
  /// In es, this message translates to:
  /// **'Esto implica que el Campo Electrostático está asociado a sistemas con fuerzas conservativas, en estos sistemas la energía siempre se conserva.'**
  String get campoElectrostaticoFuerzasConservativas;

  /// No description provided for @segundaLeyMaxwell.
  ///
  /// In es, this message translates to:
  /// **'Segunda Ley de Maxwell'**
  String get segundaLeyMaxwell;

  /// No description provided for @teoremaUnicidad.
  ///
  /// In es, this message translates to:
  /// **'El Teorema de Unicidad establece que cualquier solución a la ecuación de Poisson o Laplace que satisface las condiciones de frontera de un problema particular es única.'**
  String get teoremaUnicidad;

  /// No description provided for @superficiesConductorasCargadasParalelas.
  ///
  /// In es, this message translates to:
  /// **'Superficies Conductoras Cargadas Paralelas'**
  String get superficiesConductorasCargadasParalelas;

  /// No description provided for @condicionesFrontera.
  ///
  /// In es, this message translates to:
  /// **'Condiciones en la Frontera'**
  String get condicionesFrontera;

  /// No description provided for @superficieEquipotencial.
  ///
  /// In es, this message translates to:
  /// **'Una Superficie Equipotencial es una Región Geométrica en donde el Potencial Eléctrico es Constante'**
  String get superficieEquipotencial;

  /// No description provided for @equipotencialCumple.
  ///
  /// In es, this message translates to:
  /// **'En una Equipotencial se Cumple:'**
  String get equipotencialCumple;

  /// No description provided for @unCapacitorEsUnDispositivo.
  ///
  /// In es, this message translates to:
  /// **'Un Capacitor es un Dispotivo Formado por un Par de Placas de Material Conductor (Electrodos) Separadas por un Medio Dieléctrico (Vacío).'**
  String get unCapacitorEsUnDispositivo;

  /// No description provided for @unCapacitorEstaCargado.
  ///
  /// In es, this message translates to:
  /// **'Un Capacitor está Cargado Cuando sus Placas llevan Cargas Iguales y Opuestas +Q y -Q.\nLa Carga Total en el Capacitor es Cero y se Considera Q.'**
  String get unCapacitorEstaCargado;

  /// No description provided for @diferenciaDePotencialParPlacas.
  ///
  /// In es, this message translates to:
  /// **'Diferencia de Potencial Para un Par de Placas'**
  String get diferenciaDePotencialParPlacas;

  /// No description provided for @conLaGeometriaDelProblema.
  ///
  /// In es, this message translates to:
  /// **'Con la Geometría del Problema'**
  String get conLaGeometriaDelProblema;

  /// No description provided for @deAcuerdoALaDefinicionDeCapacitancia.
  ///
  /// In es, this message translates to:
  /// **'De Acuerdo a la Definición de Capacitancia'**
  String get deAcuerdoALaDefinicionDeCapacitancia;

  /// No description provided for @paraCargarUnCapacitor.
  ///
  /// In es, this message translates to:
  /// **'Para Cargar Un Capacitor se Debe Aplicar una Transferencia de Carga desde Un Cuerpo Externo'**
  String get paraCargarUnCapacitor;

  /// No description provided for @sentidoFisico.
  ///
  /// In es, this message translates to:
  /// **'Sentido Físico'**
  String get sentidoFisico;

  /// No description provided for @simbologia.
  ///
  /// In es, this message translates to:
  /// **'Simbología'**
  String get simbologia;

  /// No description provided for @conexionEnParalelo.
  ///
  /// In es, this message translates to:
  /// **'Conexión en Paralelo (Carga, Diferencia de Potencial y Capacitancia Equivalente)'**
  String get conexionEnParalelo;

  /// No description provided for @conexionEnSerie.
  ///
  /// In es, this message translates to:
  /// **'Conexión en Serie (Carga, Diferencia de Potencial y Capacitancia Equivalente)'**
  String get conexionEnSerie;

  /// No description provided for @elMomentoDipolar.
  ///
  /// In es, this message translates to:
  /// **'El Momento Dipolar en una Molécula y la Polarización de un Material Dependerá de la Rigidez con que las Cargas Eléctricas Estén Distribuidas en los Átomos Constituyentes.'**
  String get elMomentoDipolar;

  /// No description provided for @polarizacionEnRespuesta.
  ///
  /// In es, this message translates to:
  /// **'Polarización en Respuesta a un Campo Eléctrico Aplicado.'**
  String get polarizacionEnRespuesta;

  /// No description provided for @laConstante.
  ///
  /// In es, this message translates to:
  /// **'La Constante'**
  String get laConstante;

  /// No description provided for @seDenominaSusceptibilidad.
  ///
  /// In es, this message translates to:
  /// **'Se denomina Susceptibilidad Eléctrica. La Susceptibilidad Eléctrica es una constante adimensional de proporcionalidad que establece la relación entre Campo Eléctrico Aplicado y la Polarización Generada en un Material.'**
  String get seDenominaSusceptibilidad;

  /// No description provided for @permitividadRelativa.
  ///
  /// In es, this message translates to:
  /// **'Permitividad Relativa'**
  String get permitividadRelativa;

  /// No description provided for @permitividadDelMaterial.
  ///
  /// In es, this message translates to:
  /// **'Permitividad del Material'**
  String get permitividadDelMaterial;

  /// No description provided for @cuandoUnCapacitorSeCarga.
  ///
  /// In es, this message translates to:
  /// **'Cuando un Capacitor Se Carga, La Carga Que Aparece Entre Sus Placas Es Siempre Directamente Proporcional A La Diferencia De Potencial Entre Ellas. La Constante De Proporcionalidad Entre La Diferencia De Potencial Y La Carga Almacenada Se Conoce Como Capacitancia.'**
  String get cuandoUnCapacitorSeCarga;

  /// No description provided for @esUnProcesoDeCarga.
  ///
  /// In es, this message translates to:
  /// **'Es un Proceso de Carga en un Capacitor La Fuente Externa de Diferencia de Potencial Efectúa Cierta Cantidad de Trabajo para Transferir Carga Eléctrica de una Placa Conductora a Otra.'**
  String get esUnProcesoDeCarga;

  /// No description provided for @enUnCasoIdeal.
  ///
  /// In es, this message translates to:
  /// **'En un caso ideal por conservación, la cantidad de energía utilizada en el proceso de carga se mantiene al retirar la fuente de diferencia de potencial.'**
  String get enUnCasoIdeal;

  /// No description provided for @enUnCasoReal.
  ///
  /// In es, this message translates to:
  /// **'En un caso Real, cierta cantidad de trabajo se mantiene en el capacitor en forma de energía electrostática, ésta a su vez puede transformarse en otro tipo de energía (cinética en caso de corriente eléctrica).'**
  String get enUnCasoReal;

  /// No description provided for @capacitancia.
  ///
  /// In es, this message translates to:
  /// **'Capacitancia'**
  String get capacitancia;

  /// No description provided for @energiaPotencialElectricaDiferenciaPotencial.
  ///
  /// In es, this message translates to:
  /// **'Energía Potencial Eléctrica y Diferencia De Potencial'**
  String get energiaPotencialElectricaDiferenciaPotencial;

  /// No description provided for @alAplicarUnCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Al Aplicar un Campo Eléctrico a un Conductor se Presenta en su Interior el Movimiento de cada Portador de Carga Libre.\n\nEl movimiento de cada Portador de Carga Libre. El movimiento Conjunto de Cada Portador Puege Genera una Corriente Eléctrica al Interior del Material, o bien, debido al movimiento cada portador se deposita en la superficie del Material.'**
  String get alAplicarUnCampoElectrico;

  /// No description provided for @enUnDielectrico.
  ///
  /// In es, this message translates to:
  /// **'En un Dieléctrico, al aplicar un Campo Eléctrico Electrones y Núcleos sufren un Desplazamineto Generando el Fenómeno que se Denomina Polarización'**
  String get enUnDielectrico;

  /// No description provided for @unDipoloElectrico.
  ///
  /// In es, this message translates to:
  /// **'Un Dipolo Eléctrico es una Distribución de Carga Formada por Dos Cargas Puntuales de Igual Magnitud pero Con signo contrario Separadas por una distancia pequeña.'**
  String get unDipoloElectrico;

  /// No description provided for @laPolarizacion.
  ///
  /// In es, this message translates to:
  /// **'La Polarización es una Cantidad Vectorial que representa la cantidad de Momentos Dipolares Eléctricos por Unidad de Volumen.'**
  String get laPolarizacion;

  /// No description provided for @capacitorDePlacas.
  ///
  /// In es, this message translates to:
  /// **'Capacitor de placas planas y paralelas con un medio dieléctrico'**
  String get capacitorDePlacas;

  /// No description provided for @paraUnMaterialDado.
  ///
  /// In es, this message translates to:
  /// **'Para un material dado, a mayor campo Eléctrico se tendrá una mayor Densidad Superficial de Carga Inducida. En un caso real la carga inducida no puede crecer indefinidamente. Cuando el campo eléctrico es muy grande las fuerzas de origen electrostático pueden originar procesos de ionización.'**
  String get paraUnMaterialDado;

  /// No description provided for @elDesplazamientoDeCarga.
  ///
  /// In es, this message translates to:
  /// **'El desplazamiento de Carga Negativa y Positiva en el Interior del Material hace que el Material Dieléctrico pierda sus Propiedades, a este Fenómeno se le denomina Ruptura de Rigidez Dieléctrica, la Generación de una Alta Temperatura en muchas Ocasiones hace que el Dieléctrico se destruya por Combustión.'**
  String get elDesplazamientoDeCarga;

  /// No description provided for @paraMaterialesLineales.
  ///
  /// In es, this message translates to:
  /// **'Para Materiales Lineales e Isótropos'**
  String get paraMaterialesLineales;

  /// No description provided for @leyDeGaussGeneralizada.
  ///
  /// In es, this message translates to:
  /// **'Ley de Gauss Generalizada'**
  String get leyDeGaussGeneralizada;

  /// No description provided for @alTiempoT0.
  ///
  /// In es, this message translates to:
  /// **'Al tiempo t=0 (interruptor posición a)'**
  String get alTiempoT0;

  /// No description provided for @procesoDeCargaEnUnCapacitor.
  ///
  /// In es, this message translates to:
  /// **'Proceso de carga en un capacitor'**
  String get procesoDeCargaEnUnCapacitor;

  /// No description provided for @velocidadDeLosPortadoresDeCargaLibre.
  ///
  /// In es, this message translates to:
  /// **'Velocidad de los Portadores de Carga Libre'**
  String get velocidadDeLosPortadoresDeCargaLibre;

  /// No description provided for @densidadDeCorriente.
  ///
  /// In es, this message translates to:
  /// **'Densidad de Corriente'**
  String get densidadDeCorriente;

  /// No description provided for @conductividadElectrica.
  ///
  /// In es, this message translates to:
  /// **'Conductividad Eléctrica'**
  String get conductividadElectrica;

  /// No description provided for @laConductividadElectricaEsUnaConstante.
  ///
  /// In es, this message translates to:
  /// **'La Conductividad Eléctrica es una \'Constante\' de Proporcionalidad entre la Densidad de Corriente y el Campo Eléctrico. Su valor es una Propiedad que Depende del Material y que Indica su Capacidad para Conducir Corriente Eléctrica. Un Material con Alta Conductividad es un Buen Conductor de Corriente Eléctrica.'**
  String get laConductividadElectricaEsUnaConstante;

  /// No description provided for @conexionEnParaleloTexto.
  ///
  /// In es, this message translates to:
  /// **'Conexión en Paralelo (Corriente Diferencia de Potencial y Resistencia Equivalente)'**
  String get conexionEnParaleloTexto;

  /// No description provided for @conexionEnSerieTexto.
  ///
  /// In es, this message translates to:
  /// **'Conexión en Serie (Corriente Diferencia de Potencial y Resistencia Equivalente)'**
  String get conexionEnSerieTexto;

  /// No description provided for @densidadDeCorrienteDetalle.
  ///
  /// In es, this message translates to:
  /// **'Densidad de Corriente:\nLa densidad de Corriente Representa la Cantidad de Carga Por Unidad de Tiempo y por Unidad de Área de Sección Transversal Que Atraviesa un Conductor.'**
  String get densidadDeCorrienteDetalle;

  /// No description provided for @cargaInstantanea.
  ///
  /// In es, this message translates to:
  /// **'En el Caso en Que la Carga Que Cruza un Conductor Varía de Forma Instantánea en el Tiempo:'**
  String get cargaInstantanea;

  /// No description provided for @corrienteElectrica.
  ///
  /// In es, this message translates to:
  /// **'La Corriente Eléctrica Representa el Flujo de Carga Eléctrica a través de la Sección Transversal de Área en un Conductor por Unidad de Tiempo.'**
  String get corrienteElectrica;

  /// No description provided for @alambreConductor.
  ///
  /// In es, this message translates to:
  /// **'En el caso de un alambre conductor homogéneo con área de sección transversal constante.'**
  String get alambreConductor;

  /// No description provided for @leyDeOhm.
  ///
  /// In es, this message translates to:
  /// **'Ley de Ohm (magnitud)'**
  String get leyDeOhm;

  /// No description provided for @resistenciaElectrica.
  ///
  /// In es, this message translates to:
  /// **'La Resistencia Eléctrica es la Oposición al Paso de la Corriente Eléctrica que Presenta un Material'**
  String get resistenciaElectrica;

  /// No description provided for @ecuacionDeOhm.
  ///
  /// In es, this message translates to:
  /// **'La ecuación de Ohm establece que la diferencia de Potencial Aplicada a un Material y la Corriente que se Genera en su Interior son Directamente Proporcionales y se Relacionan a través de una Constante conocida como Resistencia Eléctrica.'**
  String get ecuacionDeOhm;

  /// No description provided for @desplazamientoDeElectrones.
  ///
  /// In es, this message translates to:
  /// **'El desplazamiento de Electrones en un sólido genera múltiples dispersiones (Colisiones) en el interior del material, el aumento de la energía cinética en la estructura interna del material (vibración) genera un aumento en su temperatura. Desde el punto de vista de energía, la energía cinética de los electrones se transfiere a la estructura interna formada por átomos en forma de calor. Cuanto mayor es el campo eléctrico mayor es la energía disipada en forma de calor.'**
  String get desplazamientoDeElectrones;

  /// No description provided for @leyDeJoule.
  ///
  /// In es, this message translates to:
  /// **'Ley de Joule (James Prescott Joule 1818-1889)'**
  String get leyDeJoule;

  /// No description provided for @resistor.
  ///
  /// In es, this message translates to:
  /// **'Resistor. Dispositivo eléctrico con resistencia eléctrica intrínseca. Este se opone al paso de corriente eléctrica en su interior ocasionando que a sus extremos aparezca una diferencia de potencial.'**
  String get resistor;

  /// No description provided for @resistorPuro.
  ///
  /// In es, this message translates to:
  /// **'En un resistor puro, toda la energía eléctrica que recibe en un segundo se transforma en calor.'**
  String get resistorPuro;

  /// No description provided for @dispositivoTransformador.
  ///
  /// In es, this message translates to:
  /// **'Es un Dispositivo que permite transformar algún tipo de energía en energía eléctrica.'**
  String get dispositivoTransformador;

  /// No description provided for @dispositivosDiferenciaDePotencial.
  ///
  /// In es, this message translates to:
  /// **'Estos dispositivos al recibir energía de algún tipo producen una diferencia de potencial.'**
  String get dispositivosDiferenciaDePotencial;

  /// No description provided for @fuentesFEM.
  ///
  /// In es, this message translates to:
  /// **'Todas las Fuentes FEM debido a su estructura interna poseen cierta resistencia.\n\nUna FEM real se puede representar como una combinación de una FEM ideal y un resistor.\nLa FEM ideal cumple con la definición anterior (transformar energía).'**
  String get fuentesFEM;

  /// No description provided for @femAspectosRelevantes.
  ///
  /// In es, this message translates to:
  /// **'FEM: Aspectos Relevantes'**
  String get femAspectosRelevantes;

  /// No description provided for @teoriaDeCircuitos.
  ///
  /// In es, this message translates to:
  /// **'En Teoría de Circuitos a las Fuentes de Fuerza Electromotriz se les conoces como Fuentes de Voltaje.\n\nUna Fuente fem es capaz de suministrar energía eléctrica a otro dispositivo o elemento.\n\nLa energía entregada por una fem:'**
  String get teoriaDeCircuitos;

  /// No description provided for @femIdeal.
  ///
  /// In es, this message translates to:
  /// **'FEM Ideal'**
  String get femIdeal;

  /// No description provided for @sumaAlgebraicaCorrientes.
  ///
  /// In es, this message translates to:
  /// **'En Cualquier Instante, La Suma Algebraica de las Corrientes En Un Nodo es Cero'**
  String get sumaAlgebraicaCorrientes;

  /// No description provided for @conservacionDeCarga.
  ///
  /// In es, this message translates to:
  /// **'Consecuencia del Principio de Conservación de Carga.\nLa Carga Total del Sistema Se Conserva'**
  String get conservacionDeCarga;

  /// No description provided for @energiaTotalConservada.
  ///
  /// In es, this message translates to:
  /// **'La Energía Total del Circuito Se Conserva'**
  String get energiaTotalConservada;

  /// No description provided for @resistividadElectrica.
  ///
  /// In es, this message translates to:
  /// **'Resistividad Eléctrica'**
  String get resistividadElectrica;

  /// No description provided for @resistividadElectricaConstante.
  ///
  /// In es, this message translates to:
  /// **'La Resistividad Eléctrica es una \'Constante\' de la proporcionalidad entre el campo eléctrico y la densidad de corriente. Su valor es el inverso de la conductividad, en consecuencia también es una propiedad que depende del material y que indica su capacidad para impedir la conducción de corriente eléctrica. Un material con alta resistividad es un mal conductor de corriente eléctrica.'**
  String get resistividadElectricaConstante;

  /// No description provided for @densisdadCorrienteCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Densidad de Corriente y Campo Eléctrico'**
  String get densisdadCorrienteCampoElectrico;

  /// No description provided for @formaVectorialLeyDeOhm.
  ///
  /// In es, this message translates to:
  /// **'Forma Vectorial Para la Ley de Ohm\n(Georg Simon Ohm 1798-1854)'**
  String get formaVectorialLeyDeOhm;

  /// No description provided for @leyDeOhmDensidad.
  ///
  /// In es, this message translates to:
  /// **'La Ley de Ohm Establece que en ciertos materiales la densidad de corriente y el campo eléctrico están relacionados por una constante de proporcionalidad conocida como conductividad eléctrica'**
  String get leyDeOhmDensidad;

  /// No description provided for @sumaAlgebraicaPotencial.
  ///
  /// In es, this message translates to:
  /// **'En Cualquier Instante, la Suma Algebraica de las Diferencias de Potencial (Voltajes) en cada una de las Ramas que forma una Malla es Cero.'**
  String get sumaAlgebraicaPotencial;

  /// No description provided for @conservacionDeEnergia.
  ///
  /// In es, this message translates to:
  /// **'Consecuencia del Principio de Conservación de Energía:'**
  String get conservacionDeEnergia;

  /// No description provided for @energiaTotalCircuito.
  ///
  /// In es, this message translates to:
  /// **'La energía total del circuito se conserva'**
  String get energiaTotalCircuito;

  /// No description provided for @leyDeVoltajesDeKirchhoff.
  ///
  /// In es, this message translates to:
  /// **'Ley de Voltajes de Kirchhoff'**
  String get leyDeVoltajesDeKirchhoff;

  /// No description provided for @leyDeCorrientesDeKirchhoff.
  ///
  /// In es, this message translates to:
  /// **'Ley de Corrientes de Kirchhoff'**
  String get leyDeCorrientesDeKirchhoff;

  /// No description provided for @diferenciaDePotencialEnElResistor.
  ///
  /// In es, this message translates to:
  /// **'Diferencia de Potencial en el Resistor'**
  String get diferenciaDePotencialEnElResistor;

  /// No description provided for @diferenciaDePotencialEnElCapacitor.
  ///
  /// In es, this message translates to:
  /// **'Diferencia de Potencial en el Capacitor'**
  String get diferenciaDePotencialEnElCapacitor;

  /// No description provided for @ecuacionDiferencial.
  ///
  /// In es, this message translates to:
  /// **'Ecuación Diferencial'**
  String get ecuacionDiferencial;

  /// No description provided for @solucionALaEcucacionDiferencial.
  ///
  /// In es, this message translates to:
  /// **'Solución a la Ecuación Diferencial'**
  String get solucionALaEcucacionDiferencial;

  /// No description provided for @enHomogenea.
  ///
  /// In es, this message translates to:
  /// **'En Homogénea'**
  String get enHomogenea;

  /// No description provided for @ecuacionDiferencialNoHomogenea.
  ///
  /// In es, this message translates to:
  /// **'Ecuacion Diferencial no Homogénea'**
  String get ecuacionDiferencialNoHomogenea;

  /// No description provided for @condicionALaFrontera.
  ///
  /// In es, this message translates to:
  /// **'Condición a la Frontera'**
  String get condicionALaFrontera;

  /// No description provided for @constantesDeTiempoDeCargaEnElCapacitor.
  ///
  /// In es, this message translates to:
  /// **'Constantes de Tiempo de Carga en el Capacitor'**
  String get constantesDeTiempoDeCargaEnElCapacitor;

  /// No description provided for @alTiempoT0InterruptorPosicionB.
  ///
  /// In es, this message translates to:
  /// **'Al Tiempo t=0 (Interruptor posición b)'**
  String get alTiempoT0InterruptorPosicionB;

  /// No description provided for @procesoDeDescargaEnUnCapacitor.
  ///
  /// In es, this message translates to:
  /// **'Proceso de Descarga en un Capacitor'**
  String get procesoDeDescargaEnUnCapacitor;

  /// No description provided for @cargaDelPortador.
  ///
  /// In es, this message translates to:
  /// **'Carga del Portador'**
  String get cargaDelPortador;

  /// No description provided for @movilidadDeLosPortadoresDeCargaLibres.
  ///
  /// In es, this message translates to:
  /// **'Movilidad de los Portadores de Carga Libres'**
  String get movilidadDeLosPortadoresDeCargaLibres;

  /// No description provided for @flujoDelCampoVectorialDeVelocidad.
  ///
  /// In es, this message translates to:
  /// **'Flujo del Campo Vectorial de Velocidad'**
  String get flujoDelCampoVectorialDeVelocidad;

  /// No description provided for @flujoDeCargaNetaPorUnidadDeTiempo.
  ///
  /// In es, this message translates to:
  /// **'Flujo de Carga Neta Por Unidad de Tiempo'**
  String get flujoDeCargaNetaPorUnidadDeTiempo;

  /// No description provided for @portadorDeCargaLibre.
  ///
  /// In es, this message translates to:
  /// **'Portador de Carga Libre:\nParticula Libre no Enlazada a la Estructura Atómica del Material que Posee Carga Eléctrica.'**
  String get portadorDeCargaLibre;

  /// No description provided for @laPresenciaDeLaDiferenciaDePotencial.
  ///
  /// In es, this message translates to:
  /// **'La Presencia de la Diferencia de Potencial o del Campo Eléctrico Produce una Fuerza Electrostática en los Portadores de Carga Libre. Al Estar Libres, la Fuerza Ejercida Genera el Desplazamiento de los Portadores de Carga Libre, en el Desplazamiento se Realiza a una Velocidad Constante.'**
  String get laPresenciaDeLaDiferenciaDePotencial;

  /// No description provided for @enRelacionConLVK.
  ///
  /// In es, this message translates to:
  /// **'En relación con LVK'**
  String get enRelacionConLVK;

  /// No description provided for @establecerLaPolaridad.
  ///
  /// In es, this message translates to:
  /// **'Establecer la Polaridad de las diferencias de potencial en cada rama y adicionarlas en sentido horario. Al moverse de un potencial mayor a uno menor el signo de la diferencia de potencial será positivo. El número de ecuaciones independientes de malla es igual al número de ramas principales menos el número ecuaciones de nodos independientes.'**
  String get establecerLaPolaridad;

  /// No description provided for @enRelacionConLCK.
  ///
  /// In es, this message translates to:
  /// **'En relación con LCK'**
  String get enRelacionConLCK;

  /// No description provided for @considerarUnaCorrientePositiva.
  ///
  /// In es, this message translates to:
  /// **'Considerar una Corriente Positiva Cuando Entra en un Nodo y Una Corriente Negativa Cuando sale de un Nodo.\nConsiderar que en cada Rama Principal Circula una Corriente.\nEl Número de Ecuaciones de Nodos Independientes es Igual al Número de Nodos Principales Menos Uno (n-1).'**
  String get considerarUnaCorrientePositiva;

  /// No description provided for @unMaterialConductor.
  ///
  /// In es, this message translates to:
  /// **'Un Material Conductor que Cumple con la Ley de Ohm Se Denomina Material Óhmnico.\nExisten Materiales que para ciertos valores de Diferencia de Potencial y Corriente tienen un Comportamiento Óhmnico.'**
  String get unMaterialConductor;

  /// No description provided for @alIncrementarLaTemperatura.
  ///
  /// In es, this message translates to:
  /// **'Al Incrementar la Temperatura de Un conductor Existe un decremento en la movilidad de Eletrones, esto ocurre por el choque entre electrones (dispersión electrón-electrón) y por colisiones entre electrones y estructura (dispersión electrón-estructura).'**
  String get alIncrementarLaTemperatura;

  /// No description provided for @laResistividadEnUnConductor.
  ///
  /// In es, this message translates to:
  /// **'La Resistividad en un Conductor Crece Conforme se Incremente La Termperatura, la representación más adecuada para este comportamiento es mediante una serie de potencias.'**
  String get laResistividadEnUnConductor;

  /// No description provided for @circuitoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Circuito Eléctrico: Conexión de elementos a través de los cuales puede circular corriente eléctrica permanente o transitoria (requiere al menos una fem o fuente de energía eléctrica).'**
  String get circuitoElectrico;

  /// No description provided for @rama.
  ///
  /// In es, this message translates to:
  /// **'Rama: Elemento de dos Terminales, Componente de un Circuito Eléctrico.'**
  String get rama;

  /// No description provided for @nodo.
  ///
  /// In es, this message translates to:
  /// **'Nodo: Terminal de un Elemento, Componente de un Circuito Eléctrico que se utiliza para unir Otros elementos.'**
  String get nodo;

  /// No description provided for @malla.
  ///
  /// In es, this message translates to:
  /// **'Malla: Conjunto conectado de ramas que forman una trayectoria cerrada, en donde cada nodo conecta únicamente dos ramas de la trayectoria.'**
  String get malla;

  /// No description provided for @nodoPrincipal.
  ///
  /// In es, this message translates to:
  /// **'Nodo Principal: Punto de Unión de Tres o más Ramas.'**
  String get nodoPrincipal;

  /// No description provided for @ramaPrincipal.
  ///
  /// In es, this message translates to:
  /// **'Rama Principal: Rama o Conjunto de Ramas que Forman una Trayectoria entre Dos Nodos Principales Adyacentes.'**
  String get ramaPrincipal;

  /// No description provided for @corrienteElectricaContinua.
  ///
  /// In es, this message translates to:
  /// **'Corriente Eléctrica Continua:\nEs aquiella que fluye a través de un conductor con magnitud y signo constantes.'**
  String get corrienteElectricaContinua;

  /// No description provided for @corrienteElectricaDirecta.
  ///
  /// In es, this message translates to:
  /// **'Corriente Eléctrica Directa:\nEs aquiella que fluye a través de un conductor con magnitud variable y signo constante.'**
  String get corrienteElectricaDirecta;

  /// No description provided for @corrienteElectricaAlterna.
  ///
  /// In es, this message translates to:
  /// **'Corriente Eléctrica Alterna:\nEs aquiella que fluye a través de un conductor con magnitud y signo variables.'**
  String get corrienteElectricaAlterna;

  /// No description provided for @enElCasoDeUnSolenoideLargo.
  ///
  /// In es, this message translates to:
  /// **'En el caso de un Solenoide Largo:'**
  String get enElCasoDeUnSolenoideLargo;

  /// No description provided for @enFuncionDelCampoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'En Función del Campo Magnético (Homogéneo):'**
  String get enFuncionDelCampoMagnetico;

  /// No description provided for @energiaPorUnidadDeVolumen.
  ///
  /// In es, this message translates to:
  /// **'Energía por Unidad de Volúmen:'**
  String get energiaPorUnidadDeVolumen;

  /// No description provided for @energiaDeUnCampoMagneticoNoHomogeneo.
  ///
  /// In es, this message translates to:
  /// **'Energía de un Campo Magnético No Homogéneo'**
  String get energiaDeUnCampoMagneticoNoHomogeneo;

  /// No description provided for @generador.
  ///
  /// In es, this message translates to:
  /// **'Generador: Máquina de Convierte Algún tipo de Energía en Energía Eléctrica'**
  String get generador;

  /// No description provided for @elMovimientoDeRotacionGenera.
  ///
  /// In es, this message translates to:
  /// **'El Movimiento de Rotación Genera una FEM Inducida en el Cuerpo Metálico del Dínamo, mediante las escobillas la diferencia de potencial se utiliza para alimentar a algún circuito.'**
  String get elMovimientoDeRotacionGenera;

  /// No description provided for @femInducidaEnElConductor.
  ///
  /// In es, this message translates to:
  /// **'FEM Inducida en el conductor en Movimiento'**
  String get femInducidaEnElConductor;

  /// No description provided for @paraElConductorGirando.
  ///
  /// In es, this message translates to:
  /// **'Para el Conductor Girando'**
  String get paraElConductorGirando;

  /// No description provided for @inductorTexto.
  ///
  /// In es, this message translates to:
  /// **'Inductor: Un elemento o Circuito Eléctrico que posee una inductancia intrínseca se conoce como inductor.'**
  String get inductorTexto;

  /// No description provided for @inductanciaMutuaTexto.
  ///
  /// In es, this message translates to:
  /// **'Inductancia Mutua: Cuando El flujo Mágnético en un Elemento o Circuito Eléctrico es Producido por una Corriente Que Circula en Otro Circuito Eléctrico la Constante de Proporcionalidad entre ambas Cantidades se conoce como Inductancia Mutua (M).'**
  String get inductanciaMutuaTexto;

  /// No description provided for @ecuacionGeneral.
  ///
  /// In es, this message translates to:
  /// **'Ecuación General'**
  String get ecuacionGeneral;

  /// No description provided for @inductanciasMutuas.
  ///
  /// In es, this message translates to:
  /// **'Inductancias Mutuas'**
  String get inductanciasMutuas;

  /// No description provided for @enElCasoDeFlujoConcatenado.
  ///
  /// In es, this message translates to:
  /// **'En el Caso de Flujo Concatenado'**
  String get enElCasoDeFlujoConcatenado;

  /// No description provided for @enProductoDeFlujoTotal.
  ///
  /// In es, this message translates to:
  /// **'En Producto de Flujo Total y Corriente Representa la Energía Total'**
  String get enProductoDeFlujoTotal;

  /// No description provided for @porConservacionDeEnergia.
  ///
  /// In es, this message translates to:
  /// **'Por Conservación de Energía'**
  String get porConservacionDeEnergia;

  /// No description provided for @inductanciaPropiaYMutua.
  ///
  /// In es, this message translates to:
  /// **'Inductancia Propia y Mutua'**
  String get inductanciaPropiaYMutua;

  /// No description provided for @disminucionDeFlujoConDistancia.
  ///
  /// In es, this message translates to:
  /// **'Disminución de flujo con distancia'**
  String get disminucionDeFlujoConDistancia;

  /// No description provided for @constanteDeAcoplamiento.
  ///
  /// In es, this message translates to:
  /// **'Constante de Acoplamiento'**
  String get constanteDeAcoplamiento;

  /// No description provided for @laInductanciaMutua.
  ///
  /// In es, this message translates to:
  /// **'La Inductancia Mutua'**
  String get laInductanciaMutua;

  /// No description provided for @flujoConcatenadoEnElSolenoide2.
  ///
  /// In es, this message translates to:
  /// **'Flujo Concatenado en el Solenoide 2 debido al flujo producido en el solenoide 1'**
  String get flujoConcatenadoEnElSolenoide2;

  /// No description provided for @flujoTotal.
  ///
  /// In es, this message translates to:
  /// **'Flujo Total (Concatenado)'**
  String get flujoTotal;

  /// No description provided for @laInductancia.
  ///
  /// In es, this message translates to:
  /// **'La Inductancia'**
  String get laInductancia;

  /// No description provided for @laInductanciaEnUnElemento.
  ///
  /// In es, this message translates to:
  /// **'La inductancia en un elemento o circuito eléctrico representa la oposición a cambios de corriente eléctrica al interior del elemento o circuito eléctrico. La inductancia está directamente relacionada con la Ley de Faraday.'**
  String get laInductanciaEnUnElemento;

  /// No description provided for @enUnaEspiraElFlujo.
  ///
  /// In es, this message translates to:
  /// **'En una Espira el flujo magnético es directamente proporcional a la corriente que fluye a través de la espira.'**
  String get enUnaEspiraElFlujo;

  /// No description provided for @enElCasoDeUnaSolaEspira.
  ///
  /// In es, this message translates to:
  /// **'En el Caso de Una Sola Espira el FLujo Magnético es producido por la corriente eléctrica que circula en ella, la constante de proporcionalidad entre ambas cantidades se conoce como inductancia propia o autoinductancia (L) del circuito eléctrico.'**
  String get enElCasoDeUnaSolaEspira;

  /// No description provided for @laVariacionDeCorriente.
  ///
  /// In es, this message translates to:
  /// **'La Variación de Corriente Eléctrica Induce una Variación del Flujo Magnético Concatenado en el Circuito Eléctrico, de Acuerdo a la Ley de Faraday Se Genera una FEM Inducida.'**
  String get laVariacionDeCorriente;

  /// No description provided for @flujoConcatenado.
  ///
  /// In es, this message translates to:
  /// **'Flujo Concatenado'**
  String get flujoConcatenado;

  /// No description provided for @flujoMagneticoEnUnSolenoideIdeal.
  ///
  /// In es, this message translates to:
  /// **'Flujo Magnético en un Solenoide Ideal'**
  String get flujoMagneticoEnUnSolenoideIdeal;

  /// No description provided for @flujoTotalConcatenado.
  ///
  /// In es, this message translates to:
  /// **'Flujo Total Concatenado'**
  String get flujoTotalConcatenado;

  /// No description provided for @conexionEnSerieSimbologia.
  ///
  /// In es, this message translates to:
  /// **'Conexión en Serie (Simbología)'**
  String get conexionEnSerieSimbologia;

  /// No description provided for @corrienteYDiferenciaDePotencial.
  ///
  /// In es, this message translates to:
  /// **'Corriente y Diferencia De Potencial'**
  String get corrienteYDiferenciaDePotencial;

  /// No description provided for @elSegundoAlambre.
  ///
  /// In es, this message translates to:
  /// **'El Segundo Alambre tiene un Devanado en Sentido Contrario al Primero (Flujo Opuesto, Signo Negativo).'**
  String get elSegundoAlambre;

  /// No description provided for @unInductorAlmacena.
  ///
  /// In es, this message translates to:
  /// **'Un Inductor Almacena Energía Magnética cuando a través de él circula una Corriente Eléctrica.'**
  String get unInductorAlmacena;

  /// No description provided for @deAcuerdoConLaLeyDeInduccion.
  ///
  /// In es, this message translates to:
  /// **'De acuerdo con la Ley de Inducción de Faraday y Definición de Inductancia:'**
  String get deAcuerdoConLaLeyDeInduccion;

  /// No description provided for @laCorrienteAsociadaALaFEM.
  ///
  /// In es, this message translates to:
  /// **'La Corriente Asociada a la FEM inducida se Desplaza a través de una región de Campo Eléctrico, la Variación de Carga en la Región de Campo Magnético requiere el uso de un Trabajo.'**
  String get laCorrienteAsociadaALaFEM;

  /// No description provided for @bobinaTexto.
  ///
  /// In es, this message translates to:
  /// **'Bobina: Componente de un Circulo Eléctrico Formado por un Hilo Conductor Aislado y Enrollado Repetidamente.'**
  String get bobinaTexto;

  /// No description provided for @magnitudDelCampoMagneticoParaUnaBobina.
  ///
  /// In es, this message translates to:
  /// **'Magnitud del Campo Magnético para una Bobina'**
  String get magnitudDelCampoMagneticoParaUnaBobina;

  /// No description provided for @enElCasoDeUnConductorRectoLargo.
  ///
  /// In es, this message translates to:
  /// **'En el Caso de un Conductor Recto Largo'**
  String get enElCasoDeUnConductorRectoLargo;

  /// No description provided for @enElCasoDeUnSolenoideLargoInterior.
  ///
  /// In es, this message translates to:
  /// **'En el Caso de un Solenoide Largo (Interior)'**
  String get enElCasoDeUnSolenoideLargoInterior;

  /// No description provided for @circulacionDelCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Circulación del Campo Eléctrico'**
  String get circulacionDelCampoElectrico;

  /// No description provided for @circulacionDelCampoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'Circulación del Campo Magnético'**
  String get circulacionDelCampoMagnetico;

  /// No description provided for @enElCasoDeUnConductorRecto.
  ///
  /// In es, this message translates to:
  /// **'En el Caso de un Conductor Recto'**
  String get enElCasoDeUnConductorRecto;

  /// No description provided for @leyDeAmpere.
  ///
  /// In es, this message translates to:
  /// **'Ley de Ampere: Una Corriente Estacionaría es Capaz de Producir un Campo Magnético Estático'**
  String get leyDeAmpere;

  /// No description provided for @campoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'Campo Magnético'**
  String get campoMagnetico;

  /// No description provided for @elCampoMagneticoB.
  ///
  /// In es, this message translates to:
  /// **'El Campo Magnético B es una región en el espacio en donde al colocar una Carga de Prueba q0 moviéndose a una velocidad v ésta experimentará una fuerza de tipo magnetostática.'**
  String get elCampoMagneticoB;

  /// No description provided for @fenomenologia.
  ///
  /// In es, this message translates to:
  /// **'Fenomenología:'**
  String get fenomenologia;

  /// No description provided for @laIntensidadDelCampoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'1) La Intensidad del Campo Magnético Producido por el Conductor es Directamente Proporcional a la Velocidad y a la Carga de la Corriente Eléctrica.'**
  String get laIntensidadDelCampoMagnetico;

  /// No description provided for @siLaVelocidadSeInvierte.
  ///
  /// In es, this message translates to:
  /// **'2) Si la Velocidad se Invierte o si el Signo de la Carga Cambia, la Dirección del Campo Magnético se Invierte.'**
  String get siLaVelocidadSeInvierte;

  /// No description provided for @elCampoMagneticoSeAnula.
  ///
  /// In es, this message translates to:
  /// **'3) El Campo Magnético se Anula a lo Largo de la Dirección de Desplazamiento de las Cargas. El Campo Magnético Varia como sen θ'**
  String get elCampoMagneticoSeAnula;

  /// No description provided for @elCampoMagneticoEsTangente.
  ///
  /// In es, this message translates to:
  /// **'4) El Campo Magnético es Tangente a los Círculos Concéntricos alrededor del Conductor en Planos Perpendiculares a la Dirección de la Corriente (Regla de la Mano Derecha), la Magnitud del Campo Magnético es Constante sobre un Círculo Concéntrico.'**
  String get elCampoMagneticoEsTangente;

  /// No description provided for @laMagnitudDelCampoMagneticoDisminuye.
  ///
  /// In es, this message translates to:
  /// **'5) La Magnitud del Campo Magnético Disminuye como 1/r^2'**
  String get laMagnitudDelCampoMagneticoDisminuye;

  /// No description provided for @constanteDePermeabilidad.
  ///
  /// In es, this message translates to:
  /// **'Constante de Permeabilidad o Constante Magnética'**
  String get constanteDePermeabilidad;

  /// No description provided for @lineasDeCampoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'Líneas de Campo Magnético'**
  String get lineasDeCampoMagnetico;

  /// No description provided for @elCampoMagneticoSeRepresenta.
  ///
  /// In es, this message translates to:
  /// **'El Campo Magnético se Representa Mediante un Conjunto de Líneas Bajo la Siguiente Convención:'**
  String get elCampoMagneticoSeRepresenta;

  /// No description provided for @aEstasLineasSeLesDenomina.
  ///
  /// In es, this message translates to:
  /// **'A estas Líneas se les Denomina Líneas de Campo Magnético.'**
  String get aEstasLineasSeLesDenomina;

  /// No description provided for @laTangenteALaLineaDeCampo.
  ///
  /// In es, this message translates to:
  /// **'La Tangente a la Línea de Campo Magnético que Cruza un Punto Cualquiera del Espacio Denota la Dirección del Campo Magnético en ese Punto.'**
  String get laTangenteALaLineaDeCampo;

  /// No description provided for @lasLineasDeCampoMagneticoSonContinuas.
  ///
  /// In es, this message translates to:
  /// **'Las Líneas de Campo Magnético son Continuas y nunca se Cruzan'**
  String get lasLineasDeCampoMagneticoSonContinuas;

  /// No description provided for @lasLineasDeCampoMagneticoComienzan.
  ///
  /// In es, this message translates to:
  /// **'Las Líneas de Campo Magnético Comienzan en un Polo Norte Magnético y Terminan en un Polo Sur Magnético'**
  String get lasLineasDeCampoMagneticoComienzan;

  /// No description provided for @laMagnitudDelCampoMagneticoEnUnPunto.
  ///
  /// In es, this message translates to:
  /// **'La Magnitud del Campo Magnético en un Punto Cualquiera es Proporcional al Número de Líneas por Unidad de Superficie Perpendicular a Estas Líneas.'**
  String get laMagnitudDelCampoMagneticoEnUnPunto;

  /// No description provided for @descripcionDeUnIman.
  ///
  /// In es, this message translates to:
  /// **'Descripción de un Imán'**
  String get descripcionDeUnIman;

  /// No description provided for @unImanEsUnObjeto.
  ///
  /// In es, this message translates to:
  /// **'Un Imán es un Objeto Capaz de Crear Fuerzas de Atracción y Repulsión con Otros Tipos de Sustancias'**
  String get unImanEsUnObjeto;

  /// No description provided for @enLaNaturalezaElMineral.
  ///
  /// In es, this message translates to:
  /// **'En la Naturaleza El Mineral Conocido Como Magnetita (Fe3O4) Se Utiliza Para la Obtención de Imanes Naturales (Grecia Antigua: Tales de Mileto, Siglo 6 AC).'**
  String get enLaNaturalezaElMineral;

  /// No description provided for @deFormaSinteticaLosImanes.
  ///
  /// In es, this message translates to:
  /// **'De Forma Sintética Los Imanes Permanentes Se Obtienen a Partir de Aleaciones Nd-Fe-B (General Motors, Siglo 20).'**
  String get deFormaSinteticaLosImanes;

  /// No description provided for @caracteristicasDeUnIman.
  ///
  /// In es, this message translates to:
  /// **'Características de un Imán: Un Imán Posee Dos Polos (Convención), Un Polo Magnético Norte y Un Polo Magnético Sur.'**
  String get caracteristicasDeUnIman;

  /// No description provided for @polosIgualesSeRepelen.
  ///
  /// In es, this message translates to:
  /// **'Polos Iguales Se Repelen y Polos Diferentes Se Atraen.'**
  String get polosIgualesSeRepelen;

  /// No description provided for @laTierraSeComportaComo.
  ///
  /// In es, this message translates to:
  /// **'La Tierra Se Comporta Como un Imán Gigantesco (0.3-0.6 [Gauss])'**
  String get laTierraSeComportaComo;

  /// No description provided for @experimentoDeOersted.
  ///
  /// In es, this message translates to:
  /// **'Experimento de Oersted'**
  String get experimentoDeOersted;

  /// No description provided for @hansChristianOersted.
  ///
  /// In es, this message translates to:
  /// **'Hans Christian Oersted (1777-1851).'**
  String get hansChristianOersted;

  /// No description provided for @campoParaUnConductorRecto.
  ///
  /// In es, this message translates to:
  /// **'Campo Para un Conductor Recto'**
  String get campoParaUnConductorRecto;

  /// No description provided for @campoMagneticoProducidoPorUnConductor.
  ///
  /// In es, this message translates to:
  /// **'Campo Magnético Producido por un Conductor (Centro de la Espira y = L/2)'**
  String get campoMagneticoProducidoPorUnConductor;

  /// No description provided for @paraLosCuatroConductoresRectos.
  ///
  /// In es, this message translates to:
  /// **'Para los Cuatro Conductores Rectos'**
  String get paraLosCuatroConductoresRectos;

  /// No description provided for @paraUnPuntoFueraDelPlanoAlCentro.
  ///
  /// In es, this message translates to:
  /// **'Para un Punto Fuera del Plano al Centro de la Espira'**
  String get paraUnPuntoFueraDelPlanoAlCentro;

  /// No description provided for @leyDeBioSavart.
  ///
  /// In es, this message translates to:
  /// **'Ley de Bio-Savart'**
  String get leyDeBioSavart;

  /// No description provided for @magnitudDelCampoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'Magnitud del Campo Magnético (Eje de la Espira)'**
  String get magnitudDelCampoMagnetico;

  /// No description provided for @enElCentroDeLaEspira.
  ///
  /// In es, this message translates to:
  /// **'En el Centro de la Espira'**
  String get enElCentroDeLaEspira;

  /// No description provided for @elFlujoDeCampoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Magnético Puede Concebirse Como Una Medida Del Flujo O De La Penetración De Los Vectores Del Campo Magnético A Través De Un Elemento Fijo E Imaginario De Una Superficie.'**
  String get elFlujoDeCampoMagnetico;

  /// No description provided for @elFlujoDeCampoMagneticoEsUnaMedida.
  ///
  /// In es, this message translates to:
  /// **'El Flujo de Campo Magnético es una Medida del Número de Líneas del Campo Magnético Que Atraviesan Una Superficie Dada.'**
  String get elFlujoDeCampoMagneticoEsUnaMedida;

  /// No description provided for @laIntegralDeSuperficieIndica.
  ///
  /// In es, this message translates to:
  /// **'La Integral de Superficie Indica Que La Superficie Total Debe Dividirse En Elementos Diferenciales De Área, Posterior A Esto La Integral Debe Evaluarse En Cada Elemento Diferencial Y Finalmente Sumarse Para Obtener La Contribución De La Superficie Entera.'**
  String get laIntegralDeSuperficieIndica;

  /// No description provided for @analogiaConCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'Analogía con Campo Eléctrico'**
  String get analogiaConCampoElectrico;

  /// No description provided for @elEfectoDeUnCampoElectrico.
  ///
  /// In es, this message translates to:
  /// **'El Efecto de Un Campo Eléctrico es Crear Fuerza Electrostática Sobre una Carga de Prueba en Reposo'**
  String get elEfectoDeUnCampoElectrico;

  /// No description provided for @elEfectoDeUnCampoMagnetico.
  ///
  /// In es, this message translates to:
  /// **'El Efecto de un Campo Magnético es Crear Fuerza Magnetostática Sobre una Carga en Movimiento'**
  String get elEfectoDeUnCampoMagnetico;

  /// No description provided for @unImanEsUnObjetoTexto.
  ///
  /// In es, this message translates to:
  /// **'Un Imán es un Objeto Capaz de Crear Fuerzas de Atracción y Repulsión con Otros Tipos de Sustancias'**
  String get unImanEsUnObjetoTexto;

  /// No description provided for @fuerzaMagnetica.
  ///
  /// In es, this message translates to:
  /// **'Fuerza Magnética'**
  String get fuerzaMagnetica;

  /// No description provided for @magnitudDeLaFuerzaMagnetica.
  ///
  /// In es, this message translates to:
  /// **'Magnitud de la Fuerza Magnética'**
  String get magnitudDeLaFuerzaMagnetica;

  /// No description provided for @direccionDeLaFuerzaMagnetica.
  ///
  /// In es, this message translates to:
  /// **'Dirección de la Fuerza Magnética'**
  String get direccionDeLaFuerzaMagnetica;

  /// No description provided for @laFuerzaMagneticaEsSiemprePerpendicular.
  ///
  /// In es, this message translates to:
  /// **'La Fuerza Magnética es Siempre Perpendicular al Plano Formado por los Vectores Velocidad y Campo Magnético'**
  String get laFuerzaMagneticaEsSiemprePerpendicular;

  /// No description provided for @laFuerzaMagneticaNoRealizaTrabajo.
  ///
  /// In es, this message translates to:
  /// **'La Fuerza Magnética no Realiza Trabajo Sobre la Carga en Movimiento (Solo Modifica la Dirección del Movimiento)'**
  String get laFuerzaMagneticaNoRealizaTrabajo;

  /// No description provided for @laDireccionDeLaFuerzaDependeDelSigno.
  ///
  /// In es, this message translates to:
  /// **'La Dirección de la Fuerza Depende Del Signo de la Carga'**
  String get laDireccionDeLaFuerzaDependeDelSigno;

  /// No description provided for @definicionDeCorrienteElectrica.
  ///
  /// In es, this message translates to:
  /// **'Definición de Corriente Eléctrica'**
  String get definicionDeCorrienteElectrica;

  /// No description provided for @leyDeAmperePalabra.
  ///
  /// In es, this message translates to:
  /// **'Ley de Ampere'**
  String get leyDeAmperePalabra;

  /// No description provided for @deAcuerdoConElTeoremaDeStokes.
  ///
  /// In es, this message translates to:
  /// **'De Acuerdo con el Teorema de Stokes'**
  String get deAcuerdoConElTeoremaDeStokes;

  /// No description provided for @leyDeAmpereEnFormaDiferencial.
  ///
  /// In es, this message translates to:
  /// **'Ley de Ampere en Forma Diferencial'**
  String get leyDeAmpereEnFormaDiferencial;

  /// No description provided for @motorMaquina.
  ///
  /// In es, this message translates to:
  /// **'Motor: Máquina que convierte energía eléctrica en trabajo mecánico'**
  String get motorMaquina;

  /// No description provided for @magnitudDelCampoMagneticoMitadConductor.
  ///
  /// In es, this message translates to:
  /// **'Magnitud Del Campo Magnético (Mitad Conductor)'**
  String get magnitudDelCampoMagneticoMitadConductor;

  /// No description provided for @conductorMuyLargo.
  ///
  /// In es, this message translates to:
  /// **'Conductor Muy Largo'**
  String get conductorMuyLargo;

  /// No description provided for @solenoideBobina.
  ///
  /// In es, this message translates to:
  /// **'Solenoide: Bobina en donde el hilo conductor está enrollado de forma helicoidal, debido a la geometría, el campo magnético se considera uniforme en su interior.'**
  String get solenoideBobina;

  /// No description provided for @magnitudDelCampoMagneticoParaUnaEspira.
  ///
  /// In es, this message translates to:
  /// **'Magnitud del Campo Magnético Para Una Espira'**
  String get magnitudDelCampoMagneticoParaUnaEspira;

  /// No description provided for @paraUnaPosicionD.
  ///
  /// In es, this message translates to:
  /// **'Para una Posición (d) en el eje del Solenoide y una Densidad de Vueltas n=N/h'**
  String get paraUnaPosicionD;

  /// No description provided for @solenoideIdeal.
  ///
  /// In es, this message translates to:
  /// **'Solenoide Ideal'**
  String get solenoideIdeal;

  /// No description provided for @cuadrado.
  ///
  /// In es, this message translates to:
  /// **'Cuadrado'**
  String get cuadrado;

  /// No description provided for @area.
  ///
  /// In es, this message translates to:
  /// **'Área'**
  String get area;

  /// No description provided for @perimetro.
  ///
  /// In es, this message translates to:
  /// **'Perímetro'**
  String get perimetro;

  /// No description provided for @rectangulo.
  ///
  /// In es, this message translates to:
  /// **'Rectángulo'**
  String get rectangulo;

  /// No description provided for @trapecio.
  ///
  /// In es, this message translates to:
  /// **'Trapecio'**
  String get trapecio;

  /// No description provided for @paralelogramo.
  ///
  /// In es, this message translates to:
  /// **'Paralelogramo'**
  String get paralelogramo;

  /// No description provided for @rombo.
  ///
  /// In es, this message translates to:
  /// **'Rombo'**
  String get rombo;

  /// No description provided for @lado.
  ///
  /// In es, this message translates to:
  /// **'Lado'**
  String get lado;

  /// No description provided for @base.
  ///
  /// In es, this message translates to:
  /// **'Base'**
  String get base;

  /// No description provided for @altura.
  ///
  /// In es, this message translates to:
  /// **'Altura'**
  String get altura;

  /// No description provided for @isosceles.
  ///
  /// In es, this message translates to:
  /// **'Isósceles'**
  String get isosceles;

  /// No description provided for @equilatero.
  ///
  /// In es, this message translates to:
  /// **'Equilátero'**
  String get equilatero;

  /// No description provided for @escaleno.
  ///
  /// In es, this message translates to:
  /// **'Escaleno'**
  String get escaleno;

  /// No description provided for @radio.
  ///
  /// In es, this message translates to:
  /// **'Radio'**
  String get radio;

  /// No description provided for @diametro.
  ///
  /// In es, this message translates to:
  /// **'Diámetro'**
  String get diametro;

  /// No description provided for @pi.
  ///
  /// In es, this message translates to:
  /// **'Pi'**
  String get pi;

  /// No description provided for @baseMayor.
  ///
  /// In es, this message translates to:
  /// **'Base Mayor'**
  String get baseMayor;

  /// No description provided for @baseMenor.
  ///
  /// In es, this message translates to:
  /// **'Base Menor'**
  String get baseMenor;

  /// No description provided for @ladoA.
  ///
  /// In es, this message translates to:
  /// **'Lado A'**
  String get ladoA;

  /// No description provided for @ladoC.
  ///
  /// In es, this message translates to:
  /// **'Lado C'**
  String get ladoC;

  /// No description provided for @diagonalMayor.
  ///
  /// In es, this message translates to:
  /// **'Diagonal Mayor'**
  String get diagonalMayor;

  /// No description provided for @diagonalMenor.
  ///
  /// In es, this message translates to:
  /// **'Diagonal Menor'**
  String get diagonalMenor;

  /// No description provided for @areaCuadrado.
  ///
  /// In es, this message translates to:
  /// **'Área Cuadrado'**
  String get areaCuadrado;

  /// No description provided for @perimetroCuadrado.
  ///
  /// In es, this message translates to:
  /// **'Perímetro Cuadrado'**
  String get perimetroCuadrado;

  /// No description provided for @areaRectangulo.
  ///
  /// In es, this message translates to:
  /// **'Área Rectángulo'**
  String get areaRectangulo;

  /// No description provided for @perimetroRectangulo.
  ///
  /// In es, this message translates to:
  /// **'Perímetro Rectángulo'**
  String get perimetroRectangulo;

  /// No description provided for @areaTrapecio.
  ///
  /// In es, this message translates to:
  /// **'Área Trapecio'**
  String get areaTrapecio;

  /// No description provided for @perimetroTrapecio.
  ///
  /// In es, this message translates to:
  /// **'Perímetro Trapecio'**
  String get perimetroTrapecio;

  /// No description provided for @areaParalelogramo.
  ///
  /// In es, this message translates to:
  /// **'Área Paralelogramo'**
  String get areaParalelogramo;

  /// No description provided for @perimetroParalelogramo.
  ///
  /// In es, this message translates to:
  /// **'Perímetro Paralelogramo'**
  String get perimetroParalelogramo;

  /// No description provided for @areaRombo.
  ///
  /// In es, this message translates to:
  /// **'Área Rombo'**
  String get areaRombo;

  /// No description provided for @perimetroRombo.
  ///
  /// In es, this message translates to:
  /// **'Perímetro Rombo'**
  String get perimetroRombo;

  /// No description provided for @areaIsosceles.
  ///
  /// In es, this message translates to:
  /// **'Área Isósceles'**
  String get areaIsosceles;

  /// No description provided for @perimetroIsosceles.
  ///
  /// In es, this message translates to:
  /// **'Perímetro Isósceles'**
  String get perimetroIsosceles;

  /// No description provided for @areaEquilatero.
  ///
  /// In es, this message translates to:
  /// **'Área Equilátero'**
  String get areaEquilatero;

  /// No description provided for @perimetroEquilatero.
  ///
  /// In es, this message translates to:
  /// **'Perímetro Equilátero'**
  String get perimetroEquilatero;

  /// No description provided for @areaEscaleno.
  ///
  /// In es, this message translates to:
  /// **'Área Escaleno'**
  String get areaEscaleno;

  /// No description provided for @perimetroEscaleno.
  ///
  /// In es, this message translates to:
  /// **'Perímetro Escaleno'**
  String get perimetroEscaleno;

  /// No description provided for @areaCirculo.
  ///
  /// In es, this message translates to:
  /// **'Área Círculo'**
  String get areaCirculo;

  /// No description provided for @perimetroCirculo.
  ///
  /// In es, this message translates to:
  /// **'Perímetro Círculo'**
  String get perimetroCirculo;

  /// No description provided for @representaNumeroLadosPoligono.
  ///
  /// In es, this message translates to:
  /// **'Representa el número de lados de un polígono'**
  String get representaNumeroLadosPoligono;

  /// No description provided for @sumaAngulosInteriores.
  ///
  /// In es, this message translates to:
  /// **'Suma de ángulos interiores'**
  String get sumaAngulosInteriores;

  /// No description provided for @medidasCadaAnguloInterior.
  ///
  /// In es, this message translates to:
  /// **'Medidas de cada ángulo interior'**
  String get medidasCadaAnguloInterior;

  /// No description provided for @sumaAngulosExteriores.
  ///
  /// In es, this message translates to:
  /// **'Suma de ángulos exteriores'**
  String get sumaAngulosExteriores;

  /// No description provided for @medidaCadaAnguloExterior.
  ///
  /// In es, this message translates to:
  /// **'Medida de cada ángulo exterior'**
  String get medidaCadaAnguloExterior;

  /// No description provided for @numeroDiagonales.
  ///
  /// In es, this message translates to:
  /// **'Número de diagonales'**
  String get numeroDiagonales;

  /// No description provided for @valorAnguloCentral.
  ///
  /// In es, this message translates to:
  /// **'Valor de un ángulo central'**
  String get valorAnguloCentral;

  /// No description provided for @ecuacionCircunferencia.
  ///
  /// In es, this message translates to:
  /// **'Ecuación de la circunferencia'**
  String get ecuacionCircunferencia;

  /// No description provided for @formaGeneralEcuacion.
  ///
  /// In es, this message translates to:
  /// **'Forma general de la ecuación'**
  String get formaGeneralEcuacion;

  /// No description provided for @ecuacionRecta.
  ///
  /// In es, this message translates to:
  /// **'Ecuación de la recta'**
  String get ecuacionRecta;

  /// No description provided for @punto.
  ///
  /// In es, this message translates to:
  /// **'Punto'**
  String get punto;

  /// No description provided for @distanciaPuntoPRecta.
  ///
  /// In es, this message translates to:
  /// **'Distancia de un punto P a una recta'**
  String get distanciaPuntoPRecta;

  /// No description provided for @pendienteRecta.
  ///
  /// In es, this message translates to:
  /// **'Pendiente de la recta'**
  String get pendienteRecta;

  /// No description provided for @rectasParalelas.
  ///
  /// In es, this message translates to:
  /// **'Rectas paralelas'**
  String get rectasParalelas;

  /// No description provided for @rectasPerpendiculares.
  ///
  /// In es, this message translates to:
  /// **'Rectas perpendiculares'**
  String get rectasPerpendiculares;

  /// No description provided for @formaPendienteInterseccion.
  ///
  /// In es, this message translates to:
  /// **'Forma pendiente - intersección'**
  String get formaPendienteInterseccion;

  /// No description provided for @formaPuntoPendiente.
  ///
  /// In es, this message translates to:
  /// **'Forma punto - pendiente'**
  String get formaPuntoPendiente;

  /// No description provided for @formaEstandar.
  ///
  /// In es, this message translates to:
  /// **'Forma estándar'**
  String get formaEstandar;

  /// No description provided for @formaSimetrica.
  ///
  /// In es, this message translates to:
  /// **'Forma simétrica'**
  String get formaSimetrica;

  /// No description provided for @pendiente.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get pendiente;

  /// No description provided for @coordenadasPuntoP.
  ///
  /// In es, this message translates to:
  /// **'Coordenadas de un punto P'**
  String get coordenadasPuntoP;

  /// No description provided for @interseccionX.
  ///
  /// In es, this message translates to:
  /// **'Intersección en x(x,0)'**
  String get interseccionX;

  /// No description provided for @interseccionY.
  ///
  /// In es, this message translates to:
  /// **'Intersección en y(0,y)'**
  String get interseccionY;

  /// No description provided for @centroDiferenteOrigenEjeFocalX.
  ///
  /// In es, this message translates to:
  /// **'Centro diferente del origen y eje focal en x'**
  String get centroDiferenteOrigenEjeFocalX;

  /// No description provided for @centroDiferenteOrigenEjeFocalY.
  ///
  /// In es, this message translates to:
  /// **'Centro diferente del origen y eje focal en y'**
  String get centroDiferenteOrigenEjeFocalY;

  /// No description provided for @centroOrigenEjeFocalX.
  ///
  /// In es, this message translates to:
  /// **'Centro en el origen y eje focal en x'**
  String get centroOrigenEjeFocalX;

  /// No description provided for @centroOrigenEjeFocalY.
  ///
  /// In es, this message translates to:
  /// **'Centro en el origen y eje focal en y'**
  String get centroOrigenEjeFocalY;

  /// No description provided for @ecuacionGeneralElipse.
  ///
  /// In es, this message translates to:
  /// **'Ecuación general de la elipse'**
  String get ecuacionGeneralElipse;

  /// No description provided for @horizontal.
  ///
  /// In es, this message translates to:
  /// **'Horizontal'**
  String get horizontal;

  /// No description provided for @vertical.
  ///
  /// In es, this message translates to:
  /// **'Vertical'**
  String get vertical;

  /// No description provided for @focoA0.
  ///
  /// In es, this message translates to:
  /// **'Foco en (a,0)'**
  String get focoA0;

  /// No description provided for @foco0A.
  ///
  /// In es, this message translates to:
  /// **'Foco en (0,a)'**
  String get foco0A;

  /// No description provided for @focoMenosA0.
  ///
  /// In es, this message translates to:
  /// **'Foco en (-a,0)'**
  String get focoMenosA0;

  /// No description provided for @foco0MenosA.
  ///
  /// In es, this message translates to:
  /// **'Foco en (0,-a)'**
  String get foco0MenosA;

  /// No description provided for @ecuacionGeneralParabola.
  ///
  /// In es, this message translates to:
  /// **'Ecuación general de la parábola'**
  String get ecuacionGeneralParabola;

  /// No description provided for @ejeFocalX.
  ///
  /// In es, this message translates to:
  /// **'Eje focal en x'**
  String get ejeFocalX;

  /// No description provided for @ejeFocalY.
  ///
  /// In es, this message translates to:
  /// **'Eje focal en y'**
  String get ejeFocalY;

  /// No description provided for @puntoMedio.
  ///
  /// In es, this message translates to:
  /// **'Punto medio'**
  String get puntoMedio;

  /// No description provided for @encuentraPuntoMedioEntre.
  ///
  /// In es, this message translates to:
  /// **'Encuentra el punto medio entre:'**
  String get encuentraPuntoMedioEntre;

  /// No description provided for @simplificando.
  ///
  /// In es, this message translates to:
  /// **'Simplificando'**
  String get simplificando;

  /// No description provided for @cubo.
  ///
  /// In es, this message translates to:
  /// **'Cubo'**
  String get cubo;

  /// No description provided for @prisma.
  ///
  /// In es, this message translates to:
  /// **'Prisma'**
  String get prisma;

  /// No description provided for @cilindro.
  ///
  /// In es, this message translates to:
  /// **'Cilindro'**
  String get cilindro;

  /// No description provided for @esfera.
  ///
  /// In es, this message translates to:
  /// **'Esfera'**
  String get esfera;

  /// No description provided for @piramide.
  ///
  /// In es, this message translates to:
  /// **'Pirámide'**
  String get piramide;

  /// No description provided for @cono.
  ///
  /// In es, this message translates to:
  /// **'Cono'**
  String get cono;

  /// No description provided for @focoEn.
  ///
  /// In es, this message translates to:
  /// **'Foco en'**
  String get focoEn;

  /// No description provided for @conector.
  ///
  /// In es, this message translates to:
  /// **'Conector'**
  String get conector;

  /// No description provided for @simbolo.
  ///
  /// In es, this message translates to:
  /// **'Símbolo'**
  String get simbolo;

  /// No description provided for @tablaVerdad.
  ///
  /// In es, this message translates to:
  /// **'Tabla de verdad'**
  String get tablaVerdad;

  /// No description provided for @implica.
  ///
  /// In es, this message translates to:
  /// **'Implica'**
  String get implica;

  /// No description provided for @simbolos.
  ///
  /// In es, this message translates to:
  /// **'Símbolos'**
  String get simbolos;

  /// No description provided for @implicacionCondicional.
  ///
  /// In es, this message translates to:
  /// **'Implicación Condicional'**
  String get implicacionCondicional;

  /// No description provided for @equivalenteBicondicional.
  ///
  /// In es, this message translates to:
  /// **'Equivalente Bicondicional'**
  String get equivalenteBicondicional;

  /// No description provided for @oExclusivo.
  ///
  /// In es, this message translates to:
  /// **'O exclusivo'**
  String get oExclusivo;

  /// No description provided for @o.
  ///
  /// In es, this message translates to:
  /// **'O'**
  String get o;

  /// No description provided for @esTautologia.
  ///
  /// In es, this message translates to:
  /// **'Es una tautología'**
  String get esTautologia;

  /// No description provided for @esContradiccion.
  ///
  /// In es, this message translates to:
  /// **'Es una contradicción'**
  String get esContradiccion;

  /// No description provided for @dobleNegacion.
  ///
  /// In es, this message translates to:
  /// **'Doble negación'**
  String get dobleNegacion;

  /// No description provided for @deMorgan.
  ///
  /// In es, this message translates to:
  /// **'De Morgan'**
  String get deMorgan;

  /// No description provided for @conmutativa.
  ///
  /// In es, this message translates to:
  /// **'Conmutativa'**
  String get conmutativa;

  /// No description provided for @asociativa.
  ///
  /// In es, this message translates to:
  /// **'Asociativa'**
  String get asociativa;

  /// No description provided for @distributiva.
  ///
  /// In es, this message translates to:
  /// **'Distributiva'**
  String get distributiva;

  /// No description provided for @idempotencia.
  ///
  /// In es, this message translates to:
  /// **'Idempotencia'**
  String get idempotencia;

  /// No description provided for @neutros.
  ///
  /// In es, this message translates to:
  /// **'Neutros'**
  String get neutros;

  /// No description provided for @dominacion.
  ///
  /// In es, this message translates to:
  /// **'Dominación'**
  String get dominacion;

  /// No description provided for @inversos.
  ///
  /// In es, this message translates to:
  /// **'Inversos'**
  String get inversos;

  /// No description provided for @absorcion.
  ///
  /// In es, this message translates to:
  /// **'Absorción'**
  String get absorcion;

  /// No description provided for @conjuncionLogica.
  ///
  /// In es, this message translates to:
  /// **'Conjunción lógica'**
  String get conjuncionLogica;

  /// No description provided for @disyuncionLogica.
  ///
  /// In es, this message translates to:
  /// **'Disyunción Lógica'**
  String get disyuncionLogica;

  /// No description provided for @esConjuntoY.
  ///
  /// In es, this message translates to:
  /// **'Es un conjunto Y'**
  String get esConjuntoY;

  /// No description provided for @sonSubconjuntosDe.
  ///
  /// In es, this message translates to:
  /// **'Son subconjuntos de'**
  String get sonSubconjuntosDe;

  /// No description provided for @dobleComplemento.
  ///
  /// In es, this message translates to:
  /// **'Doble complemento'**
  String get dobleComplemento;

  /// No description provided for @unionConjuntos.
  ///
  /// In es, this message translates to:
  /// **'Unión de conjuntos'**
  String get unionConjuntos;

  /// No description provided for @interseccionConjuntos.
  ///
  /// In es, this message translates to:
  /// **'Intersección de Conjuntos'**
  String get interseccionConjuntos;

  /// No description provided for @conjuntoVacio.
  ///
  /// In es, this message translates to:
  /// **'Conjunto vacío'**
  String get conjuntoVacio;

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @absorbentes.
  ///
  /// In es, this message translates to:
  /// **'Absorbentes'**
  String get absorbentes;

  /// No description provided for @rentaInteresAmortizacion.
  ///
  /// In es, this message translates to:
  /// **'Renta = Interes + Amortización'**
  String get rentaInteresAmortizacion;

  /// No description provided for @amortizacion.
  ///
  /// In es, this message translates to:
  /// **'Amortización'**
  String get amortizacion;

  /// No description provided for @interesesSaldosInsolutos.
  ///
  /// In es, this message translates to:
  /// **'Con intereses sobre saldos insolutos'**
  String get interesesSaldosInsolutos;

  /// No description provided for @tasaInteresSimple.
  ///
  /// In es, this message translates to:
  /// **'Tasa de Interés simple'**
  String get tasaInteresSimple;

  /// No description provided for @numeroPeriodos.
  ///
  /// In es, this message translates to:
  /// **'Número de Periodos'**
  String get numeroPeriodos;

  /// No description provided for @renta.
  ///
  /// In es, this message translates to:
  /// **'Renta'**
  String get renta;

  /// No description provided for @capital.
  ///
  /// In es, this message translates to:
  /// **'Capital'**
  String get capital;

  /// No description provided for @montoAcumulado.
  ///
  /// In es, this message translates to:
  /// **'Monto Acumulado'**
  String get montoAcumulado;

  /// No description provided for @valorPresente.
  ///
  /// In es, this message translates to:
  /// **'Valor Presente'**
  String get valorPresente;

  /// No description provided for @tasaInteresAnual.
  ///
  /// In es, this message translates to:
  /// **'Tasa de Interés Anual'**
  String get tasaInteresAnual;

  /// No description provided for @periodoAnos.
  ///
  /// In es, this message translates to:
  /// **'Periodo(años)'**
  String get periodoAnos;

  /// No description provided for @frecuenciaCapitalizacion.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia de Capitalización'**
  String get frecuenciaCapitalizacion;

  /// No description provided for @valorDescontado.
  ///
  /// In es, this message translates to:
  /// **'Valor Descontado'**
  String get valorDescontado;

  /// No description provided for @tasaDescuentoNominal.
  ///
  /// In es, this message translates to:
  /// **'Tasa de descuento nominal'**
  String get tasaDescuentoNominal;

  /// No description provided for @valorNominal.
  ///
  /// In es, this message translates to:
  /// **'Valor nominal'**
  String get valorNominal;

  /// No description provided for @frecuenciaDescuentoCompuesto.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia del descuento compuesto'**
  String get frecuenciaDescuentoCompuesto;

  /// No description provided for @descuentoSimpleReal.
  ///
  /// In es, this message translates to:
  /// **'Descuento simple real'**
  String get descuentoSimpleReal;

  /// No description provided for @descuentoComercial.
  ///
  /// In es, this message translates to:
  /// **'Descuento comercial'**
  String get descuentoComercial;

  /// No description provided for @valorComercial.
  ///
  /// In es, this message translates to:
  /// **'Valor comercial'**
  String get valorComercial;

  /// No description provided for @descuento.
  ///
  /// In es, this message translates to:
  /// **'Descuento'**
  String get descuento;

  /// No description provided for @tasaDescuentoSimple.
  ///
  /// In es, this message translates to:
  /// **'Tasa de Descuento Simple'**
  String get tasaDescuentoSimple;

  /// No description provided for @saldoInsolutoDespuesPeriodo.
  ///
  /// In es, this message translates to:
  /// **'Saldo Insoluto Después del k-ésimo periodo'**
  String get saldoInsolutoDespuesPeriodo;

  /// No description provided for @saldoInsoluto.
  ///
  /// In es, this message translates to:
  /// **'Saldo Insoluto'**
  String get saldoInsoluto;

  /// No description provided for @tasaInteresGlobal.
  ///
  /// In es, this message translates to:
  /// **'Tasa de Interés Global'**
  String get tasaInteresGlobal;

  /// No description provided for @tasaEfectiva.
  ///
  /// In es, this message translates to:
  /// **'Tasa Efectiva'**
  String get tasaEfectiva;

  /// No description provided for @tasaNominal.
  ///
  /// In es, this message translates to:
  /// **'Tasa Nominal'**
  String get tasaNominal;

  /// No description provided for @periodo.
  ///
  /// In es, this message translates to:
  /// **'Periodo'**
  String get periodo;

  /// No description provided for @frecuenciaCapitalizacionDefinicion.
  ///
  /// In es, this message translates to:
  /// **'La frecuencia de capitalización es el número de veces que se capitalizan los intereses en un año.'**
  String get frecuenciaCapitalizacionDefinicion;

  /// No description provided for @interes.
  ///
  /// In es, this message translates to:
  /// **'Interés'**
  String get interes;

  /// No description provided for @tasaInteres.
  ///
  /// In es, this message translates to:
  /// **'Tasa de Interés'**
  String get tasaInteres;

  /// No description provided for @montoCapital.
  ///
  /// In es, this message translates to:
  /// **'Monto del Capital'**
  String get montoCapital;

  /// No description provided for @numeroPeriodo.
  ///
  /// In es, this message translates to:
  /// **'Número del periodo'**
  String get numeroPeriodo;

  /// No description provided for @valorEsperado.
  ///
  /// In es, this message translates to:
  /// **'Valor Esperado'**
  String get valorEsperado;

  /// No description provided for @varianza.
  ///
  /// In es, this message translates to:
  /// **'Varianza'**
  String get varianza;

  /// No description provided for @numeroExperimentos.
  ///
  /// In es, this message translates to:
  /// **'Número de Experimentos'**
  String get numeroExperimentos;

  /// No description provided for @numeroExitos.
  ///
  /// In es, this message translates to:
  /// **'Número de Exitos'**
  String get numeroExitos;

  /// No description provided for @probabilidadExito.
  ///
  /// In es, this message translates to:
  /// **'probabilidad de exito'**
  String get probabilidadExito;

  /// No description provided for @probabilidadFracaso.
  ///
  /// In es, this message translates to:
  /// **'probabilidad de fracaso'**
  String get probabilidadFracaso;

  /// No description provided for @numeroExitosIntervaloTiempo.
  ///
  /// In es, this message translates to:
  /// **'Numero de exitos en un intervalo de tiempo'**
  String get numeroExitosIntervaloTiempo;

  /// No description provided for @lapsoTiempo.
  ///
  /// In es, this message translates to:
  /// **'Lapso de tiempo'**
  String get lapsoTiempo;

  /// No description provided for @tasaPromedioOcurrencia.
  ///
  /// In es, this message translates to:
  /// **'tasa promedio de ocurrencia'**
  String get tasaPromedioOcurrencia;

  /// No description provided for @baseLogaritmoNatural.
  ///
  /// In es, this message translates to:
  /// **'base del logaritmo natural'**
  String get baseLogaritmoNatural;

  /// No description provided for @numeroIntentosPrimerExito.
  ///
  /// In es, this message translates to:
  /// **'Numero de intentos hasta el primer exito'**
  String get numeroIntentosPrimerExito;

  /// No description provided for @tamanoMuestra.
  ///
  /// In es, this message translates to:
  /// **'Tamaño de la muestra'**
  String get tamanoMuestra;

  /// No description provided for @tamanoPoblacion.
  ///
  /// In es, this message translates to:
  /// **'tamaño de la poblacion'**
  String get tamanoPoblacion;

  /// No description provided for @numeroExitosPoblacion.
  ///
  /// In es, this message translates to:
  /// **'numero de exitos en la poblacion'**
  String get numeroExitosPoblacion;

  /// No description provided for @desviacionEstandar.
  ///
  /// In es, this message translates to:
  /// **'Desviación Estandar'**
  String get desviacionEstandar;

  /// No description provided for @mediaAritmetica.
  ///
  /// In es, this message translates to:
  /// **'Media Aritmetica'**
  String get mediaAritmetica;

  /// No description provided for @mediaMuestral.
  ///
  /// In es, this message translates to:
  /// **'Media Muestral'**
  String get mediaMuestral;

  /// No description provided for @mediaPoblacional.
  ///
  /// In es, this message translates to:
  /// **'Media Poblacional'**
  String get mediaPoblacional;

  /// No description provided for @terminoColeccion.
  ///
  /// In es, this message translates to:
  /// **'Un termino de la coleccion'**
  String get terminoColeccion;

  /// No description provided for @valorMedidaPosicion.
  ///
  /// In es, this message translates to:
  /// **'Valor de la medida de posicion'**
  String get valorMedidaPosicion;

  /// No description provided for @posicionPercentilP.
  ///
  /// In es, this message translates to:
  /// **'Posicion del percentil P'**
  String get posicionPercentilP;

  /// No description provided for @percentil.
  ///
  /// In es, this message translates to:
  /// **'Percentil: Divide la colección en 100 partes iguales.'**
  String get percentil;

  /// No description provided for @decil.
  ///
  /// In es, this message translates to:
  /// **'Decil: Divide la colección en 10 partes iguales'**
  String get decil;

  /// No description provided for @cuartil.
  ///
  /// In es, this message translates to:
  /// **'Divide la colección en 4 partes iguales'**
  String get cuartil;

  /// No description provided for @marcaAmplitudClase.
  ///
  /// In es, this message translates to:
  /// **'Marca y amplitud de clase'**
  String get marcaAmplitudClase;

  /// No description provided for @media.
  ///
  /// In es, this message translates to:
  /// **'Media'**
  String get media;

  /// No description provided for @mediana.
  ///
  /// In es, this message translates to:
  /// **'Mediana'**
  String get mediana;

  /// No description provided for @moda.
  ///
  /// In es, this message translates to:
  /// **'Moda'**
  String get moda;

  /// No description provided for @amplitudDatos.
  ///
  /// In es, this message translates to:
  /// **'Amplitud de datos'**
  String get amplitudDatos;

  /// No description provided for @marcaClase.
  ///
  /// In es, this message translates to:
  /// **'Marca de clase'**
  String get marcaClase;

  /// No description provided for @marcaClaseIntervaloi.
  ///
  /// In es, this message translates to:
  /// **'Marca de clase en el intervalo i'**
  String get marcaClaseIntervaloi;

  /// No description provided for @frecuenciaClaseMediana.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia de la clase mediana'**
  String get frecuenciaClaseMediana;

  /// No description provided for @frecuenciaAnteriorClaseModal.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia anterior a la clase modal'**
  String get frecuenciaAnteriorClaseModal;

  /// No description provided for @frecuenciaIntervaloi.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia en el intervalo i'**
  String get frecuenciaIntervaloi;

  /// No description provided for @frecuenciaPosteriorClaseModal.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia posterior a la clase modal'**
  String get frecuenciaPosteriorClaseModal;

  /// No description provided for @frecuenciaClaseModal.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia de la clase modal'**
  String get frecuenciaClaseModal;

  /// No description provided for @frecuenciaAcumuladaClaseAnteriorMediana.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia acumulada de la clase anterior a la clase mediana'**
  String get frecuenciaAcumuladaClaseAnteriorMediana;

  /// No description provided for @limiteInferior.
  ///
  /// In es, this message translates to:
  /// **'Límite inferior'**
  String get limiteInferior;

  /// No description provided for @limiteSuperior.
  ///
  /// In es, this message translates to:
  /// **'Limite superior'**
  String get limiteSuperior;

  /// No description provided for @limiteInferiorB.
  ///
  /// In es, this message translates to:
  /// **'Limite inferior de B'**
  String get limiteInferiorB;

  /// No description provided for @limiteInferiorA.
  ///
  /// In es, this message translates to:
  /// **'Limite inferior de A'**
  String get limiteInferiorA;

  /// No description provided for @limiteInferiorRealClaseMediana.
  ///
  /// In es, this message translates to:
  /// **'Limite inferior real de la clase mediana'**
  String get limiteInferiorRealClaseMediana;

  /// No description provided for @limiteInferiorRealClaseModal.
  ///
  /// In es, this message translates to:
  /// **'Limite inferior real de la clase modal'**
  String get limiteInferiorRealClaseModal;

  /// No description provided for @esmediaAritmetica.
  ///
  /// In es, this message translates to:
  /// **'es la media aritmetica'**
  String get esmediaAritmetica;

  /// No description provided for @representaValor.
  ///
  /// In es, this message translates to:
  /// **'representa el valor'**
  String get representaValor;

  /// No description provided for @esnumeroTotalDatos.
  ///
  /// In es, this message translates to:
  /// **' es el numero total de datos'**
  String get esnumeroTotalDatos;

  /// No description provided for @valorCentralColeccion.
  ///
  /// In es, this message translates to:
  /// **'Valor Central de la colección hay dos casos para n:'**
  String get valorCentralColeccion;

  /// No description provided for @impar.
  ///
  /// In es, this message translates to:
  /// **'Impar: El valor de la mediana es el valor central de la misma dividiendo en dos segmentos iguales la coleccion'**
  String get impar;

  /// No description provided for @par.
  ///
  /// In es, this message translates to:
  /// **'Par: El valor de la mediana es el promedio aritmetico de los valores centrales'**
  String get par;

  /// No description provided for @modaValorMayorFrecuencia.
  ///
  /// In es, this message translates to:
  /// **'Moda: Valor(es) con la mayor frecuencia (Los que más se repiten). Una colección puede ser:'**
  String get modaValorMayorFrecuencia;

  /// No description provided for @modal.
  ///
  /// In es, this message translates to:
  /// **'Modal: Cuenta con un solo valor de Mayor frecuencia'**
  String get modal;

  /// No description provided for @bimodal.
  ///
  /// In es, this message translates to:
  /// **'Bimodal: Cuenta con dos valores con la misma frecuencia'**
  String get bimodal;

  /// No description provided for @multimodal.
  ///
  /// In es, this message translates to:
  /// **'Multimodal: Cuenta con más de dos valores con la misma frecuencia'**
  String get multimodal;

  /// No description provided for @amplitudClase.
  ///
  /// In es, this message translates to:
  /// **'Amplitud de clase'**
  String get amplitudClase;

  /// No description provided for @numeroTotalDatos.
  ///
  /// In es, this message translates to:
  /// **'numero total de datos'**
  String get numeroTotalDatos;

  /// No description provided for @combinaciones.
  ///
  /// In es, this message translates to:
  /// **'Combinaciones'**
  String get combinaciones;

  /// No description provided for @permutaciones.
  ///
  /// In es, this message translates to:
  /// **'Permutaciones'**
  String get permutaciones;

  /// No description provided for @combinacionesElementos.
  ///
  /// In es, this message translates to:
  /// **'Combinaciones de r elementos tomados de entre n elementos'**
  String get combinacionesElementos;

  /// No description provided for @percentilP.
  ///
  /// In es, this message translates to:
  /// **'percentil P'**
  String get percentilP;

  /// No description provided for @limiteInferiorRealClasePercentilP.
  ///
  /// In es, this message translates to:
  /// **'Limite inferior real de la clase del percentil P'**
  String get limiteInferiorRealClasePercentilP;

  /// No description provided for @frecuenciaAcumuladaClaseAnteriorPercentil.
  ///
  /// In es, this message translates to:
  /// **'frecuencia acumulada de la clase anterior a la clase percentil'**
  String get frecuenciaAcumuladaClaseAnteriorPercentil;

  /// No description provided for @frecuenciaClasePercentil.
  ///
  /// In es, this message translates to:
  /// **'frecuencia de la clase percentil'**
  String get frecuenciaClasePercentil;

  /// No description provided for @amplitudClasePercentil.
  ///
  /// In es, this message translates to:
  /// **'amplitud de clase de la clase percentil'**
  String get amplitudClasePercentil;

  /// No description provided for @errorMuestral.
  ///
  /// In es, this message translates to:
  /// **'Error muestral'**
  String get errorMuestral;

  /// No description provided for @probabilidadOcurrenciaMediaMuestral.
  ///
  /// In es, this message translates to:
  /// **'Probabilidad de ocurrencia sobre la media muestral'**
  String get probabilidadOcurrenciaMediaMuestral;

  /// No description provided for @poblacion.
  ///
  /// In es, this message translates to:
  /// **'Población'**
  String get poblacion;

  /// No description provided for @numeroElementos.
  ///
  /// In es, this message translates to:
  /// **'Numero de Elementos'**
  String get numeroElementos;

  /// No description provided for @muestra.
  ///
  /// In es, this message translates to:
  /// **'muestra'**
  String get muestra;

  /// No description provided for @intervaloConfianzaMediaPoblacional.
  ///
  /// In es, this message translates to:
  /// **'Intervalo de Confianza Para la Media Poblacional'**
  String get intervaloConfianzaMediaPoblacional;

  /// No description provided for @valorLimiteInferior.
  ///
  /// In es, this message translates to:
  /// **'Valor del límite inferior'**
  String get valorLimiteInferior;

  /// No description provided for @valorLimiteSuperior.
  ///
  /// In es, this message translates to:
  /// **'Valor del Límite Superior'**
  String get valorLimiteSuperior;

  /// No description provided for @intervaloConfianzaProporcionPoblacional.
  ///
  /// In es, this message translates to:
  /// **'Intervalo de Confianza Para la Proporción Poblacional'**
  String get intervaloConfianzaProporcionPoblacional;

  /// No description provided for @probabilidadOcurrencia.
  ///
  /// In es, this message translates to:
  /// **'Probabilidad de Ocurrencia'**
  String get probabilidadOcurrencia;

  /// No description provided for @errorEstandarMedia.
  ///
  /// In es, this message translates to:
  /// **'Error estandar de la media'**
  String get errorEstandarMedia;

  /// No description provided for @promedioMuestralProporcion.
  ///
  /// In es, this message translates to:
  /// **'Promedio muestral de la proporción'**
  String get promedioMuestralProporcion;

  /// No description provided for @errorEstandarProporcion.
  ///
  /// In es, this message translates to:
  /// **'Error estandar de la proporcion'**
  String get errorEstandarProporcion;

  /// No description provided for @datosNoAgrupados.
  ///
  /// In es, this message translates to:
  /// **'Para datos no agrupados'**
  String get datosNoAgrupados;

  /// No description provided for @datosAgrupados.
  ///
  /// In es, this message translates to:
  /// **'para datos agrupados'**
  String get datosAgrupados;

  /// No description provided for @valoresConjuntoDatos.
  ///
  /// In es, this message translates to:
  /// **'Valores del conjunto de datos'**
  String get valoresConjuntoDatos;

  /// No description provided for @frecuenciaIntervalo.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia en el intervalo i'**
  String get frecuenciaIntervalo;

  /// No description provided for @marcaClaseIntervalo.
  ///
  /// In es, this message translates to:
  /// **'Marca de clase del intervalo i'**
  String get marcaClaseIntervalo;

  /// No description provided for @diferenciaMarcaClaseMedia.
  ///
  /// In es, this message translates to:
  /// **'Diferencia de Marca de Clase con respecto a la Media'**
  String get diferenciaMarcaClaseMedia;

  /// No description provided for @momentoEstadisticoPrimerGrado.
  ///
  /// In es, this message translates to:
  /// **'Momento estadístico de primer grado'**
  String get momentoEstadisticoPrimerGrado;

  /// No description provided for @momentoEstadisticoSegundoGrado.
  ///
  /// In es, this message translates to:
  /// **'Momento estadístico de segundo grado'**
  String get momentoEstadisticoSegundoGrado;

  /// No description provided for @momentoEstadisticoTercerGrado.
  ///
  /// In es, this message translates to:
  /// **'Momento Estadístico de Tercer Grado'**
  String get momentoEstadisticoTercerGrado;

  /// No description provided for @momentoEstadisticoCuartoGrado.
  ///
  /// In es, this message translates to:
  /// **'Momento Estadístico de Cuarto Grado'**
  String get momentoEstadisticoCuartoGrado;

  /// No description provided for @momentoEstadistico.
  ///
  /// In es, this message translates to:
  /// **'Momento estadistico'**
  String get momentoEstadistico;

  /// No description provided for @diferenciaMarcaClaseMedida.
  ///
  /// In es, this message translates to:
  /// **'Diferencia de marca de clase del intervalo i con respecto a la medida'**
  String get diferenciaMarcaClaseMedida;

  /// No description provided for @coeficienteAsimetria.
  ///
  /// In es, this message translates to:
  /// **'coeficiente de asimetria'**
  String get coeficienteAsimetria;

  /// No description provided for @curvaAsimetriaDerecha.
  ///
  /// In es, this message translates to:
  /// **'la curva de la distribucion tiene una asimetria derecha o sesgo positivo'**
  String get curvaAsimetriaDerecha;

  /// No description provided for @curvaDistribucionSimetrica.
  ///
  /// In es, this message translates to:
  /// **'la curva de distribucion es simetrica'**
  String get curvaDistribucionSimetrica;

  /// No description provided for @curvaAsimetriaIzquierda.
  ///
  /// In es, this message translates to:
  /// **'la curva de la distribucion tiene una asimetria izquierda o sesgo negativo'**
  String get curvaAsimetriaIzquierda;

  /// No description provided for @coeficienteApuntamiento.
  ///
  /// In es, this message translates to:
  /// **'Es el coeficiente de apuntamiento (o curtosis)'**
  String get coeficienteApuntamiento;

  /// No description provided for @curvaLeptocurtica.
  ///
  /// In es, this message translates to:
  /// **'La curva es leptocúrtica'**
  String get curvaLeptocurtica;

  /// No description provided for @curvaMesocurtica.
  ///
  /// In es, this message translates to:
  /// **'La curva es Mesocúrtica'**
  String get curvaMesocurtica;

  /// No description provided for @curvaPlatocurtica.
  ///
  /// In es, this message translates to:
  /// **'La curva es platocúrtica'**
  String get curvaPlatocurtica;

  /// No description provided for @probabilidadEventoA.
  ///
  /// In es, this message translates to:
  /// **'Probabilidad de un evento A'**
  String get probabilidadEventoA;

  /// No description provided for @resultadosFavorables.
  ///
  /// In es, this message translates to:
  /// **'resultados favorables'**
  String get resultadosFavorables;

  /// No description provided for @resultadosPosibles.
  ///
  /// In es, this message translates to:
  /// **'resultados posibles'**
  String get resultadosPosibles;

  /// No description provided for @probabilidadEventoSeguro.
  ///
  /// In es, this message translates to:
  /// **'1) la probabilidad del evento seguro es uno.'**
  String get probabilidadEventoSeguro;

  /// No description provided for @probabilidadEventoImposible.
  ///
  /// In es, this message translates to:
  /// **'2) La probabilidad del evento imposible es cero'**
  String get probabilidadEventoImposible;

  /// No description provided for @probabilidadEventoCualquiera.
  ///
  /// In es, this message translates to:
  /// **'3) La probabilidad de un evento cualquiera esta entre cero y uno'**
  String get probabilidadEventoCualquiera;

  /// No description provided for @probabilidadEventoContrarioA.
  ///
  /// In es, this message translates to:
  /// **'4) La probabilidad del evento contrario de A'**
  String get probabilidadEventoContrarioA;

  /// No description provided for @estimarMediaPoblacional.
  ///
  /// In es, this message translates to:
  /// **'Para estimar una media poblacional'**
  String get estimarMediaPoblacional;

  /// No description provided for @estimarProporcionPoblacional.
  ///
  /// In es, this message translates to:
  /// **'Para estimar la proporcion poblacional'**
  String get estimarProporcionPoblacional;

  /// No description provided for @proporcion.
  ///
  /// In es, this message translates to:
  /// **'Proporción'**
  String get proporcion;

  /// No description provided for @valorProporcionPoblacion.
  ///
  /// In es, this message translates to:
  /// **'Valor de la proporción en la población'**
  String get valorProporcionPoblacion;

  /// No description provided for @simetriaMediaOnda.
  ///
  /// In es, this message translates to:
  /// **'Simetría de Media Onda'**
  String get simetriaMediaOnda;

  /// No description provided for @serieFourier.
  ///
  /// In es, this message translates to:
  /// **'Serie de Fourier'**
  String get serieFourier;

  /// No description provided for @coeficientesSerieFourier.
  ///
  /// In es, this message translates to:
  /// **'Coeficientes de la Serie de Fourier'**
  String get coeficientesSerieFourier;

  /// No description provided for @simetriaCuartoOndaImpar.
  ///
  /// In es, this message translates to:
  /// **'Simetría de un Cuarto de Onda Impar'**
  String get simetriaCuartoOndaImpar;

  /// No description provided for @simetriaCuartoOndaPar.
  ///
  /// In es, this message translates to:
  /// **'Simetría de un Cuarto de Onda Par'**
  String get simetriaCuartoOndaPar;

  /// No description provided for @transformadaSenoFourier.
  ///
  /// In es, this message translates to:
  /// **'Transformada Seno de Fourier'**
  String get transformadaSenoFourier;

  /// No description provided for @transformadaInversaFourier.
  ///
  /// In es, this message translates to:
  /// **'Transformada Inversa de Fourier'**
  String get transformadaInversaFourier;

  /// No description provided for @transformadaCosenoFourier.
  ///
  /// In es, this message translates to:
  /// **'Transformada Coseno de Fourier'**
  String get transformadaCosenoFourier;

  /// No description provided for @transformada.
  ///
  /// In es, this message translates to:
  /// **'Transformada'**
  String get transformada;

  /// No description provided for @funcion.
  ///
  /// In es, this message translates to:
  /// **'Función'**
  String get funcion;

  /// No description provided for @dosFuncionesDadas.
  ///
  /// In es, this message translates to:
  /// **'dos funciones dadas'**
  String get dosFuncionesDadas;

  /// No description provided for @convolucionDe.
  ///
  /// In es, this message translates to:
  /// **'Convolución de'**
  String get convolucionDe;

  /// No description provided for @serieComplejaFourier.
  ///
  /// In es, this message translates to:
  /// **'Serie Compleja de Fourier'**
  String get serieComplejaFourier;

  /// No description provided for @coeficientesSerieComplejaFourier.
  ///
  /// In es, this message translates to:
  /// **'Coeficientes de la Serie Compleja de Fourier'**
  String get coeficientesSerieComplejaFourier;

  /// No description provided for @seObtieneAnterior.
  ///
  /// In es, this message translates to:
  /// **'Se Obtiene con lo Anterior que:'**
  String get seObtieneAnterior;

  /// No description provided for @teniendo.
  ///
  /// In es, this message translates to:
  /// **'Teniendo'**
  String get teniendo;

  /// No description provided for @porLoTanto.
  ///
  /// In es, this message translates to:
  /// **'Por lo tanto'**
  String get porLoTanto;

  /// No description provided for @serieTrenPeriodicoImpulsosUnitarios.
  ///
  /// In es, this message translates to:
  /// **'Serie de Tren Periódico de Impulsos Unitarios'**
  String get serieTrenPeriodicoImpulsosUnitarios;

  /// No description provided for @funcionNoDefinidaEn.
  ///
  /// In es, this message translates to:
  /// **'La función no está definida en'**
  String get funcionNoDefinidaEn;

  /// No description provided for @para.
  ///
  /// In es, this message translates to:
  /// **'para'**
  String get para;

  /// No description provided for @ladosTrianguloEsferico.
  ///
  /// In es, this message translates to:
  /// **'Lados del triángulo esférico'**
  String get ladosTrianguloEsferico;

  /// No description provided for @angulosTrianguloEsferico.
  ///
  /// In es, this message translates to:
  /// **'Ángulos del triángulo esférico'**
  String get angulosTrianguloEsferico;

  /// No description provided for @identidadesTrigonometricasSumaProducto.
  ///
  /// In es, this message translates to:
  /// **'Identidades trigonometricas de suma a producto'**
  String get identidadesTrigonometricasSumaProducto;

  /// No description provided for @identidadesTrigonometricasProductoSuma.
  ///
  /// In es, this message translates to:
  /// **'Identidades trigonometricas de producto a suma'**
  String get identidadesTrigonometricasProductoSuma;

  /// No description provided for @identidadesTrigonometricasParImpar.
  ///
  /// In es, this message translates to:
  /// **'Identidades trigonometricas de par e impar'**
  String get identidadesTrigonometricasParImpar;

  /// No description provided for @identidadesTrigonometricasSuplementoComplemento.
  ///
  /// In es, this message translates to:
  /// **'Identidades trigonometricas de suplemento y complemento'**
  String get identidadesTrigonometricasSuplementoComplemento;

  /// No description provided for @leySenos.
  ///
  /// In es, this message translates to:
  /// **'Ley de Senos'**
  String get leySenos;

  /// No description provided for @leyCosenos.
  ///
  /// In es, this message translates to:
  /// **'Ley de Cosenos'**
  String get leyCosenos;

  /// No description provided for @teoremaTangente.
  ///
  /// In es, this message translates to:
  /// **'Teorema de la Tangente'**
  String get teoremaTangente;

  /// No description provided for @sistema.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get sistema;

  /// No description provided for @sexagesimal.
  ///
  /// In es, this message translates to:
  /// **'Sexagesimal'**
  String get sexagesimal;

  /// No description provided for @circular.
  ///
  /// In es, this message translates to:
  /// **'Circular'**
  String get circular;

  /// No description provided for @unidad.
  ///
  /// In es, this message translates to:
  /// **'Unidad'**
  String get unidad;

  /// No description provided for @grados.
  ///
  /// In es, this message translates to:
  /// **'Grados'**
  String get grados;

  /// No description provided for @radianes.
  ///
  /// In es, this message translates to:
  /// **'Radianes'**
  String get radianes;

  /// No description provided for @radian.
  ///
  /// In es, this message translates to:
  /// **'Radian'**
  String get radian;

  /// No description provided for @clasificacionSegunMedida.
  ///
  /// In es, this message translates to:
  /// **'Clasificación según su medida'**
  String get clasificacionSegunMedida;

  /// No description provided for @anguloRecto.
  ///
  /// In es, this message translates to:
  /// **'◍ Un ángulo recto es aquel que mide 90°'**
  String get anguloRecto;

  /// No description provided for @anguloLlano.
  ///
  /// In es, this message translates to:
  /// **'◍ Un ángulo llano es aquel que mide 180°'**
  String get anguloLlano;

  /// No description provided for @anguloAgudo.
  ///
  /// In es, this message translates to:
  /// **'◍ Un ángulo agudo es aquel que mide menos de  90°'**
  String get anguloAgudo;

  /// No description provided for @anguloObtuso.
  ///
  /// In es, this message translates to:
  /// **'◍ Un ángulo obtuso es aquel que mide más de 90° pero menos de 180°'**
  String get anguloObtuso;

  /// No description provided for @clasificacionSegunValorSuma.
  ///
  /// In es, this message translates to:
  /// **'Clasificación según el valor de su suma'**
  String get clasificacionSegunValorSuma;

  /// No description provided for @angulosComplementarios.
  ///
  /// In es, this message translates to:
  /// **'◍ Dos ángulos son complementarios si su suma mide 90°'**
  String get angulosComplementarios;

  /// No description provided for @angulosSuplementarios.
  ///
  /// In es, this message translates to:
  /// **'◍ Dos ángulos son suplementarios si su suma mide 180°'**
  String get angulosSuplementarios;

  /// No description provided for @angulosConjugados.
  ///
  /// In es, this message translates to:
  /// **'◍ Dos ángulos son conjugados si su suma mide 360°'**
  String get angulosConjugados;

  /// No description provided for @superficieTrianguloEsferico.
  ///
  /// In es, this message translates to:
  /// **'Superficie de un Triángulo Esférico'**
  String get superficieTrianguloEsferico;

  /// No description provided for @superficiePoligonoEsferico.
  ///
  /// In es, this message translates to:
  /// **'Superficie de un polígono Esférico'**
  String get superficiePoligonoEsferico;

  /// No description provided for @radioEsfera.
  ///
  /// In es, this message translates to:
  /// **'Radio de la esfera'**
  String get radioEsfera;

  /// No description provided for @angulosTriangulo.
  ///
  /// In es, this message translates to:
  /// **'Ángulos del Triángulo'**
  String get angulosTriangulo;

  /// No description provided for @angulosPoligono.
  ///
  /// In es, this message translates to:
  /// **'Ángulos del Polígono'**
  String get angulosPoligono;

  /// No description provided for @numeroLadosPoligono.
  ///
  /// In es, this message translates to:
  /// **'Número de lados del polígono'**
  String get numeroLadosPoligono;

  /// No description provided for @buscarFormula.
  ///
  /// In es, this message translates to:
  /// **'Buscar Fórmula...'**
  String get buscarFormula;

  /// No description provided for @eliminarTareas.
  ///
  /// In es, this message translates to:
  /// **'Eliminar Todas las Tareas'**
  String get eliminarTareas;

  /// No description provided for @confirmacionEliminarTareas.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de eliminar TODAS las Tareas?'**
  String get confirmacionEliminarTareas;

  /// No description provided for @todoList.
  ///
  /// In es, this message translates to:
  /// **'To-Do List'**
  String get todoList;

  /// No description provided for @agregar.
  ///
  /// In es, this message translates to:
  /// **'Agregar'**
  String get agregar;

  /// No description provided for @borrarTodo.
  ///
  /// In es, this message translates to:
  /// **'Borrar Todo'**
  String get borrarTodo;

  /// No description provided for @eliminarFavoritos.
  ///
  /// In es, this message translates to:
  /// **'Eliminar de favoritos'**
  String get eliminarFavoritos;

  /// No description provided for @confirmacionEliminarFavoritos.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro que deseas eliminar TODOS tus favoritos?'**
  String get confirmacionEliminarFavoritos;

  /// No description provided for @nuevaTarea.
  ///
  /// In es, this message translates to:
  /// **'Nueva Tarea'**
  String get nuevaTarea;

  /// No description provided for @eliminarTarea.
  ///
  /// In es, this message translates to:
  /// **'Eliminar tarea'**
  String get eliminarTarea;

  /// No description provided for @confirmacionEliminarTarea.
  ///
  /// In es, this message translates to:
  /// **'¿Está seguro que desea eliminar la tarea?'**
  String get confirmacionEliminarTarea;

  /// No description provided for @confirmacionEliminarFavoritos1.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro que deseas ELIMINAR'**
  String get confirmacionEliminarFavoritos1;

  /// No description provided for @confirmacionEliminarFavoritosComplemento.
  ///
  /// In es, this message translates to:
  /// **'de tus favoritos?'**
  String get confirmacionEliminarFavoritosComplemento;

  /// No description provided for @tuDispositivo.
  ///
  /// In es, this message translates to:
  /// **'tu dispositivo'**
  String get tuDispositivo;

  /// No description provided for @pagoCargaraCuenta.
  ///
  /// In es, this message translates to:
  /// **'El pago se cargará a tu cuenta de'**
  String get pagoCargaraCuenta;

  /// No description provided for @renovacionAutomatica.
  ///
  /// In es, this message translates to:
  /// **'. La suscripción se renovará automáticamente a menos que se cancele.'**
  String get renovacionAutomatica;

  /// No description provided for @comprar.
  ///
  /// In es, this message translates to:
  /// **'Comprar'**
  String get comprar;

  /// No description provided for @restaurarCompras.
  ///
  /// In es, this message translates to:
  /// **'Restaurar Compras'**
  String get restaurarCompras;

  /// No description provided for @formulaeProChat.
  ///
  /// In es, this message translates to:
  /// **'Formulae Pro Chat'**
  String get formulaeProChat;

  /// No description provided for @comoPuedoAyudarte.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo puedo ayudarte?'**
  String get comoPuedoAyudarte;

  /// No description provided for @escogeModelo.
  ///
  /// In es, this message translates to:
  /// **'Escoge el modelo'**
  String get escogeModelo;

  /// No description provided for @errorProcesarCompra.
  ///
  /// In es, this message translates to:
  /// **'Hubo un error al procesar la compra. Por favor, intenta de nuevo.'**
  String get errorProcesarCompra;

  /// No description provided for @mensajeVacio.
  ///
  /// In es, this message translates to:
  /// **'No puedes enviar un mensaje vacío'**
  String get mensajeVacio;

  /// No description provided for @comenzamosSinSimbolo.
  ///
  /// In es, this message translates to:
  /// **'Comenzamos con la entrada sin ningún símbolo.'**
  String get comenzamosSinSimbolo;

  /// No description provided for @presionandoUnaVez.
  ///
  /// In es, this message translates to:
  /// **'Presionando una vez el símbolo de punto, sólo se agrega un punto.'**
  String get presionandoUnaVez;

  /// No description provided for @presionandoSegundaVez.
  ///
  /// In es, this message translates to:
  /// **'Presionando con segunda vez, ya se agrega el símbolo negativo.'**
  String get presionandoSegundaVez;

  /// No description provided for @comenzamosConFormulas.
  ///
  /// In es, this message translates to:
  /// **'Comenzamos con las formulas viendose algo así.'**
  String get comenzamosConFormulas;

  /// No description provided for @dirigimosAjustes.
  ///
  /// In es, this message translates to:
  /// **'Nos dirigimos a ajustes, nos vamos al apartado de display.'**
  String get dirigimosAjustes;

  /// No description provided for @apartadoFontSizeStyle.
  ///
  /// In es, this message translates to:
  /// **'Después al apartado de Font Size and Style. (Tamaño de letra y estilo)'**
  String get apartadoFontSizeStyle;

  /// No description provided for @bajamosTamanoLetra.
  ///
  /// In es, this message translates to:
  /// **'Bajamos el tamaño de letra de nuestro dispositivo'**
  String get bajamosTamanoLetra;

  /// No description provided for @regresamosConCambios.
  ///
  /// In es, this message translates to:
  /// **'Listo, regresamos a la Aplicación con los cambios realizados'**
  String get regresamosConCambios;

  /// No description provided for @siResultadoNaN.
  ///
  /// In es, this message translates to:
  /// **'Si el resultado es NaN.'**
  String get siResultadoNaN;

  /// No description provided for @solucionesImaginarias.
  ///
  /// In es, this message translates to:
  /// **'En este caso es por que las soluciones de la ecuación son Imaginarias.'**
  String get solucionesImaginarias;

  /// No description provided for @masInformacion.
  ///
  /// In es, this message translates to:
  /// **'Más Información:'**
  String get masInformacion;

  /// No description provided for @valorNaN.
  ///
  /// In es, this message translates to:
  /// **'NaN (del inglés \"Not a Number\", que significa No es un Número) es un valor que se suele devolver como el resultado de una operación con operandos de entrada no válidos, especialmente en los cálculos de punto flotante. Por ejemplo, cuando una operación intenta dividir cero entre cero, devuelve un resultado NaN.'**
  String get valorNaN;

  /// No description provided for @botonVerPDF.
  ///
  /// In es, this message translates to:
  /// **'El botón de Ver PDF solo funciona para ver el PDF sin ninguna funcionalidad extra, El botón Descargar o Imprimir PDF contiene varias opciones extras'**
  String get botonVerPDF;

  /// No description provided for @parteSuperiorCelular.
  ///
  /// In es, this message translates to:
  /// **'En la parte superior del celular, encontrará tres puntos.'**
  String get parteSuperiorCelular;

  /// No description provided for @presionandoOpcionesPDF.
  ///
  /// In es, this message translates to:
  /// **'Presionándolos saldrán todas las opciones que puede realizar con el PDF:'**
  String get presionandoOpcionesPDF;

  /// No description provided for @asegurarConexionInternet.
  ///
  /// In es, this message translates to:
  /// **'1) Asegurarnos que tengamos conexión a Internet'**
  String get asegurarConexionInternet;

  /// No description provided for @activarDesactivado.
  ///
  /// In es, this message translates to:
  /// **'2) Si se encuentra desactivado, activarlo'**
  String get activarDesactivado;

  /// No description provided for @esperarCargaVideo.
  ///
  /// In es, this message translates to:
  /// **'3) Esperar a que cargue el vídeo'**
  String get esperarCargaVideo;

  /// No description provided for @disfrutarVideo.
  ///
  /// In es, this message translates to:
  /// **'4) Disfrutar del video completamente cargado'**
  String get disfrutarVideo;

  /// No description provided for @siNoFunciona.
  ///
  /// In es, this message translates to:
  /// **'Si lo anterior no funciona'**
  String get siNoFunciona;

  /// No description provided for @salirVolverSeccion.
  ///
  /// In es, this message translates to:
  /// **'5) Salir y volver a entrar a la sección donde se encuentra el vídeo que queríamos ver'**
  String get salirVolverSeccion;

  /// No description provided for @esperarCargaPDF.
  ///
  /// In es, this message translates to:
  /// **'3) Esperar a que cargue el PDF'**
  String get esperarCargaPDF;

  /// No description provided for @disfrutarPDF.
  ///
  /// In es, this message translates to:
  /// **'4) Disfrutar del PDF deseado'**
  String get disfrutarPDF;

  /// No description provided for @formulaePro.
  ///
  /// In es, this message translates to:
  /// **'Formulae Pro'**
  String get formulaePro;

  /// No description provided for @descripcionApp.
  ///
  /// In es, this message translates to:
  /// **'Es una aplicación desarrollada para apoyar a estudiantes de cualquier nivel de estudios. \n\nEl objetivo de la aplicación es facilitar la búsqueda de fórmulas para la resolución de ejercicios y exámenes con ayuda de ejercicios para fortalecer lo aprendido, videos y PDF\'s que se pueden descargar e imprimir para su uso en los mismos. \n\nSe actualiza constantemente para mantenerse a la vanguardia, gracias por adquirir la aplicación. Esperemos que sea de utilidad. ¡Rómpela y síguela rompiendo!'**
  String get descripcionApp;

  /// No description provided for @descargaApp.
  ///
  /// In es, this message translates to:
  /// **'Descarga la aplicación Formulae Pro:'**
  String get descargaApp;

  /// No description provided for @favoritos.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favoritos;

  /// No description provided for @chat.
  ///
  /// In es, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @derivacionConstante.
  ///
  /// In es, this message translates to:
  /// **'Derivación de una Constante'**
  String get derivacionConstante;

  /// No description provided for @derivadaVariable.
  ///
  /// In es, this message translates to:
  /// **'Derivada de una Variable'**
  String get derivadaVariable;

  /// No description provided for @derivadaConstanteVariable.
  ///
  /// In es, this message translates to:
  /// **'Derivada Constante por Variable'**
  String get derivadaConstanteVariable;

  /// No description provided for @derivadaExponente.
  ///
  /// In es, this message translates to:
  /// **'Derivada Exponente'**
  String get derivadaExponente;

  /// No description provided for @derivadaConstanteExponente.
  ///
  /// In es, this message translates to:
  /// **'Derivada Constante por Exponente'**
  String get derivadaConstanteExponente;

  /// No description provided for @derivadaConstanteFuncionCompuesta.
  ///
  /// In es, this message translates to:
  /// **'Derivada Constante por Función Compuesta'**
  String get derivadaConstanteFuncionCompuesta;

  /// No description provided for @derivadaFuncionCompuestaExponente.
  ///
  /// In es, this message translates to:
  /// **'Derivada Funcion Compuesta con Exponente'**
  String get derivadaFuncionCompuestaExponente;

  /// No description provided for @derivadaProductoFuncionesCompuestas.
  ///
  /// In es, this message translates to:
  /// **'Derivada del Producto de Dos Funciones Compuestas'**
  String get derivadaProductoFuncionesCompuestas;

  /// No description provided for @derivadaCocienteFuncionesCompuestas.
  ///
  /// In es, this message translates to:
  /// **'Derivada del Cociente de Funciones Compuestas'**
  String get derivadaCocienteFuncionesCompuestas;

  /// No description provided for @derivadaProductoNFuncionesCompuestas.
  ///
  /// In es, this message translates to:
  /// **'Derivada del Producto de N Funciones Compuestas'**
  String get derivadaProductoNFuncionesCompuestas;

  /// No description provided for @derivadaSumaFuncionesCompuestas.
  ///
  /// In es, this message translates to:
  /// **'Derivada de la Suma de Funciones Compuestas'**
  String get derivadaSumaFuncionesCompuestas;

  /// No description provided for @funcionCompuesta.
  ///
  /// In es, this message translates to:
  /// **'Función Compuesta'**
  String get funcionCompuesta;

  /// No description provided for @dondeUVValores.
  ///
  /// In es, this message translates to:
  /// **'Donde (u) y (v) tomarán los valores según el orden de aparición de:'**
  String get dondeUVValores;

  /// No description provided for @logaritmicas.
  ///
  /// In es, this message translates to:
  /// **'1) Logaritmicas'**
  String get logaritmicas;

  /// No description provided for @trigonometricasInversasNumero.
  ///
  /// In es, this message translates to:
  /// **'2) Trigonométricas Inversas'**
  String get trigonometricasInversasNumero;

  /// No description provided for @algebraicas.
  ///
  /// In es, this message translates to:
  /// **'3) Algebraicas'**
  String get algebraicas;

  /// No description provided for @trigonometricas.
  ///
  /// In es, this message translates to:
  /// **'4) Trigonométricas'**
  String get trigonometricas;

  /// No description provided for @exponenciales.
  ///
  /// In es, this message translates to:
  /// **'5) Exponenciales'**
  String get exponenciales;

  /// No description provided for @logaritmoNaturalDefinicion.
  ///
  /// In es, this message translates to:
  /// **'El Logaritmo Natural (ln) de un número (x) es entonces el Exponente al que debe ser elevado el número (e) para obtener (x)'**
  String get logaritmoNaturalDefinicion;

  /// No description provided for @sai.
  ///
  /// In es, this message translates to:
  /// **'Sai(n)='**
  String get sai;

  /// No description provided for @ai.
  ///
  /// In es, this message translates to:
  /// **'Ai(n)='**
  String get ai;

  /// No description provided for @ae.
  ///
  /// In es, this message translates to:
  /// **'Ae(n)='**
  String get ae;

  /// No description provided for @paraYIgualFdeX.
  ///
  /// In es, this message translates to:
  /// **'Para y = F(x)'**
  String get paraYIgualFdeX;

  /// No description provided for @paraXIgualGdeY.
  ///
  /// In es, this message translates to:
  /// **'Para x = G(y)'**
  String get paraXIgualGdeY;

  /// No description provided for @derivadaDeFEnPEnDireccionDeU.
  ///
  /// In es, this message translates to:
  /// **'Derivada De F en P(x,y) en la dirección de u'**
  String get derivadaDeFEnPEnDireccionDeU;

  /// No description provided for @dadaFuncionFDeXYZ.
  ///
  /// In es, this message translates to:
  /// **'Dada la función f(x,y,z)'**
  String get dadaFuncionFDeXYZ;

  /// No description provided for @vectorConstante.
  ///
  /// In es, this message translates to:
  /// **'Un vector Constante'**
  String get vectorConstante;

  /// No description provided for @funcionEscalarDerivable.
  ///
  /// In es, this message translates to:
  /// **'Una función escalar derivable'**
  String get funcionEscalarDerivable;

  /// No description provided for @areaDeLaBase.
  ///
  /// In es, this message translates to:
  /// **'Área de la Base'**
  String get areaDeLaBase;

  /// No description provided for @mantenPresionadoParaEliminarTarea.
  ///
  /// In es, this message translates to:
  /// **'Mantén presionado para eliminar la tarea'**
  String get mantenPresionadoParaEliminarTarea;

  /// No description provided for @mantenPresionadoBotonMasParaEliminarTodasTareas.
  ///
  /// In es, this message translates to:
  /// **'Mantén presionado el botón (+ Agregar) para eliminar todas las tareas'**
  String get mantenPresionadoBotonMasParaEliminarTodasTareas;

  /// No description provided for @tareaDemo.
  ///
  /// In es, this message translates to:
  /// **'Tarea demo'**
  String get tareaDemo;

  /// No description provided for @disponibilidadVideos.
  ///
  /// In es, this message translates to:
  /// **'Por el momento los videos solo están disponibles en la versión móvil.'**
  String get disponibilidadVideos;

  /// No description provided for @traduccionVideos.
  ///
  /// In es, this message translates to:
  /// **'Por el momento no está disponible el video en tu idioma, estamos trabajando para tenerlo disponible lo más pronto posible.'**
  String get traduccionVideos;

  /// No description provided for @mensajeError.
  ///
  /// In es, this message translates to:
  /// **'Hubo un problema al cargar el archivo PDF. Revisa tu conexión a internet e intenta de nuevo más tarde.'**
  String get mensajeError;

  /// No description provided for @reintentar.
  ///
  /// In es, this message translates to:
  /// **'Intentar de nuevo'**
  String get reintentar;

  /// No description provided for @formulaePDF.
  ///
  /// In es, this message translates to:
  /// **'Formulae PDF'**
  String get formulaePDF;

  /// No description provided for @validandoCompra.
  ///
  /// In es, this message translates to:
  /// **'Validando la Compra...'**
  String get validandoCompra;

  /// No description provided for @eliminar.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get eliminar;

  /// No description provided for @compartir.
  ///
  /// In es, this message translates to:
  /// **'Compartir'**
  String get compartir;

  /// No description provided for @plazo.
  ///
  /// In es, this message translates to:
  /// **'Plazo'**
  String get plazo;

  /// No description provided for @recordatorio.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio'**
  String get recordatorio;

  /// No description provided for @guardarRecordatorio.
  ///
  /// In es, this message translates to:
  /// **'Guardar Recordatorio'**
  String get guardarRecordatorio;

  /// No description provided for @tarea.
  ///
  /// In es, this message translates to:
  /// **'Tarea'**
  String get tarea;

  /// No description provided for @estado.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get estado;

  /// No description provided for @completada.
  ///
  /// In es, this message translates to:
  /// **'✅'**
  String get completada;

  /// No description provided for @noCompletada.
  ///
  /// In es, this message translates to:
  /// **'❌'**
  String get noCompletada;

  /// No description provided for @editar.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get editar;

  /// No description provided for @editarTarea.
  ///
  /// In es, this message translates to:
  /// **'Editar Tarea'**
  String get editarTarea;

  /// No description provided for @guardar.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get guardar;

  /// No description provided for @nombreTarea.
  ///
  /// In es, this message translates to:
  /// **'Nombre Tarea'**
  String get nombreTarea;

  /// No description provided for @compartirTareas.
  ///
  /// In es, this message translates to:
  /// **'Compartir Todo'**
  String get compartirTareas;

  /// No description provided for @tareasPDF.
  ///
  /// In es, this message translates to:
  /// **'tareas.pdf'**
  String get tareasPDF;

  /// No description provided for @lasTareasSon.
  ///
  /// In es, this message translates to:
  /// **'Las tareas son:'**
  String get lasTareasSon;

  /// No description provided for @asignarRecordatorio.
  ///
  /// In es, this message translates to:
  /// **'Asigna un Recordatorio'**
  String get asignarRecordatorio;

  /// No description provided for @fechaFuturo.
  ///
  /// In es, this message translates to:
  /// **'La fecha y hora seleccionadas deben estar en el futuro.'**
  String get fechaFuturo;

  /// No description provided for @detallesTarea.
  ///
  /// In es, this message translates to:
  /// **'Detalles de la Tarea'**
  String get detallesTarea;

  /// No description provided for @fechaRecordatorio.
  ///
  /// In es, this message translates to:
  /// **'Fecha Recordatorio'**
  String get fechaRecordatorio;

  /// No description provided for @fechaEntrega.
  ///
  /// In es, this message translates to:
  /// **'Fecha Entrega'**
  String get fechaEntrega;

  /// No description provided for @saltar.
  ///
  /// In es, this message translates to:
  /// **'Saltar'**
  String get saltar;

  /// No description provided for @seleccionarFecha.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar Fecha'**
  String get seleccionarFecha;

  /// No description provided for @noAsignado.
  ///
  /// In es, this message translates to:
  /// **'No Asignado'**
  String get noAsignado;

  /// No description provided for @hacerTarea.
  ///
  /// In es, this message translates to:
  /// **'Hacer Tarea:'**
  String get hacerTarea;

  /// No description provided for @opcionesExportacion.
  ///
  /// In es, this message translates to:
  /// **'Opciones de Exportación'**
  String get opcionesExportacion;

  /// No description provided for @incluirFechaEntrega.
  ///
  /// In es, this message translates to:
  /// **'Incluir Fecha de Entrega'**
  String get incluirFechaEntrega;

  /// No description provided for @incluirRecordatorio.
  ///
  /// In es, this message translates to:
  /// **'Incluir Recordatorio'**
  String get incluirRecordatorio;

  /// No description provided for @incluirEstado.
  ///
  /// In es, this message translates to:
  /// **'Incluir Estado'**
  String get incluirEstado;

  /// No description provided for @carpetasFavoritos.
  ///
  /// In es, this message translates to:
  /// **'Carpetas'**
  String get carpetasFavoritos;

  /// No description provided for @crearCarpeta.
  ///
  /// In es, this message translates to:
  /// **'Crear carpeta'**
  String get crearCarpeta;

  /// No description provided for @nombreCarpeta.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la carpeta'**
  String get nombreCarpeta;

  /// No description provided for @carpetaActiva.
  ///
  /// In es, this message translates to:
  /// **'Carpeta activa'**
  String get carpetaActiva;

  /// No description provided for @exportarPDF.
  ///
  /// In es, this message translates to:
  /// **'Exportar PDF'**
  String get exportarPDF;

  /// No description provided for @generandoPDF.
  ///
  /// In es, this message translates to:
  /// **'Generando PDF...'**
  String get generandoPDF;

  /// No description provided for @pdfGenerado.
  ///
  /// In es, this message translates to:
  /// **'PDF generado'**
  String get pdfGenerado;

  /// No description provided for @carpetaVacia.
  ///
  /// In es, this message translates to:
  /// **'Esta carpeta no tiene fórmulas todavía.'**
  String get carpetaVacia;

  /// No description provided for @moverACarpeta.
  ///
  /// In es, this message translates to:
  /// **'Mover a carpeta'**
  String get moverACarpeta;

  /// No description provided for @eliminarCarpeta.
  ///
  /// In es, this message translates to:
  /// **'Eliminar carpeta'**
  String get eliminarCarpeta;

  /// No description provided for @coeficientesBinomiales.
  ///
  /// In es, this message translates to:
  /// **'Coeficientes binomiales y binomio de Newton'**
  String get coeficientesBinomiales;

  /// No description provided for @potenciasNEsimas.
  ///
  /// In es, this message translates to:
  /// **'Suma y diferencia de potencias n-esimas'**
  String get potenciasNEsimas;

  /// No description provided for @ecuacionCubica.
  ///
  /// In es, this message translates to:
  /// **'Ecuacion cubica (metodo de Cardano)'**
  String get ecuacionCubica;

  /// No description provided for @ecuacionCuadraticaFormaMonicaVieta.
  ///
  /// In es, this message translates to:
  /// **'Ecuacion cuadratica: forma monica y teorema de Vieta'**
  String get ecuacionCuadraticaFormaMonicaVieta;

  /// No description provided for @numerosComplejosFormaExponencialNumeroComplejo.
  ///
  /// In es, this message translates to:
  /// **'Forma exponencial (Euler) de un numero complejo'**
  String get numerosComplejosFormaExponencialNumeroComplejo;

  /// No description provided for @numerosComplejosRaicesEIgualdadNumerosComplejos.
  ///
  /// In es, this message translates to:
  /// **'Raices e igualdad de numeros complejos'**
  String get numerosComplejosRaicesEIgualdadNumerosComplejos;

  /// No description provided for @propiedadesLogaritmos2.
  ///
  /// In es, this message translates to:
  /// **'Logaritmos (leyes y transformaciones)'**
  String get propiedadesLogaritmos2;

  /// No description provided for @determinantesCramerSarrus.
  ///
  /// In es, this message translates to:
  /// **'Determinantes y regla de Cramer / Sarrus'**
  String get determinantesCramerSarrus;

  /// No description provided for @algebraLinealMatricesTiposDeMatrices.
  ///
  /// In es, this message translates to:
  /// **'Tipos de matrices'**
  String get algebraLinealMatricesTiposDeMatrices;

  /// No description provided for @algebraLinealVectoresProductosBaseCanonica.
  ///
  /// In es, this message translates to:
  /// **'Producto punto y cruz de la base canonica'**
  String get algebraLinealVectoresProductosBaseCanonica;

  /// No description provided for @algebraLinealVectoresProductoEscalarTriple.
  ///
  /// In es, this message translates to:
  /// **'Producto escalar triple y volumen'**
  String get algebraLinealVectoresProductoEscalarTriple;

  /// No description provided for @algebraLinealVectoresSumaVectoresComponentes.
  ///
  /// In es, this message translates to:
  /// **'Suma de vectores por componentes (metodo del poligono)'**
  String get algebraLinealVectoresSumaVectoresComponentes;

  /// No description provided for @algebraLinealVectoresLeySenosCosenos.
  ///
  /// In es, this message translates to:
  /// **'Ley de senos y cosenos'**
  String get algebraLinealVectoresLeySenosCosenos;

  /// No description provided for @algebraLinealVectoresRazonesTrigonometricas.
  ///
  /// In es, this message translates to:
  /// **'Razones trigonometricas (triangulo rectangulo)'**
  String get algebraLinealVectoresRazonesTrigonometricas;

  /// No description provided for @limitesTeoremasLimites.
  ///
  /// In es, this message translates to:
  /// **'Teoremas de los limites'**
  String get limitesTeoremasLimites;

  /// No description provided for @limitesLimitesInfinitos.
  ///
  /// In es, this message translates to:
  /// **'Limites infinitos'**
  String get limitesLimitesInfinitos;

  /// No description provided for @limitesLimitesImportantes.
  ///
  /// In es, this message translates to:
  /// **'Limites importantes'**
  String get limitesLimitesImportantes;

  /// No description provided for @asintotasHorizontalesOblicuas.
  ///
  /// In es, this message translates to:
  /// **'Asintotas horizontales y oblicuas'**
  String get asintotasHorizontalesOblicuas;

  /// No description provided for @continuidad.
  ///
  /// In es, this message translates to:
  /// **'Continuidad'**
  String get continuidad;

  /// No description provided for @reglaLhopital.
  ///
  /// In es, this message translates to:
  /// **'Regla de L\'Hopital'**
  String get reglaLhopital;

  /// No description provided for @diferenciales.
  ///
  /// In es, this message translates to:
  /// **'Diferenciales'**
  String get diferenciales;

  /// No description provided for @derivadasAlgebraicasRadicales.
  ///
  /// In es, this message translates to:
  /// **'Derivadas algebraicas y radicales'**
  String get derivadasAlgebraicasRadicales;

  /// No description provided for @reglaCadenaFuncionInversa.
  ///
  /// In es, this message translates to:
  /// **'Regla de la cadena y funcion inversa'**
  String get reglaCadenaFuncionInversa;

  /// No description provided for @derivadasTrigonometricasComplementarias.
  ///
  /// In es, this message translates to:
  /// **'Derivadas trigonometricas complementarias (verseno y en terminos del arco)'**
  String get derivadasTrigonometricasComplementarias;

  /// No description provided for @derivadasHiperbolicasInversas.
  ///
  /// In es, this message translates to:
  /// **'Derivadas de funciones hiperbolicas inversas'**
  String get derivadasHiperbolicasInversas;

  /// No description provided for @derivacionLogaritmica.
  ///
  /// In es, this message translates to:
  /// **'Derivacion logaritmica (potencias variables)'**
  String get derivacionLogaritmica;

  /// No description provided for @razonCambioTangenteNormal.
  ///
  /// In es, this message translates to:
  /// **'Razon de cambio, recta tangente y normal'**
  String get razonCambioTangenteNormal;

  /// No description provided for @aplicacionFisicaDerivada.
  ///
  /// In es, this message translates to:
  /// **'Aplicacion fisica de la derivada'**
  String get aplicacionFisicaDerivada;

  /// No description provided for @integralesInmediatasAdicionalesIntegral.
  ///
  /// In es, this message translates to:
  /// **'Integrales inmediatas adicionales (formas racionales y radicales)'**
  String get integralesInmediatasAdicionalesIntegral;

  /// No description provided for @potenciasReduccionTrigonometricasIntegral.
  ///
  /// In es, this message translates to:
  /// **'Potencias de funciones trigonometricas y formulas de reduccion'**
  String get potenciasReduccionTrigonometricasIntegral;

  /// No description provided for @trigonometricasRacionalesProductosIntegral.
  ///
  /// In es, this message translates to:
  /// **'Integrales trigonometricas racionales y productos'**
  String get trigonometricasRacionalesProductosIntegral;

  /// No description provided for @potenciasReduccionHiperbolicasIntegral.
  ///
  /// In es, this message translates to:
  /// **'Potencias y reduccion de funciones hiperbolicas'**
  String get potenciasReduccionHiperbolicasIntegral;

  /// No description provided for @hiperbolicasInversasIntegral.
  ///
  /// In es, this message translates to:
  /// **'Integrales de funciones hiperbolicas inversas'**
  String get hiperbolicasInversasIntegral;

  /// No description provided for @integralDefinidaPropiedadesIntegral.
  ///
  /// In es, this message translates to:
  /// **'Integral definida: propiedades y teoremas'**
  String get integralDefinidaPropiedadesIntegral;

  /// No description provided for @integracionNumericaIntegral.
  ///
  /// In es, this message translates to:
  /// **'Integracion numerica'**
  String get integracionNumericaIntegral;

  /// No description provided for @sustitucionTrigonometricaIntegral.
  ///
  /// In es, this message translates to:
  /// **'Integracion por sustitucion trigonometrica'**
  String get sustitucionTrigonometricaIntegral;

  /// No description provided for @areaLongitudArcoIntegral.
  ///
  /// In es, this message translates to:
  /// **'Aplicaciones de la integral: area entre curvas y longitud de arco'**
  String get areaLongitudArcoIntegral;

  /// No description provided for @fraccionesParcialesIntegral.
  ///
  /// In es, this message translates to:
  /// **'Descomposicion en fracciones parciales'**
  String get fraccionesParcialesIntegral;

  /// No description provided for @constantesMatematicas.
  ///
  /// In es, this message translates to:
  /// **'Constantes matemáticas'**
  String get constantesMatematicas;

  /// No description provided for @constantesFisicasUniversales.
  ///
  /// In es, this message translates to:
  /// **'Constantes físicas universales'**
  String get constantesFisicasUniversales;

  /// No description provided for @constantesElectromagneticas.
  ///
  /// In es, this message translates to:
  /// **'Constantes electromagnéticas'**
  String get constantesElectromagneticas;

  /// No description provided for @constantesAtomicasMoleculares.
  ///
  /// In es, this message translates to:
  /// **'Constantes atómicas y moleculares'**
  String get constantesAtomicasMoleculares;

  /// No description provided for @constantesTerrestresAstronomicas.
  ///
  /// In es, this message translates to:
  /// **'Constantes terrestres y astronómicas'**
  String get constantesTerrestresAstronomicas;

  /// No description provided for @seccionConstantesMatematicas.
  ///
  /// In es, this message translates to:
  /// **'Constantes matemáticas'**
  String get seccionConstantesMatematicas;

  /// No description provided for @longitudConversion.
  ///
  /// In es, this message translates to:
  /// **'Longitud'**
  String get longitudConversion;

  /// No description provided for @superficieConversion.
  ///
  /// In es, this message translates to:
  /// **'Superficie'**
  String get superficieConversion;

  /// No description provided for @volumenConversion.
  ///
  /// In es, this message translates to:
  /// **'Volumen'**
  String get volumenConversion;

  /// No description provided for @masaConversion.
  ///
  /// In es, this message translates to:
  /// **'Masa'**
  String get masaConversion;

  /// No description provided for @densidadConversion.
  ///
  /// In es, this message translates to:
  /// **'Densidad'**
  String get densidadConversion;

  /// No description provided for @presionConversion.
  ///
  /// In es, this message translates to:
  /// **'Presion'**
  String get presionConversion;

  /// No description provided for @energiaConversion.
  ///
  /// In es, this message translates to:
  /// **'Energia'**
  String get energiaConversion;

  /// No description provided for @potenciaConversion.
  ///
  /// In es, this message translates to:
  /// **'Potencia'**
  String get potenciaConversion;

  /// No description provided for @seccionConversionDeUnidades.
  ///
  /// In es, this message translates to:
  /// **'Conversión de unidades'**
  String get seccionConversionDeUnidades;

  /// No description provided for @potenciaYReactanciasEnCa.
  ///
  /// In es, this message translates to:
  /// **'Potencia y reactancias en corriente alterna (CA)'**
  String get potenciaYReactanciasEnCa;

  /// No description provided for @caValoresEficacesTransformador.
  ///
  /// In es, this message translates to:
  /// **'Corriente alterna: valores eficaces, transformador y maquinas rotatorias'**
  String get caValoresEficacesTransformador;

  /// No description provided for @instrumentosDeMedicionElectrica.
  ///
  /// In es, this message translates to:
  /// **'Instrumentos de medicion electrica: puente de Wheatstone, voltimetro y amperimetro'**
  String get instrumentosDeMedicionElectrica;

  /// No description provided for @circuitoLrEnSerie.
  ///
  /// In es, this message translates to:
  /// **'Circuito LR (RL) en serie'**
  String get circuitoLrEnSerie;

  /// No description provided for @fuerzaYTorcaMagnetica.
  ///
  /// In es, this message translates to:
  /// **'Fuerza y momento de torsion magneticos'**
  String get fuerzaYTorcaMagnetica;

  /// No description provided for @capacitoresCilindricoYEsferico.
  ///
  /// In es, this message translates to:
  /// **'Capacitancia de capacitores cilindrico y esferico'**
  String get capacitoresCilindricoYEsferico;

  /// No description provided for @permeabilidadMagneticaEnMateriales.
  ///
  /// In es, this message translates to:
  /// **'Permeabilidad magnetica e intensidad de campo en materiales'**
  String get permeabilidadMagneticaEnMateriales;

  /// No description provided for @bateriaRealVoltajeEnTerminales.
  ///
  /// In es, this message translates to:
  /// **'Fuente real (bateria): voltaje en terminales y resistencia interna'**
  String get bateriaRealVoltajeEnTerminales;

  /// No description provided for @laRectaYElTriangulo.
  ///
  /// In es, this message translates to:
  /// **'La recta y el triangulo'**
  String get laRectaYElTriangulo;

  /// No description provided for @tangentesYPropiedadesDeLasConicas.
  ///
  /// In es, this message translates to:
  /// **'Tangentes y propiedades de las conicas'**
  String get tangentesYPropiedadesDeLasConicas;

  /// No description provided for @hiperbolaEquilatera.
  ///
  /// In es, this message translates to:
  /// **'La hiperbola equilatera'**
  String get hiperbolaEquilatera;

  /// No description provided for @laCurvaExponencial.
  ///
  /// In es, this message translates to:
  /// **'La curva exponencial'**
  String get laCurvaExponencial;

  /// No description provided for @aceleracionYMrua.
  ///
  /// In es, this message translates to:
  /// **'Aceleracion y Movimiento Rectilineo Uniformemente Acelerado (MRUA)'**
  String get aceleracionYMrua;

  /// No description provided for @caidaLibreYTiroVertical.
  ///
  /// In es, this message translates to:
  /// **'Caida libre y tiro vertical'**
  String get caidaLibreYTiroVertical;

  /// No description provided for @movimientoDeProyectiles.
  ///
  /// In es, this message translates to:
  /// **'Movimiento de proyectiles (tiro parabolico)'**
  String get movimientoDeProyectiles;

  /// No description provided for @movimientoCircularUniforme.
  ///
  /// In es, this message translates to:
  /// **'Movimiento circular uniforme'**
  String get movimientoCircularUniforme;

  /// No description provided for @cinematicaAngular.
  ///
  /// In es, this message translates to:
  /// **'Cinematica angular (rotacion uniformemente acelerada)'**
  String get cinematicaAngular;

  /// No description provided for @aceleracionYFuerzaCentripeta.
  ///
  /// In es, this message translates to:
  /// **'Aceleracion y fuerza centripeta'**
  String get aceleracionYFuerzaCentripeta;

  /// No description provided for @leyesDeNewton.
  ///
  /// In es, this message translates to:
  /// **'Leyes de Newton'**
  String get leyesDeNewton;

  /// No description provided for @pesoYGravedad.
  ///
  /// In es, this message translates to:
  /// **'Peso y gravedad'**
  String get pesoYGravedad;

  /// No description provided for @cantidadDeMovimientoEImpulso.
  ///
  /// In es, this message translates to:
  /// **'Cantidad de movimiento e impulso'**
  String get cantidadDeMovimientoEImpulso;

  /// No description provided for @friccion.
  ///
  /// In es, this message translates to:
  /// **'Friccion'**
  String get friccion;

  /// No description provided for @movimientoArmonicoSimple.
  ///
  /// In es, this message translates to:
  /// **'Movimiento armonico simple (M.A.S.)'**
  String get movimientoArmonicoSimple;

  /// No description provided for @penduloSimple.
  ///
  /// In es, this message translates to:
  /// **'Pendulo simple'**
  String get penduloSimple;

  /// No description provided for @equilibrioDeCuerposRigidos.
  ///
  /// In es, this message translates to:
  /// **'Equilibrio de cuerpos rigidos'**
  String get equilibrioDeCuerposRigidos;

  /// No description provided for @momentoDeTorsion.
  ///
  /// In es, this message translates to:
  /// **'Momento de torsion (torque)'**
  String get momentoDeTorsion;

  /// No description provided for @eficiencia.
  ///
  /// In es, this message translates to:
  /// **'Eficiencia'**
  String get eficiencia;

  /// No description provided for @hidrostatica.
  ///
  /// In es, this message translates to:
  /// **'Hidrostatica'**
  String get hidrostatica;

  /// No description provided for @hidrodinamica.
  ///
  /// In es, this message translates to:
  /// **'Hidrodinamica (Bernoulli, continuidad, Torricelli)'**
  String get hidrodinamica;

  /// No description provided for @seccionMecanica.
  ///
  /// In es, this message translates to:
  /// **'Mecánica'**
  String get seccionMecanica;

  /// No description provided for @axiomasDeCampoNumerosReales.
  ///
  /// In es, this message translates to:
  /// **'Axiomas de campo de los numeros reales'**
  String get axiomasDeCampoNumerosReales;

  /// No description provided for @axiomasDeOrdenYTeoremasReales.
  ///
  /// In es, this message translates to:
  /// **'Axiomas de orden y teoremas de los numeros reales'**
  String get axiomasDeOrdenYTeoremasReales;

  /// No description provided for @desigualdadesTeoremasDeOrden.
  ///
  /// In es, this message translates to:
  /// **'Desigualdades: teoremas de orden'**
  String get desigualdadesTeoremasDeOrden;

  /// No description provided for @conjuntosEIntervalos.
  ///
  /// In es, this message translates to:
  /// **'Conjuntos e intervalos'**
  String get conjuntosEIntervalos;

  /// No description provided for @valorAbsoluto.
  ///
  /// In es, this message translates to:
  /// **'Valor absoluto'**
  String get valorAbsoluto;

  /// No description provided for @seccionNumerosRealesYDesigualdades.
  ///
  /// In es, this message translates to:
  /// **'Números reales y desigualdades'**
  String get seccionNumerosRealesYDesigualdades;

  /// No description provided for @leyDeLaIluminacion.
  ///
  /// In es, this message translates to:
  /// **'Ley de la iluminación'**
  String get leyDeLaIluminacion;

  /// No description provided for @reflexionYAumentoFormaNewtoniana.
  ///
  /// In es, this message translates to:
  /// **'Reflexión y aumento de la imagen (forma Newtoniana)'**
  String get reflexionYAumentoFormaNewtoniana;

  /// No description provided for @ecuacionDeLasLentesFormaGaussiana.
  ///
  /// In es, this message translates to:
  /// **'Ecuación de las lentes (forma Gaussiana)'**
  String get ecuacionDeLasLentesFormaGaussiana;

  /// No description provided for @refraccionDeLaLuzLeyDeSnell.
  ///
  /// In es, this message translates to:
  /// **'Refracción de la luz (ley de Snell)'**
  String get refraccionDeLaLuzLeyDeSnell;

  /// No description provided for @tiposDeLentesYMarchaDeRayos.
  ///
  /// In es, this message translates to:
  /// **'Tipos de lentes y marcha de rayos'**
  String get tiposDeLentesYMarchaDeRayos;

  /// No description provided for @seccionOptica.
  ///
  /// In es, this message translates to:
  /// **'Óptica'**
  String get seccionOptica;

  /// No description provided for @axiomasDeProbabilidad.
  ///
  /// In es, this message translates to:
  /// **'Axiomas de probabilidad y probabilidad condicional'**
  String get axiomasDeProbabilidad;

  /// No description provided for @funcionesDeMasaDensidadYAcumulada.
  ///
  /// In es, this message translates to:
  /// **'Funciones de masa, densidad y distribucion acumulada'**
  String get funcionesDeMasaDensidadYAcumulada;

  /// No description provided for @funcionesDeProbabilidadConjuntasYCondicionales.
  ///
  /// In es, this message translates to:
  /// **'Funciones de probabilidad conjuntas y condicionales'**
  String get funcionesDeProbabilidadConjuntasYCondicionales;

  /// No description provided for @esperanzaMediaYVarianza.
  ///
  /// In es, this message translates to:
  /// **'Esperanza, media y varianza'**
  String get esperanzaMediaYVarianza;

  /// No description provided for @distribucionesDistribucionDeBernoulli.
  ///
  /// In es, this message translates to:
  /// **'Distribucion de Bernoulli'**
  String get distribucionesDistribucionDeBernoulli;

  /// No description provided for @distribucionesDistribucionDePascal.
  ///
  /// In es, this message translates to:
  /// **'Distribucion de Pascal (binomial negativa)'**
  String get distribucionesDistribucionDePascal;

  /// No description provided for @distribucionesDistribucionBeta.
  ///
  /// In es, this message translates to:
  /// **'Distribucion Beta'**
  String get distribucionesDistribucionBeta;

  /// No description provided for @distribucionesDistribucionDeCauchy.
  ///
  /// In es, this message translates to:
  /// **'Distribucion de Cauchy'**
  String get distribucionesDistribucionDeCauchy;

  /// No description provided for @distribucionesDistribucionDeErlang.
  ///
  /// In es, this message translates to:
  /// **'Distribucion de Erlang'**
  String get distribucionesDistribucionDeErlang;

  /// No description provided for @distribucionesDistribucionUniforme.
  ///
  /// In es, this message translates to:
  /// **'Distribucion uniforme (continua)'**
  String get distribucionesDistribucionUniforme;

  /// No description provided for @regresionLineal.
  ///
  /// In es, this message translates to:
  /// **'Regresion lineal y correlacion'**
  String get regresionLineal;

  /// No description provided for @desigualdadDeChebyshevYConvergencia.
  ///
  /// In es, this message translates to:
  /// **'Desigualdad de Chebyshev y convergencia estocastica'**
  String get desigualdadDeChebyshevYConvergencia;

  /// No description provided for @transferenciaDeCalor.
  ///
  /// In es, this message translates to:
  /// **'Transferencia de calor'**
  String get transferenciaDeCalor;

  /// No description provided for @capacidadCalorificaYCalorLatente.
  ///
  /// In es, this message translates to:
  /// **'Capacidad calorifica y calor latente'**
  String get capacidadCalorificaYCalorLatente;

  /// No description provided for @leyesDeLosGases.
  ///
  /// In es, this message translates to:
  /// **'Leyes de los gases'**
  String get leyesDeLosGases;

  /// No description provided for @cicloDeCarnotYLeyesDeLaTermodinamica.
  ///
  /// In es, this message translates to:
  /// **'Ciclo de Carnot y leyes de la termodinamica'**
  String get cicloDeCarnotYLeyesDeLaTermodinamica;

  /// No description provided for @trabajoTermodinamico.
  ///
  /// In es, this message translates to:
  /// **'Trabajo termodinamico'**
  String get trabajoTermodinamico;

  /// No description provided for @entalpiaYEnergiaInterna.
  ///
  /// In es, this message translates to:
  /// **'Entalpia y energia interna'**
  String get entalpiaYEnergiaInterna;

  /// No description provided for @dilatacionLineal.
  ///
  /// In es, this message translates to:
  /// **'Dilatacion lineal'**
  String get dilatacionLineal;

  /// No description provided for @dilatacionSuperficialYVolumetrica.
  ///
  /// In es, this message translates to:
  /// **'Dilatacion superficial y volumetrica'**
  String get dilatacionSuperficialYVolumetrica;

  /// No description provided for @entropiaYTeoriaCinetica.
  ///
  /// In es, this message translates to:
  /// **'Entropia y teoria cinetica de los gases'**
  String get entropiaYTeoriaCinetica;

  /// No description provided for @procesosTermodinamicos.
  ///
  /// In es, this message translates to:
  /// **'Procesos termodinamicos'**
  String get procesosTermodinamicos;

  /// No description provided for @seccionTermodinamica.
  ///
  /// In es, this message translates to:
  /// **'Termodinámica'**
  String get seccionTermodinamica;

  /// No description provided for @circuloUnitario.
  ///
  /// In es, this message translates to:
  /// **'Circulo unitario'**
  String get circuloUnitario;

  /// No description provided for @signosDeFuncionesPorCuadrante.
  ///
  /// In es, this message translates to:
  /// **'Signos de las funciones trigonometricas por cuadrante'**
  String get signosDeFuncionesPorCuadrante;

  /// No description provided for @angulosNotablesGradosRadianes.
  ///
  /// In es, this message translates to:
  /// **'Equivalencia de angulos notables: grados y radianes'**
  String get angulosNotablesGradosRadianes;

  /// No description provided for @relacionEntreFuncionesTrigonometricas.
  ///
  /// In es, this message translates to:
  /// **'Relacion entre funciones trigonometricas'**
  String get relacionEntreFuncionesTrigonometricas;

  /// No description provided for @identidadesDeAnguloTripleYCuadruple.
  ///
  /// In es, this message translates to:
  /// **'Identidades de angulo triple y cuadruple'**
  String get identidadesDeAnguloTripleYCuadruple;

  /// No description provided for @identidadesDeReduccionDePotencias.
  ///
  /// In es, this message translates to:
  /// **'Identidades de reduccion de potencias'**
  String get identidadesDeReduccionDePotencias;

  /// No description provided for @identidadesFundamentalesFormasDerivadas.
  ///
  /// In es, this message translates to:
  /// **'Identidades fundamentales: formas derivadas'**
  String get identidadesFundamentalesFormasDerivadas;

  /// No description provided for @cotangenteDeSumaYRestaDeAngulos.
  ///
  /// In es, this message translates to:
  /// **'Cotangente de la suma y resta de angulos'**
  String get cotangenteDeSumaYRestaDeAngulos;

  /// No description provided for @productoDeCosenoPorSeno.
  ///
  /// In es, this message translates to:
  /// **'Producto de coseno por seno (producto a suma)'**
  String get productoDeCosenoPorSeno;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
