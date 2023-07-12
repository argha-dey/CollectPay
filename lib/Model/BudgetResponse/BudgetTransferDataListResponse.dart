class BudgetTransferDataListResponse {
  List<BudgetTransferData> data;


  BudgetTransferDataListResponse(
      {this.data,});

  BudgetTransferDataListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BudgetTransferData>[];
      json['data'].forEach((v) {
        data.add(new BudgetTransferData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class BudgetTransferData {
  int userWalletId;
  Budget budget;
  String amount;
  int userId;
  String status;
  String updatedAt;
  String createdAt;

  BudgetTransferData(
      {this.userWalletId,
        this.budget,
        this.amount,
        this.userId,
        this.status,
        this.updatedAt,
        this.createdAt});

  BudgetTransferData.fromJson(Map<String, dynamic> json) {
    userWalletId = json['user_wallet_id'];
    budget = json['budget'] != null ? new Budget.fromJson(json['budget']) : null;
    amount = json['amount'];
    userId = json['user_id'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_wallet_id'] = this.userWalletId;
    if (this.budget != null) {
      data['budget'] = this.budget.toJson();
    }
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Budget {
  int budgetId;
  int userId;
  String name;
  String type;
  int amount;


  Budget(
      {this.budgetId,
        this.userId,
        this.name,
        this.type,
        this.amount,
      });

  Budget.fromJson(Map<String, dynamic> json) {
    budgetId = json['budget_id'];
    userId = json['user_id'];
    name = json['name'];
    type = json['type'];
    amount = json['amount'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['budget_id'] = this.budgetId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['amount'] = this.amount;

    return data;
  }
}
