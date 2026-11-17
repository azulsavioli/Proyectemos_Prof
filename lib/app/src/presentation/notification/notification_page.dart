import 'package:material_ui/material_ui.dart';

import '../../../../commons/styles.dart';
import '../../../../repository/models.dart';
import '../../../../repository/repository_impl.dart';
import '../../../../widgets/status_views.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, this.repository});

  final RepositoryImpl? repository;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

String _formatDate(DateTime date) {
  final local = date.toLocal();
  String two(int value) => value.toString().padLeft(2, '0');
  return '${two(local.day)}/${two(local.month)}/${local.year} '
      '${two(local.hour)}:${two(local.minute)}';
}

class _NotificationPageState extends State<NotificationPage> {
  late final RepositoryImpl _repository = widget.repository ?? RepositoryImpl();
  late Future<List<AppNotification>> _items = _repository.fetchNotifications();

  Future<void> _reload() async {
    setState(() {
      _items = _repository.fetchNotifications();
    });
    await _items;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reload,
      child: FutureBuilder<List<AppNotification>>(
        future: _items,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(label: 'Carregando notificações');
          }
          if (snapshot.hasError) {
            final message = snapshot.error is RepositoryException
                ? (snapshot.error! as RepositoryException).message
                : 'Não foi possível carregar as notificações.';
            return ErrorView(message: message, onRetry: _reload);
          }

          final items = snapshot.data ?? const <AppNotification>[];
          if (items.isEmpty) {
            return const EmptyView(
              title: 'Nenhuma notificação',
              message: 'Quando houver avisos para os professores, eles aparecem aqui.',
              icon: Icons.notifications_none,
            );
          }

          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            itemCount: items.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('Notificações', style: ThemeText.display),
                );
              }
              final item = items[index - 1];
              final when = item.createdAt == null ? null : _formatDate(item.createdAt!);
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: ThemeText.label.copyWith(fontSize: 16)),
                      if (item.body.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(item.body, style: ThemeText.body),
                      ],
                      if (when != null) ...[
                        const SizedBox(height: 8),
                        Text(when, style: ThemeText.subtitle),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
