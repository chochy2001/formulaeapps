import 'dart:io' as io;
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> downloadFavoritePdf(Uint8List bytes, String fileName) async {
  final output = await getTemporaryDirectory();
  final file = io.File('${output.path}/$fileName');
  await file.writeAsBytes(bytes, flush: true);

  await Share.shareXFiles(
    [XFile(file.path, mimeType: 'application/pdf')],
    subject: fileName,
  );
}
