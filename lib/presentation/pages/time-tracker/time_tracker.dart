import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeTracker extends StatefulWidget {
  const TimeTracker({super.key});

  @override
  State<TimeTracker> createState() => _TimeTrackerState();
}

class _TimeTrackerState extends State<TimeTracker> {
  var _isRunning = true;

  void _startStopTimer() {
    if (_isRunning) {
      setState(() {
        _isRunning = !_isRunning;
      });
    } else {
      _showMyDialog();
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
        var seen = Set<String>();
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
                const ContainerBorder(
                  child: Column(
                    children: [
                      TimeEntrySection(
                        name: 'Date',
                        child: ContainerBorder(
                          horizontalPadding: 5,
                          verticalPadding: 5,
                          child: Row(
                            children: [
                              Text('11/29/2024'),
                              SizedBox(width: 30),
                              Icon(
                                CupertinoIcons.calendar,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      CustomDivider(),
                      TimeEntrySection(
                        name: 'Time',
                        child: Row(
                          children: [
                            ContainerBorder(
                              horizontalPadding: 5,
                              verticalPadding: 6,
                              child: Text('22:51'),
                            ),
                            SizedBox(width: 10),
                            Text('-'),
                            SizedBox(width: 10),
                            ContainerBorder(
                              horizontalPadding: 5,
                              verticalPadding: 6,
                              child: Text('--:--'),
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
                      const TimeEntrySection(
                        name: 'Client',
                        child: ContainerBorder(
                          horizontalPadding: 5,
                          verticalPadding: 6,
                          child: Row(
                            children: [
                              Text('11/29/2024'),
                              SizedBox(width: 30),
                              Icon(
                                CupertinoIcons.calendar,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      const CustomDivider(),
                      const TimeEntrySection(
                        name: 'Project',
                        child: ContainerBorder(
                          horizontalPadding: 5,
                          verticalPadding: 6,
                          child: Text('22:51'),
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
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
                          // child: Text('Refactor'),
                        ),
                      ),
                      const TimeEntrySection(
                        name: 'Description',
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
  void initState() {
    super.initState();
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
                    const Text(
                      '00:00:00',
                      style: TextStyle(
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
