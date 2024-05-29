import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Image.asset(Constants.closeIcon),
      ),
      backgroundColor: Colors.black,
      body: _buildBodyPage(),
    );
  }

  Widget _buildBodyPage() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          _buildTaskTitleAndDescription(),
          const SizedBox(height: 30),
          _buildTaskField(Constants.taskTimeIcon, "Task Time:", "Today"),
          _buildTaskField(
              Constants.taskCategoryIcon, "Task Category:", "University"),
          _buildTaskField(
              Constants.taskPriorityIcon, "Task Priority:", "Default"),
          _buildTaskField(Constants.subTaskIcon, "Sub Task:", "Add sub task"),
          _buildDeleteButton(),
          const Spacer(),
          _buildEditButton(),
        ],
      ),
    );
  }

  Widget _buildTaskTitleAndDescription() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Do something",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Spacer(),
              Image.asset(Constants.editIcon),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Description",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskField(String icon, String field, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Image.asset(icon),
          const SizedBox(width: 10),
          Text(
            field,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Image.asset(Constants.deleteIcon),
          const SizedBox(width: 10),
          Text(
            "delete_task_text".tr(),
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
        margin: const EdgeInsets.only(bottom: 70, left: 20, right: 20),
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          child: Text(
            "edit_task_text".tr(),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ));
  }
}
