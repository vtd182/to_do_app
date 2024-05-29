import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'focus_page_state.dart';

class FocusPageCubit extends Cubit<FocusPageState> {
  FocusPageCubit() : super(FocusPageInitial());
}
