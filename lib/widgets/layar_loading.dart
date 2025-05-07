import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LayarLoading extends StatelessWidget {
  const LayarLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38, // Semi-transparent background
      child: Center(
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withAlpha(25),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Lottie.network(
              // Loading animation yang lebih simpel namun elegan
              "https://assets7.lottiefiles.com/packages/lf20_rwq6ciql.json",
              frameRate: FrameRate.max,
              repeat: true,
              animate: true,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}