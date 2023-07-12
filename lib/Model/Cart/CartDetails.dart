class CartDetails {
  List<CartData> cartData;
  int subTotalAmount;
  int taxAmount;
  int deliveryCharge;
  int otherCharge;
  int totalAmount;
  int totalItems;

  CartDetails(
      {this.cartData,
        this.subTotalAmount,
        this.taxAmount,
        this.deliveryCharge,
        this.otherCharge,
        this.totalAmount,
        this.totalItems});

  CartDetails.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      cartData = <CartData>[];
      json['data'].forEach((v) {
        cartData.add(new CartData.fromJson(v));
      });
    }
    subTotalAmount = json['sub_total_amount'];
    taxAmount = json['tax_amount'];
    deliveryCharge = json['delivery_charge'];
    otherCharge = json['other_charge'];
    totalAmount = json['total_amount'];
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartData != null) {
      data['data'] = this.cartData.map((v) => v.toJson()).toList();
    }
    data['sub_total_amount'] = this.subTotalAmount;
    data['tax_amount'] = this.taxAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['other_charge'] = this.otherCharge;
    data['total_amount'] = this.totalAmount;
    data['total_items'] = this.totalItems;
    return data;
  }
}

class CartData {
  int cartId;
  int userId;
  int superMarketId;
  Product product;
  int quantity;

  CartData(
      {this.cartId,
        this.userId,
        this.superMarketId,
        this.product,
        this.quantity});

  CartData.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    superMarketId = json['super_market_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['super_market_id'] = this.superMarketId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class Product {
  int productId;
  int superMarketId;
  int categoryId;
  String productDisplayId;
  String name;
  String description;
  String image;
  String marketPrice;
  String sellingPrice;
  String totalStock;
  String soldStock;
  int activeStatus;
  String approvedStatus;
  int cartQuantity;

  Product(
      {this.productId,
        this.superMarketId,
        this.categoryId,
        this.productDisplayId,
        this.name,
        this.description,
        this.image,
        this.marketPrice,
        this.sellingPrice,
        this.totalStock,
        this.soldStock,
        this.activeStatus,
        this.approvedStatus,
        this.cartQuantity});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    superMarketId = json['super_market_id'];
    categoryId = json['category_id'];
    productDisplayId = json['product_display_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    marketPrice = json['market_price'];
    sellingPrice = json['selling_price'];
    totalStock = json['total_stock'];
    soldStock = json['sold_stock'];
    activeStatus = json['active_status'];
    approvedStatus = json['approved_status'];
    cartQuantity = json['cart_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['super_market_id'] = this.superMarketId;
    data['category_id'] = this.categoryId;
    data['product_display_id'] = this.productDisplayId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['market_price'] = this.marketPrice;
    data['selling_price'] = this.sellingPrice;
    data['total_stock'] = this.totalStock;
    data['sold_stock'] = this.soldStock;
    data['active_status'] = this.activeStatus;
    data['approved_status'] = this.approvedStatus;
    data['cart_quantity'] = this.cartQuantity;
    return data;
  }
}