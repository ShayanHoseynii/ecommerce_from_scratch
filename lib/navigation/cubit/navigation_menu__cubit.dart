import 'package:bloc/bloc.dart';
import 'package:cwt_starter_template/navigation/cubit/navigation_menu_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(0));

  void changeIndex(int index) {
    emit(NavigationState(index));
  }
}
