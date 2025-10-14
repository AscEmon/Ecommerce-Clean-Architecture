import 'package:package_info_plus/package_info_plus.dart';
import '../constants/app_constants.dart';
import 'extension.dart';
import 'preferences_helper.dart';

class AppVersion {
  static String currentVersion = '';
  static String versionCode = '';
  static Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    PrefHelper.instance.setString(AppConstants.appVersion.key, currentVersion);
    PrefHelper.instance.setString(AppConstants.buildNumber.key, versionCode);
    'Current version is  :: ${currentVersion.toString()}'.log();
    'App version Code is :: ${versionCode.toString()}'.log();
  }
}
 
