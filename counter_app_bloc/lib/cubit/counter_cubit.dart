import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(value: 0));

  void increment() => emit(CounterState(
        value: state.value + 1,
        isIncremented: true,
      ));

  void decrement() => emit(CounterState(
        value: state.value >= 1 ? state.value - 1 : 0,
        isIncremented: false,
      ));
}
