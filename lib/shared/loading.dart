import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinKit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50,
        ),
      );
  }
}
