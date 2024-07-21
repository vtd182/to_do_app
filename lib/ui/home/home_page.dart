import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/data/models/category.dart';
import 'package:to_do_app/data/models/task.dart';
import 'package:to_do_app/domain/data_source/firebase_service.dart';
import 'package:to_do_app/ui/task_detail/task_detail_page.dart';

import '../../constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService _firebaseService = FirebaseService();
  List<TaskModel> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    List<TaskModel> tasks = await _firebaseService.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  Future<CategoryModel?> _findCategory(String categoryId) async {
    CategoryModel? category =
        await _firebaseService.getCategoryById(categoryId);
    return category;
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

  Color darkenColor(Color color, [double amount = 0.15]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Widget _buildBodyPage() {
    return Column(
      children: [
        _buildListTask(),
      ],
    );
  }

  Widget _buildListTask() {
    return Expanded(
      child: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _buildListTaskItem(_tasks[index]),
              const SizedBox(height: 10), // Khoảng cách giữa các phần tử
            ],
          );
        },
      ),
    );
  }

  Widget _buildListTaskItem(TaskModel taskModel) {
    return GestureDetector(
      onTap: () {
        if (taskModel.id != null) {
          Navigator.of(context)
              .pushNamed(TaskDetailPage.route, arguments: taskModel.id);
        }
      },
      child: FutureBuilder<CategoryModel?>(
        future: _findCategory(taskModel.categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Hoặc một widget chờ đợi khác.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No category found');
          } else {
            CategoryModel category = snapshot.data!;
            return Container(
              padding: const EdgeInsets.only(bottom: 10, top: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade800,
              ),
              child: Row(children: [
                const Checkbox(
                  value: false,
                  onChanged: null,
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
                        DateFormat('dd/MM/yyyy - HH:mm').format(
                            taskModel.dateTime), // format date time nếu cần
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
                          color: Color(category.backgroundColor),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              category.icon,
                              color:
                                  darkenColor(Color(category.backgroundColor)),
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              category.name,
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
              ]),
            );
          }
        },
      ),
    );
  }
}
