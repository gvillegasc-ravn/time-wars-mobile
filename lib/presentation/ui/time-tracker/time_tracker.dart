import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timestart/domain/models/time_entries.dart';
import 'package:timestart/presentation/ui/time-tracker/widgets/container_border.dart';
import 'package:timestart/presentation/ui/time-tracker/widgets/custom_divider.dart';
import 'package:timestart/presentation/ui/time-tracker/widgets/date_picker.dart';
import 'package:timestart/presentation/ui/time-tracker/widgets/time_entry_section.dart';
import 'package:timestart/presentation/ui/time-tracker/widgets/time_picker.dart';

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
      _onPressed();

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

  Future<void> _onPressed() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        String? clientSelected;
        List<String> clients = [
          "Client 1",
          "Client 2",
          "Client 3",
        ];

        String? projectSelected;
        List<String> projects = [
          "Project 1",
          "Project 2",
          "Project 3",
        ];

        String? workTypeSelected;
        List<String> workTypes = [
          "Refactor",
          "Fix",
          "Feature",
          "Chore",
        ];

        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
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
                                  hint: const Text('Select'),
                                  value: clientSelected,
                                  items: clients.map((client) {
                                    return DropdownMenuItem(
                                      value: client,
                                      child: Text(client),
                                    );
                                  }).toList(),
                                  onChanged: (client) {
                                    setState(() {
                                      clientSelected = client;
                                    });
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
                                  hint: const Text('Select'),
                                  value: projectSelected,
                                  items: projects.map((project) {
                                    return DropdownMenuItem(
                                      value: project,
                                      child: Text(
                                        project,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (project) {
                                    setState(() {
                                      projectSelected = project;
                                    });
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
                                  hint: const Text('Select'),
                                  value: workTypeSelected,
                                  items: workTypes.map((workType) {
                                    return DropdownMenuItem(
                                      value: workType,
                                      child: Text(
                                        workType,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (workType) {
                                    setState(() {
                                      workTypeSelected = workType;
                                    });
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
            );
          }),
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
