import 'package:material_ui/material_ui.dart';

import '../commons/styles.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.label = 'Carregando'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return fillScroll(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(label, style: ThemeText.subtitle),
        ],
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return fillScroll(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, color: ThemeColors.red, size: 40),
              const SizedBox(height: 12),
              Semantics(
                liveRegion: true,
                child: Text(
                  message,
                  style: ThemeText.body,
                  textAlign: TextAlign.center,
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Tentar de novo'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.icon = Icons.inbox_outlined,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return fillScroll(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: ThemeColors.yellow, size: 42),
              const SizedBox(height: 12),
              Text(title, style: ThemeText.title, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                message,
                style: ThemeText.body,
                textAlign: TextAlign.center,
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 16),
                FilledButton(onPressed: onAction, child: Text(actionLabel!)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Lista rolável que preenche a altura disponível, para o gesto de atualizar
/// funcionar mesmo quando o conteúdo é menor que a tela.
Widget fillScroll({required Widget child}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final minHeight = constraints.maxHeight.isFinite ? constraints.maxHeight : 0.0;
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Center(child: child),
          ),
        ],
      );
    },
  );
}
