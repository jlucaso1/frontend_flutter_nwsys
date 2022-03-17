import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  var client = Dio()..options.baseUrl = 'http://localhost:3000';
}
