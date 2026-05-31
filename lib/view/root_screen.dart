import 'package:flutter/material.dart';

import '../data/auth_repository.dart';
import '../viewmodel/app_view_model.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';

//выбор экрана по состоянию авторизации
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final viewModel = AppViewModel(AuthRepository());

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        switch (viewModel.status) {
          case AuthStatus.loading:
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          case AuthStatus.authenticated:
            return HomeScreen(viewModel: viewModel);
          case AuthStatus.unauthenticated:
            return WelcomeScreen(viewModel: viewModel);
        }
      },
    );
  }
}
