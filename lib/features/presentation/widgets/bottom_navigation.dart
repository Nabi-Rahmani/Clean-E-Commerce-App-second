import 'package:e_clean_fcm/features/presentation/screen/home_page.dart';
import 'package:e_clean_fcm/features/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigations extends StatelessWidget {
  static const String id = 'bottom_navigation';

  // ValueNotifier to hold the current index
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  BottomNavigations({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable:
          _currentIndexNotifier, // Listen for changes to the current index
      builder: (context, currentIndex, child) {
        return Scaffold(
          // backgroundColor: Theme.of(context).colorScheme.surface,
          body: _pages[currentIndex], // Display the current page
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
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
            currentIndex: currentIndex, // Highlight the current index
            // Color for the selected item
            onTap: (index) {
              _currentIndexNotifier.value = index; // Update the current index
            },
          ),
        );
      },
    );
  }

  // List of pages for the navigation
  final List<Widget> _pages = [
    const HomePage(),
    ProfileScreen(),
  ];
}
// bottom_navigations.dart
