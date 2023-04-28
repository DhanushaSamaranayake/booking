import 'package:booking/model/adslider.dart';
import 'package:booking/model/bus_model.dart';
import 'package:booking/model/crew_cast_model.dart';
import 'package:booking/model/event.dart';
import 'package:booking/model/menu.dart';
import 'package:booking/model/movie.dart';
import 'package:booking/model/offer_model.dart';
import 'package:booking/model/seat_layout.dart';
import 'package:booking/utils/mythemes.dart';

import '../utils/constants.dart';

List<AdSliderModel> sliderData = [
  AdSliderModel(
    url: "assets/banner.jpg",
    redirectUrl: Constants.baseApiUrl,
  ),
  AdSliderModel(url: "assets/banner1.jpg", redirectUrl: Constants.baseApiUrl),
  AdSliderModel(url: "assets/banner2.jpg", redirectUrl: Constants.baseApiUrl),
];

List<MenuModel> menus = [
  MenuModel(name: "Tickets", asset: "assets/icons/tickets.svg"),
];

List<MovieModel> movies = [
  MovieModel(
    title: "Matara",
    time: "2h 10m",
    busNumber: "NP-3265",
    description: "description",
    actors: ["actor a", "actor b"],
    like: 83,
    bannerUrl: "assets/movies/bus.png",
    name: "Chadwick",
    image: "assets/actors/chadwick.png",
    namee: "Letitia Wright",
    imagee: "assets/actors/LetitiaWright.png",
  ),
  MovieModel(
    title: "Galle",
    time: "1h 10m",
    busNumber: "NB-5647",
    description: "description",
    actors: ["actor a", "actor b"],
    like: 80,
    bannerUrl: "assets/movies/bus1.png",
    name: "Chadwick",
    image: "assets/actors/chadwick.png",
    namee: "Letitia Wright",
    imagee: "assets/actors/LetitiaWright.png",
  ),
  MovieModel(
    title: "Kadawatha",
    time: "30m",
    busNumber: "NP-5794",
    description: "description",
    actors: ["actor a", "actor b"],
    like: 90,
    bannerUrl: "assets/movies/bus2.png",
    name: "Chadwick",
    image: "assets/actors/chadwick.png",
    namee: "Letitia Wright",
    imagee: "assets/actors/LetitiaWright.png",
  ),
  MovieModel(
    title: "Malabe",
    time: "25m",
    busNumber: "NC-5873",
    description: "description",
    actors: ["actor a", "actor b"],
    like: 84,
    bannerUrl: "assets/movies/bus3.png",
    name: "Chadwick",
    image: "assets/actors/chadwick.png",
    namee: "Letitia Wright",
    imagee: "assets/actors/LetitiaWright.png",
  ),
];

List<EventModel> events = [
  EventModel(
    title: "Happy Halloween 2K19",
    description: "Music show",
    date: "date",
    bannerUrl: "assets/events/event1.png",
  ),
  EventModel(
    title: "Music DJ king monger Sert...",
    description: "Music show",
    date: "date",
    bannerUrl: "assets/events/event2.png",
  ),
  EventModel(
    title: "Summer sounds festiva..",
    description: "Comedy show",
    date: "date",
    bannerUrl: "assets/events/event3.png",
  ),
  EventModel(
    title: "Happy Halloween 2K19",
    description: "Music show",
    bannerUrl: "assets/events/event4.png",
    date: "date",
  ),
];

List<EventModel> plays = [
  EventModel(
    title: "Alex in wonderland",
    description: "Comedy Show",
    date: "date",
    bannerUrl: "assets/plays/play1.png",
  ),
  EventModel(
    title: "Marry poppins puffet show",
    description: "Music Show",
    date: "date",
    bannerUrl: "assets/plays/play2.png",
  ),
  EventModel(
    title: "Patrimandram special dewali",
    description: "Dibet Show",
    date: "date",
    bannerUrl: "assets/plays/play3.png",
  ),
  EventModel(
    title: "Happy Halloween 2K19",
    description: "Music Show",
    bannerUrl: "assets/plays/play4.png",
    date: "date",
  ),
];

List<String> screens = [
  "A/C",
  "Non A/C",
];

List<String> cities = [
  "Moratuwa",
  "Homagama",
  "Mathara",
  "Hambanthota",
  "Beruwala",
];
final seatLayout = SeatLayoutModel(
    rows: 8,
    cols: 8,
    seatTypes: [
      {"title": "Per Seat", "price": 120.0, "status": "Filling Fast"},
    ],
    theatreId: 123,
    gap: 2,
    gapColIndex: 4,
    isLastFilled: true,
    rowBreaks: [8]);
List<OfferModel> offers = [
  OfferModel(
    title: "Wait ! Grab FREE reward",
    description: "Book your seats and tap on the reward box to claim it.",
    expiry: DateTime(2022, 4, 15, 12),
    startTime: DateTime(2022, 3, 15, 12),
    discount: 100,
    color: MyTheme.redTextColor,
    gradientColor: MyTheme.redGiftGradientColors,
  ),
  OfferModel(
    title: "Wait ! Grab FREE reward",
    description: "Book your seats and tap on the reward box to claim it.",
    expiry: DateTime(2022, 4, 15, 12),
    startTime: DateTime(2022, 3, 15, 12),
    discount: 100,
    color: MyTheme.greenTextColor,
    gradientColor: MyTheme.greenGiftGradientColors,
    icon: "gift_green.svg",
  ),
];
List<String> facilityAsset = [
  "assets/icons/cancel.svg",
  "assets/icons/parking.svg",
  "assets/icons/cutlery.svg",
  "assets/icons/rocking_horse.svg",
];

List<CrewCastModel> crewCast = [
  CrewCastModel(
    movieId: "123",
    castId: "123",
    name: "Chadwick",
    image: "assets/actors/chadwick.png",
  ),
  CrewCastModel(
    movieId: "123",
    castId: "123",
    name: "Letitia Wright",
    image: "assets/actors/LetitiaWright.png",
  ),
  CrewCastModel(
    movieId: "123",
    castId: "123",
    name: "B. Jordan",
    image: "assets/actors/b_jordan.png",
  ),
  CrewCastModel(
    movieId: "123",
    castId: "123",
    name: "Lupita Nyong",
    image: "assets/actors/lupita_nyong.png",
  ),
];

List<TheatreModel> theatres = [
  TheatreModel(id: "1", name: "Sampath Super Line A/C"),
  TheatreModel(id: "2", name: "Lanka Super Leyland"),
  TheatreModel(id: "3", name: "CTB Lanka Super"),
  TheatreModel(id: "4", name: "Jagath Super Line"),
];

final List<int> s = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
