import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDate;
  bool isUncompletedChoosing = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'calendar_text'.tr(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: _buildBodyPage(),
    );
  }

  Widget _buildBodyPage() {
    return Column(
      children: [
        _buildDatePickerTimeline(),
        const SizedBox(height: 10),
        _buildButtonUncompletedAndCompleted(),
      ],
    );
  }

  Widget _buildListTask() {
    return Container();
  }

  Widget _buildDatePickerTimeline() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade800,
      ),
      child: DatePicker(
        width: 60,
        height: 90,
        DateTime.now(),
        deactivatedColor: Colors.white,
        selectionColor: Color(Constants.primaryColor),
        dateTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        dayTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
        monthTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
        initialSelectedDate: DateTime.now(),
        onDateChange: (date) {
          // New date selected
          setState(
            () {
              _selectedDate = date;
            },
          );
        },
      ),
    );
  }

  Widget _buildButtonUncompletedAndCompleted() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey.shade800,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              if (!isUncompletedChoosing) {
                setState(() {
                  isUncompletedChoosing = !isUncompletedChoosing;
                });
                print("query uncompleted");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isUncompletedChoosing
                  ? Color(Constants.primaryColor)
                  : Colors.grey.shade700,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: const Text(
              "Uncompleted",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 50),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              if (isUncompletedChoosing) {
                setState(() {
                  isUncompletedChoosing = !isUncompletedChoosing;
                });
                print("query completed");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: !isUncompletedChoosing
                  ? Color(Constants.primaryColor)
                  : Colors.grey.shade700,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: const Text(
              "Completed",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
