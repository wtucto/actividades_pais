import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckConnection {
  /// Returns `true` si existe conexion a  internet
  static Future<bool> isOnline(String type) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected == true) {
      var typeConnectivity = await (Connectivity().checkConnectivity());
      if (type != '') {
        switch (type) {
          case 'WIFI':
            if (typeConnectivity == ConnectivityResult.wifi) {
              print('Wifi Connect');
              return true;
            }
            break;
          case 'MOBILE':
            if (typeConnectivity == ConnectivityResult.mobile) {
              print('Mobile Connect');
              return true;
            }
            break;
          case 'ALL':
            if (typeConnectivity == ConnectivityResult.wifi ||
                typeConnectivity == ConnectivityResult.mobile) {
              print('Mobile/Wifi Connect');
              return true;
            }
            break;
          default:
            return false;
        }
      }
      return true;
    }

    print('No internet :(');
    return false;
  }

  /// Returns `true` si existe conexion a  internet y la conezion es por wifi.
  static Future<bool> isOnlineWifi() async {
    return await isOnline('WIFI');
  }

  static Future<bool> isOnlineMobile() async {
    return await isOnline('MOBILE');
  }

  static Future<bool> isOnlineWifiMobile() async {
    return await isOnline('ALL');
  }
}
