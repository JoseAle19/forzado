import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';


class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int activeStep = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        // color: Colors.red,
        child: EasyStepper(
                  activeStep: activeStep,
                  stepShape: StepShape.rRectangle,
                  stepBorderRadius: 15,
                  borderThickness: 2,
                  stepRadius: 28,
                  finishedStepBorderColor: Colors.deepOrange,
                  finishedStepTextColor: Colors.deepOrange,
                  finishedStepBackgroundColor: Colors.deepOrange,
                  activeStepIconColor: Colors.deepOrange,
                  showLoadingAnimation: false,
                  steps: [
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 0 ? 1 : 0.3,
                          child: Image.asset('assets/1.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Dash 1',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 1 ? 1 : 0.3,
                          child: Image.asset('assets/2.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Dash 2',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 2 ? 1 : 0.3,
                          child: Image.asset('assets/3.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Dash 3',
                        textAlign: TextAlign.center,
                      ),
                    ),
                 
                  ],
                  onStepReached: (index) => setState(() => activeStep = index),
                ),
    );
  }
}