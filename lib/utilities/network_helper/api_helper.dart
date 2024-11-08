import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
class ApiHelper {
  static const baseUrl = "https://fake-store-api.mock.beeceptor.com/api/";
  static const imageUrl = "https://images.unsplash.com/photo-1535303311164-664fc9ec6532?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

  static Future getApi(
      {path, bool isStaticToken = false}) async {
    Uri uri = Uri.parse(baseUrl + path);
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final response = await http.get(uri, headers: headers);
      if(response.body is List) return response.body;
      return tryDecode(response.body);
    } on SocketException catch (_) {
      Get.showSnackbar(const GetSnackBar(message: "Please check your connection"));
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> postApi({
    path,
    Map<String, dynamic>? args,
    bool isStaticToken = false,
    bool addBranchId = true,
  }) async {
    Uri uri = Uri.parse(baseUrl + path);
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map<String, dynamic> body = {};
    if (args != null) {
      args.forEach((key, value) {
        body[key] = value;
      });
    }
    try {
      String encodedBody = json.encode(body);
      final response = await http.post(
        uri,
        headers: headers,
        body: encodedBody,
      );
      return tryDecode(response.body);
    } on SocketException catch (_) {
      Get.showSnackbar(const GetSnackBar(message: "Please check your connection"));
      return null;
    } on TimeoutException catch (e, _) {
      return postApi(path: path, args: args, isStaticToken: isStaticToken);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> postApiWithFile(
      {path,
      Map args = const {},
      File? file,
      String apiMethod = "POST",
      String uploadArgument = "image"}) async {
    Uri uri = Uri.parse(baseUrl + path);
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      var request = http.MultipartRequest(apiMethod, uri);
      args.forEach((key, value) {
        if (key != "image") {
          request.fields[key] = "${value ?? ''}";
        }
      });
      request.headers.addAll(headers);
      try {
        if (file != null) {
          request.files.add(
            http.MultipartFile.fromBytes(
              uploadArgument,
              file.readAsBytesSync(),
              filename: basename(file.path),
            ),
          );
        }
      } catch (e, _) {
        rethrow;
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      return tryDecode(response.body);
    } on SocketException catch (_) {
      Get.showSnackbar(const GetSnackBar(message: "Please check your connection"));
      return null;
    } catch (e, _) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> postApiWithFiles(
      {path,
      Map body = const {},
      required List<File> files,
      String uploadArgument = "image"}) async {
    Uri uri = Uri.parse(baseUrl + path);
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      var request = http.MultipartRequest("POST", uri);
      body.forEach((key, value) {
        if (key != "image") {
          request.fields[key] = "${value ?? ''}";
        }
      });
      request.headers.addAll(headers);
      try {
        for (int i = 0; i < files.length; i++) {
          final file = files[i];
          request.files.add(
            http.MultipartFile.fromBytes(
              uploadArgument,
              file.readAsBytesSync(),
              filename: basename(file.path),
            ),
          );
        }
      } catch (e, _) {
        rethrow;
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return tryDecode(response.body);
    } on SocketException catch (_) {
      Get.showSnackbar(const GetSnackBar(message: "Please check your connection"));
      return null;
    } catch (e) {
      return null;
    }
  }

  static dynamic tryDecode(data) {
    try {
      return jsonDecode(data);
    } catch (e) {
      return null;
    }
  }
}
