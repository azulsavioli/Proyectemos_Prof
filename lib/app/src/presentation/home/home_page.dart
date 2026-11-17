import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../../../../commons/breakpoints.dart';
import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../providers/google_sign_in_provider.dart';
import '../../../../widgets/instagram_link.dart';
import '../configuration/configuration_page.dart';
import '../dashboard/dashboard_page.dart';
import '../notification/notification_page.dart';
import '../school/school_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 0;

  static const _destinations = <_Destination>[
    _Destination('Painel', Icons.space_dashboard_outlined),
    _Destination('Escolas', Icons.school_outlined),
    _Destination('Notificações', Icons.notifications_outlined),
    _Destination('Configurações', Icons.settings_outlined),
  ];

  Future<void> _signOut() async {
    await context.read<GoogleSignInProvider>().signOut();
    if (!mounted) {
      return;
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _select(int index) {
    setState(() => _index = index);
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const DashboardPage(),
      const SchoolPage(),
      const NotificationPage(),
      const ConfigurationPage(),
    ];
    final mobile = Breakpoints.isMobile(context);
    final extended = Breakpoints.isDesktop(context);

    if (mobile) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_destinations[_index].label),
          actions: const [
            InstagramLink(compact: true),
            SizedBox(width: 4),
          ],
        ),
        drawer: Drawer(
          child: _SidePanel(
            extended: true,
            index: _index,
            onSelect: _select,
            onSignOut: _signOut,
          ),
        ),
        body: IndexedStack(index: _index, children: pages),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Row(
          children: [
            _SidePanel(
              extended: extended,
              index: _index,
              onSelect: _select,
              onSignOut: _signOut,
            ),
            const VerticalDivider(width: 1),
            Expanded(child: IndexedStack(index: _index, children: pages)),
          ],
        ),
      ),
    );
  }
}

class _Destination {
  const _Destination(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _SidePanel extends StatelessWidget {
  const _SidePanel({
    required this.extended,
    required this.index,
    required this.onSelect,
    required this.onSignOut,
  });

  final bool extended;
  final int index;
  final ValueChanged<int> onSelect;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: extended ? 248 : 84,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Row(
                children: [
                  Image.asset(
                    Strings.logo,
                    height: 36,
                    width: 36,
                    semanticLabel: 'Logo do Proyectemos',
                  ),
                  if (extended) ...[
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Proyectemos',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ThemeColors.yellow,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            for (var i = 0; i < _HomePageState._destinations.length; i++)
              _NavButton(
                destination: _HomePageState._destinations[i],
                selected: i == index,
                extended: extended,
                onTap: () => onSelect(i),
              ),
            const Spacer(),
            InstagramLink(compact: !extended),
            IconButton(
              tooltip: 'Sair',
              onPressed: onSignOut,
              icon: const Icon(Icons.logout),
              color: ThemeColors.gray,
            ),
            if (extended)
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  'MoobaaLabs',
                  style: ThemeText.subtitle,
                ),
              )
            else
              const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.destination,
    required this.selected,
    required this.extended,
    required this.onTap,
  });

  final _Destination destination;
  final bool selected;
  final bool extended;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : ThemeColors.gray;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Semantics(
        selected: selected,
        button: true,
        label: destination.label,
        child: Material(
          color: selected ? ThemeColors.yellow : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: extended
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Icon(destination.icon, color: color),
                    if (extended) ...[
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          destination.label,
                          style: ThemeText.label.copyWith(color: color),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
