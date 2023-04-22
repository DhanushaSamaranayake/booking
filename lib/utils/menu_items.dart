import 'package:booking/pages/ticket.dart';
import 'package:booking/pages/view_all_screens.dart';
import 'package:booking/utils/dummy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyMenuItem extends StatelessWidget {
  const MyMenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menus.length,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 20.0, right: 10),
            child: GestureDetector(
              onTap: () {
                //print(menus[i].name);
                //sending argument to next page
                //Get.to(() => ViewAllScreen(), arguments: menus[i]);
                Get.to(() => FetchData());
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      menus[i].asset,
                      height: 35,
                      width: 35,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    menus[i].name,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
