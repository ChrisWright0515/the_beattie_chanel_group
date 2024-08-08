import 'package:flutter/material.dart';

import '../../../components/button.dart';
import '../../../constants.dart';

class AccountOptionItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final AnimationInfo animation;

  const AccountOptionItem({
    required this.text,
    required this.onTap,
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const [
              BoxShadow(
                blurRadius: 0,
                color: Color(0xFFE3E5E7),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
              color: const Color(0xFFE3E5E7),
              width: 0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 4, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontFamily: 'Plus Jakarta Sans',
                        letterSpacing: 0,
                      ),
                ),
                CustomIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  buttonSize: 46,
                  icon: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF95A1AC),
                    size: 25,
                  ),
                  onPressed: onTap,
                ).animateOnActionTrigger(animation),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
