import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import '../../core/utils/constants.dart';


class CustomDateTimePicker extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorText;
  final ValueChanged<String> onChanged;

  const CustomDateTimePicker({
    super.key,
    required this.controller,
    required this.labelText,
    required this.errorText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      controller: controller,
      type: DateTimePickerType.dateTime,
      dateMask: Constants.dateTimeFormat,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        errorText: errorText,
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      onChanged: onChanged,
    );
  }
}
