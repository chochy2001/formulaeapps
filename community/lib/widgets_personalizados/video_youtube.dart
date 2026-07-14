import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constantes/export_constantes.dart';
import '../constantes/constantes_mapa_videos.dart';

class VideosYoutube extends StatelessWidget {
  final String videoId;

  const VideosYoutube(this.videoId, {super.key});

  @override
  Widget build(BuildContext context) {
    if (UniversalPlatform.isWeb || UniversalPlatform.isWindows) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.disponibilidadVideos,
          textAlign: TextAlign.center,
          style: kEstiloTextoMenus,
        ),
      );
    }

    String? urlVideo = getUrlVideoById(context, videoId);

    // Verificar si urlVideo es una cadena vacía
    if (urlVideo == '') {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.traduccionVideos,
          textAlign: TextAlign.center,
          style: kEstiloSubMenu, // Ajusta el estilo del texto como desees.
        ),
      );
    }

    return PhysicalModel(
      color: kColorTextoBotones,
      shadowColor: kColorTextoBotones,
      elevation: 10.0,
      child: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(urlVideo!)!,
        ),
        liveUIColor: kColorBotones,
      ),
    );
  }
}
