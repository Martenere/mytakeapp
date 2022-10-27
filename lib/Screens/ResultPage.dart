import 'package:flutter/material.dart';
import 'package:mytakeapp/Providers/group_provider.dart';
import 'package:mytakeapp/main.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import '../models/buttons.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    var url = fb
        .downloadFile(Provider.of<GroupProvider>(context, listen: false).group);
    print(url.toString());
    var group = Provider.of<GroupProvider>(context, listen: false).group;

    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
        title: Text('RESULT', style: defaultText),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
          child: backButton(),
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
                child: FutureBuilder(
                    future: group.getTextPrompt(),
                    builder: (context, AsyncSnapshot<String> textPrompt) {
                      if (textPrompt.hasData) {
                        return Text('PROMPT: ' + textPrompt.data!.toUpperCase(),
                            style: defaultText);
                      } else {
                        return SizedBox();
                      }
                    }),
              ),
            ),
            FutureBuilder(
                future: url,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              resultPhotos(
                                  url: snapshot.data![index],
                                  pictureTaker: group.getNameFromId(group
                                      .people[index % group.people.length])),
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
  resultPhotos({Key? key, required this.url, required this.pictureTaker})
      : super(key: key);
  String url;
  Future<String> pictureTaker;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
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
            FutureBuilder(
                future: pictureTaker,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!, style: defaultText);
                  } else {
                    return Container(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  height: size,
                  width: size,
                  decoration: boxstylingThick,
                  child: Image.network(
                    url,
                    fit: BoxFit.fitWidth,
                  )),
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
