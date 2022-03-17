import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prova_nwsys/routes/routes.dart';
import 'package:prova_nwsys/services/api.dart';
import 'package:prova_nwsys/services/auth.dart';

void main() async {
  Get.put(ApiService());
  var authService = Get.put(AuthService());
  await GetStorage.init();
  var box = GetStorage();
  var token = box.read<String>('token');
  late String page;
  if (token == null) {
    page = '/login';
  } else {
    authService.setToken(token);
    page = '/products';
  }
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: routes,
    initialRoute: page,
  ));
}
