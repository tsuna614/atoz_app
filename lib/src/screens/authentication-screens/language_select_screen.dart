import 'package:flutter/material.dart';

class LanguageSelectPage extends StatelessWidget {
  LanguageSelectPage({super.key});

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 194, 255),
      body: Stack(
        children: [
          Positioned(
            top: 160,
            left: 50,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'First, let us set you up!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'What language do you want to study?',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 1,
                    //     blurRadius: 1,
                    //     offset: Offset(0, 3), // changes position of shadow
                    //   ),
                    // ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: ConstrainedBox(
                    // height: 100,
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height),
                    child: Scrollbar(
                      thickness: 10.0,
                      thumbVisibility: true,
                      controller: controller,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, right: 10),
                        child: ListView(
                          controller: controller,
                          scrollDirection: Axis.vertical,
                          children: const [
                            CountryCard(
                              country: 'Vietnamese',
                              flagAssets: 'assets/images/vietnam.png',
                            ),
                            CountryCard(
                              country: 'English',
                              flagAssets: 'assets/images/uk.png',
                            ),
                            CountryCard(
                              country: 'Japanese',
                              flagAssets: 'assets/images/japan.png',
                            ),
                            CountryCard(
                              country: 'German',
                              flagAssets: 'assets/images/germany.png',
                            ),
                            CountryCard(
                              country: 'French',
                              flagAssets: 'assets/images/france.png',
                            ),
                            CountryCard(
                              country: 'Spanish',
                              flagAssets: 'assets/images/spain.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class TemporaryPlayerTitle extends StatelessWidget {
//   const TemporaryPlayerTitle({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ListTile(
//         leading: SizedBox(
//           height: 80,
//           width: 80,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage("assets/images/pfp.jpeg"),
//               ),
//             ],
//           ),
//         ),
//         trailing: Text('2190'),
//         tileColor: Colors.white,
//       ),
//     );
//   }
// }

class CountryCard extends StatelessWidget {
  const CountryCard({
    super.key,
    required this.country,
    required this.flagAssets,
  });

  final String country;
  final String flagAssets;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () => {},
              child: Container(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        child: Image(
                          image: AssetImage(flagAssets),
                        ),
                      ),
                      Spacer(),
                      Text(
                        country,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
