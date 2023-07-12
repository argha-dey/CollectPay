import 'package:collectpay/Screens/Budget/budget_category_page.dart';
import 'package:collectpay/Screens/Cart/cart_page.dart';
import 'package:collectpay/Screens/Home/home_page.dart';
import 'package:collectpay/Screens/Profile/ProfilePage.dart';
import 'package:collectpay/Screens/Wallet/wallet_page.dart';
import 'package:flutter/material.dart';


class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    Widget child ;
    if(tabItem == "Page1") {
      print("tabItemNew : $tabItem");

      child = new HomePage();
    }
    else if(tabItem == "Page2") {
      print("tabItemNew : $tabItem");
      child = new BudgetPage();
    }
    else if(tabItem == "Page3") {
      print("tabItemNew : $tabItem");
      child = new WalletPage();
    }
    else if(tabItem == "Page4") {
      print("tabItemNew : $tabItem");
      child = new CartPage();
    }
    else if(tabItem == "Page5") {
      print("tabItemNew : $tabItem");
      child = new ProfilePage();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}