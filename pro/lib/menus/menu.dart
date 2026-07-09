import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';

import '../widgets_personalizados/busqueda/busqueda_intermedio.dart';
import '../constantes/export_constantes.dart';
import '../widgets_personalizados/widgets_intermedios/chat_gpt_intermedio.dart';
import '../widgets_personalizados/widgets_intermedios/favorites_intermedio.dart';
import '../widgets_personalizados/widgets_intermedios/menu_principal.dart';
import '../widgets_personalizados/widgets_intermedios/todo_list_intermedio.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const MenuPrincipal1(),
    const TodoListIntermedio(),
    const BusquedaIntermedio(),
    const FavoritesIntermedio(),
  ];

  @override
  void initState() {
    super.initState();

    if (!UniversalPlatform.isWindows &&
        !UniversalPlatform.isLinux &&
        !UniversalPlatform.isWeb) {
      _widgetOptions.add(const ChatGPTIntermedio());
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomNavBarItems =
        <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: const FaIcon(
          FontAwesomeIcons.houseChimneyCrack,
          size: 20,
        ),
        icon: const FaIcon(
          FontAwesomeIcons.houseCrack,
          size: 20,
        ),
        backgroundColor: kColorFondo,
        label: AppLocalizations.of(context)!.menu,
      ),
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.format_list_numbered_rounded),
        icon: const Icon(Icons.format_list_bulleted),
        backgroundColor: kColorFondo,
        label: AppLocalizations.of(context)!.tareas,
      ),
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.content_paste_search),
        icon: const Icon(Icons.search_rounded),
        backgroundColor: kColorFondo,
        label: AppLocalizations.of(context)!.busqueda,
      ),
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.favorite_rounded),
        icon: const Icon(Icons.favorite_border),
        backgroundColor: kColorFondo,
        label: AppLocalizations.of(context)!.favoritos,
      ),
    ];

    if (!UniversalPlatform.isWindows &&
        !UniversalPlatform.isLinux &&
        !UniversalPlatform.isWeb) {
      bottomNavBarItems.add(
        BottomNavigationBarItem(
          activeIcon: const Icon(Icons.chat_bubble),
          icon: const Icon(Icons.chat_bubble_outline),
          backgroundColor: kColorFondo,
          label: AppLocalizations.of(context)!.chat,
        ),
      );
    }

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
                  items: bottomNavBarItems,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
