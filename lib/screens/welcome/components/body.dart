import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../login/login_screen.dart';
import 'welcome_screen_content.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> welcomeScreens = [
    {
      "text": "The Beattie-Chanel Group",
      "subText": "Welcome to the Beattie-Chanel Group",
      "image": "assets/images/placeholder.jpg"
    },
    {
      "text": "Beattie",
      "subText": "Danielle Beattie",
      "image": "assets/images/placeholder.jpg"
    },
    {
      "text": "Chanel",
      "subText": "Chanel Chanel",
      "image": "assets/images/placeholder.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: welcomeScreens.length,
                itemBuilder: (context, index) => WelcomeScreenContent(
                  text: welcomeScreens[index]['text'] ??
                      'The Beattie-Chanel Group',
                  subText: welcomeScreens[index]['subText'] ?? '',
                  image: welcomeScreens[index]['image'] ??
                      'assets/images/placeholder.jpg',
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        welcomeScreens.length,
                        (index) => paginateDots(index: index),
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            // Add more widgets here
          ],
        ),
      ),
    );
  }

  AnimatedContainer paginateDots({int? index}) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).primaryColor
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.text,
    required this.press,
    this.loadingIcon,
  });
  final String? text;
  final Widget? loadingIcon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: SizeConfig.getProportionateScreenWidthPercentage(50),
        maxHeight: SizeConfig.getProportionateScreenHeight(56),
      ),
      child: TextButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.resolveWith<double?>(
            (states) {
              if (states.contains(WidgetState.hovered)) {
                return 8.0;
              }
              return 2.0;
            },
          ),
          backgroundColor:
              WidgetStateProperty.all(buttonPrimary.withOpacity(0.3)),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: SizeConfig.getProportionateScreenWidth(20),
              vertical: SizeConfig.getProportionateScreenHeight(15),
            ),
          ),
        ),
        onPressed: press as void Function()?,
        child: loadingIcon ??
            Text(
              // if loadingIcon is null, use Text
              text!,
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(18),
                color: Colors.white,
              ),
            ),
      ),
    );
  }
}
