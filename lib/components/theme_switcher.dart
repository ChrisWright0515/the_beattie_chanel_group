import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

// class ThemeSwitcher extends StatelessWidget {
//   const ThemeSwitcher({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
//     bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

//     return InkWell(
//       splashColor: Colors.transparent,
//       focusColor: Colors.transparent,
//       hoverColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       onTap: () {
//         themeProvider.toggleTheme();
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           color: Theme.of(context).primaryColorDark,
//           boxShadow: const [
//             BoxShadow(
//               blurRadius: 1,
//               color: Color(0xFF1A1F24),
//               offset: Offset(0, 0),
//             )
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 isDarkTheme ? 'Switch to Light Mode' : 'Switch to Dark Mode',
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontFamily: 'Outfit',
//                       color: Colors.white,
//                       fontSize: 14,
//                       letterSpacing: 0,
//                       fontWeight: FontWeight.w500,
//                     ),
//               ),
//               Container(
//                 width: 80,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: isDarkTheme
//                       ? Theme.of(context).scaffoldBackgroundColor
//                       : const Color(0xFF1D2429),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Stack(
//                   alignment: const AlignmentDirectional(0, 0),
//                   children: [
//                     Align(
//                       alignment: isDarkTheme
//                           ? AlignmentDirectional(-0.85, 0)
//                           : AlignmentDirectional(0.95, 0),
//                       child: Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(
//                             isDarkTheme ? 8 : 0, 2, isDarkTheme ? 0 : 8, 0),
//                         child: Icon(
//                           isDarkTheme
//                               ? Icons.wb_sunny_rounded
//                               : Icons.nights_stay,
//                           color: const Color(0xFF95A1AC),
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: isDarkTheme
//                           ? AlignmentDirectional(0.9, 0)
//                           : AlignmentDirectional(-0.85, 0),
//                       child: Container(
//                         width: 36,
//                         height: 36,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF14181B),
//                           boxShadow: const [
//                             BoxShadow(
//                               blurRadius: 4,
//                               color: Color(0x430B0D0F),
//                               offset: Offset(0, 2),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(30),
//                           shape: BoxShape.rectangle,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        themeProvider.toggleTheme();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              color: Color(0xFF1A1F24),
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isDarkTheme ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? Theme.of(context).scaffoldBackgroundColor
                      : const Color(0xFF1D2429),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: isDarkTheme
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            isDarkTheme ? 8 : 0, 2, isDarkTheme ? 0 : 8, 0),
                        child: Icon(
                          isDarkTheme
                              ? Icons.wb_sunny_rounded
                              : Icons.nights_stay,
                          color: const Color(0xFF95A1AC),
                          size: 20,
                        ),
                      ),
                    ),
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      alignment: isDarkTheme
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF14181B),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x430B0D0F),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
