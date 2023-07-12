class ActivePastOrderResponse {
  ActivePastOrderData data;

  ActivePastOrderResponse({this.data});

  ActivePastOrderResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ActivePastOrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ActivePastOrderData {
  int orderId;
  String orderDisplayId;
  String subTotalAmount;
  String taxAmount;
  String deliveryCharge;
  String otherCharge;
  String discountAmount;
  List<ProductDetails> productDetails;
  String totalAmount;
  int totalProduct;
  String latitude;
  String longitude;
  DeliveryAddress deliveryAddress;
  String paymentMode;
  String payStatus;
  String orderStatus;
  String createdAt;
  String updatedAt;
  String invoiceUrl;
  ActivePastOrderData(
      {this.orderId,
        this.orderDisplayId,
        this.subTotalAmount,
        this.taxAmount,
        this.deliveryCharge,
        this.otherCharge,
        this.discountAmount,
        this.productDetails,
        this.totalAmount,
        this.totalProduct,
        this.latitude,
        this.longitude,
        this.deliveryAddress,
        this.paymentMode,
        this.payStatus,
        this.orderStatus,
        this.createdAt,
        this.updatedAt,this.invoiceUrl});

  ActivePastOrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderDisplayId = json['order_display_id'];
    subTotalAmount = json['sub_total_amount'];
    taxAmount = json['tax_amount'];
    deliveryCharge = json['delivery_charge'];
    otherCharge = json['other_charge'];
    discountAmount = json['discount_amount'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails.add(new ProductDetails.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    totalProduct = json['total_product'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deliveryAddress = json['delivery_address'] != null
        ? new DeliveryAddress.fromJson(json['delivery_address'])
        : null;
    paymentMode = json['payment_mode'];
    payStatus = json['pay_status'];
    orderStatus = json['order_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    invoiceUrl =  json['invoice_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_display_id'] = this.orderDisplayId;
    data['sub_total_amount'] = this.subTotalAmount;
    data['tax_amount'] = this.taxAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['other_charge'] = this.otherCharge;
    data['discount_amount'] = this.discountAmount;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    data['total_product'] = this.totalProduct;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress.toJson();
    }
    data['payment_mode'] = this.paymentMode;
    data['pay_status'] = this.payStatus;
    data['order_status'] = this.orderStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['invoice_url'] = this.invoiceUrl;

    return data;
  }
}

class ProductDetails {
  int cartId;
  Product product;
  int userId;
  int quantity;
  int superMarketId;

  ProductDetails(
      {this.cartId,
        this.product,
        this.userId,
        this.quantity,
        this.superMarketId});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    userId = json['user_id'];
    quantity = json['quantity'];
    superMarketId = json['super_market_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['super_market_id'] = this.superMarketId;
    return data;
  }
}

class Product {
  String name;
  String image;
  int productId;
  String soldStock;
  int categoryId;
  String description;
  String totalStock;
  String marketPrice;
  int activeStatus;
  int cartQuantity;
  String sellingPrice;
  String approvedStatus;
  int superMarketId;
  String productDisplayId;

  Product(
      {this.name,
        this.image,
        this.productId,
        this.soldStock,
        this.categoryId,
        this.description,
        this.totalStock,
        this.marketPrice,
        this.activeStatus,
        this.cartQuantity,
        this.sellingPrice,
        this.approvedStatus,
        this.superMarketId,
        this.productDisplayId});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    productId = json['product_id'];
    soldStock = json['sold_stock'];
    categoryId = json['category_id'];
    description = json['description'];
    totalStock = json['total_stock'];
    marketPrice = json['market_price'];
    activeStatus = json['active_status'];
    cartQuantity = json['cart_quantity'];
    sellingPrice = json['selling_price'];
    approvedStatus = json['approved_status'];
    superMarketId = json['super_market_id'];
    productDisplayId = json['product_display_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['product_id'] = this.productId;
    data['sold_stock'] = this.soldStock;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['total_stock'] = this.totalStock;
    data['market_price'] = this.marketPrice;
    data['active_status'] = this.activeStatus;
    data['cart_quantity'] = this.cartQuantity;
    data['selling_price'] = this.sellingPrice;
    data['approved_status'] = this.approvedStatus;
    data['super_market_id'] = this.superMarketId;
    data['product_display_id'] = this.productDisplayId;
    return data;
  }
}

class DeliveryAddress {
  int id;
  String city;
  String type;
  String address;
  int userId;
  String latitude;
  String postcode;
  String username;
  String longitude;
  String createdAt;
  String updatedAt;

  DeliveryAddress(
      {this.id,
        this.city,
        this.type,
        this.address,
        this.userId,
        this.latitude,
        this.postcode,
        this.username,
        this.longitude,
        this.createdAt,
        this.updatedAt});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    type = json['type'];
    address = json['address'];
    userId = json['user_id'];
    latitude = json['latitude'];
    postcode = json['postcode'];
    username = json['username'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['type'] = this.type;
    data['address'] = this.address;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['postcode'] = this.postcode;
    data['username'] = this.username;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}