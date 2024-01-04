import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const String title = 'Addiction Tracker';

extension PageParsingString on String {
  int get asPage {
    switch (this) {
      case "/historical":
        return 1;
      default:
        return 0;
    }
  }
}

extension PageParsingInt on int {
  String get asPage {
    switch (this) {
      case 1:
        return "/historical";
      default:
        return "/";
    }
  }
}

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({super.key, required this.selectedPage});

  final String selectedPage;

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: super.widget.selectedPage.asPage,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.numbers),
          label: "Today's Count",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: "Past Counts",
        ),
      ],
      onTap: (value) => setState(
        () {
          if (value != super.widget.selectedPage.asPage) {
            context.go(value.asPage);
          }
        },
      ),
    );
  }
}
