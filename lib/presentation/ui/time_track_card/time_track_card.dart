import 'package:flutter/material.dart';
import 'package:timestart/presentation/ui/time_track_card/widgets/time_card.dart';

class TimeTrackCard extends StatelessWidget {
  final bool manyTime;
  final String title;
  final String timeSpent;
  final String projectName;
  final String startTime;
  final String endTime;
  const TimeTrackCard({
    super.key,
    required this.manyTime,
    required this.title,
    required this.timeSpent,
    required this.projectName,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: manyTime ? _manyTimeEffect(context) : _singleTimeEffect(),
    );
  }

  Widget _manyTimeEffect(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 12,
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                height: 140,
              ),
            ),
          ),
          Positioned(
            top: 24,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 24,
                height: 120,
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TimeCard(
                title: title,
                timeSpent: timeSpent,
                projectName: projectName,
                startTime: startTime,
                endTime: endTime,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Efecto cuando manyTime es false
  Widget _singleTimeEffect() {
    return SizedBox(
      width: double.infinity,
      child: TimeCard(
        title: title,
        timeSpent: timeSpent,
        projectName: projectName,
        startTime: startTime,
        endTime: endTime,
      ),
    );
  }
}
