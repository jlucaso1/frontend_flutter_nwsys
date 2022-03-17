import 'package:get/get.dart';
import 'package:prova_nwsys/pages/login_page.dart';
import 'package:prova_nwsys/pages/products_page.dart';

final routes = [
  GetPage(
    name: '/login',
    page: () => const LoginPage(),
  ),
  GetPage(
    name: '/products',
    page: () => const ProductsPage(),
  ),
];
