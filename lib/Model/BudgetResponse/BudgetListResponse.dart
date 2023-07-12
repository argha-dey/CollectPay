class BudgetListResponse {
  List<BudgetData> data;


  BudgetListResponse({this.data});

  BudgetListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BudgetData>[];
      json['data'].forEach((v) {
        data.add(new BudgetData.fromJson(v));
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

class BudgetData {
  int id;
  int userId;
  String name;
  String type;
  int amount;
  int current_wallet_balance;
  BudgetData(
      {this.id,
        this.userId,
        this.name,
        this.type,
        this.amount,this.current_wallet_balance,});

  BudgetData.fromJson(Map<String, dynamic> json) {
    id = json['budget_id'];
    userId = json['user_id'];
    name = json['name'];
    type = json['type'];
    amount = json['amount'];
    current_wallet_balance = json['current_wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['current_wallet_balance'] = this.current_wallet_balance;
    return data;
  }
}

