import 'package:addictiontracker/counter.dart';
import 'package:flutter/material.dart';

import 'historical.dart';

const String title = "Addiction Tracker";

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({super.key, required this.selectedPage});

  final int selectedPage;

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: super.widget.selectedPage,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.numbers),
          label: 'Today\'s Hits',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Past Hits',
        ),
      ],
      onTap: (value) => setState(
        () {
          if (value != super.widget.selectedPage) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  switch (value) {
                    case 1:
                      return const HistoricalPage();
                    // Generally will trigger when value is 0,
                    // But in bug cases we don't necessarily want to exit
                    default:
                      return const CounterPage();
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
