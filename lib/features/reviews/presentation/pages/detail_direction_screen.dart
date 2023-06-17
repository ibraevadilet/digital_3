import 'package:digital_3/features/reviews/data/models/review_model.dart';
import 'package:digital_3/features/reviews/presentation/widgets/custom_step_widget.dart';
import 'package:digital_3/helpers/app_text_styles.dart';
import 'package:digital_3/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DetailDirectionScreen extends StatefulWidget {
  const DetailDirectionScreen({
    required this.data,
    super.key,
  });
  final List<StepModel> data;

  @override
  State<DetailDirectionScreen> createState() => _DetailDirectionScreenState();
}

class _DetailDirectionScreenState extends State<DetailDirectionScreen> {
  int activeStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const BackButton(),
                        CustomStepWidget(
                          activeStep: activeStep,
                          stepLenght: widget.data.length,
                          padding: 28,
                          betweenWidth: 4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.data[activeStep - 1].title,
                        style: AppTextStyles.s18W600(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.data[activeStep - 1].description,
                        style: AppTextStyles.s16W400(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  activeStep != 1
                      ? CustomButton(
                          onPressed: () {
                            setState(() {
                              activeStep--;
                            });
                          },
                          width: (MediaQuery.of(context).size.width - 72) / 3,
                          height: 48,
                          radius: 8,
                          color: Colors.grey,
                          text: 'Назад',
                        )
                      : const SizedBox(),
                  SizedBox(
                    width: activeStep != 1 ? 24 : 0,
                  ),
                  CustomButton(
                    onPressed: () {
                      if (activeStep != widget.data.length) {
                        setState(() {
                          activeStep++;
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    width: activeStep != 1
                        ? (MediaQuery.of(context).size.width - 72) / 3 * 2
                        : MediaQuery.of(context).size.width - 56,
                    height: 48,
                    radius: 8,
                    color: Colors.blue,
                    text: activeStep != widget.data.length ? 'Дальше' : 'Выйти',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
