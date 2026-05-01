import 'package:flutter/cupertino.dart';

import '../screens_personalizados/configuracion.dart';
import 'export_constantes.dart';
import 'nombres_videos.dart';

Map<String, Map<String, String>> urlVideoMap = {
  //todo crear video que diga que por el momento no esta disponible el video en ingles
  //exponentes
  kVideoPropiedadesDeLosExponentes: {
    'es': kUrlVideoPropiedadesDeLosExponentes,
    'en': kUrlVideoPropiedadesDeLosExponentesIngles,
  },
  //Logaritmos
  kVideoPropiedadesLogaritmoIgualACero: {
    'es': kUrlVideoPropiedadesLogaritmoIgualACero,
    'en': '',
  },
  kVideoPropiedadesLogaritmoBaseDiez: {
    'es': kUrlVideoPropiedadesLogaritmoBaseDiez,
    'en': '',
  },
  kVideoPropiedadesLogaritmoDeUno: {
    'es': kUrlVideoPropiedadesLogaritmoDeUno,
    'en': '',
  },
  kVideoPropiedadesSumaLogaritmo: {
    'es': kUrlVideoPropiedadesSumaLogaritmo,
    'en': '',
  },
  kVideoPropiedadesRestaLogaritmo: {
    'es': kUrlVideoPropiedadesRestaLogaritmo,
    'en': '',
  },
  kVideoPropiedadesProductoLogaritmo: {
    'es': kUrlVideoPropiedadesProductoLogaritmo,
    'en': '',
  },
  kVideoPropiedadesCocienteLogaritmo: {
    'es': kUrlVideoPropiedadesCocienteLogaritmo,
    'en': '',
  },
  kVideoPropiedadesPotenciaLogaritmo: {
    'es': kUrlVideoPropiedadesPotenciaLogaritmo,
    'en': '',
  },
  kVideoPropiedadesLogaritmoNatural: {
    'es': kUrlVideoPropiedadesLogaritmoNatural,
    'en': '',
  },
  kVideoPropiedadesLogaritmoCambioDeBase: {
    'es': kUrlVideoPropiedadesLogaritmoCambioDeBase,
    'en': '',
  },
  kVideoPropiedadesLogaritmoRaiz: {
    'es': kUrlVideoPropiedadesLogaritmoRaiz,
    'en': '',
  },
  //Funciones Trigonometricas
  kVideoFuncionesTrigonometricas: {
    'es': kUrlVideoFuncionesTrigonometricas,
    'en': '',
  },
  //Identidades Trigonometricas
  kVideoIdentidadesPitagoricas: {
    'es': kUrlVideoIdentidadesPitagoricas,
    'en': '',
  },
  kVideoIdentidadesBasicas: {
    'es': kUrlVideoIdentidadesBasicas,
    'en': '',
  },
  kVideoIdentidadesReciprocas: {
    'es': kUrlVideoIdentidadesReciprocas,
    'en': '',
  },
  kVideoIdentidadesPorCociente: {
    'es': kUrlVideoIdentidadesPorCociente,
    'en': '',
  },
  kVideoIdentidadesParImpar: {
    'es': kUrlVideoIdentidadesParImpar,
    'en': '',
  },
  kVideoAngulosComplementariosSuplementarios: {
    'es': kUrlVideoAngulosComplementariosSuplementarios,
    'en': '',
  },
  //Derivacion Basica
  kVideoDerivadaDeUnaConstante: {
    'es': kUrlVideoDerivadaDeUnaConstante,
    'en': '',
  },
  kVideoDerivadaDeUnaVariable: {
    'es': kUrlVideoDerivadaDeUnaVariable,
    'en': '',
  },
  kVideoDerivadaDeUnaConstantePorVariable: {
    'es': kUrlVideoDerivadaDeUnaConstantePorVariable,
    'en': '',
  },
  kVideoDerivadaExponente: {
    'es': kUrlVideoDerivadaExponente,
    'en': '',
  },
  kVideoDerivadaConstantePorExponente: {
    'es': kUrlVideoDerivadaConstantePorExponente,
    'en': '',
  },
  kVideoDerivadaFuncionCompuestaConExponente: {
    'es': kUrlVideoDerivadaFuncionCompuestaConExponente,
    'en': '',
  },
  kVideoDerivadaDelProductoDeDosFuncionesCompuestas: {
    'es': kUrlVideoDerivadaDelProductoDeDosFuncionesCompuestas,
    'en': '',
  },
  kVideoDerivadaDelCocienteDeDosFuncionesCompuestas: {
    'es': kUrlVideoDerivadaDelCocienteDeDosFuncionesCompuestas,
    'en': '',
  },
  kVideoDerivadaDelProductoDeNFuncionesCompuestas: {
    'es': kUrlVideoDerivadaDelProductoDeNFuncionesCompuestas,
    'en': '',
  },
  kVideoDerivadaDeLaSumaDeFuncionesCompuestas: {
    'es': kUrlVideoDerivadaDeLaSumaDeFuncionesCompuestas,
    'en': '',
  },
  //Integracion Basica
  kVideoIntegralDeX: {
    'es': kUrlVideoIntegralDeX,
    'en': '',
  },
  kVideoIntegralDeConstantePorX: {
    'es': kUrlVideoIntegralDeConstantePorX,
    'en': '',
  },
  kVideoIntegralDeVariableConExponenteN: {
    'es': kUrlVideoIntegralDeVariableConExponenteN,
    'en': '',
  },
  kVideoIntegralDeVariableConExponenteMenosUno: {
    'es': kUrlVideoIntegralDeVariableConExponenteMenosUno,
    'en': '',
  },
  kVideoIntegralDeVariableConExponenteMenosN: {
    'es': kUrlVideoIntegralDeVariableConExponenteMenosN,
    'en': '',
  },
  kVideoIntegralDeUnCociente: {
    'es': kUrlVideoIntegralDeUnCociente,
    'en': '',
  },
  kVideoIntegralDeExponenteFraccionario: {
    'es': kUrlVideoIntegralDeExponenteFraccionario,
    'en': '',
  },
  kVideoIntegralDeSumaDeFunciones: {
    'es': kUrlVideoIntegralDeSumaDeFunciones,
    'en': '',
  },
  kVideoIntegralDeProductoConstanteYFuncion: {
    'es': kUrlVideoIntegralDeProductoConstanteYFuncion,
    'en': '',
  },
  kVideoIntegralPorPartes: {
    'es': kUrlVideoIntegralPorPartes,
    'en': '',
  },
};

String? getUrlVideoById(BuildContext context, String id) {
  Locale currentLocale =
      Provider.of<LocaleProvider>(context, listen: false).locale;
  return urlVideoMap[id]?[currentLocale.languageCode];
}
