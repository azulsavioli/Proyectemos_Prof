import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BRESS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Emily Jonson'),
              accountEmail: Text('jonson@bress.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Substitua pela imagem correta
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Projects'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Task list'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Services'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chat'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last tasks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '117 total, proceed to resolve them',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  TaskCard(
                    name: 'ClientOnboarding - Circle',
                    admin: 'Samanta J.',
                    members: 3,
                    status: 'In progress',
                    runTime: '6 hours',
                    finishDate: '6 Mon',
                  ),
                  TaskCard(
                    name: 'Meeting with Webflow & Notion',
                    admin: 'Bob P.',
                    members: 4,
                    status: 'Done',
                    runTime: '2 hours',
                    finishDate: '7 Tue',
                  ),
                  TaskCard(
                    name: 'First Handoff with Engineers',
                    admin: 'Kate O.',
                    members: 10,
                    status: 'In progress',
                    runTime: '3 days',
                    finishDate: '10 Fri',
                  ),
                  TaskCard(
                    name: 'Client Drafting (2) with Lawrence',
                    admin: 'Jack F.',
                    members: 7,
                    status: 'In progress',
                    runTime: '1 week',
                    finishDate: '19 Sun',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Productivity',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: const FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 1),
                          const FlSpot(1, 2),
                          const FlSpot(2, 3),
                          const FlSpot(3, 4),
                          const FlSpot(4, 3),
                          const FlSpot(5, 2),
                          const FlSpot(6, 1),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 2),
                          const FlSpot(1, 3),
                          const FlSpot(2, 2),
                          const FlSpot(3, 3),
                          const FlSpot(4, 4),
                          const FlSpot(5, 3),
                          const FlSpot(6, 2),
                        ],
                        isCurved: true,
                        color: Colors.purple,
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String name;
  final String admin;
  final int members;
  final String status;
  final String runTime;
  final String finishDate;

  const TaskCard({super.key,
    required this.name,
    required this.admin,
    required this.members,
    required this.status,
    required this.runTime,
    required this.finishDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('Admin: $admin, Members: $members'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(status),
            Text('$runTime - $finishDate'),
          ],
        ),
      ),
    );
  }
}
