import 'package:app/config/theme/theme_controller.dart';
import 'package:app/service/settings_service.dart';
import 'package:app/service/user_service.dart';

class SettingsUtil
{
  static Future<void> loadAndApplyCurrentUserSettings(UserService userService, SettingsService settingsService, ThemeController themeController) async
  {
    final user = await userService.getCurrentUser();
    final settings = await settingsService.getSettings(user.id);

    themeController.setColorSelection(settings.colorMode);
    themeController.setFontSizeSelection(settings.fontSize);
  }

  static Future<void> loadAndApplyUserSettings(int userId, SettingsService settingsService, ThemeController themeController) async
  {
    final settings = await settingsService.getSettings(userId);

    themeController.setColorSelection(settings.colorMode);
    themeController.setFontSizeSelection(settings.fontSize);
  }
}
