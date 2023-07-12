/*


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
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'changeBottomNavigationIndex.dart';
import 'dart:async';






class MyMainPage extends StatefulWidget   {


  @override
  _MainPageState createState() => _MainPageState();


}

class _MainPageState extends State<MyMainPage>  {
  PersistentTabController _controller;

  bool isOffline = false;
  int _selectedIndex = 0;



  String _currentPage = "Page1";

  List<String> pageKeys = ["Page1", "Page2", "Page3","Page4","Page5"];


  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };



   _selectTab(String tabItem, int index) {


print("tabItem : $tabItem");
print("_currentPage : $_currentPage");
print("index: $index");

      if (tabItem == _currentPage) {
        _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
      } else {
        setState(() {
          _currentPage = pageKeys[index];
          _selectedIndex = index;
        });
      }

  }



  List<Widget> _buildScreens() {
    return [
      HomePage(),
      BudgetPage(),
      WalletPage(),
      CartPage(),
      ProfilePage()
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary:  CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.addchart_outlined),
        title: ("Budget"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_balance_wallet_rounded),
        title: ("Wallet"),
        activeColorPrimary:  CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_rounded),
        title: ("Profile"),
        activeColorPrimary:  CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }
*/
/*  @override
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
        ),

        bottomNavigationBar:BottomNavyBar(
          backgroundColor: Colors.white,
          selectedIndex: _selectedIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (_selectedIndex){ _selectTab(pageKeys[_selectedIndex], _selectedIndex); },
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
                  int.parse(Provider.of<CartCount>(context).count) != 0 ? new Positioned(    // check
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

  }*//*

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white70, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.


          decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
*/
/*      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 50),
        curve: Curves.easeIn,
      ),*//*

    */
/*  screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 50),
      ),*//*

      navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
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



  @override
  void initState() {
    super.initState();
    setState(() {
       _controller = PersistentTabController(initialIndex: 0);


    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;

    });
  }







}
*/
