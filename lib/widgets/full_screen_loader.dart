import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black54,
        backgroundBlendMode: BlendMode.darken,
      ),
      child: Center(
        child: HeartbeatProgressIndicator(
            child: SizedBox(
          height: 70.0,
          width: 70.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0,right: 2.0),
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/ic_wtq_app.png',
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
