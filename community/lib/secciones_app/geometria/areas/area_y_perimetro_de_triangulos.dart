import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class AreaYPerimetroDeTriangulos extends StatefulWidget {
  const AreaYPerimetroDeTriangulos({super.key});
  @override
  State<AreaYPerimetroDeTriangulos> createState() =>
      _AreaYPerimetroDeTriangulosState();
}

class _AreaYPerimetroDeTriangulosState
    extends State<AreaYPerimetroDeTriangulos> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
  }


  Widget get adContainer => _ads.banner;

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  double baseIsosceles = 0.0, alturaIsosceles = 0.0, ladoAIsosceles = 0.0;
  double baseEquilatero = 0.0, alturaEquilatero = 0.0, ladoEquilatero = 0.0;
  double baseEscaleno = 0.0,
      alturaEscaleno = 0.0,
      ladoAEscaleno = 0.0,
      ladoCEscaleno = 0.0;

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
                    AppLocalizations.of(context)!.areaPerimetroTriangulos,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .areaPerimetroTriangulos,
                            widgetName: kWidgetAreaYPerimetroDeTriangulos),
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
                                    title: AppLocalizations.of(context)!
                                        .areaPerimetroTriangulos,
                                    widgetName:
                                        kWidgetAreaYPerimetroDeTriangulos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .areaPerimetroTriangulos,
                                    widgetName:
                                        kWidgetAreaYPerimetroDeTriangulos),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.isosceles,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.area,
                      ),
                      const Latex(formulaText: r"\frac{bh}{2}"),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.perimetro,
                      ),
                      const Latex(formulaText: r"2a+b"),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
                  ),
                  const ZoomImagePersonalizado(urlImagen: kUrlImagenIsosceles),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            ladoAIsosceles = double.parse(valor);
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            baseIsosceles = double.parse(valor);
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            alturaIsosceles = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  _solucionIsoceles(
                      baseIsosceles, ladoAIsosceles, alturaIsosceles),
                  const SizedBox(height: kEspacioEntreBotones * 2),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.equilatero,
                  ),

                  const SizedBox(height: kEspacioEntreBotones),

                  TextoEcuaciones(
                    AppLocalizations.of(context)!.area,
                  ),
                  const Latex(formulaText: r"\frac{bh}{2}"),

                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.perimetro,
                  ),
                  const Latex(formulaText: r"3l"),

                  const SizedBox(height: kEspacioEntreBotones),
                  const ZoomImagePersonalizado(urlImagen: kUrlImagenEquilatero),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            alturaEquilatero = double.parse(valor);
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            baseEquilatero = double.parse(valor);
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            ladoEquilatero = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),

                  _solucionEquilatero(
                      baseEquilatero, ladoEquilatero, alturaEquilatero),
                  const SizedBox(height: kEspacioEntreBotones * 2),

                  TextoEcuaciones(
                    AppLocalizations.of(context)!.escaleno,
                  ),

                  const SizedBox(height: kEspacioEntreBotones),

                  TextoEcuaciones(
                    AppLocalizations.of(context)!.area,
                  ),
                  const Latex(formulaText: r"\frac{bh}{2}"),

                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.perimetro,
                  ),
                  const Latex(formulaText: r"a+b+c"),

                  const SizedBox(height: kEspacioEntreBotones),
                  const ZoomImagePersonalizado(urlImagen: kUrlImagenEscaleno),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            ladoCEscaleno = double.parse(valor);
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            ladoAEscaleno = double.parse(valor);
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            baseEscaleno = double.parse(valor);
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
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
                            alturaEscaleno = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  _solucionEscaleno(baseEscaleno, ladoAEscaleno, alturaEscaleno,
                      ladoCEscaleno),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetAreaYPerimetroDeTriangulos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetAreaYPerimetroDeTriangulos,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(
                        color: kColorFondo,
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.lado,
                        ),
                        const Latex(formulaText: r"l"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.base,
                        ),
                        const Latex(formulaText: r"b"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.altura,
                        ),
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

  Widget _solucionIsoceles(baseIsosceles, ladoAIsosceles, alturaIsosceles) {
    double areaIsosceles = (baseIsosceles * alturaIsosceles) / 2;
    num perimetroIsosceles = (2 * ladoAIsosceles) + baseIsosceles;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(
          width: 10.0,
          color: kColorFondo,
        ),
      ),
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.areaIsosceles}= ${implementFraction(areaIsosceles)}\n${AppLocalizations.of(context)!.perimetroIsosceles}= ${implementFraction(perimetroIsosceles)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }

  Widget _solucionEquilatero(baseEquilatero, ladoEquilatero, alturaEquilatero) {
    double areaEquilatero = (baseEquilatero * alturaEquilatero) / 2;
    num perimetroEquilatero = 3 * ladoEquilatero;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(
          width: 10.0,
          color: kColorFondo,
        ),
      ),
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.areaEquilatero}= ${implementFraction(areaEquilatero)}\n${AppLocalizations.of(context)!.perimetroEquilatero}= ${implementFraction(perimetroEquilatero)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }

  Widget _solucionEscaleno(
      baseEscaleno, ladoAEscaleno, alturaEscaleno, ladoCEscaleno) {
    double areaEscaleno = (baseEscaleno * alturaEscaleno) / 2;
    double perimetroEscaleno = ladoAEscaleno + ladoCEscaleno + baseEscaleno;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(
          width: 10.0,
          color: kColorFondo,
        ),
      ),
      child: ListTile(
        title: Text(
          '${AppLocalizations.of(context)!.areaEscaleno}= ${implementFraction(areaEscaleno)}\n${AppLocalizations.of(context)!.perimetroEscaleno}= ${implementFraction(perimetroEscaleno)}',
          style: kEstiloTextoMenus,
        ),
      ),
    );
  }
}
