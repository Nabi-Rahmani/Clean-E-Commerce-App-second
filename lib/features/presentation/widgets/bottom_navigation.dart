import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/features/presentation/screen/home_page.dart';
import 'package:e_clean_fcm/features/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigations extends ConsumerWidget {
  static const String id = 'bottom_navigation';
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  BottomNavigations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme =
        ref.watch(appThemeModeNotifierProvider); // Watch the theme state
    final isDarkMode = currentTheme == ThemeMode.dark ||
        (currentTheme == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    return ValueListenableBuilder<int>(
      valueListenable: _currentIndexNotifier,
      builder: (context, currentIndex, child) {
        return Scaffold(
          body: _pages[currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isDarkMode
                      ? const Color.fromARGB(255, 18, 18, 18)
                      : Colors.grey.shade200,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: isDarkMode
                  ? const Color.fromARGB(255, 18, 18, 18)
                  : Colors.white,
              selectedItemColor:
                  isDarkMode ? Colors.white : Theme.of(context).primaryColor,
              unselectedItemColor:
                  isDarkMode ? Colors.grey.shade600 : Colors.grey.shade800,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: currentIndex,
              onTap: (index) {
                _currentIndexNotifier.value = index;
              },
            ),
          ),
        );
      },
    );
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const ProfileScreen(),
  ];
}
