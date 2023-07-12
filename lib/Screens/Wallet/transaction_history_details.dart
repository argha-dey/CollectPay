

import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SendMoneyAnyPersonPage extends StatefulWidget {
  @override
  _SendMoneyAnyPersonPageState createState() => _SendMoneyAnyPersonPageState();
}

class _SendMoneyAnyPersonPageState extends State<SendMoneyAnyPersonPage> {
  final myShortNoteTController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(

      backgroundColor: Color(0xffE5E5E5),
      appBar: new AppBar(
        title: Text("MONEY SEND TO",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black)),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),

      body: SingleChildScrollView(

        child: Container(


          child: Column(

            children: <Widget>[

              Container(
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      image: DecorationImage(

                          image:AssetImage("images/ic_user_profile.png",
                            /*    image: NetworkImage(_productDetailsList[index].product_pic,*/
                          ), fit: BoxFit.cover)
                  )),

              Container(
                child: Text(
                  "Paying To ARGHA DEY",
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Text(
                  "9832060801",
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.black, fontSize: 16),
                ),
                margin: EdgeInsets.only(top: 10,bottom: 30),
              ),
              Container(
                margin: EdgeInsets.only(left: 2,right: 2),
                child:RoundedInputField(
                  icon: null,
                  hintText: "SRD 0",
                  onChanged: (value) {

                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(top:10,left: 12,right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],

                  // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(6.0)), // set rounded corner radius
                ),


                child: TextFormField(

                  controller: myShortNoteTController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  maxLength: 50,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Add a note',
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
              ),

              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top:120),

                  child: SquareButtonLinearGradient(
                    buttonText: "SEND",
                    press: () {

                    },
                    width: size.width * 9,
                  ),
                ),
              ),
            ],
          ),

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