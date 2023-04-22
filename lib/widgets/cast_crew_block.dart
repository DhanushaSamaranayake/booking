import 'package:booking/utils/dummy.dart';
import 'package:booking/utils/mythemes.dart';
import 'package:flutter/material.dart';

class CrewCastBlock extends StatelessWidget {
  const CrewCastBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Driver & Conductor",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All >",
                  style: TextStyle(
                    color: MyTheme.splash,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (_, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              movies[index].image,
                              height: 107,
                              width: 87,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(movies[index].name)
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              movies[index].imagee,
                              height: 107,
                              width: 87,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(movies[index].namee)
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
