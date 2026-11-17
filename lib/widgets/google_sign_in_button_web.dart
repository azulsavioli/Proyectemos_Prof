import 'package:flutter/widgets.dart';
import 'package:google_sign_in_web/web_only.dart';

Widget buildGoogleSignInButton(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final available = constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
      final width = available.clamp(160.0, 360.0);
      return Align(
        alignment: Alignment.centerLeft,
        child: renderButton(
          configuration: GSIButtonConfiguration(
            type: GSIButtonType.standard,
            theme: GSIButtonTheme.filledBlack,
            size: GSIButtonSize.large,
            text: GSIButtonText.continueWith,
            shape: GSIButtonShape.pill,
            logoAlignment: GSIButtonLogoAlignment.left,
            minimumWidth: width,
            locale: 'pt-BR',
          ),
        ),
      );
    },
  );
}
