import 'package:flutter/material.dart';

import '../features/auth/login_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/media/media_viewer_screen.dart';
import '../features/memories/memories_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/splash/splash_screen.dart';

abstract final class AppRouter {
  static const splash = '/';
  static const login = '/login';
  static const chat = '/chat';
  static const media = '/media';
  static const memories = '/memories';
  static const profile = '/profile';
  static const settings = '/settings';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    final Widget screen = switch (routeSettings.name) {
      AppRouter.splash => const SplashScreen(),
      AppRouter.login => const LoginScreen(),
      AppRouter.chat => const ChatScreen(),
      AppRouter.media => const MediaViewerScreen(),
      AppRouter.memories => const MemoriesScreen(),
      AppRouter.profile => const ProfileScreen(),
      AppRouter.settings => const SettingsScreen(),
      _ => const SplashScreen(),
    };
    return MaterialPageRoute<void>(
      builder: (_) => screen,
      settings: routeSettings,
    );
  }
}
