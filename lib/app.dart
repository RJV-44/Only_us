import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'routing/app_router.dart';

class OnlyUsApp extends StatelessWidget {
  const OnlyUsApp({this.supabaseClient, super.key});

  final SupabaseClient? supabaseClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.light,
      initialRoute: AppRouter.splash,
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(
        settings,
        supabaseClient: supabaseClient,
      ),
    );
  }
}
