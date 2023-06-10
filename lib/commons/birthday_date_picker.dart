import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthdayDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const BirthdayDatePicker({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  _BirthdayDatePickerState createState() => _BirthdayDatePickerState();
}

class _BirthdayDatePickerState extends State<BirthdayDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      final now = DateTime.now();
      final age = now.year -
          picked.year -
          ((now.month > picked.month ||
                  (now.month == picked.month && now.day >= picked.day))
              ? 0
              : 1);
      if (age < 18) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Invalid Date'),
              content:
                  Text('You must be at least 18 years old to use this app.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          _selectedDate = picked;
        });
        widget.onDateSelected(_selectedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Birthday',
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              DateFormat('MMMM d, yyyy').format(_selectedDate),
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
