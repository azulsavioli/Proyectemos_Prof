import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyectemos_prof/commons/styles.dart';

import '../../../../commons/strings.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();
  bool loadingGoogle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.grayLight2,
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '¡Bienvenidos a Proyectemos!',
                      style: ThemeText.paragraph14YellowBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      Strings.descriptionLogin,
                      style: ThemeText.paragraph6Gray,
                    ),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(ThemeColors.yellow),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _controller.login().then(
                                (_) => Navigator.pushNamed(context, '/'),
                              );
                          setState(() {
                            loadingGoogle = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: loadingGoogle
                              ? [
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ]
                              : [
                                  const FaIcon(
                                    FontAwesomeIcons.google,
                                    color: ThemeColors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      Strings.iniciaSessao,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(6),
                                          color: ThemeColors.white),
                                    ),
                                  )
                                ],
                        ),
                      ),
                    ),
                    Text(
                      Strings.capesDescription,
                      style: ThemeText.paragraph4Gray,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset(
                    'images/login_img.png',
                    height: 700,
                    width: 700,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
