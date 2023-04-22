import 'dart:convert';
import 'dart:math';

import 'package:booking/controllers/auth_con.dart';
import 'package:booking/controllers/calender_con.dart';
import 'package:booking/controllers/location_con.dart';
import 'package:booking/model/bus_model.dart';
import 'package:booking/model/movie.dart';
import 'package:booking/utils/constants.dart';
import 'package:booking/utils/dummy.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/foundation.dart';

class SeatSelectionController extends GetxController {
  static SeatSelectionController instance = Get.find();
  late DatabaseReference dbRef;
  late DatabaseReference dbReff;
  final DateFormat format = DateFormat("EEEE, MMM dd, yyyy");
  final DateFormat time = DateFormat("hh:mm a");
  //final MovieModel movieModel;

  //SeatSelectionController({Key? key, required this.movieModel});

  var instancee = CalendarController.instance;

  RxInt timeSelectedIndex = 0.obs;
  RxString destination = ''.obs;
  RxString busName = ''.obs;
  RxString destinationTime = ''.obs;
  RxString busTime = ''.obs;
  static int initialValue = -1;
  RxInt noOfSeats = initialValue.obs;
  RxInt seatType = initialValue.obs;
  RxBool isSeatSelection = false.obs;
  late Razorpay _razorpay;

  RxList selectedSeats = [].obs;
  RxList seatPrices = [].obs;
  RxDouble seatPrice = 0.0.obs;
  static const String _chars = '1234567890';
  final Random _rnd = Random();

  @override
  void onReady() {
    super.onReady();
    noOfSeats = initialValue.obs;
    seatType = initialValue.obs;
    dbRef = FirebaseDatabase.instance
        .ref()
        .child("Booking")
        .child(AuthController.instance.user!.uid);
    dbReff = FirebaseDatabase.instance.ref().child("Booked Seats");
  }

  String getAsset() {
    int val = noOfSeats.value;
    if (val <= 2) {
      return "vespa.svg";
    } else if (val > 2 && val <= 4) {
      return "car.svg";
    } else if (val > 4 && val <= 8) {
      return "van.svg";
    }
    return "bus.svg";
  }

  updateNoOfSeats(int value) {
    noOfSeats = value.obs;
    update();
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void createOrder() async {
    http.Response res = await http.post(
      Uri.parse(Constants.createOrderUrl),
      headers: {
        'content-type': 'application/json',
        'authorization':
            'Basic ${base64Encode(utf8.encode(Constants.keyId + ':' + Constants.keySecret))}'
      },
      body: jsonEncode({
        "amount": seatPrice * 100,
        "currency": "LKR",
        "receipt": 'recpt_' + getRandomString(4),
      }),
    );

    print(res.body);
    String orderId = jsonDecode(res.body)['id'];
    print(orderId);
    createPayment(orderId);
    //bookingSeats(orderId);
  }

  void bookingSeats(String orderId) async {
    //String timeValue = theatreModel.timings[timeSelectedIndex.value];
    /*print("selectedSeats: $selectedSeats");
    print("seatPrice: $seatPrice");
    print(
        "timeSelectedIndex: ${instance.format.format(instancee.selectedMovieDate.value)}");
    print("orderId: $orderId");
    print("destination: $destination");
    print("busName: $busName");
    print("destinationTime: $destinationTime");
    print("busTime: $busTime");*/
    Map<String, String> booking = {
      "selectedSeats": selectedSeats.toString(),
      "seatPrice": seatPrice.toString(),
      "timeSelectedIndex":
          instance.format.format(instancee.selectedMovieDate.value),
      "time": instance.time.format(instancee.selectedMovieDate.value),
      "from": LocationController.instance.city.value,
      "destination": destination.toString(),
      "orderId": orderId,
      "busName": busName.toString(),
      "destinationTime": destinationTime.toString(),
      "busTime": busTime.toString(),
    };
    dbRef.push().set(booking);

    Map<String, String> seatsNumbers = {
      "selectedSeats": selectedSeats.toString(),
    };
    dbReff.push().set(seatsNumbers);
  }

  void createPayment(String orderId) async {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    var options = {
      'key': Constants.keyId,
      'amount': seatPrice * 100, //in the smallest currency sub-unit.
      'name': 'Find Seat',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Bus Ticket Amount',
      'timeout': 300, // in seconds
      'prefill': {
        'contact': AuthController.instance.user!.phoneNumber ?? '9876543210',
        'email': AuthController.instance.user!.email,
      }
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    AuthController.instance.getSuccessSnackBar(
        "Payment Success for order Id : ${response.orderId}");
    bookingSeats(response.orderId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    AuthController.instance
        .getErrorSnackBarNew("Payment failed : ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
