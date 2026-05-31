import 'package:flutter/material.dart';

import '../viewmodel/app_view_model.dart';
import 'auth_screen.dart';

//то, что видит гость - только приветствие и предложение войти
//секретный экран доступен уже после авторизации
class WelcomeScreen extends StatelessWidget {
  final AppViewModel viewModel;

  const WelcomeScreen({super.key, required this.viewModel});

  void _openAuth(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => AuthScreen(viewModel: viewModel)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.waving_hand_outlined, size: 72, color: theme.colorScheme.primary),
                  const SizedBox(height: 20),
                  Text(
                    'Добро пожаловать',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Вы зашли как гость',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
                  ),
                  const SizedBox(height: 24),
                  //подсказка гостю про ограниченный доступ
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.lock_outline, color: theme.colorScheme.primary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Секретный экран доступен только после входа. '
                              'Войдите или зарегистрируйтесь, чтобы его открыть.',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _openAuth(context),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.login),
                    label: const Text('Войти или зарегистрироваться'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
