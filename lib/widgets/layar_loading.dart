import 'package:flutter/material.dart';
import 'package:dotlottie_flutter/dotlottie.dart';

class LayarLoading extends StatelessWidget {
  const LayarLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DotLottieAnimation(
            source: DotLottieSource.url("https://lottie.host/562ef7df-3759-4e44-98bd-14627f714daa/b5xbSW0u3q.lottie"),
            autoplay: true,
            loop: true,
            speed: 3.0,
            useFrameInterpolation: false,
            playMode: DotLottieAnimationPlayMode.forward,
            backgroundColor: Colors.grey[200],
          ),
        ),
      ),
    );
  }
}