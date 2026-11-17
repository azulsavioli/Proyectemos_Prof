import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../commons/styles.dart';
import '../providers/google_sign_in_provider.dart';
import '../services/auth_check.dart';
import 'src/presentation/login/login_page.dart';
import 'src/presentation/registration/registration_page.dart';

class ProyectemosProf extends StatelessWidget {
  const ProyectemosProf({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proyectemos Prof',
        theme: buildAppTheme(),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthCheck(),
          '/login': (context) => const LoginPage(),
          '/registration': (context) => const RegistrationPage(),
        },
      ),
    );
  }
}
