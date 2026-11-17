import 'package:material_ui/material_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../commons/strings.dart';
import '../commons/styles.dart';

class InstagramLink extends StatelessWidget {
  const InstagramLink({super.key, this.compact = false});

  final bool compact;

  Future<void> _open(BuildContext context) async {
    final uri = Uri.parse(Strings.instagramUrl);
    final opened = await launchUrl(uri, webOnlyWindowName: '_blank');
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o Instagram.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      tooltip: '${Strings.instagramLabel} da UFSC',
      onPressed: () => _open(context),
      icon: const FaIcon(FontAwesomeIcons.instagram),
      color: ThemeColors.yellow,
    );

    return Semantics(
      link: true,
      label: Strings.instagramLabel,
      child: compact
          ? button
          : TextButton.icon(
              onPressed: () => _open(context),
              icon: const FaIcon(FontAwesomeIcons.instagram, size: 18),
              label: const Text(Strings.instagramLabel),
              style: TextButton.styleFrom(foregroundColor: ThemeColors.yellow),
            ),
    );
  }
}
