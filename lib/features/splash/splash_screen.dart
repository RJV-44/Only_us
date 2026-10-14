import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_button.dart';
import '../../routing/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.favorite_rounded, size: 72, color: Color(0xFFB34F68)),
              const SizedBox(height: 20),
              Text(
                AppConstants.appName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'A little space for the two of you.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              AppButton(
                label: 'Get started',
                onPressed: () => Navigator.pushNamed(context, AppRouter.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
