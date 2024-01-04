import 'package:flutter/material.dart';

import 'data.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final Future<Counter> _vapeCount = Counter.init();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _vapeCount,
      builder: (BuildContext ctx, AsyncSnapshot<Counter> snapshot) {
        if (snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('Loading Data...')),
          );
        }

        var counter = snapshot.data!;

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Today's Count:",
                ),
                Text(
                  "${counter.count}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton.icon(
                  onPressed: () => setState(() => counter.increment()),
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
