import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class TaskPriorityListPage extends StatefulWidget {
  const TaskPriorityListPage({super.key});

  @override
  State<TaskPriorityListPage> createState() => _TaskPriorityListPageState();
}

class _TaskPriorityListPageState extends State<TaskPriorityListPage> {
  List<int> _priorityDataSource = [];
  int? _selectedPriority;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          _priorityDataSource = List.generate(10, (index) => index + 1);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBodyPage(),
    );
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "choose_priority_text".tr(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.5),
            ),
            _buildGridCategoryList(),
            _buildButtonCancelAndSavePriorityTask(),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCategoryList() {
    return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          return _buildGridPriorityTaskItem(_priorityDataSource[index]);
        },
        itemCount: _priorityDataSource.length);
  }

  Widget _buildGridPriorityTaskItem(int priority) {
    final isSelected = _selectedPriority == priority;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPriority = priority;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 3, right: 3, bottom: 10),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: isSelected ? Color(Constants.primaryColor) : Colors.black26,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Constants.taskPriorityIcon, width: 24, height: 24, fit: BoxFit.fill),
              Text(
                priority.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonCancelAndSavePriorityTask() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade700,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: Text(
              "cancel_button".tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 50),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _selectedPriority);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(Constants.primaryColor),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: Text(
              "save_button".tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
