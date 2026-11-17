import 'package:material_ui/material_ui.dart';

import '../commons/styles.dart';

class CardProyecto extends StatelessWidget {
  const CardProyecto({
    super.key,
    required this.title,
    required this.description,
    required this.accent,
    required this.onTap,
  });

  final String title;
  final String description;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 72,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: ThemeText.label.copyWith(fontSize: 16)),
                    const SizedBox(height: 6),
                    Text(description, style: ThemeText.body),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: ThemeColors.grayLight),
            ],
          ),
        ),
      ),
    );
  }
}
