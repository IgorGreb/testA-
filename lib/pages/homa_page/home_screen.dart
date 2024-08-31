import 'package:flutter/material.dart';
import 'package:test_webspark/core/const.dart';
import 'package:test_webspark/core/images.dart';
import 'package:test_webspark/pages/homa_page/data/fetch_data_from_server.dart';
import 'package:test_webspark/pages/homa_page/data/validate_url.dart';
import 'package:test_webspark/pages/loading_page/loadind_page.dart';
import 'package:test_webspark/pages/result_page/result_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController =
      TextEditingController(text: Constants.textEditingController);
  String _apiUrl = Constants.apiUrlDummy;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _startProcess() async {
    // Перевірка на валідність URL
    if (ValidateUrl.isValidUrl(_urlController.text)) {
      _apiUrl = _urlController.text;

      // Показати LoadindPage з індикатором завантаження
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingPage(
            fetchData: fetchDataFromServer(_apiUrl),
          ),
        ),
      );

      // Якщо дані повернені, переход до ResultListScreen з отриманими даними
      if (result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultListScreen(
              data: result,
            ),
          ),
        );
      }
    } else {
      setState(() {
        _errorMessage = Constants.errorValidUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colorWhite,
      appBar: AppBar(
        shadowColor: Constants.colorBlack,
        backgroundColor: Constants.colorBlue,
        title: Text(
          Constants.homeTitle,
          style: TextStyle(color: Constants.colorWhite),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(Constants.paddingEightUnits),
              child: Text(Constants.apiTextInput),
            ),
            const SizedBox(height: Constants.sizedBoxTen),
            Row(
              children: [
                const SizedBox(
                  width: Constants.sizedBoxFifteen,
                ),
                Image.asset(
                  AppImage.arrowImage,
                  height: Constants.fortyUnits,
                  width: Constants.fortyUnits,
                ),
                const SizedBox(
                  width: Constants.sizedBoxFifty,
                ),
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      errorText: _errorMessage,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Constants.colorBlack),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Constants.colorBlack),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height:
                  MediaQuery.of(context).size.height / Constants.onePointFive,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.paddingFiftyUnits),
              child: Container(
                decoration: BoxDecoration(
                  color: Constants.colorBlue,
                  borderRadius: BorderRadius.circular(Constants.twelvelUnits),
                  border: Border.all(color: Constants.colorBlue),
                ),
                height: Constants.fortyFiveUnits,
                width: Constants.threeHundredUnits,
                child: TextButton(
                  onPressed: _startProcess,
                  child: Text(
                    Constants.buttonText,
                    style: TextStyle(color: Constants.colorBlack),
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
