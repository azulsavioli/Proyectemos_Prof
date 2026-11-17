import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos_prof/app/src/presentation/dashboard/dashboard_page.dart';
// import 'package:proyectemos_prof/app/src/presentation/email/email_page.dart';
import 'package:proyectemos_prof/app/src/presentation/notification/notification_page.dart';
import 'package:proyectemos_prof/app/src/presentation/school/school_page.dart';
import 'package:proyectemos_prof/commons/styles.dart';

import '../configuration/configuration_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenuController = SideMenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            style: SideMenuStyle(
              showTooltip: true,
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              hoverColor: const Color(0xFFF4DABD),
              selectedHoverColor: ThemeColors.yellow,
              selectedColor: ThemeColors.yellow,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            controller: sideMenuController,
            title: const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    'Proyectemos',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      color: ThemeColors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                ],
              ),
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: ThemeColors.yellow,
                    borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    'Created by MoobaaLabs',
                    style: TextStyle(fontSize: 15, color: ThemeColors.white),
                  ),
                ),
              ),
            ),
            items: [
              // No arquivo home_page.dart, adicione este item ao SideMenu
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenuController.changePage(index);
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                icon: const Icon(Icons.home),
              ),
              SideMenuItem(
                title: 'Escolas',
                onTap: (index, _) {
                  sideMenuController.changePage(index);
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                icon: const Icon(Icons.school),
              ),
              // SideMenuItem(
              //   title: 'Email',
              //   onTap: (index, _) {
              //     sideMenuController.changePage(index);
              //     pageController.animateToPage(index,
              //         duration: const Duration(milliseconds: 300),
              //         curve: Curves.easeIn);
              //   },
              //   icon: const Icon(Icons.email),
              // ),
              SideMenuItem(
                title: 'Notificações',
                onTap: (index, _) {
                  sideMenuController.changePage(index);
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                icon: const Icon(Icons.notifications),
              ),
              SideMenuItem(
                title: 'Configurações',
                onTap: (index, _) {
                  sideMenuController.changePage(index);
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                builder: (context, displayMode) {
                  return const Divider();
                },
              ),
            ],
          ),
          const VerticalDivider(width: 0),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                sideMenuController.changePage(index);
              },
              children: const [
                // DashboardPage(),
                  SpanishStudyPage(),
                SchoolPage(),

                // EmailPage(),
                NotificationPage(),
                ConfigurationPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
