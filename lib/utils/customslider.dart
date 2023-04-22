import 'package:booking/utils/dummy.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final index;
  const CustomSlider({Key? key, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width,
      child: Image.asset(
        sliderData[index].url,
        fit: BoxFit.cover,
      ),
    );
  }
}
