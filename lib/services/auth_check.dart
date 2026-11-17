import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';

import '../app/src/presentation/home/home_page.dart';
import '../app/src/presentation/login/login_page.dart';
import '../commons/styles.dart';
import '../widgets/status_views.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: LoadingView(label: 'Conferindo a sessão'),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: const ErrorView(
              message: 'Não foi possível verificar o login. Recarregue a página.',
            ),
          );
        }
        if (snapshot.data == null) {
          return const LoginPage();
        }
        return const HomePage();
      },
    );
  }
}

class StartupErrorApp extends StatelessWidget {
  const StartupErrorApp({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: Scaffold(
        body: ErrorView(
          message: 'O painel não conseguiu iniciar.\n$message',
          onRetry: null,
        ),
      ),
    );
  }
}
