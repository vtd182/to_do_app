import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/home/bloc/home_page_cubit.dart';

import '../../constants/constants.dart';
import '../../data/models/category.dart';
import '../../data/models/task.dart';
import '../../utils/global_function/global_function.dart';
import '../task_detail/task_detail_page.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return CalendarPageView(
          incompletedTasks: state.incompleteTasksByDate,
          completedTasks: state.completedTasksByDate,
        );
      },
    );
  }
}

class CalendarPageView extends StatefulWidget {
  final List<TaskModel> _incompletedTasks = [];
  final List<TaskModel> _completedTasks = [];
  CalendarPageView({super.key, required List<TaskModel> incompletedTasks, required List<TaskModel> completedTasks}) {
    _incompletedTasks.addAll(incompletedTasks);
    _completedTasks.addAll(completedTasks);
  }

  @override
  State<CalendarPageView> createState() => _CalendarPageViewState();
}

class _CalendarPageViewState extends State<CalendarPageView> {
  DateTime? _selectedDate;
  bool isUncompletedChoosing = true;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomePageCubit>().onQueryTasksByDate(_selectedDate!);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "calendar_page_title".tr(),
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
        const SizedBox(height: 10),
        isUncompletedChoosing ? _buildListTask(widget._incompletedTasks) : _buildListTask(widget._completedTasks),
      ],
    );
  }

  Widget _buildListTask(List<TaskModel> tasks) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _buildListTaskItem(tasks[index]),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListTaskItem(TaskModel taskModel) {
    CategoryModel? category = context.read<HomePageCubit>().findCategory(taskModel.categoryId);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          TaskDetailPage.route,
          arguments: taskModel.id,
        );
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10, top: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade800,
        ),
        child: Row(
          children: [
            Checkbox(
              value: taskModel.isDone,
              shape: const CircleBorder(),
              side: const BorderSide(color: Colors.white),
              onChanged: (bool? value) {
                setState(
                  () {
                    taskModel.isDone = value ?? false;
                    context.read<HomePageCubit>().updateTask(taskModel);
                    context.read<HomePageCubit>().onQueryTasksByDate(_selectedDate!);
                  },
                );
                // Cập nhật taskModel vào cơ sở dữ liệu
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('dd/MM/yyyy - HH:mm').format(taskModel.dateTime),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    height: 30,
                    decoration: BoxDecoration(
                      color: category == null ? Colors.grey : Color(category.backgroundColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          category == null ? Icons.category : category.icon,
                          color: category == null
                              ? Colors.white
                              : GlobalFunction.darkenColor(Color(category.backgroundColor)),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category == null ? "category_text".tr() : category.name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(Constants.primaryColor),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Image.asset(Constants.taskPriorityIcon, width: 20, height: 20, fit: BoxFit.fill),
                        const SizedBox(width: 4),
                        Text(
                          taskModel.priority.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
        DateTime.now().subtract(const Duration(days: 4)),
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
              context.read<HomePageCubit>().onQueryTasksByDate(_selectedDate!);
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
                context.read<HomePageCubit>().onQueryTasksByDate(_selectedDate!);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isUncompletedChoosing ? Color(Constants.primaryColor) : Colors.grey.shade700,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: Text(
              "uncompleted_text".tr(),
              style: const TextStyle(color: Colors.white),
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
              }
              context.read<HomePageCubit>().onQueryTasksByDate(_selectedDate!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: !isUncompletedChoosing ? Color(Constants.primaryColor) : Colors.grey.shade700,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: Text(
              "completed_text".tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
