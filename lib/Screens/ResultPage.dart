import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'HomeScreen.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
        title: Text('RESULT', style: defaultText),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
          child: Container(
              decoration: backButtonStyling,
              child: BackButton(color: Colors.black)),
          // child: Icon(CarbonIcons.arrow_left)),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 110,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: Container(
                child: Text('A BREATH OF FRESH AIR', style: defaultText),
              ),
            ),
            resultPhotos(),
            resultPhotos(),

          ],
        ),
      ),
    );
  }
}

class resultPhotos extends StatelessWidget {
  const resultPhotos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: Container(
          height: 350,
          width: 400,
          color: primaryColor,
        )),
        Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Text('JACOB:', style: defaultText),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  decoration: boxstylingThick,
                  child: Image.network('https://picsum.photos/400')),
            ),
            const SizedBox(
              height: 6,
            ),
            Text('24/9 11:33', style: timeText),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ],
    );
  }
}
