import 'package:flutter/material.dart';
import 'package:timestart/data/data_sources/remote_data_source.dart';
import 'package:timestart/domain/models/time_entries.dart';
import 'package:timestart/presentation/pages/time-tracker/time_tracker.dart';
import 'package:timestart/presentation/ui/time_track_card/time_track_card.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isLoadingTimeEntries = true;
  var _timeEntries = <TimeEntry>[];
  TimeEntries? _timeEntriesGeneral;

  @override
  void initState() {
    super.initState();
    _loadTimeEntries();
  }

  Future<void> _loadTimeEntries() async {
    final remoteDataSourceImpl = RemoteDataSourceImpl(client: http.Client());
    final timeEntries = await remoteDataSourceImpl.getTimeEntries();

    setState(() {
      _timeEntries = timeEntries.lastTimeEntries;
      _timeEntriesGeneral = timeEntries;
      _isLoadingTimeEntries = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _isLoadingTimeEntries
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                TimeTracker(
                  timeEntry: _timeEntriesGeneral?.currentTimeEntry,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        _timeEntries.length,
                        (i) => TimeTrackCard(
                          manyTime: false,
                          title: _timeEntries[i].description ?? '',
                          timeSpent: _timeEntries[i].duration,
                          projectName:
                              '${_timeEntries[i].clientName} - ${_timeEntries[i].projectName}',
                          startTime: _timeEntries[i].startTimeRaw,
                          endTime: _timeEntries[i].endTimeRaw,
                        ),
                      ),
                      // children: [
                      // TimeTrackCard(
                      //   manyTime: false,
                      //   title:
                      //       'Refactor - Add Sizes enum for manage sizes in Component module',
                      //   timeSpent: '02:53:21',
                      //   projectName: 'Nelnet - Nelnet',
                      //   startTime: '07:55',
                      //   endTime: '18:06',
                      // ),
                      // //   TimeTrackCard(
                      // //     manyTime: false,
                      // //     title:
                      // //         'Refactor - Add Sizes enum for manage sizes in Component module',
                      // //     timeSpent: '02:53:21',
                      // //     projectName: 'Nelnet - Nelnet',
                      // //     startTime: '07:55',
                      // //     endTime: '18:06',
                      // //   ),
                      // //   TimeTrackCard(
                      // //     manyTime: true,
                      // //     title:
                      // //         'Refactor - Add Sizes enum for manage sizes in Component module',
                      // //     timeSpent: '02:53:21',
                      // //     projectName: 'Nelnet - Nelnet',
                      // //     startTime: '07:55',
                      // //     endTime: '18:06',
                      // //   ),
                      // //   TimeTrackCard(
                      // //     manyTime: false,
                      // //     title:
                      // //         'Refactor - Add Sizes enum for manage sizes in Component module',
                      // //     timeSpent: '02:53:21',
                      // //     projectName: 'Nelnet - Nelnet',
                      // //     startTime: '07:55',
                      // //     endTime: '18:06',
                      // //   )
                      // // ],
                    ),
                  ),
                )
              ],
            ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
