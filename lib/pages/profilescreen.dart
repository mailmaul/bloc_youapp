import 'dart:io';

import 'package:bloc_youapp/bloc/profile/profil_bloc.dart';
import 'package:bloc_youapp/pages/loginscreen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'addinterestscreen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.email});

  final String email;
  dynamic selectedImagePath;

  var gender = <String>['Male', 'Female'];
  var Gender;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? selectedValue;

  var selectedDate = DateTime.now();

  // var age = DateTime.now().year - selectedDate.year;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final zodiac = getZodiac(selectedDate.month, selectedDate.day);
    final horoscope = _calculateZodiac(selectedDate.year);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(9, 20, 26, 1),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 81),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 26.76),
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                BlocBuilder<ProfilBloc, ProfilState>(
                  builder: (context, state) {
                    if (selectedImagePath != null) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 190,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(selectedImagePath)),
                          color: const Color.fromRGBO(22, 35, 41, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(
                                22, 35, 41, 1), //color of border
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 87, left: 13),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: BlocBuilder<ProfilBloc, ProfilState>(
                                  builder: (context, state) {
                                    if (state.status == "SAVED") {
                                      return Text(
                                        state.name +
                                            ', ' +
                                            state.age.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }

                                    return const Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 6, bottom: 12, left: 13),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: BlocBuilder<ProfilBloc, ProfilState>(
                                    builder: (context, state) {
                                      if (state.status == "SAVED") {
                                        return Text(state.gender,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13));
                                      } else {
                                        return const Text("",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13));
                                      }
                                    },
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 13),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(31, 35, 31, 1),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              31, 35, 31, 1), //color of border
                                          width: 2, //width of border
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: 97,
                                      height: 36,
                                      child: Center(
                                        child: Text(
                                          state.zodiac,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(31, 35, 31, 1),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              31, 35, 31, 1), //color of border
                                          width: 2, //width of border
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: 97,
                                      height: 36,
                                      child: Center(
                                        child: Text(
                                          state.horoscope,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state.status == "SAVED") {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 190,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(22, 35, 41, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(
                                22, 35, 41, 1), //color of border
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 87, left: 13),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: BlocBuilder<ProfilBloc, ProfilState>(
                                  builder: (context, state) {
                                    if (state.status == "SAVED") {
                                      return Text(
                                        state.name +
                                            ', ' +
                                            state.age.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }

                                    return const Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 6, bottom: 12, left: 13),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: BlocBuilder<ProfilBloc, ProfilState>(
                                    builder: (context, state) {
                                      if (state.status == "SAVED") {
                                        return Text(state.gender,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13));
                                      } else {
                                        return const Text("",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13));
                                      }
                                    },
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 13),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(31, 35, 31, 1),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              31, 35, 31, 1), //color of border
                                          width: 2, //width of border
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: 97,
                                      height: 36,
                                      child: Center(
                                        child: Text(
                                          state.zodiac,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(31, 35, 31, 1),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              31, 35, 31, 1), //color of border
                                          width: 2, //width of border
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: 97,
                                      height: 36,
                                      child: Center(
                                        child: Text(
                                          state.horoscope,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 190,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(22, 35, 41, 1),
                        border: Border.all(
                          color: const Color.fromRGBO(
                              22, 35, 41, 1), //color of border
                          width: 2, //width of border
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 17, left: 13),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            email,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                BlocBuilder<ProfilBloc, ProfilState>(
                  builder: (context, state) {
                    if (state.status == "LOADED") {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(14, 25, 31, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 16, left: 27),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "About",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<ProfilBloc>().add(
                                          UpdateTapAbout2(
                                              name: nameController.text,
                                              gender: selectedValue.toString(),
                                              zodiac: zodiac,
                                              horoscope: horoscope,
                                              height: heightController.text,
                                              weight: weightController.text));
                                      print('hhasd' + state.gender);
                                    },
                                    child: const Text(
                                      "Save & Update",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromRGBO(250, 250, 210, 0.6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 31, left: 27),
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  16.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  16.0)),
                                                ),
                                                child: Wrap(
                                                  alignment: WrapAlignment.end,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.end,
                                                  children: [
                                                    ListTile(
                                                      leading:
                                                          Icon(Icons.camera),
                                                      title: Text('Camera'),
                                                      onTap: () {
                                                        Navigator.pop(context);

                                                        getImage(
                                                            ImageSource.camera);
                                                        context
                                                            .read<ProfilBloc>()
                                                            .add(
                                                                UpdateTapProfile());
                                                        print(state.status1);
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading:
                                                          Icon(Icons.image),
                                                      title: Text('Gallery'),
                                                      onTap: () async {
                                                        Navigator.pop(context);
                                                        await getImage(
                                                            ImageSource
                                                                .gallery);

                                                        context
                                                            .read<ProfilBloc>()
                                                            .add(
                                                                UpdateTapProfile());
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: 57,
                                        height: 57,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              22, 35, 41, 1),
                                          border: Border.all(
                                            color: const Color.fromRGBO(22, 35,
                                                41, 1), //color of border
                                            width: 2, //width of border
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: BlocConsumer<ProfilBloc,
                                            ProfilState>(
                                          listener: (context, state) async {
                                            context
                                                .read<ProfilBloc>()
                                                .add(UpdateTapProfile());
                                          },
                                          builder: (context, state) {
                                            if (selectedImagePath != null) {
                                              return Image.file(
                                                selectedImagePath,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            return const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            );
                                            ;
                                          },
                                        ),
                                      )),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Add Image",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 29, left: 27, right: 14, bottom: 40),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Display name:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.33),
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints.tightFor(
                                                width: 202, height: 36),
                                        child: TextFormField(
                                          textAlign: TextAlign.right,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          controller: nameController,
                                          // onChanged: (value) =>
                                          //     _controller.name.value = value,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.22),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                            ),
                                            filled: true,
                                            fillColor: const Color.fromRGBO(
                                                217, 217, 217, 0.06),
                                            hintText: ("Enter name"),
                                            hintStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.3),
                                                fontSize: 13),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Gender:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.33),
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints.tightFor(
                                                width: 202, height: 36),
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  217, 217, 217, 0.06),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 0.22)),
                                              borderRadius:
                                                  BorderRadius.circular(9)),
                                          child: DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                              ),
                                              filled: true,
                                            ),
                                            isExpanded: true,
                                            hint: const Text(
                                              'Select Gender',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.3)),
                                            ),
                                            items: genderItems
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ))
                                                .toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return '  gender.';
                                              }
                                              return value;
                                            },
                                            onChanged: (value) {
                                              selectedValue = value;
                                            },
                                            onSaved: (value) {
                                              selectedValue;
                                            },
                                            value: selectedValue,
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              height: 60,
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 10),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white,
                                              ),
                                              iconSize: 30,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    14, 25, 31, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Birthday:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.33),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await chooseDate(context);
                                          context.read<ProfilBloc>().add(
                                              looping(loop: state.loop + 1));
                                        },
                                        child: ConstrainedBox(
                                          constraints:
                                              const BoxConstraints.tightFor(
                                                  width: 202, height: 36),
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    217, 217, 217, 0.06),
                                                border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 0.22)),
                                                borderRadius:
                                                    BorderRadius.circular(9)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: BlocConsumer<ProfilBloc,
                                                  ProfilState>(
                                                listener:
                                                    (context, state) async {
                                                  // DateTime? pickedDate =
                                                  //     await showDatePicker(
                                                  //   context: context,
                                                  //   initialDate: selectedDate,
                                                  //   firstDate: DateTime(1800),
                                                  //   lastDate: DateTime(2024),
                                                  //   helpText: 'Select DOB',
                                                  //   cancelText: 'Close',
                                                  //   confirmText: 'Confirm',
                                                  //   errorFormatText:
                                                  //       'Enter valid date',
                                                  //   errorInvalidText:
                                                  //       'Enter valid date range',
                                                  //   fieldLabelText: 'DOB',
                                                  //   fieldHintText:
                                                  //       'Month/Date/Year',
                                                  // );
                                                  // if (pickedDate != null &&
                                                  //     pickedDate !=
                                                  //         selectedDate) {
                                                  //   selectedDate = pickedDate;
                                                  // }

                                                  final zodiac = getZodiac(
                                                      selectedDate.month,
                                                      selectedDate.day);
                                                  final horoscope =
                                                      _calculateZodiac(
                                                          selectedDate.year);

                                                  var age =
                                                      DateTime.now().year -
                                                          selectedDate.year;

                                                  print('hallo $age');

                                                  context
                                                      .read<ProfilBloc>()
                                                      .add(UpdateTapAbout3(
                                                          zodiac: zodiac,
                                                          horoscope: horoscope,
                                                          age: age,
                                                          gender: selectedValue
                                                              .toString()));
                                                },
                                                builder: (context, state) {
                                                  {
                                                    if (state.loop > 0) {
                                                      return Text(
                                                        DateFormat("dd-MM-yyyy")
                                                            .format(
                                                                selectedDate)
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    }
                                                    return Text(
                                                      "--",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                        color: Colors.white
                                                            .withOpacity(0.33),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Horoscope:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.33),
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints.tightFor(
                                                width: 202, height: 36),
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  217, 217, 217, 0.06),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 0.22)),
                                              borderRadius:
                                                  BorderRadius.circular(9)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: BlocBuilder<ProfilBloc,
                                                ProfilState>(
                                              builder: (context, state) {
                                                if (state.loop > 0) {
                                                  return Text(
                                                    state.zodiac,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                }
                                                return const Text(
                                                  "--",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Zodiac:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.33),
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints.tightFor(
                                                width: 202, height: 36),
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  217, 217, 217, 0.06),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 0.22)),
                                              borderRadius:
                                                  BorderRadius.circular(9)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: BlocBuilder<ProfilBloc,
                                                ProfilState>(
                                              builder: (context, state) {
                                                if (state.loop > 0) {
                                                  return Text(
                                                    state.horoscope,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                }
                                                return const Text(
                                                  "--",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Height:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.33),
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints.tightFor(
                                                width: 202, height: 36),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.right,
                                          controller: heightController,
                                          onChanged: (value) =>
                                              heightController.text = value,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.22),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                            ),
                                            filled: true,
                                            fillColor: const Color.fromRGBO(
                                                217, 217, 217, 0.06),
                                            hintText: ("Add height"),
                                            hintStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.3),
                                                fontSize: 13),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Weight:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.white.withOpacity(0.33),
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints.tightFor(
                                                width: 202, height: 36),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.right,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          controller: weightController,
                                          onChanged: (value) =>
                                              weightController.text,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.22),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                            ),
                                            filled: true,
                                            fillColor: const Color.fromRGBO(
                                                217, 217, 217, 0.06),
                                            hintText: ("Add weight"),
                                            hintStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.3),
                                                fontSize: 13),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (state.status == "SAVED") {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 219,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(14, 25, 31, 1),
                            border: Border.all(
                              color: const Color.fromRGBO(
                                  14, 25, 31, 1), //color of border
                              width: 2, //width of border
                            ),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 16, left: 27),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "About",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ProfilBloc>()
                                              .add(UpdateTapAbout1());
                                        },
                                        child: const Icon(
                                          Icons.edit_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 25, left: 27),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text("Birthday: ",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.52),
                                                fontSize: 14)),
                                        Text(
                                          "${DateFormat("dd / MM / yyyy").format(selectedDate)} ",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Horoscope: ",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.52),
                                                fontSize: 14)),
                                        Text(
                                          state.horoscope,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Zodiac: ",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.52),
                                                fontSize: 14)),
                                        Text(
                                          state.zodiac,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Height: ",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.52),
                                                fontSize: 14)),
                                        Text(
                                          state.height,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Weight: ",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.52),
                                                fontSize: 14)),
                                        Text(
                                          state.weight,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(14, 25, 31, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(
                                14, 25, 31, 1), //color of border
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 16, left: 27),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "About",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<ProfilBloc>()
                                            .add(UpdateTapAbout1());
                                      },
                                      child: const Icon(
                                        Icons.edit_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  bottom: 23, left: 27, right: 57),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Add in your your to help others know you better",
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.52),
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(14, 25, 31, 1),
                    border: Border.all(
                      color:
                          const Color.fromRGBO(14, 25, 31, 1), //color of border
                      width: 2, //width of border
                    ),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 16, left: 27, bottom: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Interest",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddInterestPage()),
                                ),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<ProfilBloc, ProfilState>(
                        builder: (context, state) {
                          if (state.save.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(
                                  bottom: 23, left: 27, right: 57),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Add in your your to help others know you better",
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.52),
                                      fontSize: 14),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: 23, left: 27, right: 57),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing:
                                      12, // define the spacing between items
                                  runSpacing:
                                      12, // define the spacing between rows
                                  children: List.generate(
                                    state.save.length,
                                    (index) {
                                      final value = state.save[index];
                                      return Container(
                                        height: 31,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 0.1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<File> getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    final appDocDir = await getApplicationDocumentsDirectory();
    final newDir = Directory('${appDocDir.path}/storage/product_images');
    final newPath = '${newDir.path}/image.png';

    if (!await newDir.exists()) {
      await newDir.create(recursive: true);
    }

    final oldFile = File(pickedFile!.path);
    selectedImagePath = await oldFile.copy(newPath);
    // selectedImagePath = File(selectedImagePath.path);
    // print(selectedImagePath);
    return selectedImagePath;
  }

  void onSelected(String value) {
    selectedValue = value;

    changeGender(selectedValue);
  }

  changeGender(String? selectedGender) {
    switch (selectedGender) {
      case 'Male':
        Gender = 'Male';
        break;
      case 'Female':
        Gender = 'Female';
        break;
    }
  }

  chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1800),
      lastDate: DateTime(2024),
      // initialEntryMode: DatePickerEntryMode.calendarOnly,
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'DOB',
      fieldHintText: 'Month/Date/Year',
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      // Get.updateLocale(Locale('en_US'));
    }
  }

  String getZodiac(int month, int day) {
    print("aa");
    switch (month) {
      case 1:
        return day < 20 ? 'Capricorn' : 'Aquarius';
      case 2:
        return day < 19 ? 'Aquarius' : 'Pisces';
      case 3:
        return day < 21 ? 'Pisces' : 'Aries';
      case 4:
        return day < 20 ? 'Aries' : 'Taurus';
      case 5:
        return day < 21 ? 'Taurus' : 'Gemini';
      case 6:
        return day < 21 ? 'Gemini' : 'Cancer';
      case 7:
        return day < 23 ? 'Cancer' : 'Leo';
      case 8:
        return day < 23 ? 'Leo' : 'Virgo';
      case 9:
        return day < 23 ? 'Virgo' : 'Libra';
      case 10:
        return day < 23 ? 'Libra' : 'Scorpio';
      case 11:
        return day < 22 ? 'Scorpio' : 'Sagittarius';
      case 12:
        return day < 22 ? 'Sagittarius' : 'Capricorn';
      default:
        return '';
    }
  }

  String _calculateZodiac(int year) {
    const zodiacList = [
      'Monkey',
      'Rooster',
      'Dog',
      'Pig',
      'Rat',
      'Ox',
      'Tiger',
      'Rabbit',
      'Dragon',
      'Snake',
      'Horse',
      'Sheep'
    ];
    print(year);
    return zodiacList[(year - 1924) % 12];
  }
}
