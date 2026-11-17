import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../providers/google_sign_in_provider.dart';
import '../../../../widgets/google_sign_in_button.dart';
import '../../../../widgets/instagram_link.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<GoogleSignInProvider>();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 960;
          final form = _LoginForm(busy: auth.busy, error: auth.lastError);
          final art = Padding(
            padding: const EdgeInsets.all(40),
            child: Image.asset(
              Strings.loginImage,
              fit: BoxFit.contain,
              semanticLabel: 'Ilustração de boas-vindas do Proyectemos',
            ),
          );

          if (!wide) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    SizedBox(height: 240, child: art),
                    form,
                  ],
                ),
              ),
            );
          }

          return SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(40),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: form,
                      ),
                    ),
                  ),
                ),
                Expanded(child: art),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({required this.busy, required this.error});

  final bool busy;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          Strings.logo,
          height: 64,
          width: 64,
          semanticLabel: 'Logo do Proyectemos',
        ),
        const SizedBox(height: 20),
        const Text(Strings.bemvindos, style: ThemeText.display),
        const SizedBox(height: 12),
        const Text(Strings.descriptionLogin, style: ThemeText.body),
        const SizedBox(height: 28),
        const Text(Strings.googleHint, style: ThemeText.subtitle),
        const SizedBox(height: 16),
        if (busy)
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: LinearProgressIndicator(),
          ),
        const GoogleSignInButton(),
        if (error != null && error!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Semantics(
            liveRegion: true,
            child: Text(
              error!,
              style: ThemeText.body.copyWith(color: ThemeColors.red),
            ),
          ),
        ],
        const SizedBox(height: 28),
        const Text(Strings.capesDescription, style: ThemeText.subtitle),
        const SizedBox(height: 16),
        const InstagramLink(),
      ],
    );
  }
}
