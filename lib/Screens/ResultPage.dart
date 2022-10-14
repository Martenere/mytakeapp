import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:mytakeapp/main.dart';
import '../firebase/firebaseCommunication.dart';
import 'HomeScreen.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    var url = fb.downloadFile();
    print(url.toString());
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
                // INSERT PROMPT HERE
                child: Text('A BREATH OF FRESH AIR', style: defaultText),
              ),
            ),
            resultPhotos(url: 'https://picsum.photos/200/300',),
            resultPhotos(url: 'https://picsum.photos/200/300',),

            FutureBuilder(
            future: url,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          resultPhotos(url: snapshot.data.toString()),
                          SizedBox(
            height: 32,
          ),
                        ],
                      );
                    });
              } else {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
            }),

          ],
        ),
      ),
    );
  }
}

class resultPhotos extends StatelessWidget {
  resultPhotos({
    Key? key, required this.url
  }) : super(key: key);
  String url;

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
                  child: Image.network(url)),
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
