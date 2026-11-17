import 'package:material_ui/material_ui.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../repository/models.dart';
import '../../../../repository/repository_impl.dart';
import '../../../../widgets/card_proyects.dart';
import '../../../../widgets/status_views.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, this.repository});

  final RepositoryImpl? repository;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final RepositoryImpl _repository = widget.repository ?? RepositoryImpl();
  late Future<DashboardStats> _stats = _repository.fetchDashboardStats();

  Future<void> _reload() async {
    setState(() {
      _stats = _repository.fetchDashboardStats();
    });
    await _stats;
  }

  void _openProject(String title, String description) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description, style: ThemeText.body),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reload,
      child: FutureBuilder<DashboardStats>(
        future: _stats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(label: 'Carregando o painel');
          }
          if (snapshot.hasError) {
            final message = snapshot.error is RepositoryException
                ? (snapshot.error! as RepositoryException).message
                : 'Não foi possível carregar o painel.';
            return ErrorView(message: message, onRetry: _reload);
          }

          final stats = snapshot.data!;
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            children: [
              const Text('Painel', style: ThemeText.display),
              const SizedBox(height: 8),
              const Text(
                'Resumo das escolas e dos três projetos de espanhol.',
                style: ThemeText.body,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _StatCard(label: 'Escolas', value: '${stats.schools}'),
                  _StatCard(label: 'Turmas', value: '${stats.classRooms}'),
                  _StatCard(label: 'Professores', value: '${stats.teachers}'),
                ],
              ),
              const SizedBox(height: 28),
              const Text('Projetos', style: ThemeText.title),
              const SizedBox(height: 12),
              CardProyecto(
                title: Strings.titleCardUno,
                description: Strings.descriptionCardUno,
                accent: ThemeColors.yellow,
                onTap: () => _openProject(
                  Strings.titleCardUno,
                  Strings.descriptionCardUno,
                ),
              ),
              const SizedBox(height: 12),
              CardProyecto(
                title: Strings.titleCardDos,
                description: Strings.descriptionCardDos,
                accent: ThemeColors.blue,
                onTap: () => _openProject(
                  Strings.titleCardDos,
                  Strings.descriptionCardDos,
                ),
              ),
              const SizedBox(height: 12),
              CardProyecto(
                title: Strings.titleCardTres,
                description: Strings.descriptionCardTres,
                accent: ThemeColors.green,
                onTap: () => _openProject(
                  Strings.titleCardTres,
                  Strings.descriptionCardTres,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: ThemeText.subtitle),
              const SizedBox(height: 6),
              Text(value, style: ThemeText.title),
            ],
          ),
        ),
      ),
    );
  }
}
