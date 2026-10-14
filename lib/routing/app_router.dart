import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/auth/register_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/media/image_preview_screen.dart';
import '../features/media/media_viewer_screen.dart';
import '../features/memories/memories_screen.dart';
import '../features/profile/edit_profile_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/settings/privacy_settings_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/splash/splash_screen.dart';

abstract final class AppRouter {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const chat = '/chat';
  static const media = '/media';
  static const imagePreview = '/media/image-preview';
  static const memories = '/memories';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const settings = '/settings';
  static const privacySettings = '/settings/privacy';

  static Route<dynamic> onGenerateRoute(
    RouteSettings routeSettings, {
    SupabaseClient? supabaseClient,
  }) {
    final Widget screen = switch (routeSettings.name) {
      AppRouter.splash => const SplashScreen(),
      AppRouter.login => LoginScreen(supabaseClient: supabaseClient),
      AppRouter.register => RegisterScreen(supabaseClient: supabaseClient),
      AppRouter.chat => ChatScreen(
          supabaseClient: supabaseClient,
          arguments: routeSettings.arguments,
        ),
      AppRouter.media => const MediaViewerScreen(),
      AppRouter.imagePreview => routeSettings.arguments is ImagePreviewArguments
          ? ImagePreviewScreen(
              arguments: routeSettings.arguments! as ImagePreviewArguments,
            )
          : const _MissingRouteArgumentScreen(
              message: 'No image was provided for preview.',
            ),
      AppRouter.memories => const MemoriesScreen(),
      AppRouter.profile => ProfileScreen(supabaseClient: supabaseClient),
      AppRouter.editProfile => routeSettings.arguments is SupabaseClient
          ? EditProfileScreen(
              supabaseClient: routeSettings.arguments! as SupabaseClient,
            )
          : const _MissingRouteArgumentScreen(
              message: 'Profile is unavailable.',
            ),
      AppRouter.settings => SettingsScreen(supabaseClient: supabaseClient),
      AppRouter.privacySettings => const PrivacySettingsScreen(),
      _ => const SplashScreen(),
    };
    return MaterialPageRoute<void>(
      builder: (_) => screen,
      settings: routeSettings,
    );
  }
}

class _MissingRouteArgumentScreen extends StatelessWidget {
  const _MissingRouteArgumentScreen({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unavailable')),
      body: Center(child: Text(message)),
    );
  }
}

class ChatRouteArguments {
  const ChatRouteArguments({
    this.conversationId,
    this.isPreview = false,
  });

  final String? conversationId;
  final bool isPreview;

  const ChatRouteArguments.preview() : this(isPreview: true);
}
