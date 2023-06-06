import 'dart:io';
import 'package:booking/pages/scan.dart';
import 'package:path/path.dart' as path_utils;
import 'package:barcode/barcode.dart';
import 'package:booking/controllers/auth_con.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Query dbRef = FirebaseDatabase.instance
      .ref()
      .child('Booking')
      .child(AuthController.instance.user!.uid);
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Booked Seats');

  /*Future<void> _checkPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<void> _downloadTicket(Map booking) async {
    print("download function called");
    final url = booking['ticketUrl'];
    if (url == null) {
      // handle the case where the URL is null
      return;
    }

    Directory? directory = await getExternalStorageDirectory();
    if (directory == null) {
      print('Unable to get external storage directory');
      return;
    }

    String savePath = path_utils.join(directory.path, 'Download');

    await Directory(savePath).create(recursive: true);

    await FlutterDownloader.enqueue(
      url: url,
      savedDir: savePath,
      fileName: 'ticket_${booking['key']}.pdf',
      showNotification: true,
      openFileFromNotification: true,
    );
  }*/

  Widget listItem({
    required Map booking,
    /*required VoidCallback onDownload*/
  }) {
    Color primaryColor = const Color.fromRGBO(42, 106, 238, 1);
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      height: 800,
      child: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(color: primaryColor),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.grey[50],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 64,
            bottom: 16,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(213, 78, 78, 78),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(2, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'From',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        // left: 16,
                                        // right: 16,
                                        // top: 0,
                                        // bottom: 0,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: DottedLine(
                                                dashColor: primaryColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: Divider(
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        child: Center(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                    color: primaryColor)),
                                            child: Text(
                                              booking['destinationTime'],
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                'To',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(booking['from']),
                                Text(booking['destination']),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking['busTime'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    booking['timeSelectedIndex'],
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 72,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Isiwara",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Passenger")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "199932812530",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("ID Number")
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking['busName'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Bus")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      booking['selectedSeats'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Seat Number")
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking['orderId'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Booking Code")
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking['time'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Printed Time")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "LKR",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          booking['seatPrice'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Price")
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Your E-Ticket",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: FutureBuilder<String?>(
                              future: generateBarcode(booking),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return SvgPicture.string(snapshot.data ?? '');
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Scan the barcode to the ticket printer at the departure station",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Scan();
                            },
                            child: const Icon(Icons.download),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 240,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: primaryColor,
                ),
                const Expanded(
                  child: DottedLine(
                    dashColor: Colors.grey,
                  ),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: primaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(42, 106, 238, 1),
          //automaticallyImplyLeading: false,

          title: Row(
            children: const [
              Expanded(
                child: Center(
                  child: Text(
                    "My Ticket",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map booking = snapshot.value as Map;
              booking['key'] = snapshot.key;

              return listItem(
                booking: booking,
                /*onDownload: () => _checkPermission().then((_) {
                  _downloadTicket(booking);
                }),*/
              );
            },
          ),
        ));
  }

  Future<String?> generateBarcode(Map booking) async {
    final dm = Barcode.code128();
    final jsonData =
        '''${booking['destination']}, ${booking['selectedSeats']}, ${booking['seatPrice']}'''; // Convert the booking details to a string
    final svg = dm.toSvg(jsonData, width: 500, height: 100);
    return svg;
  }
}
