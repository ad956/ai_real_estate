import 'package:connectivity_plus/connectivity_plus.dart';
import 'logger.dart';

class ConnectivityService {
  static Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      final hasConnection =
          connectivityResult != ConnectivityResult.none; // FIXED

      if (!hasConnection) {
        Logger.logWarning('No internet connection detected');
      }

      return hasConnection;
    } catch (e) {
      Logger.logError('Failed to check connectivity', e);
      return false;
    }
  }
}
