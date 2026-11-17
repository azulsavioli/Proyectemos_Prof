import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassesPage extends StatelessWidget {
  final String schoolId;
  final String schoolName;

  const ClassesPage({
    Key? key,
    required this.schoolId,
    required this.schoolName,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> getClassRoomData() async {
    final classRoomRef =
        FirebaseFirestore.instance.collection('escolas/$schoolId/turmas');
    List<Map<String, dynamic>> classRooms = [];

    try {
      await classRoomRef.get().then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          final classData = doc.data();
          if (classData == null) return;
          classRooms.add(classData as Map<String, dynamic>);
        }
      });
    } catch (error) {
      print("Erro ao buscar turmas: $error");
    }

    return classRooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turmas de $schoolName'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getClassRoomData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar turmas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma turma encontrada'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data![index];
                var classData = data['classData'];
                var teachersData = data['teachersData'];

                return ClassCard(
                  classData: classData,
                  teachersData: teachersData,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final Map<String, dynamic> classData;
  final List<Map<String, dynamic>> teachersData;

  const ClassCard({
    Key? key,
    required this.classData,
    required this.teachersData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(classData['className'] ?? 'Nome não disponível'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: teachersData.map((teacherData) {
            return Text(
              "Nome professor: ${teacherData['nome']}\nEmail professor: ${teacherData['email']}" ??
                  "Nome e email do professor não estão disponíveis",
            );
          }).toList(),
        ),
        trailing: const Icon(Icons.class_),
      ),
    );
  }
}
