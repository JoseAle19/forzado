import 'package:flutter/material.dart';

class StepperProvider with ChangeNotifier {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  void setCurrentStep(int step) {
    _currentStep = step;
    notifyListeners();
  }
  
}