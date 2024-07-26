import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constants/constants.dart';
import 'package:to_do_app/data/models/category.dart';
import 'package:to_do_app/ui/category/category_list_page.dart';
import 'package:to_do_app/ui/task_priority/task_priority_list_page.dart';

import '../../data/models/task.dart';
import '../home/bloc/home_page_cubit.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return const CreateTaskPageView();
      },
    );
  }
}

class CreateTaskPageView extends StatefulWidget {
  const CreateTaskPageView({super.key});

  @override
  State<CreateTaskPageView> createState() => _CreateTaskPageViewState();
}

class _CreateTaskPageViewState extends State<CreateTaskPageView> {
  final _nameTaskTextController = TextEditingController();
  final _descriptionTaskTextController = TextEditingController();
  CategoryModel? _selectedCategory;
  DateTime? _selectedDateTime;
  int? _selectedPriority;
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
          const SizedBox(height: 20),
          _buildTaskDescriptionField(),
          SizedBox(height: _selectedCategory != null ? 20 : 0),
          if (_selectedCategory != null) _buildTaskCategory(),
          SizedBox(height: _selectedDateTime != null ? 20 : 0),
          if (_selectedDateTime != null) _buildTaskDateTime(),
          SizedBox(height: _selectedPriority != null ? 20 : 0),
          if (_selectedPriority != null) _buildTaskPriority(),
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
        margin: const EdgeInsets.only(top: 20),
        child: TextFormField(
          controller: _nameTaskTextController,
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
              controller: _descriptionTaskTextController,
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

  Widget _buildTaskCategory() {
    return Form(
      child: Column(
        children: [
          Text(
            'Category',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 18,
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Color(_selectedCategory!.backgroundColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    _selectedCategory?.icon,
                    color: Color(_selectedCategory!.iconColor),
                    size: 40,
                  ),
                ),
              ),
              Text(
                _selectedCategory!.name,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDateTime() {
    return Form(
      child: Row(
        children: [
          Text(
            'Date time',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            // format date time
            DateFormat('dd/MM/yyyy - HH:mm').format(_selectedDateTime!),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskPriority() {
    return Form(
      child: Row(
        children: [
          Text(
            'Priority',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 20),
          Image.asset(Constants.taskPriorityIcon,
              width: 20, height: 20, fit: BoxFit.fill),
          const SizedBox(width: 4),
          Text(
            // format date time
            _selectedPriority.toString(),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
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
            onPressed: () {
              _selectTaskTime();
            },
            icon: Image.asset(Constants.taskTimeIcon),
          ),
          IconButton(
            onPressed: () {
              _showDialogChooseCategory();
            },
            icon: Image.asset(Constants.taskCategoryIcon),
          ),
          IconButton(
            onPressed: () {
              _showDialogChoosePriority();
            },
            icon: Image.asset(Constants.taskPriorityIcon),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              _createTask();
            },
            icon: Image.asset(Constants.sendIcon),
          ),
        ],
      ),
    );
  }

  void _showDialogChooseCategory() async {
    final result = await showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return const CategoryListPage();
      },
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _selectedCategory = CategoryModel.fromMap(result);
      });
    }
  }

  void _showDialogChoosePriority() async {
    final result = await showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return const TaskPriorityListPage();
      },
    );
    if (result != null && result is int) {
      setState(() {
        _selectedPriority = result;
      });
    }
  }

  void _selectTaskTime() async {
    final dateSelected = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
              primary: Color(Constants.primaryColor),
              onSurface: Colors.white,
            )),
            child: child!);
      },
    );

    if (dateSelected == null) return;

    if (!context.mounted) {
      return;
    }

    final timeSelected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
              primary: Color(Constants.primaryColor),
              onSurface: Colors.white,
            )),
            child: child!);
      },
    );

    if (timeSelected == null) return;

    if (!context.mounted) {
      return;
    }

    final selectedDateTime = DateTime(
      dateSelected.year,
      dateSelected.month,
      dateSelected.day,
      timeSelected.hour,
      timeSelected.minute,
    );
    setState(() {
      _selectedDateTime = selectedDateTime;
    });
  }

  void _createTask() async {
    if (_selectedCategory == null) {
      return;
    }
    if (_selectedDateTime == null) {
      return;
    }
    if (_selectedPriority == null) {
      return;
    }
    if (_nameTaskTextController.text.isEmpty) {
      return;
    }
    if (_descriptionTaskTextController.text.isEmpty) {
      return;
    }
    // get current user id
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final newTask = TaskModel(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(), // Tạo id duy nhất cho task
      name: _nameTaskTextController.text,
      description: _descriptionTaskTextController.text,
      categoryId: _selectedCategory!.id,
      dateTime: _selectedDateTime!,
      priority: _selectedPriority!,
      userId: user.uid, isDone: false,
    );

    print(context.read<HomePageCubit>().hashCode);
    context.read<HomePageCubit>().addTask(newTask);
  }
}
