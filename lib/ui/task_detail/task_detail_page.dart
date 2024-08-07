import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/models/category.dart';
import 'package:to_do_app/data/models/task.dart';
import 'package:to_do_app/ui/home/bloc/home_page_cubit.dart';
import 'package:to_do_app/ui/task_priority/task_priority_list_page.dart';
import 'package:to_do_app/utils/global_function/global_function.dart';

import '../../constants/constants.dart';
import '../../domain/data_source/firebase_service.dart';
import '../category/category_list_page.dart';

class TaskDetailPage extends StatefulWidget {
  static const route = '/task_detail_page';
  String? taskId;
  TaskDetailPage({super.key, this.taskId});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TaskModel? _task;
  CategoryModel? _category;
  DateTime? _selectedDateTime;
  String? _selectedName;
  String? _selectedDescription;
  int? _selectedPriority;
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: _buildCloseIcon(),
      ),
      backgroundColor: Colors.black,
      body: _buildBodyPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.taskId != null) {
        _findTaskToEdit(widget.taskId!);
      }
    });
  }

  Widget _buildCloseIcon() {
    return GestureDetector(onTap: () => Navigator.pop(context), child: Image.asset(Constants.closeIcon));
  }

  void _findTaskToEdit(String taskId) async {
    TaskModel? task = await _firebaseService.getTaskById(taskId);
    setState(() {
      _task = task;
      if (_task != null) {
        _selectedDateTime = _task!.dateTime;
        _selectedName = _task!.name;
        _selectedPriority = _task!.priority;
        _selectedDescription = _task!.description;
        _findCategoryToEdit(_task!.categoryId);
      }
    });
  }

  void _findCategoryToEdit(String categoryId) async {
    CategoryModel? category = await _firebaseService.getCategoryById(categoryId);
    setState(() {
      _category = category;
    });
  }

  Widget _buildBodyPage() {
    if (_task == null || _category == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          _buildTaskTitleAndDescription(),
          const SizedBox(height: 30),
          _buildTaskField(
              Constants.taskTimeIcon, "task_time_text".tr(), DateFormat("dd/MM/yyyy HH:mm").format(_selectedDateTime!)),
          _buildTaskField(Constants.taskCategoryIcon, "task_category_text".tr(), _category!),
          _buildTaskField(Constants.taskPriorityIcon, "task_priority_text".tr(), _selectedPriority.toString()),
          _buildTaskField(Constants.subTaskIcon, "sub_task_text".tr(), "add_sub_task_text".tr()),
          _buildDeleteButton(),
          const Spacer(),
          _task!.isDone ? Container() : _buildEditButton(),
        ],
      ),
    );
  }

  Widget _buildTaskTitleAndDescription() {
    if (_task == null) {
      const CircularProgressIndicator();
    }
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
              Text(
                _selectedName!,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    _showDialogEditTask();
                  },
                  child: Image.asset(Constants.editIcon)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _selectedDescription!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _showDialogEditTask() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(15),
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
                  "change_name_text".tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: taskNameController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "enter_task_name_text".tr(),
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                    ),
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: taskDescriptionController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "enter_task_description_text".tr(),
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                    ),
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                  ),
                ),
                _buildButtonCancelAndSave(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonCancelAndSave() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
              setState(() {
                _selectedName = taskNameController.text;
                _selectedDescription = taskDescriptionController.text;
              });
              Navigator.pop(context);
              taskNameController.clear();
              taskDescriptionController.clear();
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

  Widget _buildTaskField(String icon, String field, dynamic value) {
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
          GestureDetector(
            onTap: () {
              if (field == "task_category_text".tr()) {
                _showDialogChooseCategory();
              }
              if (field == "task_priority_text".tr()) {
                _showDialogChoosePriority();
              }
              if (field == "task_time_text".tr()) {
                _selectTaskTime();
              }
            },
            child: value is CategoryModel
                ? Container(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(_category!.backgroundColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          _category!.icon,
                          color: GlobalFunction.darkenColor(Color(_category!.backgroundColor)),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _category!.name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                : Container(
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
          ),
        ],
      ),
    );
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

  void _showDialogChooseCategory() async {
    final result = await showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return const CategoryListPage();
      },
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _category = CategoryModel.fromMap(result);
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

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.grey.shade800,
              title: Text(
                "confirm_delete_task_message".tr(),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // dismiss the dialog
                    Navigator.pop(context);
                  },
                  child: Text("cancel_button".tr(), style: const TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    context.read<HomePageCubit>().deleteTask(_task!.id);
                    context.read<HomePageCubit>().onQueryTasksByDate(_task!.dateTime);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("delete_button".tr(), style: const TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 70, left: 20, right: 20),
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_category == null) {
            return;
          }
          final oldDateTime = _task?.dateTime;
          _task?.categoryId = _category!.id;
          _task?.dateTime = _selectedDateTime!;
          _task?.priority = _selectedPriority!;
          _task?.name = _selectedName!;
          _task?.description = _selectedDescription!;
          context.read<HomePageCubit>().updateTask(_task!);
          context.read<HomePageCubit>().onQueryTasksByDate(oldDateTime!);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(Constants.primaryColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        child: Text(
          "edit_task_text".tr(),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
