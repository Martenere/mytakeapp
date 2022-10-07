import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';


class PromptPage extends StatelessWidget {
  PromptPage({super.key, required this.url});
  var url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: 
      Stack(
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
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                    decoration: boxstylingThick,
                    child: FutureBuilder(
                      future: url, 
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData)
                        {print(snapshot.data);
                          return Image.network(
                            snapshot.data!);}
                            else{return SizedBox();}
                      }
                    )),
              ),
              const SizedBox(
                height: 32,
              ),

              Text('MYTAKE', style: defaultText),

              const SizedBox(
                height: 12,
              ),

              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(CarbonIcons.camera),
                      Spacer(),
                      Icon(CarbonIcons.arrow_right),
                    ],
                  ),
                ),
                decoration: buttonStyling,
                width: 120,
                height: 60,
              )
            ],
          ),
        ],
      ),
    );
  }
}
