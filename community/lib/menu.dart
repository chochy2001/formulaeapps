import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formulae/widgets_intermedios/chat_gpt_intermedio.dart';
import 'package:universal_platform/universal_platform.dart';

import '../widgets_intermedios/busqueda_intermedio.dart';
import '../widgets_intermedios/favorites_intermedio.dart';
import '../widgets_intermedios/todo_list_intermedio.dart';
import 'constantes/export_constantes.dart';
import 'widgets_intermedios/menu_principal.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  MenuState createState() => MenuState();
}

class _MenuDestination {
  const _MenuDestination({
    required this.label,
    required this.activeIcon,
    required this.icon,
  });

  final String label;
  final Widget activeIcon;
  final Widget icon;
}

class MenuState extends State<Menu> {
  int _selectedIndex = 0;
  late final bool _chatEnabled;
  final List<Widget> _widgetOptions = <Widget>[
    const MenuPrincipal1(),
    const TodoListIntermedio(),
    const BusquedaIntermedio(),
    const FavoritesIntermedio(),
  ];

  @override
  void initState() {
    super.initState();

    _chatEnabled = !UniversalPlatform.isWindows &&
        !UniversalPlatform.isLinux &&
        !UniversalPlatform.isWeb;
    if (_chatEnabled) {
      _widgetOptions.add(const ChatGPTIntermedio());
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<_MenuDestination> _destinations(BuildContext context) =>
      <_MenuDestination>[
        _MenuDestination(
          label: AppLocalizations.of(context)!.menu,
          activeIcon: const FaIcon(
            FontAwesomeIcons.houseChimneyCrack,
            size: 20,
          ),
          icon: const FaIcon(
            FontAwesomeIcons.houseCrack,
            size: 20,
          ),
        ),
        _MenuDestination(
          label: AppLocalizations.of(context)!.tareas,
          activeIcon: const Icon(Icons.format_list_numbered_rounded),
          icon: const Icon(Icons.format_list_bulleted),
        ),
        _MenuDestination(
          label: AppLocalizations.of(context)!.busqueda,
          activeIcon: const Icon(Icons.content_paste_search),
          icon: const Icon(Icons.search_rounded),
        ),
        _MenuDestination(
          label: AppLocalizations.of(context)!.favoritos,
          activeIcon: const Icon(Icons.favorite_rounded),
          icon: const Icon(Icons.favorite_border),
        ),
        if (_chatEnabled)
          _MenuDestination(
            label: AppLocalizations.of(context)!.chat,
            activeIcon: const Icon(Icons.chat_bubble),
            icon: const Icon(Icons.chat_bubble_outline),
          ),
      ];

  Widget _buildCompactNavigation(List<_MenuDestination> destinations) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: BottomNavigationBar(
                  elevation: 0,
                  currentIndex: _selectedIndex,
                  selectedItemColor: kColorBlanco,
                  unselectedItemColor: const Color(0xFF646D9E),
                  onTap: _onItemTapped,
                  backgroundColor: kColorFondo,
                  type: BottomNavigationBarType.shifting,
                  items: <BottomNavigationBarItem>[
                    for (final _MenuDestination destination in destinations)
                      BottomNavigationBarItem(
                        activeIcon: destination.activeIcon,
                        icon: destination.icon,
                        backgroundColor: kColorFondo,
                        label: destination.label,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedNavigation(
    BuildContext context,
    List<_MenuDestination> destinations,
  ) {
    return Scaffold(
      backgroundColor: kColorFondo,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.sizeOf(context).height -
                      MediaQuery.paddingOf(context).vertical,
                ),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    backgroundColor: kColorFondo,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onItemTapped,
                    labelType: NavigationRailLabelType.all,
                    selectedIconTheme: const IconThemeData(color: kColorBlanco),
                    unselectedIconTheme:
                        const IconThemeData(color: Color(0xFF646D9E)),
                    selectedLabelTextStyle:
                        const TextStyle(color: kColorBlanco),
                    unselectedLabelTextStyle:
                        const TextStyle(color: Color(0xFF646D9E)),
                    destinations: <NavigationRailDestination>[
                      for (final _MenuDestination destination in destinations)
                        NavigationRailDestination(
                          selectedIcon: destination.activeIcon,
                          icon: destination.icon,
                          label: Text(destination.label),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              thickness: 1,
              color: Color(0xFF33344F),
            ),
            Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<_MenuDestination> destinations = _destinations(context);
    // Keep the compact bottom navigation on phones and tablets. At the same
    // 900 px breakpoint used by Pro, desktop/web gets a persistent rail so the
    // primary destinations are not constrained to a bottom-only control.
    if (MediaQuery.sizeOf(context).width >= 900) {
      return _buildExpandedNavigation(context, destinations);
    }
    return _buildCompactNavigation(destinations);
  }
}
