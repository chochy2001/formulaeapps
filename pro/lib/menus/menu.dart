import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';

import '../constantes/export_constantes.dart';
import '../responsive/breakpoints.dart';
import '../routes.dart';
import '../widgets_personalizados/busqueda/busqueda_intermedio.dart';
import '../widgets_personalizados/widgets_intermedios/chat_gpt_intermedio.dart';
import '../widgets_personalizados/widgets_intermedios/favorites_intermedio.dart';
import '../widgets_personalizados/widgets_intermedios/menu_principal.dart';
import '../widgets_personalizados/widgets_intermedios/todo_list_intermedio.dart';

/// Application shell. Hosts the persistent navigation (a bottom navigation bar
/// on compact widths, a left [NavigationRail] on wide widths) plus one nested
/// [Navigator] per tab.
///
/// Because section and formula screens are pushed onto the nested navigator of
/// the active tab (instead of the root navigator), the bottom nav / rail stays
/// visible while the user drills into sections and formulas. Every existing
/// named route keeps working: the nested navigator resolves them through
/// [getApplicationRoutes].
class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  MenuState createState() => MenuState();
}

class _ShellDestination {
  const _ShellDestination({
    required this.label,
    required this.activeIcon,
    required this.icon,
  });

  final String Function(BuildContext) label;
  final Widget activeIcon;
  final Widget icon;
}

class MenuState extends State<Menu> {
  int _selectedIndex = 0;

  late final bool _chatEnabled;
  late final List<Widget> _tabRoots;
  late final List<GlobalKey<NavigatorState>> _navigatorKeys;
  late final Map<String, WidgetBuilder> _routes;

  @override
  void initState() {
    super.initState();
    _routes = getApplicationRoutes();
    // Chat is a first-class tab only where the in-app chat screen ships; on
    // web / Windows / Linux it stays reachable through the "ask AI" buttons.
    _chatEnabled = !UniversalPlatform.isWindows &&
        !UniversalPlatform.isLinux &&
        !UniversalPlatform.isWeb;
    _tabRoots = <Widget>[
      const MenuPrincipal1(),
      const TodoListIntermedio(),
      const BusquedaIntermedio(),
      const FavoritesIntermedio(),
      if (_chatEnabled) const ChatGPTIntermedio(),
    ];
    _navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      _tabRoots.length,
      (_) => GlobalKey<NavigatorState>(),
    );
  }

  List<_ShellDestination> get _destinations => <_ShellDestination>[
        _ShellDestination(
          label: (context) => AppLocalizations.of(context)!.menu,
          activeIcon:
              const FaIcon(FontAwesomeIcons.houseChimneyCrack, size: 20),
          icon: const FaIcon(FontAwesomeIcons.houseCrack, size: 20),
        ),
        _ShellDestination(
          label: (context) => AppLocalizations.of(context)!.tareas,
          activeIcon: const Icon(Icons.format_list_numbered_rounded),
          icon: const Icon(Icons.format_list_bulleted),
        ),
        _ShellDestination(
          label: (context) => AppLocalizations.of(context)!.busqueda,
          activeIcon: const Icon(Icons.content_paste_search),
          icon: const Icon(Icons.search_rounded),
        ),
        _ShellDestination(
          label: (context) => AppLocalizations.of(context)!.favoritos,
          activeIcon: const Icon(Icons.favorite_rounded),
          icon: const Icon(Icons.favorite_border),
        ),
        if (_chatEnabled)
          _ShellDestination(
            label: (context) => AppLocalizations.of(context)!.chat,
            activeIcon: const Icon(Icons.chat_bubble),
            icon: const Icon(Icons.chat_bubble_outline),
          ),
      ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      // Re-tapping the active tab returns to that tab's first screen.
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
      return;
    }
    setState(() => _selectedIndex = index);
  }

  Route<dynamic> _onGenerateTabRoute(int tabIndex, RouteSettings settings) {
    final String? name = settings.name;
    if (name == null || name == '/' || name == Navigator.defaultRouteName) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => _tabRoots[tabIndex],
      );
    }
    final WidgetBuilder? builder = _routes[name];
    if (builder != null) {
      return MaterialPageRoute<void>(settings: settings, builder: builder);
    }
    // Unknown route: fall back to the tab root, mirroring the app-level
    // onGenerateRoute behaviour so navigation never dead-ends.
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _tabRoots[tabIndex],
    );
  }

  Widget _buildTabNavigator(int tabIndex) {
    return Navigator(
      key: _navigatorKeys[tabIndex],
      onGenerateRoute: (settings) => _onGenerateTabRoute(tabIndex, settings),
    );
  }

  void _handleSystemPop() {
    final NavigatorState? navigator =
        _navigatorKeys[_selectedIndex].currentState;
    if (navigator != null && navigator.canPop()) {
      navigator.pop();
      return;
    }
    if (_selectedIndex != 0) {
      setState(() => _selectedIndex = 0);
      return;
    }
    // Already at the home tab root: let the platform decide (close on Android,
    // no-op on iOS / web / desktop).
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    // StackFit.expand forces each nested navigator (an Overlay) to fill the
    // available space. Without it the navigator collapses to zero height under
    // the loose constraints a Scaffold body passes down, leaving a blank page.
    final Widget body = IndexedStack(
      index: _selectedIndex,
      sizing: StackFit.expand,
      children: <Widget>[
        for (int i = 0; i < _tabRoots.length; i++) _buildTabNavigator(i),
      ],
    );

    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        _handleSystemPop();
      },
      child: context.isCompactWidth
          ? _buildCompactScaffold(body)
          : _buildExpandedScaffold(body),
    );
  }

  Widget _buildCompactScaffold(Widget body) {
    final List<_ShellDestination> destinations = _destinations;
    // The bottom navigation bar is drawn as a Stack overlay (rather than the
    // Scaffold bottomNavigationBar slot) so the browsing area receives tight
    // constraints and the nested navigator always fills the screen. This
    // mirrors the layout the app shipped before the shell refactor.
    return Scaffold(
      backgroundColor: kColorFondo,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            bottom: kBottomNavigationBarHeight,
            child: body,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: BottomNavigationBar(
                  elevation: 0,
                  currentIndex: _selectedIndex,
                  // Acento PRIMARIO dorado para el destino activo; el inactivo
                  // usa un tono con contraste AA (antes #646D9E, 2.90:1).
                  selectedItemColor: kColorAcentoPrimario,
                  unselectedItemColor: kColorNavInactivo,
                  onTap: _onItemTapped,
                  backgroundColor: kColorFondo,
                  type: BottomNavigationBarType.shifting,
                  items: <BottomNavigationBarItem>[
                    for (final _ShellDestination destination in destinations)
                      BottomNavigationBarItem(
                        activeIcon: destination.activeIcon,
                        icon: destination.icon,
                        backgroundColor: kColorFondo,
                        label: destination.label(context),
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

  Widget _buildExpandedScaffold(Widget body) {
    final List<_ShellDestination> destinations = _destinations;
    return Scaffold(
      backgroundColor: kColorFondo,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
                    // Acento PRIMARIO dorado para el destino activo; el inactivo
                    // usa un tono con contraste AA (antes #646D9E, 2.90:1).
                    selectedIconTheme:
                        const IconThemeData(color: kColorAcentoPrimario),
                    unselectedIconTheme:
                        const IconThemeData(color: kColorNavInactivo),
                    selectedLabelTextStyle:
                        const TextStyle(color: kColorAcentoPrimario),
                    unselectedLabelTextStyle:
                        const TextStyle(color: kColorNavInactivo),
                    destinations: <NavigationRailDestination>[
                      for (final _ShellDestination destination in destinations)
                        NavigationRailDestination(
                          selectedIcon: destination.activeIcon,
                          icon: destination.icon,
                          label: Text(destination.label(context)),
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
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
