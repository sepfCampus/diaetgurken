import 'package:app/config/theme/theme_controller.dart';
import 'package:app/widgets/auth_guard.dart';
import 'package:app/data/daos/http/api/memory_session_store.dart';
import 'package:app/data/daos/http/api/session_api_client.dart';
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
import 'package:app/service/klienten_akte_http_service.dart';
import 'package:app/service/user_http_service.dart';
import 'package:flutter/material.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:provider/provider.dart';
import 'package:app/service/klarname_http_service.dart';

void main()
{
  runApp(const MainApp());
}
class AuthCheckWidget extends StatefulWidget
{
  const AuthCheckWidget({ super.key });

  @override
  State<AuthCheckWidget> createState() => _AuthCheckWidgetState();
}

class _AuthCheckWidgetState extends State<AuthCheckWidget>
{
  @override
  void initState()
  {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async
  {
    final userService = context.read<UserHttpService>();
    final isLoggedIn = await userService.isLoggedIn();

    if (mounted)
    {
      Navigator.of(context).pushReplacementNamed(
        isLoggedIn ? Routes.PAGE_HOME : Routes.PAGE_LOGIN,
      );
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class MainApp extends StatelessWidget
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    final sessionStore = MemorySessionStore();
    final apiClient = SessionApiClient(
      baseUrl: 'http://localhost:3000/api',
      sessionStore: sessionStore,
    );
    final klientenAkteHttpService = KlientenAkteHttpService(apiClient: apiClient);
    final userHttpService = UserHttpService(
      apiClient: apiClient,
      sessionStore: sessionStore,
    );

    return MultiProvider(
      providers:
      [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        Provider<UserHttpService>.value(value: userHttpService),
        Provider<KlientenAkteHttpService>.value(value: klientenAkteHttpService),
        Provider<KlarnameHttpService>.value(value: KlarnameHttpService(apiClient: apiClient)),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, _)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes:
{
  Routes.PAGE_HOME: (context) => AuthGuard(child: ClientFilesWidget()),
  Routes.PAGE_LOGIN: (context) => LoginWidget(),
  Routes.PAGE_REGISTER: (context) => RegisterWidget(),
  Routes.PAGE_SETTINGS: (context) => AuthGuard(child: SettingsWidget()),
  Routes.PAGE_CLEAR_NAME: (context) => AuthGuard(child: ClearNameWidget()),
  Routes.PAGE_CLIENT_FILES: (context) => AuthGuard(child: ClientFilesWidget()),
  Routes.PAGE_CHANGE_PASSWORD: (context) => AuthGuard(child: ChangePasswordWidget()),
  Routes.PAGE_DELETE_PROFILE: (context) => AuthGuard(child: DeleteProfileWidget()),
  Routes.PAGE_CREATE_CLIENT_FILE: (context) => AuthGuard(child: CreateClientFileWidget()),
  Routes.PAGE_CLIENT_FILE: (context) => AuthGuard(child: ClientFileWidget()),
  Routes.PAGE_EXPORT_CONVERSATION: (context) => AuthGuard(child: ExportConversationWidget()),
  Routes.PAGE_CONVERSATION_NOTES: (context) => AuthGuard(child: ConversationNotesWidget()),
  Routes.PAGE_CONVERSATION: (context) => AuthGuard(child: ConversationWidget()),
  Routes.PAGE_FILTER: (context) => AuthGuard(child: FilterWidget()),
  Routes.PAGE_ASSESSMENT: (context) => AuthGuard(child: AssessmentWidget()),
  Routes.PAGE_DIAGNOSIS: (context) => AuthGuard(child: DiagnosisWidget()),
  Routes.PAGE_OUTCOME_EVALUATION: (context) => AuthGuard(child: OutcomeEvaluationWidget()),
  Routes.PAGE_OUTCOME_EVALUATION_DETAIL: (context) => AuthGuard(child: OutcomeEvaluationDetailWidget()),
  Routes.PAGE_GOAL_SETTING: (context) => AuthGuard(child: GoalSettingWidget()),
  Routes.PAGE_GOAL_EDITOR: (context) => AuthGuard(child: GoalEditorWidget()),
},
            theme: themeController.theme,
            home: const AuthCheckWidget(),
          );
        }
      )
    );
  }
}