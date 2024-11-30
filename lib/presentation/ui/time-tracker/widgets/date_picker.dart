import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerTime extends StatefulWidget {
  const DatePickerTime({
    super.key,
    this.restorationId,
    required this.initialDate,
    required this.onDateSelected,
  });

  final String? restorationId;
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  State<DatePickerTime> createState() => _DatePickerTimeState();
}

class _DatePickerTimeState extends State<DatePickerTime> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  DateTime selectedDate = DateTime.now();

  late final RestorableDateTime _selectedDate =
      RestorableDateTime(widget.initialDate);

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2025),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        selectedDate = newSelectedDate;
        widget.onDateSelected(newSelectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _restorableDatePickerRouteFuture.present();
      },
      child: Row(
        children: [
          Text(
              '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}'),
          const SizedBox(width: 30),
          const Icon(
            CupertinoIcons.calendar,
            size: 20,
          )
        ],
      ),
    );
  }
}
