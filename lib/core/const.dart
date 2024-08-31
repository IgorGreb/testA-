import 'package:flutter/material.dart';

class Constants {
  //Текст
  static const String apiTextInput = 'Set valid API base URL to fetch tasks';
  static const String buttonText = 'Start counting process';
  static const String homeTitle = 'Home Screen';
  static const String previewTitle = 'Preview screen';
  static const String processTitle = 'Process screen';
  static const String sendButtonText = 'Send result to server';
  static const String resultScreenText = 'Result Screen';

  static const String processDaneMessage =
      'All calculations have finished, you can send\n your result to the server.';

  static const String textEditingController =
      'https://your-api-endpoint.com/tasks';
  static const String apiUrlDummy = '';

  //Прогрес
  static const double initialProgress = 0.0;
  static const double completedProgress = 1.0;

  //Помилки
  static const String errorValidUrl = 'Please enter a valid URL.';
  static const String errorNoData = 'No data available to send.';
  static const String errorInvServResponse =
      'Invalid server response or error in response data.';
  static const String errorFetchingData = 'Error fetching data: ';

  //Паддінги
  static const double paddingEightUnits = 8.0;
  static const double paddingFiftyUnits = 50.0;
  static const double paddingSixtyUnits = 16.0;
  static const double paddingTwentyUnits = 20.0;

  //Кольори
  static Color colorBlack = const Color(0xFF000000);
  static Color colorBlackWithOpacityZeroDotTwo =
      const Color(0xFF000000).withOpacity(0.2);

  static Color colorBlue = const Color(0xFF69C7F3);
  static Color colorWhite = const Color(0xFFFFFFFF);
  static Color colorGrey = const Color(0xFFB2B2B2);
  static Color colorRed = const Color(0xFFFF0000);
  static Color colorSalatGreen = const Color(0xFF4CAF50);
  static Color colorLightGreen = const Color(0xFF64FFDA);
  static Color colorDarkGreen = const Color(0xFF009688);

  //Інтові числа
  static const int fiftyUnits = 50;
  static const int oneHundredUnits = 100;
  static const int twoUnits = 2;

  //Milliseconds
  static const int fiveHundredMilliseconds = 500;

  //Дабл
  static const double twelvelUnits = 12.0;
  static const double fortyFiveUnits = 45.0;
  static const double threeHundredUnits = 300.0;
  static const double onePointFive = 1.5;
  static const double fortyUnits = 40.0;
  static const double fifteenUnits = 15.0;
  static const double zeroUnits = 0.0;
  static const double twentyForUnits = 24.0;
  static const double oneUnits = 1.0;
  static const double eighteenUnits = 18.0;
  static const double treeUnits = 3.0;
  static const double zeroDotTwoUnits = 0.2;
  static const double fiftyDotZero = 50.0;

  //Sized Box height
  static const double sizedBoxTwenty = 20.0;
  static const double sizedBoxTen = 10.0;
  static const double sizedBoxFifty = 50.0;
  static const double sizedBoxFifteen = 15.0;
  static const double sizedBoxOneHundredFifty = 150.0;
}
