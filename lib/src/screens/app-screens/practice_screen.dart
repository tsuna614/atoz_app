import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class PracticeScreen extends StatelessWidget {
  PracticeScreen({super.key});

  final controller = PageController(
    initialPage: 1,
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
            cardCategory: 'Reading',
          ),
          CardItem(
            cardCategory: 'Writing',
          ),
          CardItem(
            cardCategory: 'Listening',
          ),
          CardItem(
            cardCategory: 'Speaking',
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
          child: Column(children: []),
        ),
      ),
    );
  }
}
