import 'package:tailor_made/models/settings.dart';
import 'package:tailor_made/services/settings/settings.dart';

class SettingsMockImpl extends Settings {
  @override
  Stream<SettingsModel> fetch() async* {
    yield SettingsModel((b) => b
      ..premiumNotice = "Hey Premium"
      ..versionName = "1.0");
  }
}
