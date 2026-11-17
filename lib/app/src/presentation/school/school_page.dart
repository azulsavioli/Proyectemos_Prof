import 'package:material_ui/material_ui.dart';

import '../../../../commons/styles.dart';
import '../../../../repository/models.dart';
import '../../../../repository/repository_impl.dart';
import '../../../../widgets/status_views.dart';
import '../classroom/classroom_page.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key, this.repository});

  final RepositoryImpl? repository;

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  late final RepositoryImpl _repository = widget.repository ?? RepositoryImpl();
  late Future<List<SchoolRecord>> _schools = _repository.fetchSchools();

  Future<void> _reload() async {
    setState(() {
      _schools = _repository.fetchSchools();
    });
    await _schools;
  }

  Future<void> _openRegistration() async {
    final saved = await Navigator.pushNamed(context, '/registration');
    if (saved == true) {
      await _reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openRegistration,
        backgroundColor: ThemeColors.yellow,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nova turma'),
      ),
      body: RefreshIndicator(
        onRefresh: _reload,
        child: FutureBuilder<List<SchoolRecord>>(
          future: _schools,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingView(label: 'Carregando escolas');
            }
            if (snapshot.hasError) {
              final message = snapshot.error is RepositoryException
                  ? (snapshot.error! as RepositoryException).message
                  : 'Não foi possível carregar as escolas.';
              return ErrorView(message: message, onRetry: _reload);
            }

            final schools = snapshot.data ?? const <SchoolRecord>[];
            if (schools.isEmpty) {
              return EmptyView(
                title: 'Nenhuma escola ainda',
                message:
                    'Cadastre a primeira turma para a escola aparecer nesta lista.',
                actionLabel: 'Cadastrar turma',
                onAction: _openRegistration,
                icon: Icons.school_outlined,
              );
            }

            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 96),
              children: [
                Text(
                  'Escolas',
                  style: ThemeText.display.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 4),
                Text(
                  '${schools.length} no total',
                  style: ThemeText.subtitle,
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final twoColumns = constraints.maxWidth >= 800;
                    final cards = [
                      for (final school in schools)
                        _SchoolCard(
                          school: school,
                          onOpen: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => ClassesPage(
                                  schoolId: school.id,
                                  schoolName: school.name,
                                  repository: _repository,
                                ),
                              ),
                            );
                          },
                        ),
                    ];
                    if (!twoColumns) {
                      return Column(
                        children: [
                          for (final card in cards) ...[
                            card,
                            const SizedBox(height: 12),
                          ],
                        ],
                      );
                    }
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for (final card in cards)
                          SizedBox(
                            width: (constraints.maxWidth - 12) / 2,
                            child: card,
                          ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SchoolCard extends StatelessWidget {
  const _SchoolCard({required this.school, required this.onOpen});

  final SchoolRecord school;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final classLabel = school.classCount == 1 ? '1 turma' : '${school.classCount} turmas';
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: ThemeColors.yellow,
                child: Icon(Icons.school, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(school.name, style: ThemeText.label.copyWith(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(classLabel, style: ThemeText.body),
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
