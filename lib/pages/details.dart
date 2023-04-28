import 'package:booking/controllers/location_con.dart';
import 'package:booking/controllers/seats_controller.dart';
import 'package:booking/pages/list_screens.dart';
import 'package:booking/utils/mythemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../widgets/cast_crew_block.dart';
import '../widgets/offers_block.dart';
import '../widgets/review_block.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key}) : super(key: key);

  final dynamic model = Get.arguments[0];
  final int index = Get.arguments[1];

  titleWidget(model) => Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${model.title}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "-",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            LocationController.instance.city.value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.favorite,
                color: MyTheme.splash,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${model.like}%",
                style: const TextStyle(fontSize: 10),
              )
            ],
          )
        ],
      );

  final screensWidget = Row(
    children: [
      const Text(
        "Express Route",
        style: TextStyle(
          color: MyTheme.splash,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: MyTheme.blueBorder.withOpacity(0.1),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: const Text(
          "E01",
          style: TextStyle(
            color: MyTheme.blueBorder,
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: MyTheme.blueBorder.withOpacity(0.1),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: const Text(
          "E02",
          style: TextStyle(
            color: MyTheme.blueBorder,
          ),
        ),
      ),
    ],
  );

  screensWidgett(model) => Row(
        children: [
          const Icon(
            Icons.history,
            size: 22,
            color: Colors.black45,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${model.time}",
            style: const TextStyle(
              color: Colors.black45,
            ),
          ),
        ],
      );

  Widget block1(model) => Container(
        color: Colors.white,
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget(model),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${model.busNumber}",
                  style: const TextStyle(
                    color: Colors.black45,
                  ),
                ),
                const Text(
                  "1.8K votes",
                  style: TextStyle(
                    color: MyTheme.splash,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            screensWidget,
            const SizedBox(
              height: 10,
            ),
            screensWidgett(model),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Get.to(
              () => ListCinemaScreen(
                movieModel: model,
              ),
            );
          },
          child: Container(
            width: double.maxFinite,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/armchair.svg",
                  color: Colors.white,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Book Seats",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: MyTheme.splash,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: MyTheme.appBarColor,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.blue,
              ),
            ),
            title: Text(
              model.title,
              style: const TextStyle(color: Colors.blue),
            ),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "${model.title}$index",
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/banner.png",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: const Color(0xFFF5F5FA),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    block1(model),
                    const SizedBox(
                      height: 20,
                    ),
                    const OffersBlock(),
                    const SizedBox(
                      height: 20,
                    ),
                    const ReviewBlock(),
                    const SizedBox(
                      height: 20,
                    ),
                    const CrewCastBlock(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
