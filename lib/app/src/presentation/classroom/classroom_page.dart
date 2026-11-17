import 'package:material_ui/material_ui.dart';

import '../../../../commons/styles.dart';
import '../../../../repository/models.dart';
import '../../../../repository/repository_impl.dart';
import '../../../../widgets/status_views.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({
    super.key,
    required this.schoolId,
    required this.schoolName,
    this.repository,
  });

  final String schoolId;
  final String schoolName;
  final RepositoryImpl? repository;

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  late final RepositoryImpl _repository = widget.repository ?? RepositoryImpl();
  late Future<List<ClassRoomRecord>> _rooms =
      _repository.fetchClassRooms(widget.schoolId);

  Future<void> _reload() async {
    setState(() {
      _rooms = _repository.fetchClassRooms(widget.schoolId);
    });
    await _rooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Turmas de ${widget.schoolName}')),
      body: RefreshIndicator(
        onRefresh: _reload,
        child: FutureBuilder<List<ClassRoomRecord>>(
          future: _rooms,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingView(label: 'Carregando turmas');
            }
            if (snapshot.hasError) {
              final message = snapshot.error is RepositoryException
                  ? (snapshot.error! as RepositoryException).message
                  : 'Não foi possível carregar as turmas.';
              return ErrorView(message: message, onRetry: _reload);
            }

            final rooms = snapshot.data ?? const <ClassRoomRecord>[];
            if (rooms.isEmpty) {
              return const EmptyView(
                title: 'Nenhuma turma',
                message: 'Esta escola ainda não tem turmas cadastradas.',
                icon: Icons.groups_outlined,
              );
            }

            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
              itemCount: rooms.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _ClassCard(room: rooms[index]),
            );
          },
        ),
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  const _ClassCard({required this.room});

  final ClassRoomRecord room;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.groups, color: ThemeColors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(room.name, style: ThemeText.label.copyWith(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (room.teachers.isEmpty)
              const Text('Nenhum professor vinculado.', style: ThemeText.body)
            else
              for (final teacher in room.teachers) ...[
                Text(teacher.name, style: ThemeText.label),
                if (teacher.email.isNotEmpty)
                  SelectableText(teacher.email, style: ThemeText.body),
                const SizedBox(height: 8),
              ],
          ],
        ),
      ),
    );
  }
}
