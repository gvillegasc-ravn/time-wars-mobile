import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timestart/domain/models/time_entries.dart';
import 'package:timestart/presentation/pages/time-tracker/widgets/date_picket.dart';
import 'package:timestart/presentation/pages/time-tracker/widgets/time_picker.dart';

class TimeTracker extends StatefulWidget {
  const TimeTracker({
    super.key,
    this.timeEntry,
  });

  final TimeEntry? timeEntry;

  @override
  State<TimeTracker> createState() => _TimeTrackerState();
}

class _TimeTrackerState extends State<TimeTracker> {
  var _isRunning = false;
  late int _seconds;
  late Timer _timer;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _isRunning = widget.timeEntry != null;
    _seconds = _isRunning
        ? DateTime.now()
            .toUtc()
            .difference(widget.timeEntry!.startTime)
            .inSeconds
        : 0;

    if (_isRunning) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startStopTimer() {
    if (_isRunning) {
      _showMyDialog();

      // setState(() {
      //   _isRunning = !_isRunning;
      // });
    } else {
      _startTimer();
      setState(() {
        _isRunning = !_isRunning;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(remainingSeconds)}';
  }

  String _twoDigits(int number) {
    if (number < 10) {
      return '0$number';
    } else {
      return '$number';
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,

      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        List<String> countries = [
          "Canada",
          "Russia",
          "USA",
          "China",
          "United Kingdom",
          "USA",
          "India"
        ];

        List<String> workTypes = [
          "Refactor",
          "Fix",
          "Feature",
          "Chore",
        ];
        final seen = Set<String>();
        List<String> uniquelist =
            countries.where((country) => seen.add(country)).toList();

        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 450,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Time entry',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                ContainerBorder(
                  child: Column(
                    children: [
                      TimeEntrySection(
                        name: 'Date',
                        child: ContainerBorder(
                          horizontalPadding: 5,
                          verticalPadding: 5,
                          child: DatePickerTime(
                            initialDate: selectedDate,
                            onDateSelected: (DateTime date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                        ),
                      ),
                      const CustomDivider(),
                      TimeEntrySection(
                        name: 'Time',
                        child: Row(
                          children: [
                            ContainerBorder(
                              horizontalPadding: 5,
                              verticalPadding: 6,
                              child: TimePicker(
                                initialTime:
                                    const TimeOfDay(hour: 22, minute: 51),
                                onTimeSelected: (TimeOfDay newTime) {},
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text('-'),
                            const SizedBox(width: 10),
                            ContainerBorder(
                              horizontalPadding: 5,
                              verticalPadding: 6,
                              child: TimePicker(
                                initialTime:
                                    const TimeOfDay(hour: 22, minute: 51),
                                onTimeSelected: (TimeOfDay newTime) {},
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ContainerBorder(
                  child: Column(
                    children: [
                      TimeEntrySection(
                        name: 'Client*',
                        child: ContainerBorder(
                          horizontalPadding: 5,
                          verticalPadding: 6,
                          child: SizedBox(
                            height: 20,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                focusColor: Colors.transparent,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                value: uniquelist[0],
                                items: uniquelist.map((country) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      country,
                                    ),
                                    value: country,
                                  );
                                }).toList(),
                                onChanged: (country) {
                                  print("You selected: $country");
                                },
                              ),
                            ),
                          ),
                          // child: Text('Refactor'),
                        ),
                      ),
                      const CustomDivider(),
                      TimeEntrySection(
                        name: 'Project*',
                        child: ContainerBorder(
                          horizontalPadding: 5,
                          verticalPadding: 6,
                          child: SizedBox(
                            height: 20,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                focusColor: Colors.transparent,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                value: uniquelist[0],
                                items: uniquelist.map((country) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      country,
                                    ),
                                    value: country,
                                  );
                                }).toList(),
                                onChanged: (country) {
                                  print("You selected: $country");
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const CustomDivider(),
                      const TimeEntrySection(
                        name: 'Ticket Number',
                        child: ContainerBorder(
                          child: SizedBox(
                            width: 100,
                            child: TextField(
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const CustomDivider(),
                      TimeEntrySection(
                        name: 'Work Type',
                        child: ContainerBorder(
                          horizontalPadding: 5,
                          verticalPadding: 6,
                          child: SizedBox(
                            height: 20,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                focusColor: Colors.transparent,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                value: workTypes[0],
                                items: workTypes.map((workType) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      workType,
                                    ),
                                    value: workType,
                                  );
                                }).toList(),
                                onChanged: (workType) {
                                  print("You selected: $workType");
                                },
                              ),
                            ),
                          ),
                          // child: Text('Refactor'),
                        ),
                      ),
                      const TimeEntrySection(
                        name: 'Description* ',
                        child: ContainerBorder(
                          horizontalPadding: 5,
                          verticalPadding: 6,
                          child: SizedBox(
                            width: 280,
                            height: 120,
                            child: TextField(
                              style: TextStyle(fontSize: 14),
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true, // Added this
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 10),
                    MaterialButton(
                      child: const Text('Save'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 20,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What are you working on?',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'No project yet',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      formatTime(_seconds),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: _startStopTimer,
                      behavior: HitTestBehavior.translucent,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isRunning ? Colors.red : Colors.blue,
                        ),
                        child: Icon(
                          _isRunning ? Icons.stop : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}

class ContainerBorder extends StatelessWidget {
  const ContainerBorder({
    super.key,
    required this.child,
    this.verticalPadding,
    this.horizontalPadding,
  });

  final Widget child;
  final double? verticalPadding;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 5,
        vertical: verticalPadding ?? 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey.withOpacity(0.5),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}

class TimeEntrySection extends StatelessWidget {
  const TimeEntrySection({
    super.key,
    required this.name,
    required this.child,
  });

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(name),
          ),
          const SizedBox(width: 5),
          child,
        ],
      ),
    );
  }
}
