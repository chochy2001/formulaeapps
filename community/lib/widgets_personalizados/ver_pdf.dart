import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import '../../constantes/export_constantes.dart';
import '../constantes/contantes_mapa_pdfs.dart';
//Todo poner traducciones

bool isWebPlatform() {
  return kIsWeb;
}

class VerPDF extends StatefulWidget {
  final String url;

  const VerPDF({Key? key, required this.url}) : super(key: key);

  @override
  State<VerPDF> createState() => _VerPDFState();
}

class _VerPDFState extends State<VerPDF> {
  static final AdRequest request = AdMobConfig.defaultRequest;

  static const int maxFailedLoadAttempts = 3;

  late BannerAd myBanner;
  late InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    myBanner = BannerAd(
      adUnitId: AdMobConfig.bannerAdUnitId,
      size: AdSize.banner,
      request: AdMobConfig.defaultRequest,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            // Update adContainer with the correct width and height.
            adContainer = Container(
              alignment: Alignment.center,
              child: AdWidget(ad: myBanner),
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
            );
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
    myBanner.load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobConfig.interstitialAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd?.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }

  Container adContainer = Container(
    alignment: Alignment.center,
    child: SizedBox(
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? url_1 = getUrlPdfById(context, widget.url);
    //Todo poner la opcion que si no existe pdf no se muestre.
    if (url_1 == null || kIsWeb || widget.url == '') {
      return const SizedBox.shrink();
    }
    return TextButton(
      onPressed: () {
        _showInterstitialAd();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerPDFNuevo(
              pdfUrl: url_1,
            ),
          ),
        );
      },
      child: Container(
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
            const SizedBox(height: 10.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.verPDF,
                  style: kTextoBotones,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

class DescargarPDF extends StatefulWidget {
  final String url;

  const DescargarPDF({Key? key, required this.url}) : super(key: key);

  @override
  State<DescargarPDF> createState() => _DescargarPDFState();
}

class _DescargarPDFState extends State<DescargarPDF> {
  static final AdRequest request = AdMobConfig.defaultRequest;

  static const int maxFailedLoadAttempts = 3;

  late BannerAd myBanner;
  late InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    myBanner = BannerAd(
      adUnitId: AdMobConfig.bannerAdUnitId,
      size: AdSize.banner,
      request: AdMobConfig.defaultRequest,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            // Update adContainer with the correct width and height.
            adContainer = Container(
              alignment: Alignment.center,
              child: AdWidget(ad: myBanner),
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
            );
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
    myBanner.load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobConfig.interstitialAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd?.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }

  Container adContainer = Container(
    alignment: Alignment.center,
    child: SizedBox(
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? url_1 = getUrlPdfById(context, widget.url);

    if (url_1 == null) {
      return const SizedBox.shrink();
    }
    return TextButton(
      onPressed: () {
        _showInterstitialAd();
        openURL(url_1);
      },
      child: Container(
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
            const SizedBox(height: 10.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.descargarImprimirPDF,
                  style: kTextoBotones,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

class VerPDFNuevo extends StatefulWidget {
  final String pdfUrl;

  const VerPDFNuevo({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  VerPDFNuevoState createState() => VerPDFNuevoState();
}

class VerPDFNuevoState extends State<VerPDFNuevo> {
  Uint8List? _pdfData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _downloadPDF(widget.pdfUrl).then((data) {
      setState(() {
        _pdfData = data;
      });
    }).catchError((error) {
      setState(() {
        _errorMessage = error.toString();
      });
    });
  }

  Future<Uint8List> _downloadPDF(String url) async {
    try {
      final effectiveUrl = isWebPlatform() ? getCorsProxyUrl(url) : url;
      final response = await http.get(
        Uri.parse(effectiveUrl),
        headers: isWebPlatform() ? {'origin': 'localhost'} : {},
      );
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception(
            'Error al descargar el archivo PDF: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al descargar el archivo PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulae PDF'),
      ),
      body: _pdfData == null
          ? _errorMessage == null
              ? const Center(child: CircularProgressIndicator())
              //todo poner texto en multiples lenguajes
              : Center(child: Text('Error al cargar el PDF: $_errorMessage'))
          : SfPdfViewer.memory(_pdfData!),
    );
  }

  String getCorsProxyUrl(String pdfUrl) {
    const proxyUrl = 'https://cors-anywhere.herokuapp.com/';
    return '$proxyUrl$pdfUrl';
  }
}
