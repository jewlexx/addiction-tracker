import "package:addictiontracker/wrapper.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

import "counter.dart";
import "historical.dart";
import "common.dart";

void main() {
  runApp(const MyApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routeObserverProvider = RouteObserver<ModalRoute<void>>(); // <--

final _router = Provider<GoRouter>(
  create: (context) {
    final routeObserver = context.read(routeObserverProvider);

    return GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state, child) {
            return NoTransitionPage(child: PageWrapper(child: child));
          },
          routes: [
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) =>
                  const CounterPage(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'historical',
                  builder: (BuildContext context, GoRouterState state) =>
                      const HistoricalPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: title,
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
