import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setting_page_state.dart';

class SettingPageCubit extends Cubit<SettingPageState> {
  SettingPageCubit() : super(SettingPageInitial());
}
