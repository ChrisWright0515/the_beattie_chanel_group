import 'package:flutter/material.dart';

import '../../../constants.dart';

class WelcomeScreenContent extends StatelessWidget {
  const WelcomeScreenContent({
    super.key,
    this.text = '',
    this.subText = '',
    this.image = '',
  });
  final String text, subText, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(30),
              // color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              // fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ),
        Text(
          subText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const Spacer(
          flex: 2,
        ),
        Image.asset(
          image,
          height: SizeConfig.getProportionateScreenHeight(300),
          width: SizeConfig.getProportionateScreenWidth(300),
        )
      ],
    );
  }
}
