import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import 'package:jiffy/jiffy.dart';

/*

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    // write your logic here
  });

 */

class Ajax {
  static final Ajax ajax = Ajax._internal();

  Ajax._internal();

  String _baseUrl = "";
  String token = "";

  static Ajax getInstance() {
    // ajax.setBaseUrl("http://tracker.io/dn/api/");
    ajax.setBaseUrl("https://www.emstum.com/bot/dn/core/api/");
    // ajax.setBaseUrl("http://192.168.0.102:5000/core/api/");
    return ajax;
  }

  void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  String get getBaseUrl {
    return _baseUrl;
  }

  Map<String, String> postHeader() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    };
  }

  static dynamic getResponseResult(dynamic data) {
    dynamic response = {};
    try {
      if (data == null) {
        throw Exception("User authentication is invalid");
      }

      response = data["ResponseBody"];
      if (response == null) {
        throw Exception("User authentication is invalid");
      }
      // ignore: empty_catches
    } on Exception catch (e) {
      rethrow;
    }

    return response;
  }

  static String convertToServerDateTime(DateTime date) {
    if (date != null && date != "") {
      return Jiffy(date, "yyyy-MM-dd").format();
    }

    Fluttertoast.showToast(msg: "Invalid date format");
    throw Exception("Invalid date format.");
  }

  dynamic validateResponse(Response response) {
    dynamic json = {};
    switch (response.statusCode) {
      case 200:
        try {
          json = jsonDecode(response.body);
          int code = json["HttpStatusCode"];
          switch (code) {
            case 400:
              Fluttertoast.showToast(msg: json["HttpStatusMessage"]);
              break;
            default:
              break;
          }
        } on Exception catch (e) {
          debugPrint('Exception: + $e');
        }
        break;
      case 400:
        Fluttertoast.showToast(
            msg: "Got server error. Please contact to admin.");
        break;
      case 401:
        Fluttertoast.showToast(
            msg: "Your session expired. Please login again.");
        break;
      case 500:
        Fluttertoast.showToast(msg: "Server error. Please contact to admin.");
        break;
      default:
        break;
    }

    return json;
  }

  dynamic validateLoginResponse(String jsonData) {
    dynamic json = jsonDecode(jsonData);
    dynamic response = {};
    try {
      response = json["ResponseBody"];
      if (json["HttpStatusCode"] == 200 && response["UserDetail"] != null) {
        token = response["UserDetail"]["Token"];
      } else {
        throw Exception("User authentication is invalid");
      }
      // ignore: empty_catches
    } on Exception catch (e) {
      rethrow;
    }

    return json;
  }

  Future<dynamic> login(String url, dynamic data) async {
    debugPrint('Url: $getBaseUrl$url, Request: ${json.encode(data)}');
    try {
      var apiUrl = Uri.parse(getBaseUrl + url);
      http.Response response = await http.post(
        apiUrl,
        body: json.encode(data),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'companycode': 'BOT-03',
          'Authorization': 'Bearer null'
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Response: ${response.body}');
        return validateLoginResponse(response.body);
      } else {
        debugPrint('Response: ${response.body}');
        throw Exception("Invalid username or password");
      }
    } catch (e) {
      debugPrint('Login failed: $e');
      Fluttertoast.showToast(
          msg: "Invalid username or password", timeInSecForIosWeb: 10);
      rethrow;
    }
  }

  Future<dynamic> post(String url, dynamic data) async {
    debugPrint('Url: $getBaseUrl$url, Request: ${json.encode(data)}');
    try {
      var apiUrl = Uri.parse(getBaseUrl + url);
      http.Response response = await http.post(
        apiUrl,
        body: json.encode(data),
        headers: postHeader(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Response: ${response.body}');
        var jsonResult = validateResponse(response);
        return getResponseResult(jsonResult);
      } else {
        debugPrint('Get request failed: $response');
        return null;
      }
    } catch (e) {
      debugPrint('Post request failed. $e');
      return null;
    }
  }

  Future<dynamic> put(String url, dynamic data) async {
    debugPrint('Url: $getBaseUrl$url, Request: ${json.encode(data)}');
    try {
      var apiUrl = Uri.parse(getBaseUrl + url);
      http.Response response = await http.put(
        apiUrl,
        body: json.encode(data),
        headers: postHeader(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Response: ${response.body}');
        var jsonResult = validateResponse(response);
        return getResponseResult(jsonResult);
      } else {
        debugPrint('Get request failed: $response');
        return null;
      }
    } catch (e) {
      debugPrint('Post request failed. $e');
      return null;
    }
  }

  Map<String, String> imageHeader() {
    return {
      'Content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    };
  }

  Future<dynamic> upload(String url, File? imageFile, dynamic data) async {
    var uri = Uri.parse("$_baseUrl$url");
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(imageHeader());

    request.fields['leave'] = jsonEncode(data);
    request.fields['fileDetail'] = jsonEncode(List.empty());
    if (imageFile != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'file', imageFile.readAsBytesSync(),
          filename: imageFile.path));
    }

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResult = jsonDecode(respStr);
    var result = getResponseResult(jsonResult);

    switch (response.statusCode) {
      case 500:
        Fluttertoast.showToast(
            msg: "Fail to apply leave, please contact to admin");
        break;
      case 400:
        if (result["UserMessage"] != null &&
            result["UserMessage"].toString().isNotEmpty) {
          Fluttertoast.showToast(msg: result["UserMessage"]);
        } else if (result["InnerMessage"] != null &&
            result["InnerMessage"].toString().isNotEmpty) {
          Fluttertoast.showToast(msg: result["InnerMessage"]);
        } else {
          Fluttertoast.showToast(
              msg: "Fail to apply leave, please contact to admin");
        }
        break;
      default:
        break;
    }

    return result;
  }

  Future<String?> get(String url) async {
    try {
      var apiUrl = Uri.parse(getBaseUrl + url);
      http.Response response = await http.get(apiUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Response: ${response.body}');
        var jsonResult = validateResponse(response);
        return getResponseResult(jsonResult);
      } else {
        debugPrint('Get request failed: $response');
        return null;
      }
    } catch (e) {
      debugPrint('Get request failed. $e');
      return null;
    }
  }
}
