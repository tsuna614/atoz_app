import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 194, 255),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              // child: SizedBox.fromSize(
              //   size: Size.fromHeight(400),
              //   child: Image(
              //     // image: AssetImage(widget.imageAsset),
              //     image: Image.network(widget.imageAsset).image,
              //   ),
              // ),
              child: Image.asset(
                'assets/images/app/alogo.png',
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
