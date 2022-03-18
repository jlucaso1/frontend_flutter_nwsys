import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prova_nwsys/controllers/products_controller.dart';
import 'package:prova_nwsys/services/auth.dart';
import 'package:prova_nwsys/utils/default_image.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  var controller = Get.put(ProductsController());
  var authService = Get.find<AuthService>();
  @override
  Widget build(BuildContext context) {
    // listview with products
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: authService.logout,
            tooltip: "Sair",
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.loadProducts(),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              var product = controller.products[index];
              return ListTile(
                title: Text(product.nome),
                subtitle: Text("R\$ ${product.preco.toString()}"),
                leading: SizedBox(
                  width: 50,
                  child: ClipOval(
                    child: Image.memory(
                      converBase64ImageToUint8List(
                        product.imagembase64 == null ||
                                product.imagembase64!.isEmpty
                            ? defaultImage
                            : product.imagembase64!,
                      ),
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => controller.showEditDialog(product),
                    ),
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => controller.deleteProduct(product)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
