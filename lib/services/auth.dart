import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prova_nwsys/services/api.dart';

class AuthService extends GetxController {
  var isLoggedIn = false.obs;
  String? token;
  var api = Get.find<ApiService>();

  Future<void> login(String email, String password) async {
    try {
      var result = await api.client.post("/auth", data: {
        "email": email,
        "password": password,
      });

      if (result.statusCode == 201) {
        setToken(result.data['token']);
        Get.snackbar(
          "Logado com sucesso",
          "Seja bem vindo $email",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[600],
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        await Get.offNamed('/products');
      }
    } catch (e) {
      Get.snackbar(
        "Erro",
        "Usuário ou senha inválidos",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> logout() async {
    isLoggedIn.value = false;
    token = null;
    api.client.options.headers = {};
    var box = GetStorage();
    box.remove('token');
    await Get.offNamed('/login');
  }

  setToken(String token) {
    isLoggedIn.value = true;
    api.client.options.headers = {"Authorization": "Bearer $token"};
    var box = GetStorage();
    box.write('token', token);
  }
}
