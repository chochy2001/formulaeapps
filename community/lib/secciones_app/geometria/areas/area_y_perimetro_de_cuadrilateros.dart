import 'package:flutter/material.dart';
import 'dart:math';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class AreaYPerimetroDeCuadrilateros extends StatefulWidget {
  const AreaYPerimetroDeCuadrilateros({super.key});

  @override
  State<AreaYPerimetroDeCuadrilateros> createState() =>
      _AreaYPerimetroDeCuadrilaterosState();
}

class _AreaYPerimetroDeCuadrilaterosState
    extends State<AreaYPerimetroDeCuadrilateros> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(
      onBannerReady: () {
        if (mounted) setState(() {});
      },
    );
  }

  Widget get adContainer => _ads.banner;

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  double ladoCuadrado = 0.0;
  double alturaRectangulo = 0.0, baseRectangulo = 0.0;
  double baseMayorTrapecio = 0.0,
      baseMenorTrapecio = 0.0,
      alturaTrapecio = 0.0,
      ladoATrapecio = 0.0,
      ladoCTrapecio = 0.0;
  double baseParalelogramo = 0.0,
      alturaParalelogramo = 0.0,
      ladoAParalelogramo = 0.0;
  double diagonalMayorRombo = 0.0, diagonalMenorRombo = 0.0, ladoRombo = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.areaPerimetroCuadrilateros,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.areaPerimetroCuadrilateros,
                          widgetName: kWidgetAreaYPerimetroDeCuadrilateros,
                        ),
                      );
                      return IconButton(
                        icon: isFavorite
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border),
                        color: isFavorite ? Colors.white : Colors.white,
                        onPressed: () {
                          setState(() {
                            if (isFavorite) {
                              favoritesNotifier.removeFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.areaPerimetroCuadrilateros,
                                  widgetName:
                                      kWidgetAreaYPerimetroDeCuadrilateros,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.areaPerimetroCuadrilateros,
                                  widgetName:
                                      kWidgetAreaYPerimetroDeCuadrilateros,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.cuadrado),

                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.area),
                  const Latex(formulaText: r"l^2"),

                  const SizedBox(height: 10),
                  TextoEcuaciones(AppLocalizations.of(context)!.perimetro),
                  const Latex(formulaText: r"4l"),

                  const ZoomImagePersonalizado(urlImagen: kUrlImagenCuadrado),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.lado,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            ladoCuadrado = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  _solucionCuadrado(ladoCuadrado),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(AppLocalizations.of(context)!.rectangulo),

                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.area),
                  const Latex(formulaText: r"bh"),

                  const SizedBox(height: 10),
                  TextoEcuaciones(AppLocalizations.of(context)!.perimetro),
                  const Latex(formulaText: r"2b+2h"),

                  const ZoomImagePersonalizado(urlImagen: kUrlImagenRectangulo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.base,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            baseRectangulo = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.altura,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            alturaRectangulo = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  _solucionRectangulo(baseRectangulo, alturaRectangulo),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.trapecio),

                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.area),
                  const Latex(formulaText: r"\frac{(B+b)h}{2}"),

                  const SizedBox(height: 10),
                  TextoEcuaciones(AppLocalizations.of(context)!.perimetro),
                  const Latex(formulaText: r"a+b+c+B"),

                  const SizedBox(height: kEspacioEntreBotones),
                  const ZoomImagePersonalizado(urlImagen: kUrlImagenTrapecio),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.baseMayor,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            baseMayorTrapecio = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.baseMenor,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            baseMenorTrapecio = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.altura,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            alturaTrapecio = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.ladoA,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            ladoATrapecio = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.ladoC,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            ladoCTrapecio = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  _solucionTrapecio(
                    baseMayorTrapecio,
                    baseMenorTrapecio,
                    alturaTrapecio,
                    ladoATrapecio,
                    ladoCTrapecio,
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.paralelogramo),

                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.area),
                  const Latex(formulaText: r"bh"),

                  const SizedBox(height: 10),
                  TextoEcuaciones(AppLocalizations.of(context)!.perimetro),
                  const Latex(formulaText: r"2b+2a"),

                  const ZoomImagePersonalizado(urlImagen: kUrlImagenRomboide),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.ladoA,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            ladoAParalelogramo = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.base,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            baseParalelogramo = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.altura,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            alturaParalelogramo = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  _solucionParalelogramo(
                    baseParalelogramo,
                    alturaParalelogramo,
                    ladoAParalelogramo,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.rombo),

                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(AppLocalizations.of(context)!.area),
                  const Latex(formulaText: r"\frac{Dd}{2}"),

                  const SizedBox(height: 10),
                  TextoEcuaciones(AppLocalizations.of(context)!.perimetro),
                  const Latex(formulaText: r"4l"),

                  const SizedBox(height: kEspacioEntreBotones),
                  const ZoomImagePersonalizado(urlImagen: kUrlImagenRombo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(
                            context,
                          )!.diagonalMayor,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            diagonalMayorRombo = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(
                            context,
                          )!.diagonalMenor,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            diagonalMenorRombo = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: AppLocalizations.of(context)!.lado,
                        ),
                        onChanged: (valor) {
                          setState(() {
                            ladoRombo = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  _solucionRombo(
                    diagonalMayorRombo,
                    diagonalMenorRombo,
                    ladoRombo,
                  ),
                  const SizedBox(height: 20.0),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetAreaYPerimetroDeCuadrilateros),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetAreaYPerimetroDeCuadrilateros),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(color: kColorFondo, width: 8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(height: 10.0),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.lado),
                        const Latex(formulaText: r"l"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.base),
                        const Latex(formulaText: r"b"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.altura),
                        const Latex(formulaText: r"h"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _solucionCuadrado(ladoCuadrado) {
    num areaCuadrado = pow(ladoCuadrado, 2);
    num perimetroCuadrado = 4 * ladoCuadrado;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(width: 10.0, color: kColorFondo),
      ),
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.areaCuadrado} = ${implementFraction(areaCuadrado)}\n${AppLocalizations.of(context)!.perimetroCuadrado} = ${implementFraction(perimetroCuadrado)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }

  Widget _solucionRectangulo(baseRectangulo, alturaRectangulo) {
    double areaRectangulo = baseRectangulo * alturaRectangulo;
    num perimetroRectangulo = 2 * baseRectangulo + 2 * alturaRectangulo;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(width: 10.0, color: kColorFondo),
      ),
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.areaRectangulo}= ${implementFraction(areaRectangulo)}\n${AppLocalizations.of(context)!.perimetroRectangulo}= ${implementFraction(perimetroRectangulo)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }

  Widget _solucionTrapecio(
    baseMayorTrapecio,
    baseMenorTrapecio,
    alturaTrapecio,
    ladoATrapecio,
    ladoCTrapecio,
  ) {
    double areaTrapecio =
        ((baseMayorTrapecio + baseMenorTrapecio) * alturaTrapecio) / 2;
    double perimetroTrapecio =
        ladoCTrapecio + ladoATrapecio + baseMenorTrapecio + baseMayorTrapecio;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(width: 10.0, color: kColorFondo),
      ),
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.areaTrapecio}= ${implementFraction(areaTrapecio)}\n${AppLocalizations.of(context)!.perimetroTrapecio}= ${implementFraction(perimetroTrapecio)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }

  Widget _solucionParalelogramo(
    baseParalelogramo,
    alturaParalelogramo,
    ladoAParalelogramo,
  ) {
    double areaParalelogramo = baseParalelogramo * alturaParalelogramo;
    num perimetroParalelogramo =
        (2 * baseParalelogramo) + (2 * ladoAParalelogramo);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(width: 10.0, color: kColorFondo),
      ),
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.areaParalelogramo}= ${implementFraction(areaParalelogramo)}\n${AppLocalizations.of(context)!.perimetroParalelogramo}= ${implementFraction(perimetroParalelogramo)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }

  Widget _solucionRombo(diagonalMayorRombo, diagonalMenorRombo, ladoRombo) {
    double areaRombo = (diagonalMayorRombo * diagonalMenorRombo) / 2;
    num perimetroRombo = 4 * ladoRombo;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(width: 10.0, color: kColorFondo),
      ),
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.areaRombo}= ${implementFraction(areaRombo)}\n${AppLocalizations.of(context)!.perimetroRombo}= ${implementFraction(perimetroRombo)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }
}
