import 'package:booking/controllers/calender_con.dart';
import 'package:booking/controllers/seats_controller.dart';
import 'package:booking/model/bus_model.dart';
import 'package:booking/model/movie.dart';
import 'package:booking/pages/seats_selection_screen.dart';
import 'package:booking/utils/custom_celender.dart';
import 'package:booking/utils/dummy.dart';
import 'package:booking/utils/mythemes.dart';
import 'package:booking/utils/screen_selection_blok.dart';
import 'package:booking/widgets/bus_blok.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/common_controller.dart';

class ListCinemaScreen extends StatefulWidget {
  final MovieModel movieModel;

  const ListCinemaScreen({Key? key, required this.movieModel})
      : super(key: key);

  @override
  State<ListCinemaScreen> createState() => _ListCinemaScreenState();
}

class _ListCinemaScreenState extends State<ListCinemaScreen> {
  final DateFormat format = DateFormat("dd MMM");

  final now = DateTime.now();

  String selectedDate = DateFormat("dd MMM").format(DateTime.now());

  String selectedLanguage = "Type";

  String selectedScreen = "AC";
  late CalendarController commonController;

  @override
  void initState() {
    commonController = Get.put(CalendarController());
    Get.put(SeatSelectionController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.delete<CalendarController>();
        print(commonController.selectedMovieDate.value);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5FA),
        bottomNavigationBar: BottomAppBar(
          color: MyTheme.appBarColor,
          elevation: 0,
          child: Container(
            width: double.maxFinite,
            height: AppBar().preferredSize.height,
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: StatefulBuilder(
                    builder: (_, setState) {
                      final todayDate = format.format(now);
                      final tomorrowDate =
                          format.format(now.add(const Duration(days: 1)));
                      String text = "";

                      if (selectedDate == todayDate) {
                        text = "Today, ";
                      } else if (selectedDate == tomorrowDate) {
                        text = "Tomorrow, ";
                      } else {
                        text = DateFormat("EEE").format(
                                commonController.selectedMovieDate.value) +
                            ", ";
                      }

                      return ListTile(
                        onTap: () {
                          showModalBottomSheet(
                                  context: context,
                                  builder: (_) => CustomCalendar(),
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.35))
                              .then((value) => setState(() {
                                    if (value != null) {
                                      selectedDate = format.format(value);
                                    }
                                  }));
                        },
                        horizontalTitleGap: 0,
                        textColor: Colors.white,
                        leading: const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        title: Text(
                          "$text$selectedDate",
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: StatefulBuilder(builder: (context, setState) {
                    return ListTile(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => ScreenSelectionBlock(
                            onScreenSelect: (screen) {
                              CommonController.instance.updateScreen(screen);
                              setState(() => selectedScreen = screen);
                            },
                          ),
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.25),
                        );
                      },
                      horizontalTitleGap: 0,
                      textColor: Colors.white,
                      title: Text(
                        "$selectedLanguage, $selectedScreen",
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.movieModel.title),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: TheatreSearchDelegate(widget.movieModel),
                );
              },
              icon: SvgPicture.asset("assets/icons/search.svg"),
            ),
          ],
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: theatres.length,
          itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.only(
                  bottom: index != theatres.length - 1 ? 20 : 0),
              child: TheatreBlock(
                model: theatres[index],
                movieModel: widget.movieModel,
                onTimeTap: (index) {
                  Get.to(() => SeatSelectionScreen(
                      theatreModel: theatres[index],
                      movieModel: widget.movieModel));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class TheatreSearchDelegate extends SearchDelegate {
  final MovieModel model;
  TheatreSearchDelegate(this.model);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null.toString());
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? theatres
        : theatres
            .where(
              (element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: suggestionList.length,
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.only(
              bottom: index != suggestionList.length - 1 ? 20 : 0),
          child: TheatreBlock(
            model: suggestionList[index],
            movieModel: model,
            onTimeTap: (index) {
              Get.to(() => SeatSelectionScreen(
                  theatreModel: suggestionList[index], movieModel: model));
            },
          ),
        );
      },
    );
  }
}
