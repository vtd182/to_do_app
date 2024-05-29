import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_detail_page_state.dart';

class TaskDetailPageCubit extends Cubit<TaskDetailPageState> {
  TaskDetailPageCubit() : super(TaskDetailPageInitial());
}
