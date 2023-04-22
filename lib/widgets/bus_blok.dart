import 'package:booking/controllers/calender_con.dart';
import 'package:booking/controllers/location_con.dart';
import 'package:booking/controllers/seats_controller.dart';
import 'package:booking/model/bus_model.dart';
import 'package:booking/model/movie.dart';
import 'package:booking/utils/mythemes.dart';
import 'package:booking/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TheatreBlock extends StatelessWidget {
  final TheatreModel model;
  final MovieModel movieModel;
  final bool isBooking;
  final String selectedTime = '';
  final Function(int) onTimeTap;
  const TheatreBlock({
    Key? key,
    required this.model,
    required this.movieModel,
    this.isBooking = false,
    required this.onTimeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var instance = CalendarController.instance;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.name,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.63,
                    ),
                    builder: (_) => FacilitesBottomSheet(model: model),
                  );
                },
                child: Icon(
                  Icons.info_outline,
                  color: Colors.black45.withOpacity(0.3),
                  size: 25,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          isBooking
              ? Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            LocationController.instance.city.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            "-",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            movieModel.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            instance.format
                                .format(instance.selectedMovieDate.value),
                            style: const TextStyle(color: Color(0xff999999)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "",
                            style: const TextStyle(color: Color(0xff999999)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(
                          Icons.location_on,
                          size: 18,
                          color: Color(0xff999999),
                        ),
                      ),
                      TextSpan(
                        text: LocationController.instance.city.value + ", ",
                        style: const TextStyle(color: Color(0xff999999)),
                      ),
                      const TextSpan(
                        text: "2.3km Away",
                        style: TextStyle(color: Color(0xff444444)),
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Wrap(
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              spacing: 20,
              children: List.generate(
                4,
                (index) {
                  //for dummy data
                  bool isSelected = index ==
                          SeatSelectionController
                              .instance.timeSelectedIndex.value &&
                      isBooking;
                  Color color =
                      index % 2 == 0 ? MyTheme.orangeColor : MyTheme.greenColor;
                  return GestureDetector(
                    onTap: () {
                      //to seat selection
                      onTimeTap(index);
                      SeatSelectionController.instance.destination.value =
                          movieModel.title;
                      SeatSelectionController.instance.busName.value =
                          model.name;
                      SeatSelectionController.instance.destinationTime.value =
                          movieModel.time;
                      SeatSelectionController.instance.busTime.value =
                          model.timings[index];
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MyTheme.greenColor
                            : const Color(0x22E5E5E5),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 1,
                          color: isSelected
                              ? MyTheme.greenColor
                              : const Color(0xffE5E5E5),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        model.timings[index],
                        style:
                            TextStyle(color: isSelected ? Colors.white : color),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
