import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/history/history_screen.dart';
import 'package:cargo_bike/src/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import '../settings/settings_controller.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  final SettingsController settingsController;
  const HomeScreen({Key? key, required this.settingsController})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> screens;
  int pageIndex = 0;

  @override
  void initState() {
    screens = [
      const MainScreen(),
      const HistoryScreen(),
      SettingsScreen(
        controller: widget.settingsController,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(
        index: pageIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).secondaryHeaderColor,
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (index) => setState(() => pageIndex = index),
          backgroundColor: Colors.white,
          selectedItemColor: CargoBikeColors.lightGreen,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          iconSize: 25,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'History',
              icon: Icon(Icons.history),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
