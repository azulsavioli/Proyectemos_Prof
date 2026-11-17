import 'package:material_ui/material_ui.dart';

import '../../../../commons/styles.dart';
import '../../../../commons/validators.dart';
import '../../../../repository/repository_impl.dart';
import '../../../../widgets/custom_button_icon_right.dart';
import '../../../../widgets/custom_text_form_field.dart';
import 'registration_controller.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, this.controller});

  final RegistrationController? controller;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _teacherName = TextEditingController();
  final _school = TextEditingController();
  final _classRoom = TextEditingController();
  final _teacherEmail = TextEditingController();
  late final RegistrationController _controller =
      widget.controller ?? RegistrationController();

  bool _saving = false;

  @override
  void dispose() {
    _teacherName.dispose();
    _school.dispose();
    _classRoom.dispose();
    _teacherEmail.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _saving = true);
    try {
      await _controller.saveTeacher(
        teacherName: _teacherName.text,
        schoolName: _school.text,
        classRoom: _classRoom.text,
        teacherEmail: _teacherEmail.text,
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Turma salva.')),
      );
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(true);
      } else {
        await Navigator.of(context).pushReplacementNamed('/');
      }
    } on RepositoryException catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de turma'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Dados da turma', style: ThemeText.title),
                        const SizedBox(height: 8),
                        const Text(
                          'A escola é reaproveitada se o nome já existir. O mesmo vale para a turma.',
                          style: ThemeText.body,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: _teacherName,
                          label: 'Nome do professor',
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.name],
                          validator: validateRequired,
                        ),
                        const SizedBox(height: 14),
                        CustomTextFormField(
                          controller: _school,
                          label: 'Escola',
                          textInputAction: TextInputAction.next,
                          validator: validateRequired,
                        ),
                        const SizedBox(height: 14),
                        CustomTextFormField(
                          controller: _classRoom,
                          label: 'Turma',
                          textInputAction: TextInputAction.next,
                          validator: validateRequired,
                        ),
                        const SizedBox(height: 14),
                        CustomTextFormField(
                          controller: _teacherEmail,
                          label: 'E-mail de contato',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.email],
                          onFieldSubmitted: (_) => _submit(),
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 24),
                        CustomButtonIconRight(
                          isLoading: _saving,
                          onPressed: _submit,
                          backgroundButtonColor: ThemeColors.yellow,
                          icon: const Icon(Icons.arrow_forward, color: Colors.white),
                          buttonText: 'Salvar',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
