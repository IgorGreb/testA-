import 'package:flutter/material.dart';
import 'package:test_webspark/core/const.dart';
import 'package:test_webspark/pages/result_page/result_list_screen.dart';
import 'package:test_webspark/widgets/custom_progress_indicator.dart';

class LoadingPage extends StatefulWidget {
  final Future<Map<String, dynamic>?> fetchData;

  const LoadingPage({super.key, required this.fetchData});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double _progress = Constants.initialProgress;
  List<Map<String, dynamic>>? _data;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startFetching();
  }

  Future<void> _startFetching() async {
    setState(() {
      _progress = 0.0;
      _errorMessage = null;
    });

    try {
      final data = await widget.fetchData;
      setState(() {
        _progress = 1.0;
        if (data != null &&
            data['error'] == false &&
            data.containsKey('data') &&
            data['data'] is List) {
          _data = List<Map<String, dynamic>>.from(data['data']);
        } else {
          _errorMessage = Constants.errorInvServResponse;
          _progress = 0.0;
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = '${Constants.errorFetchingData}$e';
        _progress = 0.0;
      });
    }
  }

  void _navigateToResultScreen() {
    if (_data != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultListScreen(data: _data!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(Constants.errorNoData)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colorWhite,
      appBar: AppBar(
        backgroundColor: Constants.colorBlue,
        title: Text(
          Constants.processTitle,
          style: TextStyle(color: Constants.colorWhite),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.paddingSixtyUnits),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_progress == 1.0 && _data != null)
              const Padding(
                padding: EdgeInsets.only(bottom: Constants.paddingTwentyUnits),
                child: Text(
                  Constants.processDaneMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Constants.fifteenUnits),
                ),
              ),
            if (_errorMessage == null)
              TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: Constants.zeroUnits,
                  end: _progress * Constants.oneHundredUnits,
                ),
                duration: const Duration(
                    milliseconds: Constants.fiveHundredMilliseconds),
                builder: (context, value, child) {
                  return Text(
                    '${value.toStringAsFixed(0)}%',
                    style: const TextStyle(fontSize: Constants.twentyForUnits),
                  );
                },
              ),
            const SizedBox(height: Constants.sizedBoxTwenty),
            Container(
              height: Constants.oneUnits,
              width: double.infinity,
              color: Constants.colorGrey,
            ),
            const SizedBox(height: Constants.sizedBoxTwenty),
            Center(
              child: CustomProgressIndicator(
                progress: _progress,
                color: Constants.colorBlue,
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(Constants.paddingSixtyUnits),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Constants.eighteenUnits,
                    color: Constants.colorRed,
                  ),
                ),
              ),
            if (_progress == 1.0 && _data != null)
              Padding(
                padding:
                    const EdgeInsets.only(top: Constants.paddingTwentyUnits),
                child: Container(
                  decoration: BoxDecoration(
                    color: Constants.colorBlue,
                    borderRadius: BorderRadius.circular(Constants.twelvelUnits),
                  ),
                  height: Constants.fortyUnits,
                  width: Constants.threeHundredUnits,
                  child: Center(
                    child: TextButton(
                      onPressed: _navigateToResultScreen,
                      child: Text(
                        Constants.sendButtonText,
                        style: TextStyle(color: Constants.colorBlack),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
