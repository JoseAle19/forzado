import 'package:flutter/material.dart';
import 'package:forzado/core/app_colors.dart';
import 'package:forzado/data/providers/splash_provider.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context);

    if (splashProvider.nextPage == null) {
      splashProvider.loadInitialData();
    }
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.primaryColor,
      child: splashProvider.nextPage == null
          ? Center(child: Image.asset('assets/logos/logo.png'))
          : FutureBuilder(
              future: Future.delayed(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => splashProvider.nextPage!),
                      (route) => false,
                    );
                  });
                }
                return Center(child: Image.asset('assets/logos/logo.png'));
              },
            ),
    );
  }
}
