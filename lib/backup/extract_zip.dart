import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> extractZipFile() async {
  final appDir = await getApplicationDocumentsDirectory();
  final zipFilePath = '${appDir.path}/restore.zip';
  final extractionPath = '${appDir.path}/app_data';

  final zipFile = File(zipFilePath);

  if (!zipFile.existsSync()) {
    print('Zip file does not exist.');
    return;
  }

  final List<int> zipFileBytes = await zipFile.readAsBytes();
  final Archive archive = ZipDecoder().decodeBytes(zipFileBytes);

  for (final file in archive) {
    final zipFileName = file.name;
    final extractedFilePath = '${extractionPath}/${zipFileName}';

    if (file.isFile) {
      final List<int> fileData = file.content as List<int>;
      final extractedFile = File(extractedFilePath);
      await extractedFile.create(recursive: true);
      await extractedFile.writeAsBytes(fileData);
    } else {
      final extractedDir = Directory(extractedFilePath);
      await extractedDir.create(recursive: true);
    }
  }

  print('Zip file extracted successfully.');
}

void main() async {
  await extractZipFile();
}
