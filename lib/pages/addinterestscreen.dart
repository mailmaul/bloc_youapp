import 'package:bloc_youapp/bloc/profile/profil_bloc.dart';
import 'package:bloc_youapp/pages/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AddInterestPage extends StatelessWidget {
  AddInterestPage({super.key});

  final TextEditingController textEditingController = TextEditingController();

  final List<String> savedValues = <String>['aa', 'cc'];
  final List<String> save = <String>[];

  final String savedValue = '';

  @override
  void onClose() {
    textEditingController.dispose();
    // super.onClose();
  }

  void saveValue() {
    savedValues.add(textEditingController.text);
    textEditingController.clear();
  }

  void deleteValue(int index) {
    save.removeAt(index);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(31, 66, 71, 1),
              Color.fromRGBO(13, 29, 35, 1),
              Color.fromRGBO(9, 20, 26, 1)
            ],
            center: Alignment.topRight,
            radius: 2.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 83),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                email: '',
                              )),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 83, right: 26),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                      email: '',
                                    )),
                          );
                        },
                        child: GradientText("Save",
                            gradientType: GradientType.linear,
                            gradientDirection: GradientDirection.ltr,
                            colors: const [
                              Color.fromRGBO(171, 255, 253, 1),
                              Color.fromRGBO(170, 218, 255, 1),
                              Color.fromRGBO(69, 153, 219, 1),
                            ]),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 73),
              child: GradientText("Tell everyone about yourself",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ltr,
                  colors: const [
                    Color.fromRGBO(148, 120, 62, 1),
                    Color.fromRGBO(243, 237, 166, 1),
                    Color.fromRGBO(248, 250, 229, 1),
                    Color.fromRGBO(255, 226, 190, 1),
                    Color.fromRGBO(213, 190, 136, 1),
                    Color.fromRGBO(248, 250, 229, 1),
                    Color.fromRGBO(213, 190, 136, 1),
                  ]),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35, top: 12),
              child: Text(
                "What interest you?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 35, right: 27),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(217, 217, 217, 0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: BlocConsumer<ProfilBloc, ProfilState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: 17, right: 27, top: 8, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                  spacing:
                                      4, // define the spacing between items
                                  runSpacing:
                                      8.0, // define the spacing between rows
                                  children: <Widget>[
                                    ...List.generate(
                                      state.save.length,
                                      (index) {
                                        final value = state.save[index];
                                        return Container(
                                          height: 31,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.1),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                value,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                                onPressed: () {
                                                  final updatedList =
                                                      List<String>.from(
                                                          state.save)
                                                        ..removeAt(index);
                                                  context
                                                      .read<ProfilBloc>()
                                                      .add(UpdateList(
                                                          save: updatedList));
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    IntrinsicWidth(
                                      child: Container(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 15, left: 2)),
                                          onFieldSubmitted: (value) {
                                            final updatedList =
                                                List<String>.from(state.save)
                                                  ..add(textEditingController
                                                      .text);
                                            context.read<ProfilBloc>().add(
                                                UpdateList(save: updatedList));
                                            textEditingController.clear();
                                          },
                                          controller: textEditingController,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          textAlignVertical:
                                              TextAlignVertical.top,
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
