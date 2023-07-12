class CreateBudgetResponse {
  CreateDataBudget data;

  CreateBudgetResponse({this.data});

  CreateBudgetResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CreateDataBudget.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class CreateDataBudget {
  String name;
  String type;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  CreateDataBudget(
      {this.name,
        this.type,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  CreateDataBudget.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}