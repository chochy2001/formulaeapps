import 'dart:io' as io;
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> downloadCommunityPdf(Uint8List bytes, String fileName) async {
  // Linux does not support Share.shareXFiles. Save directly to the user's
  // Downloads directory there, matching the working Formulae Pro behavior.
  final output = io.Platform.isLinux
      ? await getDownloadsDirectory() ??
            await getApplicationDocumentsDirectory()
      : await getTemporaryDirectory();
  final file = io.File('${output.path}/$fileName');
  await file.writeAsBytes(bytes, flush: true);

  if (io.Platform.isLinux) {
    return;
  }

  await SharePlus.instance.share(
    ShareParams(
      files: [XFile(file.path, mimeType: 'application/pdf')],
      subject: fileName,
    ),
  );
}
