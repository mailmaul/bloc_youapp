part of 'profil_bloc.dart';

abstract class ProfilEvent extends Equatable {
  const ProfilEvent();

  @override
  List<Object> get props => [];
}

class UpdateTapProfile extends ProfilEvent {
  UpdateTapProfile();

  @override
  List<Object> get props => [];
}

class UpdateTapAbout1 extends ProfilEvent {
  const UpdateTapAbout1();

  @override
  List<Object> get props => [];
}

class UpdateTapAbout2 extends ProfilEvent {
  const UpdateTapAbout2(
      {required this.name,
      required this.gender,
      required this.zodiac,
      required this.horoscope,
      required this.height,
      required this.weight});

  final String name;
  final String gender;
  final String zodiac;
  final String horoscope;
  final String height;
  final String weight;

  @override
  List<Object> get props => [name, gender, zodiac, horoscope, height, weight];
}

class UpdateTapAbout3 extends ProfilEvent {
  UpdateTapAbout3({
    required this.zodiac,
    required this.horoscope,
    required this.age,
    required this.gender,
  });

  final String zodiac;
  final String horoscope;
  final int age;
  final String gender;

  @override
  List<Object> get props => [zodiac, horoscope, age, gender];
}

class looping extends ProfilEvent {
  const looping({this.loop = 0});

  final int loop;

  @override
  List<Object> get props => [loop];
}

class UpdateIconImage extends ProfilEvent {
  const UpdateIconImage();

  @override
  List<Object> get props => [];
}

class UpdateList extends ProfilEvent {
  UpdateList({
    // required this.savedValue,
    required this.save,
  });

  // final String savedValue;
  final List<String> save;

  @override
  List<Object> get props => [save];
}
