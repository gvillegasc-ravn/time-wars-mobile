import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    this.initialTime,
    required this.onTimeSelected,
  });

  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
      widget.onTimeSelected(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeText = _selectedTime != null
        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
        : '--:--';

    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Text(timeText),
    );
  }
}
