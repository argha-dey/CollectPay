

//import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:collectpay/Screens/Budget/budget_category_page.dart';

import 'package:collectpay/Screens/Cart/cart_page.dart';
import 'package:collectpay/Screens/Home/home_page.dart';
import 'package:collectpay/Screens/Landing/tab_navigator.dart';
import 'package:collectpay/Screens/Profile/ProfilePage.dart';
import 'package:collectpay/Screens/SuperMarket/super_market_list_page.dart';
import 'package:collectpay/Screens/Wallet/wallet_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'changeBottomNavigationIndex.dart';
import 'dart:async';






class MyMainPage extends StatefulWidget   {

  final int selectedIndex;
  final String currentPage;
  const MyMainPage({Key key,this.currentPage,this.selectedIndex}) : super(key: key);





  @override
  _MainPageState createState() => _MainPageState();


}

class _MainPageState extends State<MyMainPage>  {

  bool isOffline = false;
  int _selectedIndex;
  String _currentPage;

  List<String> pageKeys = ["Page1", "Page2", "Page3","Page4","Page5"];

  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();

    setState(() {
      _selectedIndex = widget.selectedIndex;
      _currentPage = widget.currentPage;

      print("_currentPage : $_currentPage");
      print("index: $_selectedIndex");


    });

  }



  _selectTab(String tabItem, int index) {



    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 0);
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
            children:<Widget>[
              _selectedIndex==0?_buildOffstageNavigator("Page1"):new Container(),
              _selectedIndex==1? _buildOffstageNavigator("Page2"):new Container(),
              _selectedIndex==2?_buildOffstageNavigator("Page3"):new Container(),
              _selectedIndex==3? _buildOffstageNavigator("Page4"):new Container(),
              _selectedIndex==4?_buildOffstageNavigator("Page5"):new Container(),
            ]

          /*   children:<Widget>[
              _selectedIndex==0?new HomePage():new Container(),
              _selectedIndex==1? new BudgetPage():new Container(),
              _selectedIndex==2?new WalletPage():new Container(),
              _selectedIndex==3? new CartPage():new Container(),
              _selectedIndex==4?new ProfilePage():new Container(),
            ]*/
        ),

        bottomNavigationBar:BottomNavyBar(
          backgroundColor: Colors.white,
          selectedIndex: _selectedIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (selectedIndex){ _selectTab(pageKeys[selectedIndex], selectedIndex); },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.addchart_outlined),
              title: Text('Budget'),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              title: Text('Wallet'),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: new Stack(

                children: <Widget>[
                  new Icon(Icons.shopping_cart),
                  Provider.of<CartCount>(context).count != 0 ? new Positioned(    // check
                    top: 0.0,
                    right: 0.0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        "${Provider.of<CartCount>(context).count}",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ) :new Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),

                    ),
                  )
                ],
              ),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              title: Text('Cart'),
              textAlign: TextAlign.center,
            ),

            BottomNavyBarItem(

              icon: Icon(Icons.person_rounded),
              title: Text('Profile'),
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center,
            ),

          ],
        ),

      ),
    );

  }



  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
          navigatorKey: _navigatorKeys[tabItem],
          tabItem: tabItem
      ),


    );
  }





  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;

    });
  }







}
