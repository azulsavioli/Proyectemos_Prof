import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos_prof/app/src/presentation/login/login_page.dart';
import 'package:proyectemos_prof/app/src/presentation/registration/registration_page.dart';
import 'package:proyectemos_prof/commons/strings.dart';
import 'package:proyectemos_prof/commons/styles.dart';
import 'package:proyectemos_prof/commons/validators.dart';
import 'package:proyectemos_prof/providers/google_sign_in_provider.dart';
import 'package:proyectemos_prof/widgets/card_proyects.dart';

void main() {
  test('validação de e-mail e de campos obrigatórios', () {
    expect(validateEmail(''), isNotNull);
    expect(validateEmail('professor'), isNotNull);
    expect(validateEmail('professor@escola.edu.br'), isNull);
    expect(validateRequired('A'), isNotNull);
    expect(validateRequired('Ana'), isNull);
  });

  test('a única rede social é o Instagram', () {
    expect(Strings.instagramUrl, contains('instagram.com'));
    expect(Strings.instagramUrl.toLowerCase(), isNot(contains('linkedin')));
    expect(Strings.instagramLabel, 'Instagram');
  });

  test('cancelar o Google não vira mensagem de erro', () {
    expect(
      describeAuthError(
        const GoogleSignInException(code: GoogleSignInExceptionCode.canceled),
      ),
      isEmpty,
    );
  });

  testWidgets('login mostra o Instagram e não cita LinkedIn', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GoogleSignInProvider(),
        child: MaterialApp(
          theme: buildAppTheme(),
          home: const LoginPage(),
        ),
      ),
    );

    expect(find.text(Strings.bemvindos), findsOneWidget);
    expect(find.text(Strings.instagramLabel), findsOneWidget);
    expect(find.textContaining('LinkedIn'), findsNothing);
    expect(find.textContaining('linkedin'), findsNothing);
  });

  testWidgets('cadastro aponta os campos vazios', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: const RegistrationPage(),
      ),
    );

    await tester.tap(find.text('Salvar'));
    await tester.pump();

    expect(find.text('Preencha este campo.'), findsNWidgets(3));
    expect(find.text('Informe o e-mail.'), findsOneWidget);
  });

  testWidgets('card de projeto abre a descrição', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(),
        home: Scaffold(
          body: CardProyecto(
            title: Strings.titleCardUno,
            description: Strings.descriptionCardUno,
            accent: ThemeColors.yellow,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text(Strings.titleCardUno), findsOneWidget);
    expect(find.textContaining('LinkedIn'), findsNothing);
    await tester.tap(find.text(Strings.titleCardUno));
    await tester.pump();
  });
}
