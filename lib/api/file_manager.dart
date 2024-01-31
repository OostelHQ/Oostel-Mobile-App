import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:file_picker/file_picker.dart' show FileType;

class FileManager {
  static Future<void> saveAuthDetails(Map<String, String>? auth) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString(
        "fynda_user_email", auth == null ? "" : auth["emailAddress"]!);
    await instance.setString(
        "fynda_user_password", auth == null ? "" : auth["password"]!);
  }

  static Future<Map<String, String>?> loadAuthDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("fynda_user_email");
    String? password = instance.getString("fynda_user_password");

    if (email == null || password == null || email.isEmpty || password.isEmpty) {
      return null;
    }
    return {"emailAddress": email, "password": password};
  }

  static Future<void> save(String key, String value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString(key, value);
  }

  static Future<String?> load(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString(key);
  }

  static Future<void> saveBool(String key, bool value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setBool(key, value);
  }

  static Future<bool?> loadBool(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getBool(key);
  }

  static Future<void> saveInt(String key, int value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setInt(key, value);
  }

  static Future<int?> loadInt(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getInt(key);
  }

  static Future<void> saveDouble(String key, double value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setDouble(key, value);
  }

  static Future<double?> loadDouble(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getDouble(key);
  }

  static Future<void> saveStringList(String key, List<String> value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setStringList(key, value);
  }

  static Future<List<String>?> loadStringList(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getStringList(key);
  }

  static Future<List<Uint8List>> loadToBytes(
      {FileType type = FileType.custom}) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: type, allowMultiple: true);
    if (result != null) {
      List<Uint8List> data = [];
      List<File> files = result.paths.map((path) => File(path!)).toList();
      for (var file in files) {
        data.add(await file.readAsBytes());
      }
      return data;
    }
    return [];
  }

  static Future<List<Uint8List>> loadFilesAsBytes(List<String> extensions,
      {bool many = true}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: extensions,
        type: FileType.custom,
        allowMultiple: many);
    if (result != null) {
      List<Uint8List> data = [];
      List<File> files = result.paths.map((path) => File(path!)).toList();
      for (var file in files) {
        data.add(await file.readAsBytes());
      }
      return data;
    }
    return [];
  }

  static Future<String?> pickFile(String extension) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: [extension],
        type: FileType.custom,
        allowMultiple: false);
    if (result != null) {
      return result.files.single.path;
    }
    return null;
  }

  static Future<List<String?>> pickFiles(List<String> extensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: extensions,
        type: FileType.custom,
        allowMultiple: true);
    if (result != null) {
      return result.paths;
    }
    return [];
  }

  static Future<Uint8List> convertSingleToData(String path) async =>
      File(path).readAsBytes();

  static Future<List<Uint8List>> convertToData(List<String?> data) async {
    List<Uint8List> response = [];
    for (var path in data) {
      File f = File(path!);
      response.add(await f.readAsBytes());
    }
    return response;
  }

  static List<Uint8List> decodeToBytes(List<String> encodedData) {
    List<Uint8List> response = [];
    for (var data in encodedData) {
      response.add(base64.decode(data));
    }
    return response;
  }


  static String convertToBase64String(Uint8List data) => base64.encode(data);
  static Uint8List convertToUint8List(String data) => base64.decode(data);

  static Future<SingleFileResponse?> single(
      {List<String> extensions = const [],
      FileType type = FileType.custom}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: type == FileType.custom ? extensions : null,
      type: type,
      allowMultiple: false,
    );
    if (result != null) {
      SingleFileResponse response = await _convert(result.files.single);
      return response;
    }
    return null;
  }

  static Future<List<SingleFileResponse>> multiple(
      {List<String> extensions = const [],
      FileType type = FileType.custom}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: type == FileType.custom ? extensions : null,
      type: type,
      allowMultiple: true,
    );

    if (result != null) {
      List<SingleFileResponse> responses = [];
      List<PlatformFile> files = result.files;
      for (PlatformFile file in files) {
        SingleFileResponse response = await _convert(file);
        responses.add(response);
      }
      return responses;
    }

    return [];
  }

  static Future<SingleFileResponse> _convert(PlatformFile file) async {
    Uint8List data = await FileManager.convertSingleToData(file.path!);

    return SingleFileResponse(
      path: file.path!,
      extension: file.extension!,
      filename: file.name,
      data: data,
      size: data.lengthInBytes,
    );
  }

}

class SingleFileResponse {
  String path;
  String filename;
  String extension;
  int size;

  Uint8List data;

  SingleFileResponse({
    this.path = "",
    this.filename = "",
    this.extension = "",
    this.size = 0,
    required this.data
  });


  @override
  String toString() =>
      "{name: $filename, path: $path, extension: $extension, size: $size}";

  String get toBase64String => FileManager.convertToBase64String(data);


  factory SingleFileResponse.fromBase64String(String base64String) {
    Uint8List data = FileManager.convertToUint8List(base64String);
    //File file = File.fromRawPath(data);
    return SingleFileResponse(data: data);
  }


}
