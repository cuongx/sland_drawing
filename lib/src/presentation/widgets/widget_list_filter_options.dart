import 'package:flutter/material.dart';

import '../../configs/configs.dart';

class ListFilterOptions extends StatelessWidget {
  ListFilterOptions({this.listFilterOptionsStream});

  Stream? listFilterOptionsStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: listFilterOptionsStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<String> listOption = snapshot.data;

          if (listOption.any((option) => option != "")) {
            return Container(
              height: 40,
              color: Colors.white,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listOption.length,
                    itemBuilder: (context, index) {
                      if (listOption[index] != "") {
                        return Row(
                          children: [
                            Container(
                              height: 35,
                              color: Colors.blue,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(listOption[index],
                                  style:
                                      AppStyles.DEFAULT_SMALL_BOLD.copyWith(color: Colors.white)),
                            ),
                            const SizedBox(width: 5)
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  )),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
