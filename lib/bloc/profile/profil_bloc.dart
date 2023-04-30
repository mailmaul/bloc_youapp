import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc() : super(ProfilState.initial()) {
    on<ProfilEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<UpdateTapProfile>((event, emit) {
      emit(state.copyWith(
        status1: "LOADED",
      ));
    });

    on<UpdateTapAbout1>((event, emit) {
      emit(state.copyWith(
        status: "LOADED",
      ));
    });

    on<UpdateTapAbout2>((event, emit) {
      emit(state.copyWith(
        name: event.name,
        status: "SAVED",
        horoscope: event.horoscope,
        zodiac: event.zodiac,
        weight: event.weight,
        height: event.height,
        gender: event.gender,
      ));
    });

    on<UpdateTapAbout3>((event, emit) {
      emit(state.copyWith(
        horoscope: event.horoscope,
        zodiac: event.zodiac,
        age: event.age,
        gender: event.gender,
      ));
    });

    on<looping>((event, emit) {
      emit(state.copyWith(
        loop: event.loop,
      ));
    });

    on<UpdateIconImage>((event, emit) {
      emit(state.copyWith(
        status: "LOADED",
      ));
    });

    on<UpdateList>((event, emit) {
      emit(state.copyWith(
        save: event.save,
      ));
    });
  }
}
