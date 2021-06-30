import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';

import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;

ValueNotifier<User> currentUser = new ValueNotifier(User());

Future<User> login(User user) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}login';
    print("email..${user.email}");
  final client = new http.Client();
  final response = await client.post(
    url,
   // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: {
        "number": user.phone,
        "password": user.password
      }
   // body: json.encode(user.toMap()),
  );
  print("JsonData...${json.encode(user.toMap())}");
  print("LoginResponse....${response.body}");
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<User> register(User user) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}register';
  print("registerUrl..$url");
//  print("registerUrlUser..$user");
 // print("registerUrlUser..${(user.toMap())}");
print("name...${user.name}");
  final client = new http.Client();
  final response = await client.post(
    url,
    //headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    //body: json.encode(user.toMap()),
      body: {
        "username":user.name,
        "email": user.email,
        "password": user.password,
        "number":user.phone,
        "role":"2"
      }
  );
 // print("RegisterResponse....${response.body}");
  print("RegisterResponseUser....${response.body}");
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
  return currentUser.value;
}
Future<User> confirmOTP(String otpOfNumber) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}confirmotp';
  print("ConfoimUrl..$url");
  print("vid..${currentUser.value.id}");
  final client = new http.Client();
  final response = await client.post(
      url,
      // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: {
        "OTP": otpOfNumber,
        "vid": currentUser.value.id
      }
    // body: json.encode(user.toMap()),
  );

  print("OTPResponse....${response.body}");
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
  return currentUser.value;
}
Future<bool> resetPassword(User user) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}send_reset_link_email';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  try {
    if (json.decode(jsonString)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: jsonString).toString());
    throw new Exception(e);
  }
}


Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value = User.fromJSON(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}


Future<User> update(User user) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url = '${GlobalConfiguration().getValue('api_base_url')}updates';
//  final String url = '${GlobalConfiguration().getValue('api_base_url')}users/${currentUser.value.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    url,
   // headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //  body: json.encode(user.toMap()),
      body: {
        "user_id":currentUser.value.id,

        "api_token": currentUser.value.apiToken,
        "address": user.address,
        "phone":user.phone
      }
  );
  print("UpdateResponse..${response.body}");
  setCurrentUser(response.body);
  currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  return currentUser.value;
}




