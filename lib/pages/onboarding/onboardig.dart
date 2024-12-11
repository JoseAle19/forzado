import 'package:flutter/material.dart';
import 'package:forzado/core/app_colors.dart';
import 'package:forzado/models/onboarding%20.dart';
import 'package:forzado/pages/auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardigpage extends StatefulWidget {
  const OnBoardigpage({super.key});

  @override
  State<OnBoardigpage> createState() => _OnBoardigpageState();
}

class _OnBoardigpageState extends State<OnBoardigpage> {
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: size.height * 0.7,
            width: double.infinity,
            child: PageView.builder(
                onPageChanged: (int value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                controller: _pageController,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: imagesOmboarding.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = imagesOmboarding[index];
                  return Image.asset(
                    item.image,
                    // fit: BoxFit.cover,
                    // height: 250,
                  );
                }),
          ),
          Container(
            height: size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.decelerate,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: currentIndex == 0
                                ? AppColors.primaryColor
                                : Colors.grey),
                        width: currentIndex == 0 ? 25 : 50,
                        height: 8,
                      ),
                      const SizedBox(width: 10),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.decelerate,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: currentIndex == 1
                                ? AppColors.primaryColor
                                : Colors.grey),
                        width: currentIndex == 1 ? 25 : 50,
                        height: 8,
                      ),
                      const SizedBox(width: 10),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.decelerate,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: currentIndex == 2
                                ? AppColors.primaryColor
                                : Colors.grey),
                        width: currentIndex == 2 ? 25 : 50,
                        height: 8,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: AnimatedSize(
                      duration: const Duration(milliseconds: 400),
                      alignment: Alignment.center,
                      child: Text(
                        imagesOmboarding[currentIndex].name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
                GestureDetector(
                  onTap: () async {
                    _pageController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.decelerate);
                    if (currentIndex == 2) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('aceptOm', true);
                      final route =
                          MaterialPageRoute(builder: (_) => const LoginPage());
                      Navigator.push(context, route);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      currentIndex == 2 ? 'Aceptar' : 'Siguiente',
                      style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
