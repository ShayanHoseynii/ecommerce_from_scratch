class CartItemModel {
  String productId;
  String title;
  String? image;
  double price;
  int quantity;
  String varitaionId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.varitaionId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    this.selectedVariation,
  });

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'varitaionId': varitaionId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] as String,
      title: json['title'] as String,
      image: json['image'] as String?,
      price: (json['price'] as num).toDouble(), 
      quantity: json['quantity'] as int,
      varitaionId: json['varitaionId'] as String,
      brandName: json['brandName'] as String?,
      selectedVariation: json['selectedVariation'] == null
          ? null
          : Map<String, String>.from(json['selectedVariation'] as Map),
    );
  }
}
