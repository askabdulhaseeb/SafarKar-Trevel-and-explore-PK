import 'package:flutter/material.dart';
import 'package:safarkarappfyp/screens/plannerForm/dateTimepicker/datePicker/showDatePickers.dart';
import 'package:safarkarappfyp/screens/plannerForm/dateTimepicker/timePicker/showTimePicker.dart';
import 'datePicker/widgets/dateSectionLine.dart';

class ShowDateTimePickers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Date Picker
        DateSectionLine(),
        ShowDatePickers(),
        const SizedBox(height: 20),
        ShowTimePicker(),
      ],
    );
  }
}
