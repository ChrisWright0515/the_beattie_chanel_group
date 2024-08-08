import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import 'login_form.dart';
import 'sign_up_form.dart';

class MobileBody extends StatefulWidget {


  const MobileBody({
    super.key,

  });

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  bool _showContent = false;
  final PageController _pageController = PageController();
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _pageController.addListener(() {
      setState(() {
        _progress = _pageController.page!;
      });
    });
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      _showContent = true;
    });
  }

  void _goToSignUp() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _goToLogin() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the interpolated height based on the current page index
    // double height = 590 + _progress * 150;

    double height = _progress < 1
        ? 600 + _progress * 250
        : MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const FadingBackground(),
          _buildMobileTopSheet(height, context),
        ],
      ),
    );
  }

  AnimatedPositioned _buildMobileTopSheet(double height, BuildContext context) {
    return AnimatedPositioned(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          top: _showContent ? 0 : -600,
          left: 0,
          right: 0,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 7.0,
                  color: Color(0x4D090F13),
                  offset: Offset(0.0, 3.0),
                )
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
            ),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                LoginForm(
                  onSignUpTap: _goToSignUp,
                ),
                SignUpForm(
                  onLoginTap: _goToLogin,
                ),
              ],
            ),
          ),
        );
  }
}

class FadingBackground extends StatelessWidget {
  const FadingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/createAccount_BG@3x.jpg'),
              ),
            ),
          ),
        );
      },
    );
  }
}
