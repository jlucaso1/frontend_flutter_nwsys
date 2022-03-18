class Product {
  int? id;
  final String nome;
  final double preco;
  final String? imagembase64;

  Product({
    this.id,
    required this.nome,
    required this.preco,
    this.imagembase64,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        nome: json['nome'] as String,
        preco: json['preco'] as double,
        imagembase64: json['imagembase64'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'preco': preco,
        'imagembase64': imagembase64,
      };
}
