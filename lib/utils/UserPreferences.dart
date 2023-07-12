
import '../appConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UserPreferences {

  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get userCurrentId {
    return _prefs.getString(keyUserId) ?? '';
  }

  set userCurrentId(String value) {
    _prefs.setString(keyUserId, value);
  }



  get userCurrentEmail {
    return _prefs.getString(keyUserEmail) ?? '';
  }

  set userCurrentEmail(String value) {
    _prefs.setString(keyUserEmail, value);
  }


  get userCurrentToken {
    return _prefs.getString(keyUserToken) ?? '';
  }

  set userCurrentToken(String value) {
    _prefs.setString(keyUserToken, value);
  }




  get userCartCount {
    return _prefs.getString(keyUserCartCount) ?? '0';
  }

  set userCartCount(String value) {
    _prefs.setString(keyUserCartCount, value);
  }

  get userName {
    return _prefs.getString(keyUserName) ?? '';
  }

  set userName(String value) {
    _prefs.setString(keyUserName, value);
  }

  get userProfileImage {
    return _prefs.getString(keyUserProfileImage) ?? '';
  }

  set userProfileImage(String value) {
    _prefs.setString(keyUserProfileImage, value);
  }
  get userSelectedAddress {
    return _prefs.getString(keyUserSelectedAddress) ?? '';
  }

  set userSelectedAddress(String value) {
    _prefs.setString(keyUserSelectedAddress, value);
  }

  get userMobile {
    return _prefs.getString(keyUserMobile) ?? '';
  }

  set userMobile(String value) {
    _prefs.setString(keyUserMobile, value);
  }


  get userLoginStatus {
    return _prefs.getBool(keyLoginStatus) ?? false;
  }

  set userLoginStatus(bool value) {
    _prefs.setBool(keyLoginStatus, value);
  }

}