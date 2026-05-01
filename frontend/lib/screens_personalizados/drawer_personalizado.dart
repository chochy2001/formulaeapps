import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';
import '../constantes/contantes_rutas.dart';

//Clase que sirve para añadir las distintas plataformas
class DrawerPersonalizado extends StatelessWidget {
  final int plataform;
  static const int widthFinal = 400;

  const DrawerPersonalizado(this.plataform, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (plataform) {
      //Android
      case 0:
        return Drawer(
          width: MediaQuery.of(context).size.width * 0.7,
          backgroundColor: kColorFondo,
          child: SafeArea(
            child: Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  bool isNarrow = constraints.maxWidth <=
                      widthFinal; // Establece el límite que consideras apropiado para el cambio de estilo del texto.
                  return ListView(
                    children: [
                      Column(children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                            bottom: 10.0,
                          ),
                          child: CapdesisLogo(height: 86.0, width: 86.0),
                        ),
                        Text(
                          AppLocalizations.of(context)!.formulaePro,
                          style: GoogleFonts.poppins(
                            textStyle: kTextoBotones,
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, kRutaPreguntasFrecuentes);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.question_mark_rounded,
                              color: kColorBlanco,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.preguntasFrecuentes,
                              maxLines: isNarrow ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextoBotonesDelgado,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, kRutaInformacion);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.info_outline_rounded,
                              color: kColorBlanco,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.informacion,
                              maxLines: isNarrow ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextoBotonesDelgado,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, kRutaConfiguracion);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.settings,
                              color: kColorBlanco,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.configuracion,
                              maxLines: isNarrow ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextoBotonesDelgado,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      const Divider(
                        color: kColorTextoBotones,
                        thickness: 0.2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      BotonRedSocial(
                        text: AppLocalizations.of(context)!.verApp,
                        icon: FontAwesomeIcons.googlePlay,
                        url: () {
                          openURLNuevo(
                              'https://play.google.com/store/apps/details?id=com.capdesis.formulae_pro.formulae_calculo_pro');
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                              '${AppLocalizations.of(context)!.descargaApp} $kURLFormulae');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.share,
                              color: kColorBlanco,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.compartirApp,
                              maxLines: isNarrow ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextoBotonesDelgado,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      const Divider(
                        color: kColorTextoBotones,
                        thickness: 0.2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      BotonRedSocial(
                        text: "Facebook",
                        icon: FontAwesomeIcons.facebookF,
                        url: () {
                          openURLNuevo(kFacebookFormulae);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      BotonRedSocial(
                        text: "Instagram",
//create a instagram icon
                        icon: FontAwesomeIcons.instagram,
                        url: () {
                          openURLNuevo(kInstagramFormulae);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      BotonRedSocial(
                        text: AppLocalizations.of(context)!.paginaWeb,

                        icon: FontAwesomeIcons.firefoxBrowser,
//icon: FontAwesomeIcons.chrome,
                        url: () {
                          openURLNuevo(kPaginaWebFormulae);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      const Divider(
                        color: kColorTextoBotones,
                        thickness: 0.2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      BotonRedSocial(
                        text: AppLocalizations.of(context)!.mejorarApp,
                        icon: FontAwesomeIcons.lightbulb,
                        url: () {
                          openURLNuevo1(context, kWidgetMejorarApp);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      //IOS
      case 1:
        return Drawer(
          width: MediaQuery.of(context).size.width * 0.7,
          backgroundColor: kColorFondo,
          child: SafeArea(
            child: Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  bool isNarrow = constraints.maxWidth <=
                      DrawerPersonalizado
                          .widthFinal; // Establece el límite que consideras apropiado para el cambio de estilo del texto.

                  return ListView(
                    children: [
                      Column(children: [
                        const CapdesisLogo(height: 86.0, width: 86.0),
                        Text(
                          AppLocalizations.of(context)!.formulaePro,
                          style: GoogleFonts.poppins(
                            textStyle: kTextoBotones,
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, kRutaPreguntasFrecuentes);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.question_mark_rounded,
                              color: kColorBlanco,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.preguntasFrecuentes,
                              maxLines: isNarrow ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextoBotonesDelgado,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, kRutaInformacion);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.info_outline_rounded,
                              color: kColorBlanco,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.informacion,
                              maxLines: isNarrow ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextoBotonesDelgado,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, kRutaConfiguracion);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.settings,
                              color: kColorBlanco,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.configuracion,
                              maxLines: isNarrow ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextoBotonesDelgado,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      const Divider(
                        color: kColorTextoBotones,
                        thickness: 0.2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      BotonRedSocial(
                        text: AppLocalizations.of(context)!.verApp,
                        //create a instagram icon
                        icon: FontAwesomeIcons.appStore,
                        url: () {
                          openURLNuevo(
                              'https://apps.apple.com/us/app/formulae-pro/id1666691016');
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                              '${AppLocalizations.of(context)!.descargaApp} $kURLFormulae');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.share,
                              color: kColorBlanco,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              AppLocalizations.of(context)!.compartirApp,
                              maxLines: isNarrow ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextoBotonesDelgado,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      const Divider(
                        color: kColorTextoBotones,
                        thickness: 0.2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      BotonRedSocial(
                        text: "Facebook",
                        icon: FontAwesomeIcons.facebookF,
                        url: () {
                          openURLNuevo(kFacebookFormulae);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      BotonRedSocial(
                        text: "Instagram",
                        //create a instagram icon
                        icon: FontAwesomeIcons.instagram,
                        url: () {
                          openURLNuevo(kInstagramFormulae);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      BotonRedSocial(
                        text: AppLocalizations.of(context)!.paginaWeb,

                        icon: FontAwesomeIcons.firefoxBrowser,
                        //icon: FontAwesomeIcons.chrome,
                        url: () {
                          openURLNuevo(kPaginaWebFormulae);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      const Divider(
                        color: kColorTextoBotones,
                        thickness: 0.2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      BotonRedSocial(
                        text: AppLocalizations.of(context)!.mejorarApp,
                        icon: FontAwesomeIcons.lightbulb,
                        url: () {
                          openURLNuevo1(context, kWidgetMejorarApp);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      default:
        return Material(
          elevation: 8,
          child: Drawer(
            width: MediaQuery.of(context).size.width * 0.7,
            backgroundColor: kColorFondo,
            child: SafeArea(
              child: Center(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    bool isNarrow = constraints.maxWidth <=
                        DrawerPersonalizado
                            .widthFinal; // Establece el límite que consideras apropiado para el cambio de estilo del texto.

                    return ListView(
                      children: [
                        Column(children: [
                          const CapdesisLogo(height: 86.0, width: 86.0),
                          Text(
                            AppLocalizations.of(context)!.formulaePro,
                            style: GoogleFonts.poppins(
                              textStyle: kTextoBotones,
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onHover: (event) {
                            // Aquí puedes cambiar el estado de tu botón a "hovered"
                          },
                          onExit: (event) {
                            // Aquí puedes cambiar el estado de tu botón a "not hovered"
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, kRutaPreguntasFrecuentes);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(
                                  Icons.question_mark_rounded,
                                  color: kColorBlanco,
                                  size: 30.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .preguntasFrecuentes,
                                  maxLines: isNarrow ? 2 : 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextoBotonesDelgado,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, kRutaInformacion);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.info_outline_rounded,
                                color: kColorBlanco,
                                size: 30.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                AppLocalizations.of(context)!.informacion,
                                maxLines: isNarrow ? 2 : 1,
                                overflow: TextOverflow.ellipsis,
                                style: kTextoBotonesDelgado,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, kRutaConfiguracion);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.settings,
                                color: kColorBlanco,
                                size: 30.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                AppLocalizations.of(context)!.configuracion,
                                maxLines: isNarrow ? 2 : 1,
                                overflow: TextOverflow.ellipsis,
                                style: kTextoBotonesDelgado,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        const Divider(
                          color: kColorTextoBotones,
                          thickness: 0.2,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        BotonRedSocial(
                          text: AppLocalizations.of(context)!.verApp,
//create a instagram icon
                          icon: FontAwesomeIcons.microsoft,
                          url: () {
                            openURLNuevo(
                                'https://www.microsoft.com/store/productId/9PLJZVDNGWZL');
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Share.share(
                                '${AppLocalizations.of(context)!.descargaApp} $kURLFormulae');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.share,
                                color: kColorBlanco,
                                size: 30.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                AppLocalizations.of(context)!.compartirApp,
                                maxLines: isNarrow ? 2 : 1,
                                overflow: TextOverflow.ellipsis,
                                style: kTextoBotonesDelgado,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        const Divider(
                          color: kColorTextoBotones,
                          thickness: 0.2,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        BotonRedSocial(
                          text: "Facebook",
                          icon: FontAwesomeIcons.facebookF,
                          url: () {
                            openURLNuevo(kFacebookFormulae);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        BotonRedSocial(
                          text: "Instagram",
//create a instagram icon
                          icon: FontAwesomeIcons.instagram,
                          url: () {
                            openURLNuevo(kInstagramFormulae);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        BotonRedSocial(
                          text: AppLocalizations.of(context)!.paginaWeb,

                          icon: FontAwesomeIcons.firefoxBrowser,
//icon: FontAwesomeIcons.chrome,
                          url: () {
                            openURLNuevo(kPaginaWebFormulae);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        const Divider(
                          color: kColorTextoBotones,
                          thickness: 0.2,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        BotonRedSocial(
                          text: AppLocalizations.of(context)!.mejorarApp,
                          icon: FontAwesomeIcons.lightbulb,
                          url: () {
                            openURLNuevo1(context, kWidgetMejorarApp);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
    }
  }
}
