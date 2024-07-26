import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/models/category.dart';
import 'package:to_do_app/data/models/task.dart';
import 'package:to_do_app/ui/home/bloc/home_page_cubit.dart';
import 'package:to_do_app/ui/task_detail/task_detail_page.dart';
import 'package:to_do_app/utils/global_function/global_function.dart';

import '../../constants/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return HomePageView(
          incompletedTasks: state.incompleteTasks,
          completedTasks: state.completedTasks,
        );
      },
    );
  }
}

class HomePageView extends StatefulWidget {
  final List<TaskModel> incompletedTasks;
  final List<TaskModel> completedTasks;

  const HomePageView({
    super.key,
    required this.incompletedTasks,
    required this.completedTasks,
  });

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "home_text",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ).tr(),
      ),
      body: _buildBodyPage(),
    );
  }

  Widget _buildBodyPage() {
    return Column(
      children: [
        _buildListTask(widget.incompletedTasks),
        Text(
          "Completed tasks: ${widget.completedTasks.length}",
          style: const TextStyle(color: Colors.white),
        ),
        _buildListTask(widget.completedTasks),
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
    CategoryModel? category =
        context.read<HomePageCubit>().findCategory(taskModel.categoryId);
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
                setState(() {
                  taskModel.isDone = value ?? false;
                  context.read<HomePageCubit>().updateTask(taskModel);
                });
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
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    height: 30,
                    decoration: BoxDecoration(
                      color: category == null
                          ? Colors.grey
                          : Color(category.backgroundColor),
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
                              : GlobalFunction.darkenColor(
                                  Color(category.backgroundColor)),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category == null ? "Category" : category.name,
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
                        Image.asset(Constants.taskPriorityIcon,
                            width: 20, height: 20, fit: BoxFit.fill),
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
}
