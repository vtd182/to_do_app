import 'package:flutter/material.dart';
import 'package:to_do_app/constants/constants.dart';
import 'package:to_do_app/ui/category/category_list_page.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: _buildBodyPage(),
        ),
      ),
    );
  }

  Widget _buildBodyPage() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextTitle(),
          _buildTaskNameField(),
          _buildTaskDescriptionField(),
          _buildTaskActionField(),
        ],
      ),
    );
  }

  Widget _buildTextTitle() {
    return const Text(
      "Add Task",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  Widget _buildTaskNameField() {
    return Form(
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: TextFormField(
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter Task name',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
            ),
            fillColor: Colors.grey.withOpacity(0.2),
            filled: true,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskDescriptionField() {
    return Form(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Task description',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.5), width: 1),
                ),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskActionField() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(Constants.taskTimeIcon),
          ),
          IconButton(
            onPressed: () {
              _showDialogChooseCategory();
            },
            icon: Image.asset(Constants.taskCategoryIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(Constants.taskPriorityIcon),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Image.asset(Constants.sendIcon),
          ),
        ],
      ),
    );
  }

  void _showDialogChooseCategory() {
    showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return const CategoryListPage();
        });
  }
}
