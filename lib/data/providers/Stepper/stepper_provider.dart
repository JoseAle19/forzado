import 'package:flutter/material.dart';

class StepperProvider with ChangeNotifier {
  int _currentStep = 0;
  int _currentStepOff = 0;

  int get currentStep => _currentStep;
  int get currentStepOff => _currentStepOff;

  void setCurrentStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void setCurrentStepOff(int step) {
    _currentStepOff = step;
    notifyListeners();
  }
}
