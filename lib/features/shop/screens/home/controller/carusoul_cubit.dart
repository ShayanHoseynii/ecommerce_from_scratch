import 'package:cwt_starter_template/features/shop/screens/home/controller/carusoul_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarusoulCubit extends Cubit<CarusoulState> {
  CarusoulCubit() : super(CarusoulState(currentPage: 0));

  void updatePage(int index) {
    emit(CarusoulState(currentPage: index));
  }
}
