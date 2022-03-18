import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prova_nwsys/models/product.dart';
import 'package:prova_nwsys/services/api.dart';

class ProductsController extends GetxController {
  final isLoading = false.obs;
  final RxList<Product> _products = <Product>[].obs;

  RxList<Product> get products => _products;

  var api = Get.find<ApiService>();

  void loadProducts() async {
    isLoading.value = true;
    var result = await api.client.get('/manager/products');
    _products.value =
        result.data.map<Product>((json) => Product.fromJson(json)).toList();

    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
    loadProducts();
  }

  showAddDialog() {
    var nome = TextEditingController();
    var preco = TextEditingController();
    var imagembase64 = TextEditingController();
    Get.defaultDialog(
      title: 'Adicionar Produto',
      content: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Nome'),
            controller: nome,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Preço'),
            controller: preco,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Imagem'),
            controller: imagembase64,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Cancelar'),
          onPressed: () => Get.back(),
        ),
        ElevatedButton(
          child: const Text('Salvar'),
          onPressed: () async {
            var product = Product(
              nome: nome.text,
              preco: double.parse(preco.text),
              imagembase64:
                  imagembase64.text.isEmpty ? null : imagembase64.text,
            );

            try {
              await api.client.post('/manager/products', data: {
                'nome': product.nome,
                'preco': product.preco,
                'imagembase64': product.imagembase64,
              });
              loadProducts();
              Get.back();
            } catch (e) {
              Get.snackbar('Erro', e.toString());
            }
          },
        ),
      ],
    );
  }

  deleteProduct(Product product) async {
    await api.client.delete('/manager/products/${product.id}');
    loadProducts();
  }

  showEditDialog(Product oldProduct) {
    var nome = TextEditingController();
    var preco = TextEditingController();
    var imagembase64 = TextEditingController();
    Get.defaultDialog(
      title: 'Editar Produto',
      content: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Nome'),
            controller: nome,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Preço'),
            controller: preco,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Imagem'),
            controller: imagembase64,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Cancelar'),
          onPressed: () => Get.back(),
        ),
        ElevatedButton(
          child: const Text('Salvar'),
          onPressed: () async {
            var product = Product(
              nome: nome.text.isEmpty ? oldProduct.nome : nome.text,
              preco: preco.text.isEmpty
                  ? oldProduct.preco
                  : double.parse(preco.text),
              imagembase64: imagembase64.text.isEmpty
                  ? oldProduct.imagembase64
                  : imagembase64.text,
            );

            try {
              await api.client.put('/manager/products/${oldProduct.id}', data: {
                'nome': product.nome,
                'preco': product.preco,
                'imagembase64': product.imagembase64,
              });
              loadProducts();
              Get.back();
            } catch (e) {
              Get.snackbar('Erro', e.toString());
            }
          },
        ),
      ],
    );
  }
}
