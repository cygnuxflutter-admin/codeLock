import 'dart:io' as io;
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'backup_zip.dart';
import 'extract_zip.dart';

abstract class LoginCallBack {
  void loginDone(GoogleSignInAccount account);
}

class DriveBackUP {
  /// LoginCallBack? loginCallBack;

  void backup({
    required void Function() done,
    required void Function(Object err) error,
  }) async {
    GoogleSignInAccount? account = await _signInGoogle();
    if (account == null) return;
    await createZipFile();
    drive.DriveApi? driveApi = await _getDriveApi(account);
    if (driveApi == null) return;
    Directory directory = await getApplicationDocumentsDirectory();
    String file = join(directory.path, 'backup.zip');
    try {
      await _uploadDriveFile(
        driveApi: driveApi,
        file: File(file),
      );
      done();
    } catch (exception, stack) {
      error(exception);
      throw [exception, stack];
    }
  }

  void restore({required void Function() done,required String id}) async {
    GoogleSignInAccount? account = await _signInGoogle();
    if (account == null) return;
    drive.DriveApi? driveApi = await _getDriveApi(account);
    if (driveApi == null) return;
    await _getDriveFile(driveApi, id).then((value) async {
      if (value == null) return;
      Directory directory = await getApplicationDocumentsDirectory();
      String file = join(directory.path, 'restore.zip');
      File fileExist = File(file);
      if (await fileExist.exists()) {
        await fileExist.delete();
      }
      await _restoreDriveFile(
        driveApi: driveApi,
        driveFile: value,
        targetLocalPath: file,
      );
      await extractZipFile();
      done();
    });
  }

  Future<List<drive.File>> getAll() async {
    GoogleSignInAccount? account = await _signInGoogle();
    if (account == null) return [];
    drive.DriveApi? driveApi = await _getDriveApi(account);
    if (driveApi == null) return [];
    List<drive.File>? files = await _getAllDriveBackup(driveApi);
    if (files == null) return [];
    return files;
  }

  Future<void> deleteFile(String id) async {
    GoogleSignInAccount? account = await _signInGoogle();
    if (account == null) return;
    drive.DriveApi? driveApi = await _getDriveApi(account);
    if (driveApi == null) return;
    await _deleteDriveFile(driveApi, id);
  }

  void signOut() async => await _signOut();

  /// sign in with google
  Future<GoogleSignInAccount?> _signInGoogle() async {
    GoogleSignInAccount? googleUser;

    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          drive.DriveApi.driveAppdataScope,
        ],
      );

      googleUser =
          await googleSignIn.signInSilently() ?? await googleSignIn.signIn();
      if (googleUser != null) {
        ///loginCallBack?.loginDone(googleUser);
      }
    } catch (exception, stack) {
      throw [exception, stack];
    }
    return googleUser;
  }

  ///sign out from google
  Future<void> _signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  ///get google drive client
  Future<drive.DriveApi?> _getDriveApi(GoogleSignInAccount googleUser) async {
    drive.DriveApi? driveApi;
    try {
      Map<String, String> headers = await googleUser.authHeaders;
      GoogleAuthClient client = GoogleAuthClient(headers);
      driveApi = drive.DriveApi(client);
    } catch (exception, stack) {
      throw [exception, stack];
    }
    return driveApi;
  }

  /// upload file to google drive
  Future<drive.File?> _uploadDriveFile({
    required drive.DriveApi driveApi,
    required io.File file,
    String? driveFileId,
  }) async {
    try {
      drive.File fileMetadata = drive.File();
      fileMetadata.name = path.basename(file.absolute.path);

      late drive.File response;
      if (driveFileId != null) {
        /// [driveFileId] not null means we want to update existing file
        response = await driveApi.files.update(
          fileMetadata,
          driveFileId,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
        );
      } else {
        /// [driveFileId] is null means we want to create new file
        fileMetadata.parents = ['appDataFolder'];
        response = await driveApi.files.create(
          fileMetadata,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
        );
      }
      return response;
    } catch (exception, stack) {
      throw [exception, stack];
    }
  }

  /// download file from google drive
  Future<io.File?> _restoreDriveFile({
    required drive.DriveApi driveApi,
    required drive.File driveFile,
    required String targetLocalPath,
  }) async {
    try {
      drive.Media media = await driveApi.files.get(driveFile.id!,
          downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

      List<int> dataStore = <int>[];

      await media.stream.forEach((element) {
        dataStore.addAll(element);
      });

      io.File file = io.File(targetLocalPath);
      file.writeAsBytesSync(dataStore);

      return file;
    } catch (exception, stack) {
      throw [exception, stack];
    }
  }

  /// get drive file info
  Future<drive.File?> _getDriveFile(
      drive.DriveApi driveApi, String id) async {
    try {
      drive.FileList fileList = await driveApi.files.list(
          spaces: 'appDataFolder', $fields: 'files(id, name, modifiedTime)');
      List<drive.File>? files = fileList.files;
      drive.File? driveFile =
          files?.firstWhere((element) => element.id == id);
      return driveFile;
    } catch (exception, stack) {
      throw [exception, stack];
    }
  }

  /// get drive backup File info
  Future<List<drive.File>?> _getAllDriveBackup(drive.DriveApi driveApi) async {
    try {
      drive.FileList fileList = await driveApi.files.list(
          spaces: 'appDataFolder',
          $fields:
              'files(id, name, modifiedTime,mimeType,isAppAuthorized,fileExtension,md5Checksum,owners,permissions,createdTime,size)');
      List<drive.File>? files = fileList.files;
      return files;
    } catch (exception, stack) {
      throw [exception, stack];
    }
  }

  Future<void> _deleteDriveFile(drive.DriveApi driveApi, String id) async {
    try {
      await driveApi.files.delete(id);
    } catch (exception, stack) {
      throw [exception, stack];
    }
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
