import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/history/history_screen.dart';
import 'package:cargo_bike/src/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import '../settings/settings_controller.dart';
import '../settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  final SettingsController settingsController;
  const HomeScreen({Key? key, required this.settingsController})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PageView(
        children: <Widget>[
          const MainScreen(),
          const HistoryScreen(),
          SettingsScreen(
            controller: widget.settingsController,
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
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
          onTap: onTap,
          backgroundColor: Colors.white,
          selectedItemColor: CargoBikeColors.lightGreen,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.home,
              icon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.history,
              icon: const Icon(Icons.history),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.settings,
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
