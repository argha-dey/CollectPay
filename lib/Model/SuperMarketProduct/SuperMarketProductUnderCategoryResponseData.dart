class SuperMarketProductUnderCategoryResponseData {
  List<ProductData> data;
  int totalCartItems;

  SuperMarketProductUnderCategoryResponseData(
      {this.data,this.totalCartItems});

  SuperMarketProductUnderCategoryResponseData.fromJson(
      Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data.add(new ProductData.fromJson(v));
      });
    }
    totalCartItems = json['total_cart_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total_cart_items'] = this.totalCartItems;
    return data;
  }
}

class ProductData {
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
  String discount;
  int buyerCartQuantity;

  ProductData(
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
        this.buyerCartQuantity,this.discount});

  ProductData.fromJson(Map<String, dynamic> json) {
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
    buyerCartQuantity = json['cart_quantity'];
    discount = json['discount'];
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
    data['cart_quantity'] = this.buyerCartQuantity;
    data['discount'] = this.discount;
    return data;
  }
}

