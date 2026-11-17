import 'package:flutter/widgets.dart';

import 'google_sign_in_button_stub.dart'
    if (dart.library.js_interop) 'google_sign_in_button_web.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) => buildGoogleSignInButton(context);
}
