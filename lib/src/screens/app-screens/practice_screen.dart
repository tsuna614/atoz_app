import 'package:atoz_app/src/screens/app-screens/practice-screens/listening_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/reading_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/speaking_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/writing_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class PracticeScreen extends StatelessWidget {
  PracticeScreen({super.key});

  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice'),
      ),
      // body: ListView.builder(
      //   padding: EdgeInsets.symmetric(vertical: 16.0),
      //   itemCount: 1,
      //   itemBuilder: (BuildContext context, int index) {
      //     if (index % 2 == 0) {
      //       return _buildCarousel(context, index);
      //     } else {
      //       return Divider();
      //     }
      //   },
      // ),
      body: PageView(
        controller: controller,
        children: const [
          CardItem(
            cardCategory: 'reading',
          ),
          CardItem(
            cardCategory: 'writing',
          ),
          CardItem(
            cardCategory: 'listening',
          ),
          CardItem(
            cardCategory: 'speaking',
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.cardCategory});

  final String cardCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            if (cardCategory == 'reading')
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/reading.png'),
              )
            else if (cardCategory == 'writing')
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/writing.png'),
              )
            else if (cardCategory == 'listening')
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/listening.png'),
              )
            else if (cardCategory == 'speaking')
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/speaking.png'),
              ),
            SizedBox(height: 16),
            Text(
              "${cardCategory[0].toUpperCase()}${cardCategory.substring(1).toLowerCase()}",
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            Divider(
              height: 40,
              thickness: 3,
              indent: 100,
              endIndent: 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Practice your skill with this gamemode. While it is certainly fun to play, it will definitely not give you an easy task. Your heart will not decrease if you lose in this gamemode.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.all(32),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size.fromHeight(40)),
                onPressed: () {
                  if (cardCategory == 'reading') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReadingScreen()),
                    );
                  } else if (cardCategory == 'listening') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListeningScreen()),
                    );
                  } else if (cardCategory == 'writing') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WritingScreen()),
                    );
                  } else if (cardCategory == 'speaking') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SpeakingScreen()),
                    );
                  }
                },
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
