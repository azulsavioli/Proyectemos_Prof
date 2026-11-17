// import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:fl_chart/fl_chart.dart';

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   // List<FlSpot> researchSpots = [];
//   // List<FlSpot> designSpots = [];

//   @override
//   void initState() {
//     super.initState();
//     // fetchData();
//   }
//   //
//   // void fetchData() async {
//   //   FirebaseFirestore.instance
//   //       .collection('productivity')
//   //       .snapshots()
//   //       .listen((snapshot) {
//   //     List<FlSpot> newResearchSpots = [];
//   //     List<FlSpot> newDesignSpots = [];
//   //
//   //     for (var doc in snapshot.docs) {
//   //       var data = doc.data();
//   //       newResearchSpots.add(FlSpot(data['day'], data['research']));
//   //       newDesignSpots.add(FlSpot(data['day'], data['design']));
//   //     }
//   //
//   //     setState(() {
//   //       researchSpots = newResearchSpots;
//   //       designSpots = newDesignSpots;
//   //     });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController textController = TextEditingController();

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 AnimSearchBar(
//                   onSubmitted: (String value) {},
//                   width: 400,
//                   textController: textController,
//                   onSuffixTap: () {
//                     setState(() {
//                       textController.clear();
//                     });
//                   },
//                 ),
//               ],
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Últimas tarefas',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView(
//                 children: const [
//                   TaskCard(
//                     name: 'ClientOnboarding - Circle',
//                     alunos: ['Samanta J.'],
//                     members: 3,
//                     runTime: '6 hours',
//                     finishDate: '6 Mon',
//                   ),
//                   TaskCard(
//                     name: 'Meeting with Webflow & Notion',
//                     alunos: ['Bob P.'],
//                     members: 4,
//                     runTime: '2 hours',
//                     finishDate: '7 Tue',
//                   ),
//                   TaskCard(
//                     name: 'First Handoff with Engineers',
//                     alunos: ['Kate O.'],
//                     members: 10,
//                     runTime: '3 days',
//                     finishDate: '10 Fri',
//                   ),
//                   TaskCard(
//                     name: 'Client Drafting (2) with Lawrence',
//                     alunos: ['Jack F.'],
//                     members: 7,
//                     runTime: '1 week',
//                     finishDate: '19 Sun',
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TaskCard extends StatelessWidget {
//   final String name;
//   final List<String> alunos;
//   final int members;
//   final String runTime;
//   final String finishDate;

//   const TaskCard({
//     super.key,
//     required this.name,
//     required this.alunos,
//     required this.members,
//     required this.runTime,
//     required this.finishDate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         title: Text(name),
//         subtitle: Text('Alunos: $alunos'),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text('$runTime - $finishDate'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos_prof/commons/styles.dart';

class SpanishStudyPage extends StatefulWidget {
  const SpanishStudyPage({super.key});

  @override
  State<SpanishStudyPage> createState() => _SpanishStudyPageState();
}

class _SpanishStudyPageState extends State<SpanishStudyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Proyectemos'),
        backgroundColor: ThemeColors.yellow,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de Língua Espanhola
            _buildSpanishClassSection(),
            const SizedBox(height: 24),
            
            // Seção de Livros
            _buildBooksSection(),
            const SizedBox(height: 24),
            
            // Seção de Progresso do Curso
            _buildCourseProgressSection(),
            const SizedBox(height: 24),
            
            // Seção de Aulas de Hoje
            _buildTodayClassesSection(),
            const SizedBox(height: 24),
 
          ],
        ),
      ),
    );
  }

  Widget _buildSpanishClassSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Língua Espanhola',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Você tem uma atividade nova para corrigir',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }

  Widget _buildBooksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Livros',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildInfoCard('Latinoamerica'),
        const SizedBox(height: 8),
        _buildInfoCard('Podcast'),
      ],
    );
  }

  Widget _buildCourseProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Progresso do Curso',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildProgressIndicator('Progresso de hoje', 0.6),
            const SizedBox(width: 16),
            _buildProgressIndicator('Progresso do curso', 0.8),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildProgressIndicator('Atividades do módulo', 0.4),
            const SizedBox(width: 16),
            _buildProgressIndicator('Em Progresso', 0.3),
          ],
        ),
      ],
    );
  }

Widget _buildTodayClassesSection() {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Aulas de Hoje',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildClassCard('13:30-14:30', 'Espanhol Básico', 'Todos'),
              const SizedBox(height: 8),
              _buildClassCard('15:00-16:00', 'Espanhol Avançado', 'San Francisco'),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Estatísticas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                
              ),
              const SizedBox(height: 8),
              _buildStatCard('Atividades', '5,980'),
              const SizedBox(height: 8),
              _buildStatCard('Feedbacks', '4,324'),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildInfoCard(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(String title, double progress) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.yellow),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(String time, String title, String location) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            location,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String title, String value) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}