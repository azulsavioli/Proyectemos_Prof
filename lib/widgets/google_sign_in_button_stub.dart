import 'package:material_ui/material_ui.dart';

import '../commons/styles.dart';

Widget buildGoogleSignInButton(BuildContext context) {
  return const SizedBox(
    height: 48,
    child: Center(
      child: Text(
        'A entrada com Google fica disponível na versão web.',
        style: ThemeText.body,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
