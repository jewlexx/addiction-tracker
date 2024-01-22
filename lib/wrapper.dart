import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'common.dart';

class PageWrapper extends StatefulWidget {
  final Widget child;

  const PageWrapper({super.key, required this.child});

  @override
  State<PageWrapper> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  @override
  Widget build(BuildContext context) {
    var currentPage = GoRouterState.of(context).matchedLocation;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        print("pop invoked");
        if (didPop) {
          setState(() {
            currentPage = GoRouterState.of(context).matchedLocation;
          });
        }
      },
      child: Scaffold(
        body: super.widget.child,
        bottomNavigationBar: NavigationBottomBar(
          selectedPage: currentPage,
        ),
      ),
    );
  }
}
