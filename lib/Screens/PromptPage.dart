import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:carbon_icons/carbon_icons.dart';

class PromptPage extends StatelessWidget {
  const PromptPage({super.key});

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
          Positioned(child: Container(height: 350,width: 400, color: primaryColor,)),
          Column(
            children: [

              // Stack(
              //   children: [
              //     Positioned(
              //       // bottom: 0,
              //         child: Container(
              //       height: 400,
              //       width: 400,
              //       color: Colors.black,
              //     ))
              //   ],
              // ),

              // child: Stack(
              //   children: [Positioned(
              //     left: 24,
              //     right: 24,
              //     child: Container(color: Colors.blue))],
              // ),
              const SizedBox(
                height: 32,
              ),
              Text('JACOB:', style: defaultText),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                    decoration: boxstylingThick,
                    child: Image.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
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

              // Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 42.0),
              //     child: Material(
              //       color: Colors.black,
              //       child: MaterialButton(
              //         splashColor: ,
              //         onPressed: () {},
              //         height: 50.0,
              //         child: Row(
              //           children: [Icon(Icons.abc), Icon(Icons.abc)
              //           ],
              //         ),
              //       ),
              //     ))
            ],
          ),
        ],
      ),
    );
  }
}
