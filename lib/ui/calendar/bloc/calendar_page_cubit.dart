import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calendar_page_state.dart';

class CalendarPageCubit extends Cubit<CalendarPageState> {
  CalendarPageCubit() : super(CalendarPageInitial());
}
