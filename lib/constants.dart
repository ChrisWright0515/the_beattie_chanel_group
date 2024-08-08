import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

// Sizes and Durations
const double kDefaultPadding = 20.0;
const animationDuration = Duration(milliseconds: 200);

// Light Colors
const Color lightBackground = Color(0xfffad6d9);
const Color lightPrimary = Color(0xFFCDFFF3);
const Color lightAccent = Color(0xff4d148a);
const Color lightText = Color(0xff000000);
const Color lightSecondary = Color(0xffff00ff);
const Color lightWarning = Color(0xfff59f01);
const Color lightError = Color(0xffc82a33);

// Dark Colors
const Color darkBackground = Color.fromARGB(255, 0, 0, 0);
const Color darkPrimary = Color.fromARGB(255, 49, 170, 140);
const Color darkAccent = Color(0xffae75eb);
const Color darkText = Color(0xffffffff);
const Color darkSecondary = Color(0xffff00ff);
const Color darkWarning = Color(0xfff59f01);
const Color darkError = Color(0xffc82a33);

const Color buttonPrimary = lightSecondary;

// Gradients
const LinearGradient primaryGradient = LinearGradient(
  colors: [lightPrimary, lightSecondary],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient linearPrimarySecondary = LinearGradient(
  colors: [Color(0xffdbfff6), Color(0xffff00ff)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient linearPrimaryAccent = LinearGradient(
  colors: [Color(0xffdbfff6), Color(0xff4d148a)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient linearSecondaryAccent = LinearGradient(
  colors: [Color(0xffff00ff), Color(0xff4d148a)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// Radial Gradients
const RadialGradient radialPrimarySecondary = RadialGradient(
  colors: [Color(0xffdbfff6), Color(0xffff00ff)],
  center: Alignment.center,
  radius: 0.5,
);

const RadialGradient radialPrimaryAccent = RadialGradient(
  colors: [Color(0xffdbfff6), Color(0xff4d148a)],
  center: Alignment.center,
  radius: 0.5,
);

const RadialGradient radialSecondaryAccent = RadialGradient(
  colors: [Color(0xffff00ff), Color(0xff4d148a)],
  center: Alignment.center,
  radius: 0.5,
);
// Light Input Decoration Theme
final InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: lightBackground,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: lightPrimary),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: lightPrimary),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: lightAccent),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: lightError),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: lightError),
  ),
  labelStyle: const TextStyle(color: lightText),
  hintStyle: TextStyle(color: lightText.withOpacity(0.6)),
  contentPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 0.0, 24.0),
);

// Dark Input Decoration Theme
final InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: darkBackground,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: darkPrimary),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: darkPrimary),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: darkAccent),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: darkError),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: darkError),
  ),
  labelStyle: const TextStyle(color: darkText),
  hintStyle: TextStyle(color: darkText.withOpacity(0.6)),
  contentPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 0.0, 24.0),
);

// light Text Theme
final TextTheme lightTextTheme = TextTheme(
  bodyLarge: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  bodyMedium: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  headlineLarge: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  headlineMedium: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  headlineSmall: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  titleLarge: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  titleMedium: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  titleSmall: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  labelLarge: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  labelMedium: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  labelSmall: TextStyle(
      color: lightText, fontFamily: GoogleFonts.cantataOne().fontFamily),
);

// dark Text Theme
final TextTheme darkTextTheme = TextTheme(
  bodyLarge: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  bodyMedium: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  headlineLarge: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  headlineMedium: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  headlineSmall: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  titleLarge: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  titleMedium: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  titleSmall: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  labelLarge: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  labelMedium: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
  labelSmall: TextStyle(
      color: darkText, fontFamily: GoogleFonts.cantataOne().fontFamily),
);

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimary,
  primaryColorDark: lightAccent,
  scaffoldBackgroundColor: lightBackground,
  textTheme: lightTextTheme,
  inputDecorationTheme: lightInputDecorationTheme,
  appBarTheme: const AppBarTheme(
    color: lightPrimary,
    titleTextStyle: TextStyle(
      color: lightText,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: lightText,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: buttonPrimary,
    textTheme: ButtonTextTheme.primary,
  ),
  colorScheme: const ColorScheme(
    primary: lightPrimary,
    secondary: lightAccent,
    surface: lightBackground,
    error: lightError,
    onPrimary: lightText,
    onSecondary: lightText,
    onSurface: lightText,
    onError: lightText,
    brightness: Brightness.light,
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkPrimary,
  primaryColorDark: darkAccent,
  scaffoldBackgroundColor: darkBackground,
  textTheme: darkTextTheme,
  inputDecorationTheme: darkInputDecorationTheme,
  appBarTheme: const AppBarTheme(
    color: darkPrimary,
    titleTextStyle: TextStyle(
      color: darkText,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: darkText,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: buttonPrimary,
    textTheme: ButtonTextTheme.primary,
  ),
  colorScheme: const ColorScheme(
    primary: darkPrimary,
    secondary: darkAccent,
    surface: darkBackground,
    error: darkError,
    onPrimary: darkText,
    onSecondary: darkText,
    onSurface: darkText,
    onError: darkText,
    brightness: Brightness.dark,
  ),
);

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

extension FFStringExt on String {
  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;
}

extension StatefulWidgetExtensions on State<StatefulWidget> {
  /// Check if the widget exist before safely setting state.
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(fn);
    }
  }
}

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;

  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  //* Initialize the size configurations
  static void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;
    heightMultiplier = blockSizeVertical;
  }

  static double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / 812.0) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    return (inputWidth / 375.0) * screenWidth;
  }

  // get percentage of screen width
  static double getProportionateScreenWidthPercentage(double percentage) {
    return (percentage / 100) * screenWidth;
  }

  // get percentage of screen height
  static double getProportionateScreenHeightPercentage(double percentage) {
    return (percentage / 100) * screenHeight;
  }
}

enum AnimationTrigger {
  onPageLoad,
  onActionTrigger,
}

class AnimationInfo {
  AnimationInfo({
    required this.trigger,
    required this.effectsBuilder,
    this.loop = false,
    this.reverse = false,
    this.applyInitialState = true,
  });
  final AnimationTrigger trigger;
  final List<Effect> Function()? effectsBuilder;
  final bool applyInitialState;
  final bool loop;
  final bool reverse;
  late AnimationController controller;

  List<Effect>? _effects;
  List<Effect> get effects => _effects ??= effectsBuilder!();

  void maybeUpdateEffects(List<Effect>? updatedEffects) {
    if (updatedEffects != null) {
      _effects = updatedEffects;
    }
  }
}

void createAnimation(AnimationInfo animation, TickerProvider vsync) {
  final newController = AnimationController(vsync: vsync);
  animation.controller = newController;
}

void setupAnimations(Iterable<AnimationInfo> animations, TickerProvider vsync) {
  for (var animation in animations) {
    createAnimation(animation, vsync);
  }
}

extension AnimatedWidgetExtension on Widget {
  Widget animateOnPageLoad(
    AnimationInfo animationInfo, {
    List<Effect>? effects,
  }) {
    animationInfo.maybeUpdateEffects(effects);
    return Animate(
      effects: animationInfo.effects,
      child: this,
      onPlay: (controller) => animationInfo.loop
          ? controller.repeat(reverse: animationInfo.reverse)
          : null,
      onComplete: (controller) => !animationInfo.loop && animationInfo.reverse
          ? controller.reverse()
          : null,
    );
  }

  Widget animateOnActionTrigger(
    AnimationInfo animationInfo, {
    List<Effect>? effects,
    bool hasBeenTriggered = false,
  }) {
    animationInfo.maybeUpdateEffects(effects);
    return hasBeenTriggered || animationInfo.applyInitialState
        ? Animate(
            controller: animationInfo.controller,
            autoPlay: false,
            effects: animationInfo.effects,
            child: this)
        : this;
  }
}

class TiltEffect extends Effect<Offset> {
  const TiltEffect({
    super.delay,
    super.duration,
    super.curve,
    Offset? begin,
    Offset? end,
  }) : super(
          begin: begin ?? const Offset(0.0, 0.0),
          end: end ?? const Offset(0.0, 0.0),
        );

  @override
  Widget build(
    BuildContext context,
    Widget child,
    AnimationController controller,
    EffectEntry entry,
  ) {
    Animation<Offset> animation = buildAnimation(controller, entry);
    return getOptimizedBuilder<Offset>(
      animation: animation,
      builder: (_, __) => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(animation.value.dx)
          ..rotateY(animation.value.dy),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
