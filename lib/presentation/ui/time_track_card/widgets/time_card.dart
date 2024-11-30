import 'package:flutter/material.dart';
import 'package:timestart/presentation/ui/time_track_card/widgets/options_time_track_card.dart';

class TimeCard extends StatelessWidget {
  final String title;
  final String timeSpent;
  final String projectName;
  final String startTime;
  final String endTime;
  const TimeCard({
    super.key,
    required this.title,
    required this.timeSpent,
    required this.projectName,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1, 
                  ),
                ),
                Row(
                  children: [
                    Text(
                      timeSpent,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const OptionsTimeTrackCard(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.purple,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      projectName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    Text(
                      startTime,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      endTime,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(Icons.attach_money, size: 20, color: Colors.blue),
                  Icon(Icons.bookmark, size: 20, color: Colors.grey),
                ]),
                Icon(Icons.edit, size: 20, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
