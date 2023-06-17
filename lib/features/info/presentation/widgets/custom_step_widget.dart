import 'package:flutter/material.dart';

class CustomStepWidget extends StatelessWidget {
  const CustomStepWidget({
    required this.activeStep,
    required this.stepLenght,
    this.padding = 24,
    this.betweenWidth = 4,
    this.addPadding = false,
    this.fillPreviusStep = false,
    super.key,
  });
  final int activeStep;
  final int stepLenght;
  final double padding;
  final double betweenWidth;
  final bool addPadding;
  final bool fillPreviusStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: addPadding ? EdgeInsets.symmetric(horizontal: padding) : null,
      height: 2,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: stepLenght,
        separatorBuilder: (context, index) => SizedBox(
          width: betweenWidth,
        ),
        itemBuilder: (context, index) => Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: fillPreviusStep
                      ? activeStep >= index + 1
                          ? Colors.black
                          : Colors.grey
                      : activeStep == index + 1
                          ? Colors.black
                          : Colors.grey),
              height: 2,
              width: (MediaQuery.of(context).size.width -
                      (padding * 2 + betweenWidth * (stepLenght - 1))) /
                  stepLenght,
            ),
          ],
        ),
      ),
    );
  }
}
