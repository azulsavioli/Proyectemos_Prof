import 'package:material_ui/material_ui.dart';

import '../commons/styles.dart';

class CustomButtonIconRight extends StatelessWidget {
  const CustomButtonIconRight({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.backgroundButtonColor,
    required this.icon,
    required this.buttonText,
  });

  final bool isLoading;
  final VoidCallback? onPressed;
  final Color backgroundButtonColor;
  final Icon icon;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundButtonColor,
          disabledBackgroundColor: backgroundButtonColor.withValues(alpha: 0.6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(buttonText, style: ThemeText.button),
                  const SizedBox(width: 8),
                  icon,
                ],
              ),
      ),
    );
  }
}
