import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classroom/classroom_page.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key});

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  Future<List<Map<String, dynamic>>> getAllSchools() async {
    final schoolsRef = FirebaseFirestore.instance.collection('escolas');
    List<Map<String, dynamic>> schools = [];

    try {
      await schoolsRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          var schoolData = doc.data() as Map<String, dynamic>;
          schoolData['id'] = doc.id;
          schools.add(schoolData);
        }
      });
    } catch (error) {
      print("Erro ao buscar escolas: $error");
    }

    return schools;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getAllSchools(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar escolas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Parte 1: Lista de cards de escolas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Escolas',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        // Exemplo de contagem total de escolas
                        Text(
                          '${snapshot.data!.length} total',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var school = snapshot.data![index];
                          return SchoolCard(school: school);
                        },
                      ),
                    ),

                    // Parte 2: Card para a página de cadastro de escolas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cadastro de escolas',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/registration');
                          },
                          child: const Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Partes 3 e 4 podem ser adicionadas aqui conforme necessário
                  ],
                ));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Parte 1: Lista de cards de escolas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Escolas',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      // Exemplo de contagem total de escolas
                      Text(
                        '${snapshot.data!.length} total',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var school = snapshot.data![index];
                        return SchoolCard(school: school);
                      },
                    ),
                  ),

                  // Parte 2: Card para a página de cadastro de escolas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cadastro de escolas',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/registration');
                        },
                        child: const Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Partes 3 e 4 podem ser adicionadas aqui conforme necessário
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class SchoolCard extends StatefulWidget {
  final Map<String, dynamic> school;

  const SchoolCard({super.key, required this.school});

  @override
  _SchoolCardState createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> {
  late Future<int> classCount;

  Future<int> getClassCount(String schoolId) async {
    final classRoomRef = FirebaseFirestore.instance
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas');
    int classCount = 0;

    try {
      await classRoomRef.get().then((QuerySnapshot querySnapshot) {
        classCount = querySnapshot.size;
      });
    } catch (error) {
      print("Erro ao buscar quantidade de turmas: $error");
    }
    return classCount;
  }

  @override
  void initState() {
    super.initState();
    classCount = getClassCount(widget.school['id']);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassesPage(
                schoolId: widget.school['id'],
                schoolName: widget.school['schoolName']),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          title: Text(widget.school['schoolName'] ?? 'Nome não disponível'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<int>(
                future: classCount,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Carregando...');
                  } else if (snapshot.hasError) {
                    return const Text('Erro ao carregar turmas');
                  } else {
                    return Text('Turmas: ${snapshot.data}');
                  }
                },
              ),
            ],
          ),
          trailing: const Icon(Icons.school),
        ),
      ),
    );
  }
}
