class GetBudgetResponse {
  Budget data;

  GetBudgetResponse({this.data});

  GetBudgetResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Budget.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Budget {
  int budgetId;
  int userId;
  String name;
  String type;
  int amount;
  int currentWalletBalance;

  Budget(
      {this.budgetId,
        this.userId,
        this.name,
        this.type,
        this.amount,
        this.currentWalletBalance});

  Budget.fromJson(Map<String, dynamic> json) {
    budgetId = json['budget_id'];
    userId = json['user_id'];
    name = json['name'];
    type = json['type'];
    amount = json['amount'];
    currentWalletBalance = json['current_wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['budget_id'] = this.budgetId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['current_wallet_balance'] = this.currentWalletBalance;
    return data;
  }
}