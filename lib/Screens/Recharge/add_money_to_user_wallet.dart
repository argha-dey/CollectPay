

import 'package:collectpay/Screens/Bank/AddBankDetailsPage.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AddMoneyToUserWalletPage extends StatefulWidget {
  @override
  _AddMoneyToUserWalletPageState createState() => _AddMoneyToUserWalletPageState();
}

class _AddMoneyToUserWalletPageState extends State<AddMoneyToUserWalletPage> {
  final myShortNoteTController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(

      backgroundColor: Color(0xffE5E5E5),
      appBar: new AppBar(
        title: Text("Add money to wallet".toUpperCase(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black)),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              /*     Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return MyMainPage(); // My Main page
                      },
                    ),
                    );*/
            }),
      ),

      body:  Container(


        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(

                  child: Column(


                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child:Container(
                            child:Row(
                              children: <Widget>[
                                Radio(
                                  groupValue: 1,
                                  activeColor: Colors.blue,
                                ),
                                Text(
                                  "State Bank of India",
                                  style: CustomTextStyle.textFormFieldBold
                                      .copyWith(color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(left: 6,right: 2,top: 80),
                          ),


                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "A/C No. ******3456",
                              style: CustomTextStyle.textFormFieldBold
                                  .copyWith(color: Colors.grey[600], fontSize: 16),
                            ),
                            margin: EdgeInsets.only(left: 26,right: 2,top: 5),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "Check Balance",
                              style: CustomTextStyle.textFormFieldBold
                                  .copyWith(color: Colors.blue, fontSize: 14),
                            ),
                            margin: EdgeInsets.only(left: 26,right: 2,top: 20),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6,right: 6,top: 50),
                          height: 70,
                          child: SquareButtonLinearGradient(
                            buttonText: "Add SRD 20".toUpperCase(),
                            press: () {

                            },
                            width: size.width * 9,
                          ),
                        )
                      ]
                  )
              ),
            ),


            Container(
              height: 70,
              child: SquareButtonLinearGradient(
                buttonText: "ADD BANK".toUpperCase(),
                press: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AddBankDetailsPage()
                  )
                  );
                },
                width: size.width * 9,
              ),
            )


          ],
        ),

      ),


    );
  }
}

getSizedBox({double width, double height}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

get _getOtpKeyboard {
  return new Container(

      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "1",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "2",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "3",
                    onPressed: () {

                    }),
              ],
            ),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "4",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "5",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "6",
                    onPressed: () {

                    }),
              ],
            ),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "7",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "8",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "9",
                    onPressed: () {

                    }),
              ],
            ),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  width: 80.0,
                ),
                _otpKeyboardInputButton(
                    label: "0",
                    onPressed: () {
                      _setCurrentDigit(0);
                    }),
                _otpKeyboardActionButton(
                    label: new Icon(
                      Icons.backspace,
                      color: Colors.black,
                    ),
                    onPressed: () {

                    }),
              ],
            ),
          ),
        ],
      ));
}


Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
  return new Material(
    color: Colors.transparent,
    child: new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 30.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}

// Returns "Otp keyboard action Button"
_otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
  return new InkWell(
    onTap: onPressed,
    borderRadius: new BorderRadius.circular(40.0),
    child: new Container(
      height: 80.0,
      width: 80.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: new Center(
        child: label,
      ),
    ),
  );
}



void _setCurrentDigit(int i) {
/*  setState(() {
    _currentDigit = i;
  });*/
}