
import 'package:collectpay/Model/SuperMarketCategoryDetails/Category.dart';

class SuperMarketCategory {
  int superMarketCategoryId;
  Category category;

  SuperMarketCategory({this.superMarketCategoryId, this.category});

  SuperMarketCategory.fromJson(Map<String, dynamic> json) {
    superMarketCategoryId = json['super_market_category_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['super_market_category_id'] = this.superMarketCategoryId;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}