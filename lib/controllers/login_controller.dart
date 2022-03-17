import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prova_nwsys/services/auth.dart';

class LoginController extends GetxController {
  var email = TextEditingController(text: "jlucaso@hotmail.com");
  var password = TextEditingController(text: "123456");
  RxBool isLoading = false.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var authService = Get.find<AuthService>();

  get formKey => _formKey;

  void login() async {
    if (_formKey.currentState!.validate()) {
      isLoading.value = true;
      await authService.login(email.text, password.text);
      isLoading.value = false;
    }
  }

  void logout() async {
    await authService.logout();
  }
}
