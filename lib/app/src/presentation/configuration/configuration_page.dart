import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../providers/google_sign_in_provider.dart';
import '../../../../widgets/instagram_link.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  Future<void> _signOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sair da conta'),
          content: const Text('A sessão deste navegador será encerrada.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
    await context.read<GoogleSignInProvider>().signOut();
    if (context.mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName?.trim();
    final email = user?.email ?? '';
    final photo = user?.photoURL;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Configurações', style: ThemeText.display),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: ThemeColors.yellow,
                  foregroundImage: photo == null ? null : NetworkImage(photo),
                  onForegroundImageError: photo == null ? null : (_, _) {},
                  child: Text(
                    _initials(name ?? email),
                    style: ThemeText.button,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (name == null || name.isEmpty) ? 'Professor(a)' : name,
                        style: ThemeText.label.copyWith(fontSize: 16),
                      ),
                      if (email.isNotEmpty)
                        SelectableText(email, style: ThemeText.body),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rede social', style: ThemeText.label),
                SizedBox(height: 4),
                Text(
                  'O painel mostra somente o Instagram.',
                  style: ThemeText.body,
                ),
                SizedBox(height: 8),
                InstagramLink(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => _signOut(context),
          icon: const Icon(Icons.logout),
          label: const Text('Sair'),
          style: OutlinedButton.styleFrom(
            foregroundColor: ThemeColors.red,
            minimumSize: const Size.fromHeight(48),
            side: const BorderSide(color: ThemeColors.red),
          ),
        ),
        const SizedBox(height: 24),
        const Text(Strings.capesDescription, style: ThemeText.subtitle),
      ],
    );
  }

  String _initials(String value) {
    final parts = value.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty);
    final letters = parts.take(2).map((part) => part[0].toUpperCase()).join();
    return letters.isEmpty ? 'P' : letters;
  }
}
