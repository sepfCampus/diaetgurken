import 'package:app/config/theme/theme_controller.dart';
import 'package:app/screens/assessment_widget.dart';
import 'package:app/screens/change_password_widget.dart';
import 'package:app/screens/clear_name_widget.dart';
import 'package:app/screens/client_file_widget.dart';
import 'package:app/screens/client_files_widget.dart';
import 'package:app/screens/conversation_notes_widget.dart';
import 'package:app/screens/conversation_widget.dart';
import 'package:app/screens/create_client_file_widget.dart';
import 'package:app/screens/delete_profile_widget.dart';
import 'package:app/screens/diagnosis_widget.dart';
import 'package:app/screens/export_conversation_widget.dart';
import 'package:app/screens/filter_widget.dart';
import 'package:app/screens/goal_editor_widget.dart';
import 'package:app/screens/goal_setting_widget.dart';
import 'package:app/screens/login_widget.dart';
import 'package:app/screens/outcome_evaluation_detail_widget.dart';
import 'package:app/screens/outcome_evaluation_widget.dart';
import 'package:app/screens/register_widget.dart';
import 'package:app/screens/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(const MainApp());
}

class MainApp extends StatelessWidget
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider(
      create: (_) => ThemeController(),

      child: Consumer<ThemeController>(
        builder: (context, themeController, _)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.PAGE_HOME,
            routes:
            {
              Routes.PAGE_HOME: (context) => ClientFilesWidget(),
              Routes.PAGE_LOGIN: (context) => LoginWidget(),
              Routes.PAGE_REGISTER: (context) => RegisterWidget(),
              Routes.PAGE_SETTINGS: (context) => SettingsWidget(),
              Routes.PAGE_CLEAR_NAME: (context) => ClearNameWidget(),
              Routes.PAGE_CLIENT_FILES: (context) => ClientFilesWidget(),
              Routes.PAGE_CHANGE_PASSWORD: (context) => ChangePasswordWidget(),
              Routes.PAGE_DELETE_PROFILE: (context) => DeleteProfileWidget(),
              Routes.PAGE_CREATE_CLIENT_FILE: (context) => CreateClientFileWidget(),
              Routes.PAGE_CLIENT_FILE: (context) => ClientFileWidget(),
              Routes.PAGE_EXPORT_CONVERSATION: (context) => ExportConversationWidget(),
              Routes.PAGE_CONVERSATION_NOTES: (context) => ConversationNotesWidget(),
              Routes.PAGE_CONVERSATION: (context) => ConversationWidget(),
              Routes.PAGE_FILTER: (context) => FilterWidget(),
              Routes.PAGE_ASSESSMENT: (context) => AssessmentWidget(),
              Routes.PAGE_DIAGNOSIS: (context) => DiagnosisWidget(),
              Routes.PAGE_OUTCOME_EVALUATION: (context) => OutcomeEvaluationWidget(),
              Routes.PAGE_OUTCOME_EVALUATION_DETAIL: (context) => OutcomeEvaluationDetailWidget(),
              Routes.PAGE_GOAL_SETTING: (context) => GoalSettingWidget(),
              Routes.PAGE_GOAL_EDITOR: (context) => GoalEditorWidget()
            },
            theme: themeController.theme,  // LIGHT oder HIGH_CONTRAST
            home: const LoginWidget()
          );
        }
      )
    );
  }
}
