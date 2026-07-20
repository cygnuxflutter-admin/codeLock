import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> createZipFile() async {
  final appDir = await getApplicationDocumentsDirectory();
  final folder1Path = '${appDir.path}/app_data';
  final file2Path = '${appDir.path}/app_data/Pocket.sqlite';
  final zipFilePath = '${appDir.path}/backup.zip';


  final archive = Archive();

  await addFilesToArchive(archive, folder1Path);
  await addFileToArchive(archive, file2Path, 'Pocket.sqlite');

  final zipFile = File(zipFilePath);
  final zipFileBytes = ZipEncoder().encode(archive);

  await zipFile.writeAsBytes(zipFileBytes!);

  print('Zip file created successfully.');
}

Future<void> addFilesToArchive(Archive archive, String sourceDir) async {
  final directory = Directory(sourceDir);
  final files = directory.listSync(recursive: true);

  for (var file in files) {
    if (file is File) {
      final filePath = file.path;
      final fileContent = await file.readAsBytes();
      final zipFileName = filePath.substring(sourceDir.length + 1);

      archive.addFile(ArchiveFile(zipFileName, fileContent.length, fileContent));
    }
  }
}

Future<void> addFileToArchive(Archive archive, String filePath, String zipFileName) async {
  final file = File(filePath);
  final fileContent = await file.readAsBytes();

  archive.addFile(ArchiveFile(zipFileName, fileContent.length, fileContent));
}

void main() async {
  await createZipFile();
}
