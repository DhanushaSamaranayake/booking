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
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SeatSelectionController extends GetxController {
  static SeatSelectionController instance = Get.find();
  late DatabaseReference dbRef;
  late DatabaseReference dbReff;
  final DateFormat format = DateFormat("EEEE, MMM dd, yyyy");
  final DateFormat time = DateFormat("hh:mm a");
  final databaseRef = FirebaseDatabase.instance.ref().child('Booked Seats');
  //final RxList<String> seatNumbers = RxList<String>(['A1', 'D2', 'F4']);
  RxList<String> seatNumbers = RxList<String>([]);
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
  //RxString selectedSeats = ''.obs;
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

    //print(res.body);
    String orderId = jsonDecode(res.body)['id'];
    //print(orderId);
    createPayment(orderId);
    //print(seatNumbers);
    //bookingSeats(orderId);
    //print(selectedSeats);
  }

  void getBookedSeats(setState) {
    print('getBookedSeats called');
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('Booked Seats');
    databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> bookedSeats =
            event.snapshot.value as Map<dynamic, dynamic>;

        bookedSeats.forEach((key, value) {
          String selectedSeats = value['selectedSeats'];
          List<String> seats =
              selectedSeats.split(',').map((seat) => seat.trim()).toList();

          seatNumbers.addAll(seats);
        });
        setState(() {
          //bookedSeats = seatNumbers.asMap();
          bookedSeats = Map.fromIterable(
            seatNumbers,
            key: (seatNumber) => seatNumber,
            value: (seatNumber) => 'booked',
          );
        });
      }
    });
  }

  Future sendEmail() async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_1vyixyg";
    const templateId = "template_gr0mt8u";
    const userId = "7SOh7RVs9BK5oQY5t";
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'name': 'Isiwara',
            'subject': 'Test email',
            'message': 'This is a test message',
            //'user_email': AuthController.instance.user!.email,
            'user_email': 'lyrenuka00@gmail.com',
          }
        }));
    AuthController.instance.getSuccessSnackBar("Email Sent successfully...!");
    return response.statusCode;
  }

  void bookingSeats(String orderId) async {
    Map<String, String> booking = {
      "selectedSeats": selectedSeats.join(','),
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
      "selectedSeats": selectedSeats.join(','),
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
    sendEmail();
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
