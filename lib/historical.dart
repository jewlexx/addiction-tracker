import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'common.dart';
import 'data.dart';

class HistoricalPage extends StatefulWidget {
  const HistoricalPage({super.key});

  @override
  State<HistoricalPage> createState() => _HistoricalPageState();
}

class _HistoricalPageState extends State<HistoricalPage> {
  final Future<Counter> _vapeCount = Counter.init();
  late List<String> _allDays;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _vapeCount,
        builder: (BuildContext ctx, AsyncSnapshot<Counter> snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(title),
              ),
              body: const Center(child: Text("Loading Data...")),
            );
          }

          var counter = snapshot.data!;

          Set<String> keys = counter.instance.getKeys();
          _allDays = keys.toList().reversed.toList();

          return Scaffold(
            body: Center(
              child: ListView(
                children: [
                  for (String day in _allDays)
                    ListTile(
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            counter.instance.remove(day);

                            Set<String> keys = counter.instance.getKeys();

                            _allDays = keys.toList().reversed.toList();
                          });
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 100, right: 100),
                      title: Text(formatDate(parseDate(day))),
                      trailing: Text(counter.instance.getInt(day).toString()),
                    ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: counter.export,
              child: const Icon(Icons.share),
            ),
          );
        });
  }
}

DateTime parseDate(String date) {
  List<int> info = date.split(" ").map((part) => int.parse(part)).toList();
  return DateTime(
    info[0],
    info[1],
    info[2],
  );
}

String formatDate(DateTime date) {
  DateFormat format = DateFormat("yMMMMd");

  return format.format(date);
}
