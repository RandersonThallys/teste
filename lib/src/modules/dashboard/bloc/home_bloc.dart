import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/home_events.dart';
import 'states/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  HomeBloc() : super(LightState()) {
    on<TurnThemeEvent>(_turnTheme);
  }

  Future _turnTheme(TurnThemeEvent event, Emitter<HomeStates> emit) async {
    if (state is LightState) {
      emit(HomeStates.dark());
    } else {
      emit(HomeStates.light());
    }
  }
}
