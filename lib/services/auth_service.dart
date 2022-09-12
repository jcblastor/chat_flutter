import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/models/models.dart';
import 'package:chat_app/global/global.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _isLoading = false;
  final _storage = const FlutterSecureStorage();

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // getters del token de forma statica
  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  // login
  Future<bool> login(String email, String password) async {
    isLoading = true;

    final data = {
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Environment.apiUrl}/login');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _guardarToken(loginResponse.token);

      isLoading = false;
      return true;
    } else {
      isLoading = false;
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    isLoading = true;
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Environment.apiUrl}/register');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _guardarToken(loginResponse.token);

      isLoading = false;
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      isLoading = false;
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final uri = Uri.parse('${Environment.apiUrl}/renew');

    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': '$token',
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _guardarToken(loginResponse.token);

      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
