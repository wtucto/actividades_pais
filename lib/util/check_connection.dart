import 'package:connectivity/connectivity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckConnection {
  /// Returns `true` si existe conexion a  internet
  static Future<bool> isOnline() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected == true) {
      return true;
    }

    print('No internet :(');
    return false;
  }

  /// Returns `true` si existe conexion a  internet y la conezion es por wifi.
  static Future<bool> isOnlineWifi() async {
    bool isConnected = await isOnline();
    if (isConnected == true) {
      var typeConnectivity = await (Connectivity().checkConnectivity());
      if (typeConnectivity == ConnectivityResult.mobile) {
        print('Mobile Connect');
      } else if (typeConnectivity == ConnectivityResult.wifi) {
        print('Wifi Connect');
        return true;
      }
    }

    print('No internet :(');
    return false;
  }
}
