import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UniversalLoaderOverlay extends StatelessWidget {
  final Widget child;

  const UniversalLoaderOverlay({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.5),
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 4.5,
            sigmaY: 4.5,
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0), // Rounded edges
              child: Container(
                width: 150,
                height: 120,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(
                      'Please wait...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
