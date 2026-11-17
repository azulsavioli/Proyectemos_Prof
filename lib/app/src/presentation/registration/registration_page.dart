import 'package:flutter/material.dart';
import 'package:proyectemos_prof/app/src/presentation/registration/registration_controller.dart';
import 'package:proyectemos_prof/widgets/custom_text_form_field.dart';

import '../../../../commons/styles.dart';
import '../../../../widgets/custom_button_icon_right.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final school = TextEditingController();
  final serie = TextEditingController();
  final classRoom = TextEditingController();
  final teacherName = TextEditingController();
  final teacherEmail = TextEditingController();
  final _controller = RegistrationController();

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    const isLoading = false;

    final formKey = GlobalKey<FormState>();
    return Card(
      shadowColor: ThemeColors.gray,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cadastro de turmas', style: ThemeText.paragraph8yellowBold),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Qual su nombre',
                          style: ThemeText.paragraph4Gray,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hint: 'Nombre',
                          controller: teacherName,
                          keyboardType: TextInputType.text,
                          isEmail: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Agregar escuela',
                          style: ThemeText.paragraph4Gray,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hint: 'Escuola',
                          controller: school,
                          keyboardType: TextInputType.text,
                          isEmail: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Agregar a classe',
                          style: ThemeText.paragraph4Gray,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hint: 'Classe',
                          controller: classRoom,
                          keyboardType: TextInputType.text,
                          isEmail: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Agregue el correo electrónico que recibirá las tareas y que sus estudiantes puedan contactar',
                          style: ThemeText.paragraph4Gray,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hint: 'Email',
                          controller: teacherEmail,
                          keyboardType: TextInputType.text,
                          isEmail: true,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButtonIconRight(
                          isLoading: isLoading,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              _controller
                                ..saveSchoolName(
                                  {'schoolName': school.text},
                                )
                                ..saveClassRoomName(
                                  school.text,
                                  classRoom.text,
                                  {'classRoom': classRoom.text},
                                )
                                ..saveTeacherInfo(
                                  school.text,
                                  classRoom.text,
                                  {
                                    'teacherName': teacherName.text,
                                    'teacherEmail': teacherEmail.text
                                  },
                                )
                                    // ..saveTeacherEmail(
                                    //   school.text,
                                    //   classRoom.text,
                                    //   {'teacherEmail': teacherEmail.text},
                                    // )
                                    .then(
                                  (_) => Navigator.pushNamed(context, '/home'),
                                );
                            }
                          },
                          backgroundButtonColor: ThemeColors.yellow,
                          icon: const Icon(Icons.arrow_forward_ios,
                              color: Colors.white),
                          buttonText: 'Guardar',
                        ),
                        // Add TextFormFields and ElevatedButton here.
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
