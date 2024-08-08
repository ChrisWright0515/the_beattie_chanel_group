// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:provider/provider.dart';

// import '../../components/button.dart';
// import '../../components/logout_button.dart';
// import '../../constants.dart';
// import '../../models/user.dart';
// import '../../provider/auth_provider.dart';
// import '../../provider/theme_provider.dart';
// import '../../services/user_service.dart';
// import '../edit_profile/edit_profile_screen.dart';
// import '../welcome/welcome_screen.dart';

// // class ProfileScreen extends StatefulWidget {
// //   const ProfileScreen({super.key});
// //   @override
// //   State<ProfileScreen> createState() => _ProfileScreenState();
// // }
// // class _ProfileScreenState extends State<ProfileScreen>
// //     with TickerProviderStateMixin {
// //   final scaffoldKey = GlobalKey<ScaffoldState>();
// //   var hasContainerTriggered1 = false;
// //   var hasContainerTriggered2 = false;
// //   final animationsMap = <String, AnimationInfo>{};
// //   @override
// //   void initState() {
// //     super.initState();
// //     animationsMap.addAll({
// //       'containerOnActionTriggerAnimation1': AnimationInfo(
// //         trigger: AnimationTrigger.onActionTrigger,
// //         applyInitialState: false,
// //         effectsBuilder: () => [
// //           MoveEffect(
// //             curve: Curves.easeInOut,
// //             delay: 0.0.ms,
// //             duration: 350.0.ms,
// //             begin: const Offset(40.0, 0.0),
// //             end: const Offset(0.0, 0.0),
// //           ),
// //         ],
// //       ),
// //       'containerOnActionTriggerAnimation2': AnimationInfo(
// //         trigger: AnimationTrigger.onActionTrigger,
// //         applyInitialState: false,
// //         effectsBuilder: () => [
// //           MoveEffect(
// //             curve: Curves.easeInOut,
// //             delay: 0.0.ms,
// //             duration: 350.0.ms,
// //             begin: const Offset(-40.0, 0.0),
// //             end: const Offset(0.0, 0.0),
// //           ),
// //         ],
// //       ),
// //     });
// //     setupAnimations(
// //       animationsMap.values.where((anim) =>
// //           anim.trigger == AnimationTrigger.onActionTrigger ||
// //           !anim.applyInitialState),
// //       this,
// //     );
// //   }
// //   @override
// //   void dispose() {
// //     super.dispose();
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     AuthProvider authProvider = Provider.of<AuthProvider>(context);
// //     ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
// //     User? currentUser = authProvider.user;
// //     UserService userService =
// //         UserService(); // Create an instance of UserService
// //     return Scaffold(
// //       key: scaffoldKey,
// //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
// //       body: StreamBuilder<User>(
// //         stream: userService.getUser(currentUser!.id),
// //         builder: (context, snapshot) {
// //           // Customize what your widget looks like when it's loading.
// //           if (!snapshot.hasData) {
// //             return Center(
// //               child: SizedBox(
// //                 width: 50,
// //                 height: 50,
// //                 child: CircularProgressIndicator(
// //                   valueColor: AlwaysStoppedAnimation<Color>(
// //                     Theme.of(context).primaryColor,
// //                   ),
// //                 ),
// //               ),
// //             );
// //           }
// //           final columnUsersRecord = snapshot.data!;
// //           return Column(
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               Container(
// //                 width: MediaQuery.sizeOf(context).width,
// //                 height: 160,
// //                 decoration: BoxDecoration(
// //                   color: themeProvider.isDarkTheme()
// //                       ? Color(0xFF1D2429)
// //                       : Colors.white,
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
// //                   child: Row(
// //                     mainAxisSize: MainAxisSize.max,
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       Card(
// //                         clipBehavior: Clip.antiAliasWithSaveLayer,
// //                         color: const Color(0xFF30B2A3),
// //                         elevation: 0,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(60),
// //                         ),
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(2),
// //                           child: ClipRRect(
// //                             borderRadius: BorderRadius.circular(60),
// //                             child: Image.network(
// //                               columnUsersRecord.profilePictureUrl!,
// //                               width: 80,
// //                               height: 80,
// //                               fit: BoxFit.cover,
// //                               errorBuilder: (context, error, stackTrace) {
// //                               print('Error loading image: $error');
// //                                 return Image.asset(
// //                                   'assets/images/placeholder.jpg', // path to your placeholder image
// //                                   width: 80,
// //                                   height: 80,
// //                                   fit: BoxFit.cover,
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       Expanded(
// //                         child: Padding(
// //                           padding:
// //                               const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
// //                           child: Column(
// //                             mainAxisSize: MainAxisSize.max,
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(
// //                                 valueOrDefault<String>(
// //                                   columnUsersRecord.name,
// //                                   columnUsersRecord.email,
// //                                 ),
// //                                 style: Theme.of(context)
// //                                     .textTheme
// //                                     .headlineSmall!
// //                                     .copyWith(
// //                                       fontFamily: 'Lexend Deca',
// //                                       // color: Colors.white,
// //                                       fontSize: 20,
// //                                       letterSpacing: 0,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsetsDirectional.fromSTEB(
// //                                     0, 4, 0, 0),
// //                                 child: Text(
// //                                   columnUsersRecord.email,
// //                                   style: Theme.of(context)
// //                                       .textTheme
// //                                       .bodyMedium!
// //                                       .copyWith(
// //                                         fontFamily: 'Lexend Deca',
// //                                         // color: Theme.of(context)
// //                                         //     .primary,
// //                                         fontSize: 14,
// //                                         letterSpacing: 0,
// //                                         fontWeight: FontWeight.normal,
// //                                       ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               Column(
// //                 mainAxisSize: MainAxisSize.max,
// //                 children: [
// //                   if (!(Theme.of(context).brightness == Brightness.dark))
// //                     InkWell(
// //                       splashColor: Colors.transparent,
// //                       focusColor: Colors.transparent,
// //                       hoverColor: Colors.transparent,
// //                       highlightColor: Colors.transparent,
// //                       onTap: () async {
// //                         Provider.of<ThemeProvider>(context, listen: false)
// //                             .toggleTheme();
// //                       },
// //                       child: Container(
// //                         width: MediaQuery.sizeOf(context).width,
// //                         decoration: BoxDecoration(
// //                           color: Theme.of(context).primaryColorDark,
// //                           boxShadow: const [
// //                             BoxShadow(
// //                               blurRadius: 1,
// //                               color: Color(0xFF1A1F24),
// //                               offset: Offset(
// //                                 0.0,
// //                                 0,
// //                               ),
// //                             )
// //                           ],
// //                         ),
// //                         child: Padding(
// //                           padding: const EdgeInsetsDirectional.fromSTEB(
// //                               24, 12, 24, 12),
// //                           child: Row(
// //                             mainAxisSize: MainAxisSize.max,
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 'Switch to Dark Mode',
// //                                 style: Theme.of(context)
// //                                     .textTheme
// //                                     .bodyMedium!
// //                                     .copyWith(
// //                                       fontFamily: 'Outfit',
// //                                       color: Colors.white,
// //                                       fontSize: 14,
// //                                       letterSpacing: 0,
// //                                       fontWeight: FontWeight.w500,
// //                                     ),
// //                               ),
// //                               Container(
// //                                 width: 80,
// //                                 height: 40,
// //                                 decoration: BoxDecoration(
// //                                   color: const Color(0xFF1D2429),
// //                                   borderRadius: BorderRadius.circular(20),
// //                                 ),
// //                                 child: Stack(
// //                                   alignment: const AlignmentDirectional(0, 0),
// //                                   children: [
// //                                     const Align(
// //                                       alignment: AlignmentDirectional(0.95, 0),
// //                                       child: Padding(
// //                                         padding: EdgeInsetsDirectional.fromSTEB(
// //                                             0, 0, 8, 0),
// //                                         child: Icon(
// //                                           Icons.nights_stay,
// //                                           color: Color(0xFF95A1AC),
// //                                           size: 20,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     Align(
// //                                       alignment:
// //                                           const AlignmentDirectional(-0.85, 0),
// //                                       child: Container(
// //                                         width: 36,
// //                                         height: 36,
// //                                         decoration: BoxDecoration(
// //                                           color: const Color(0xFF14181B),
// //                                           boxShadow: const [
// //                                             BoxShadow(
// //                                               blurRadius: 4,
// //                                               color: Color(0x430B0D0F),
// //                                               offset: Offset(
// //                                                 0.0,
// //                                                 2,
// //                                               ),
// //                                             )
// //                                           ],
// //                                           borderRadius:
// //                                               BorderRadius.circular(30),
// //                                           shape: BoxShape.rectangle,
// //                                         ),
// //                                       ).animateOnActionTrigger(
// //                                           animationsMap[
// //                                               'containerOnActionTriggerAnimation1']!,
// //                                           hasBeenTriggered:
// //                                               hasContainerTriggered1),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   if (Theme.of(context).brightness == Brightness.dark)
// //                     InkWell(
// //                       splashColor: Colors.transparent,
// //                       focusColor: Colors.transparent,
// //                       hoverColor: Colors.transparent,
// //                       highlightColor: Colors.transparent,
// //                       onTap: () {
// //                         Provider.of<ThemeProvider>(context, listen: false)
// //                             .toggleTheme();
// //                       },
// //                       child: Container(
// //                         width: MediaQuery.sizeOf(context).width,
// //                         decoration: BoxDecoration(
// //                           color: Theme.of(context).primaryColorDark,
// //                           boxShadow: const [
// //                             BoxShadow(
// //                               blurRadius: 1,
// //                               color: Color(0xFF1A1F24),
// //                               offset: Offset(
// //                                 0.0,
// //                                 0,
// //                               ),
// //                             )
// //                           ],
// //                         ),
// //                         child: Padding(
// //                           padding: const EdgeInsetsDirectional.fromSTEB(
// //                               24, 12, 24, 12),
// //                           child: Row(
// //                             mainAxisSize: MainAxisSize.max,
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 'Switch to Light Mode',
// //                                 style: Theme.of(context)
// //                                     .textTheme
// //                                     .bodyMedium!
// //                                     .copyWith(
// //                                       fontFamily: 'Outfit',
// //                                       color: Colors.white,
// //                                       fontSize: 14,
// //                                       letterSpacing: 0,
// //                                       fontWeight: FontWeight.w500,
// //                                     ),
// //                               ),
// //                               Container(
// //                                 width: 80,
// //                                 height: 40,
// //                                 decoration: BoxDecoration(
// //                                   color:
// //                                       Theme.of(context).scaffoldBackgroundColor,
// //                                   borderRadius: BorderRadius.circular(20),
// //                                 ),
// //                                 child: Stack(
// //                                   alignment: const AlignmentDirectional(0, 0),
// //                                   children: [
// //                                     const Align(
// //                                       alignment: AlignmentDirectional(-0.9, 0),
// //                                       child: Padding(
// //                                         padding: EdgeInsetsDirectional.fromSTEB(
// //                                             8, 2, 0, 0),
// //                                         child: Icon(
// //                                           Icons.wb_sunny_rounded,
// //                                           // color: Theme.of(context)
// //                                           //     .secondaryText,
// //                                           size: 24,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     Align(
// //                                       alignment:
// //                                           const AlignmentDirectional(0.9, 0),
// //                                       child: Container(
// //                                         width: 36,
// //                                         height: 36,
// //                                         decoration: BoxDecoration(
// //                                           // color: Theme.of(context)
// //                                           //     .secondaryBackground,
// //                                           boxShadow: const [
// //                                             BoxShadow(
// //                                               blurRadius: 4,
// //                                               color: Color(0x430B0D0F),
// //                                               offset: Offset(
// //                                                 0.0,
// //                                                 2,
// //                                               ),
// //                                             )
// //                                           ],
// //                                           borderRadius:
// //                                               BorderRadius.circular(30),
// //                                           shape: BoxShape.rectangle,
// //                                         ),
// //                                       ).animateOnActionTrigger(
// //                                           animationsMap[
// //                                               'containerOnActionTriggerAnimation2']!,
// //                                           hasBeenTriggered:
// //                                               hasContainerTriggered2),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                 ],
// //               ),
// //               Row(
// //                 mainAxisSize: MainAxisSize.max,
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Material(
// //                     color: Colors.transparent,
// //                     elevation: 0,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(0),
// //                     ),
// //                     child: Container(
// //                       width: MediaQuery.sizeOf(context).width,
// //                       height: 50,
// //                       decoration: BoxDecoration(
// //                         color: Theme.of(context).scaffoldBackgroundColor,
// //                         boxShadow: const [
// //                           BoxShadow(
// //                             blurRadius: 0,
// //                             color: Color(0xFFE3E5E7),
// //                             offset: Offset(
// //                               0.0,
// //                               2,
// //                             ),
// //                           )
// //                         ],
// //                         borderRadius: BorderRadius.circular(0),
// //                         border: Border.all(
// //                           color: const Color(0xFFE3E5E7),
// //                           width: 0,
// //                         ),
// //                       ),
// //                       child: Padding(
// //                         padding:
// //                             const EdgeInsetsDirectional.fromSTEB(16, 0, 4, 0),
// //                         child: Row(
// //                           mainAxisSize: MainAxisSize.max,
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             Text(
// //                               'Account Details',
// //                               style: Theme.of(context)
// //                                   .textTheme
// //                                   .titleSmall!
// //                                   .copyWith(
// //                                     fontFamily: 'Plus Jakarta Sans',
// //                                     letterSpacing: 0,
// //                                   ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               Row(
// //                 mainAxisSize: MainAxisSize.max,
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   InkWell(
// //                     splashColor: Colors.transparent,
// //                     focusColor: Colors.transparent,
// //                     hoverColor: Colors.transparent,
// //                     highlightColor: Colors.transparent,
// //                     onTap: () async {
// //                       print('Edit Profile');
// //                     },
// //                     child: Material(
// //                       color: Colors.transparent,
// //                       elevation: 0,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(0),
// //                       ),
// //                       child: Container(
// //                         width: MediaQuery.sizeOf(context).width,
// //                         height: 50,
// //                         decoration: BoxDecoration(
// //                           color:
// //                               Theme.of(context).scaffoldBackgroundColor,
// //                           boxShadow: const [
// //                             BoxShadow(
// //                               blurRadius: 0,
// //                               color: Color(0xFFE3E5E7),
// //                               offset: Offset(
// //                                 0.0,
// //                                 2,
// //                               ),
// //                             )
// //                           ],
// //                           borderRadius: BorderRadius.circular(0),
// //                           border: Border.all(
// //                             color: const Color(0xFFE3E5E7),
// //                             width: 0,
// //                           ),
// //                         ),
// //                         child: Padding(
// //                           padding:
// //                               const EdgeInsetsDirectional.fromSTEB(16, 0, 4, 0),
// //                           child: Row(
// //                             mainAxisSize: MainAxisSize.max,
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 'Edit Profile',
// //                                 style: Theme.of(context)
// //                                     .textTheme
// //                                     .titleSmall!
// //                                     .copyWith(
// //                                       fontFamily: 'Plus Jakarta Sans',
// //                                       letterSpacing: 0,
// //                                     ),
// //                               ),
// //                               CustomIconButton(
// //                                 borderColor: Colors.transparent,
// //                                 borderRadius: 30,
// //                                 buttonSize: 46,
// //                                 icon: const Icon(
// //                                   Icons.chevron_right_rounded,
// //                                   color: Color(0xFF95A1AC),
// //                                   size: 25,
// //                                 ),
// //                                 onPressed: () {
// //                                   print('IconButton pressed ...');
// //                                 },
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               Row(
// //                 mainAxisSize: MainAxisSize.max,
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Padding(
// //                     padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
// //                     child: InkWell(
// //                       splashColor: Colors.transparent,
// //                       focusColor: Colors.transparent,
// //                       hoverColor: Colors.transparent,
// //                       highlightColor: Colors.transparent,
// //                       onTap: () async {
// //                         // context.pushNamed('paymentInfo');
// //                       },
// //                       child: Material(
// //                         color: Colors.transparent,
// //                         elevation: 0,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(0),
// //                         ),
// //                         child: Container(
// //                           width: MediaQuery.sizeOf(context).width,
// //                           height: 50,
// //                           decoration: BoxDecoration(
// //                             color: Theme.of(context)
// //                                 .scaffoldBackgroundColor,
// //                             boxShadow: const [
// //                               BoxShadow(
// //                                 blurRadius: 0,
// //                                 color: Color(0xFFE3E5E7),
// //                                 offset: Offset(
// //                                   0.0,
// //                                   2,
// //                                 ),
// //                               )
// //                             ],
// //                             borderRadius: BorderRadius.circular(0),
// //                             border: Border.all(
// //                               color: const Color(0xFFE3E5E7),
// //                               width: 0,
// //                             ),
// //                           ),
// //                           child: Padding(
// //                             padding: const EdgeInsetsDirectional.fromSTEB(
// //                                 16, 0, 4, 0),
// //                             child: Row(
// //                               mainAxisSize: MainAxisSize.max,
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Text(
// //                                   'Other Settings',
// //                                   style: Theme.of(context)
// //                                       .textTheme
// //                                       .titleSmall!
// //                                       .copyWith(
// //                                         fontFamily: 'Plus Jakarta Sans',
// //                                         letterSpacing: 0,
// //                                       ),
// //                                 ),
// //                                 CustomIconButton(
// //                                   borderColor: Colors.transparent,
// //                                   borderRadius: 30,
// //                                   buttonSize: 46,
// //                                   icon: const Icon(
// //                                     Icons.chevron_right_rounded,
// //                                     color: Color(0xFF95A1AC),
// //                                     size: 25,
// //                                   ),
// //                                   onPressed: () {
// //                                     print('IconButton pressed ...');
// //                                   },
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               Row(
// //                 mainAxisSize: MainAxisSize.max,
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Padding(
// //                     padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
// //                     child: InkWell(
// //                       splashColor: Colors.transparent,
// //                       focusColor: Colors.transparent,
// //                       hoverColor: Colors.transparent,
// //                       highlightColor: Colors.transparent,
// //                       onTap: () async {
// //                         print('Change Password');
// //                       },
// //                       child: Material(
// //                         color: Colors.transparent,
// //                         elevation: 0,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(0),
// //                         ),
// //                         child: Container(
// //                           width: MediaQuery.sizeOf(context).width,
// //                           height: 50,
// //                           decoration: BoxDecoration(
// //                             color: Theme.of(context)
// //                                 .scaffoldBackgroundColor,
// //                             boxShadow: const [
// //                               BoxShadow(
// //                                 blurRadius: 0,
// //                                 color: Color(0xFFE3E5E7),
// //                                 offset: Offset(
// //                                   0.0,
// //                                   2,
// //                                 ),
// //                               )
// //                             ],
// //                             borderRadius: BorderRadius.circular(0),
// //                             border: Border.all(
// //                               color: const Color(0xFFE3E5E7),
// //                               width: 0,
// //                             ),
// //                           ),
// //                           child: Padding(
// //                             padding: const EdgeInsetsDirectional.fromSTEB(
// //                                 16, 0, 4, 0),
// //                             child: Row(
// //                               mainAxisSize: MainAxisSize.max,
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Text(
// //                                   'Change Password',
// //                                   style: Theme.of(context)
// //                                       .textTheme
// //                                       .titleSmall!
// //                                       .copyWith(
// //                                         fontFamily: 'Plus Jakarta Sans',
// //                                         letterSpacing: 0,
// //                                       ),
// //                                 ),
// //                                 CustomIconButton(
// //                                   borderColor: Colors.transparent,
// //                                   borderRadius: 30,
// //                                   buttonSize: 46,
// //                                   icon: const Icon(
// //                                     Icons.chevron_right_rounded,
// //                                     color: Color(0xFF95A1AC),
// //                                     size: 25,
// //                                   ),
// //                                   onPressed: () {
// //                                     print('IconButton pressed ...');
// //                                   },
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               if (columnUsersRecord.role == 'agent')
// //                 Row(
// //                   mainAxisSize: MainAxisSize.max,
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     if (columnUsersRecord.role == 'agent')
// //                       Padding(
// //                         padding:
// //                             const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
// //                         child: InkWell(
// //                           splashColor: Colors.transparent,
// //                           focusColor: Colors.transparent,
// //                           hoverColor: Colors.transparent,
// //                           highlightColor: Colors.transparent,
// //                           onTap: () async {
// //                             // context.pushNamed('myProperties');
// //                             print('My Properties');
// //                           },
// //                           child: Material(
// //                             color: Colors.transparent,
// //                             elevation: 0,
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(0),
// //                             ),
// //                             child: Container(
// //                               width: MediaQuery.sizeOf(context).width,
// //                               height: 50,
// //                               decoration: BoxDecoration(
// //                                 color: Theme.of(context)
// //                                     .scaffoldBackgroundColor,
// //                                 boxShadow: const [
// //                                   BoxShadow(
// //                                     blurRadius: 0,
// //                                     color:Color(0xFFE3E5E7),
// //                                     offset: Offset(
// //                                       0.0,
// //                                       2,
// //                                     ),
// //                                   )
// //                                 ],
// //                                 borderRadius: BorderRadius.circular(0),
// //                                 border: Border.all(
// //                                   color: Color(0xFFE3E5E7),
// //                                   width: 0,
// //                                 ),
// //                               ),
// //                               child: Padding(
// //                                 padding: const EdgeInsetsDirectional.fromSTEB(
// //                                     16, 0, 4, 0),
// //                                 child: Row(
// //                                   mainAxisSize: MainAxisSize.max,
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     Expanded(
// //                                       child: Text(
// //                                         'My Properties',
// //                                         style: Theme.of(context)
// //                                             .textTheme
// //                                             .titleSmall!
// //                                             .copyWith(
// //                                               fontFamily: 'Plus Jakarta Sans',
// //                                               letterSpacing: 0,
// //                                             ),
// //                                       ),
// //                                     ),
// //                                     Container(
// //                                       width: 32,
// //                                       height: 32,
// //                                       decoration: BoxDecoration(
// //                                         color: Theme.of(context).primaryColor,
// //                                         shape: BoxShape.circle,
// //                                       ),
// //                                       alignment:
// //                                           const AlignmentDirectional(0, 0),
// //                                       child: Text(
// //                                         // num of properties
// //                                         '0',
// //                                         textAlign: TextAlign.center,
// //                                         style: Theme.of(context)
// //                                             .textTheme
// //                                             .bodyMedium!
// //                                             .copyWith(
// //                                               fontFamily: 'Plus Jakarta Sans',
// //                                               color: Theme.of(context)
// //                                                   .colorScheme
// //                                                   .tertiary,
// //                                               letterSpacing: 0,
// //                                             ),
// //                                       ),
// //                                     ),
// //                                     CustomIconButton(
// //                                       borderColor: Colors.transparent,
// //                                       borderRadius: 30,
// //                                       buttonSize: 46,
// //                                       icon: const Icon(
// //                                         Icons.chevron_right_rounded,
// //                                         color: Color(0xFF95A1AC),
// //                                         size: 25,
// //                                       ),
// //                                       onPressed: () {
// //                                         print('IconButton pressed ...');
// //                                       },
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                   ],
// //                 ),
// //               if (columnUsersRecord.role == 'agent')
// //                 Row(
// //                   mainAxisSize: MainAxisSize.max,
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
// //                       child: InkWell(
// //                         splashColor: Colors.transparent,
// //                         focusColor: Colors.transparent,
// //                         hoverColor: Colors.transparent,
// //                         highlightColor: Colors.transparent,
// //                         onTap: () async {
// //                           // context.pushNamed('myBookings');
// //                           print('My Showings');
// //                         },
// //                         child: Material(
// //                           color: Colors.transparent,
// //                           elevation: 0,
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(0),
// //                           ),
// //                           child: Container(
// //                             width: MediaQuery.sizeOf(context).width,
// //                             height: 50,
// //                             decoration: BoxDecoration(
// //                               color: Theme.of(context)
// //                                   .scaffoldBackgroundColor,
// //                               boxShadow: [
// //                                 const BoxShadow(
// //                                   blurRadius: 0,
// //                                   color: Color(0xFFE3E5E7),
// //                                   offset: Offset(
// //                                     0.0,
// //                                     2,
// //                                   ),
// //                                 )
// //                               ],
// //                               borderRadius: BorderRadius.circular(0),
// //                               border: Border.all(
// //                                 color: Color(0xFFE3E5E7),
// //                                 width: 0,
// //                               ),
// //                             ),
// //                             child: Padding(
// //                               padding: const EdgeInsetsDirectional.fromSTEB(
// //                                   16, 0, 4, 0),
// //                               child: Row(
// //                                 mainAxisSize: MainAxisSize.max,
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceBetween,
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'My Bookings',
// //                                       style: Theme.of(context)
// //                                           .textTheme
// //                                           .titleSmall!
// //                                           .copyWith(
// //                                             fontFamily: 'Plus Jakarta Sans',
// //                                             letterSpacing: 0,
// //                                           ),
// //                                     ),
// //                                   ),
// //                                   CustomIconButton(
// //                                     borderColor: Colors.transparent,
// //                                     borderRadius: 30,
// //                                     buttonSize: 46,
// //                                     icon: const Icon(
// //                                       Icons.chevron_right_rounded,
// //                                       color: Color(0xFF95A1AC),
// //                                       size: 25,
// //                                     ),
// //                                     onPressed: () {
// //                                       print('IconButton pressed ...');
// //                                     },
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               Padding(
// //                 padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
// //                 child: Button(
// //                   onPressed: () async {
// //                     await Provider.of<AuthProvider>(context, listen: false).signOut();
// //                     if (context.mounted) {
// //                       Navigator.pushNamedAndRemoveUntil(
// //                         context,
// //                         WelcomeScreen.routeName,
// //                         (Route<dynamic> route) => false,
// //                       );
// //                     }
// //                   },
// //                   text: 'Log Out',
// //                   options: ButtonOptions(
// //                     width: 110,
// //                     height: 50,
// //                     padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
// //                     iconPadding:
// //                         const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
// //                     color: Theme.of(context).colorScheme.secondary,
// //                     textStyle: TextStyle(
// //                       fontFamily: 'Plus Jakarta Sans',
// //                       color: Colors.white,
// //                       fontSize: 16,
// //                       letterSpacing: 0,
// //                     ),
// //                     elevation: 0,
// //                     borderSide: BorderSide(
// //                       color: Theme.of(context).colorScheme.secondary,
// //                       width: 1,
// //                     ),
// //                     borderRadius: BorderRadius.circular(40),
// //                   ),
// //                 ),
// //               ),
// //               if (columnUsersRecord.role == 'agent')
// //                 Padding(
// //                   padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.max,
// //                     mainAxisAlignment: MainAxisAlignment.end,
// //                     children: [
// //                       Button(
// //                         onPressed: () async {
// //                           print('Add Property');
// //                         },
// //                         text: 'Add Property',
// //                         options: ButtonOptions(
// //                           width: 240,
// //                           height: 60,
// //                           padding:
// //                               const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
// //                           iconPadding:
// //                               const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
// //                           color: Theme.of(context).primaryColor,
// //                           textStyle:
// //                               Theme.of(context).textTheme.titleSmall!.copyWith(
// //                                     fontFamily: 'Plus Jakarta Sans',
// //                                     color: Colors.white,
// //                                     letterSpacing: 0,
// //                                   ),
// //                           elevation: 2,
// //                           borderSide: const BorderSide(
// //                             color: Colors.transparent,
// //                             width: 1,
// //                           ),
// //                           borderRadius: BorderRadius.circular(40),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import '../../components/theme_switcher.dart';
// import 'components/account_options_item.dart';
// import 'components/profile_header.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen>
//     with TickerProviderStateMixin {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   var hasContainerTriggered1 = false;
//   var hasContainerTriggered2 = false;
//   final animationsMap = <String, AnimationInfo>{};

//   @override
//   void initState() {
//     super.initState();

//     animationsMap.addAll({
//       'containerOnActionTriggerAnimation1': AnimationInfo(
//         trigger: AnimationTrigger.onActionTrigger,
//         applyInitialState: false,
//         effectsBuilder: () => [
//           MoveEffect(
//             curve: Curves.easeInOut,
//             delay: 0.ms,
//             duration: 350.ms,
//             begin: const Offset(40.0, 0.0),
//             end: const Offset(0.0, 0.0),
//           ),
//         ],
//       ),
//       'containerOnActionTriggerAnimation2': AnimationInfo(
//         trigger: AnimationTrigger.onActionTrigger,
//         applyInitialState: false,
//         effectsBuilder: () => [
//           MoveEffect(
//             curve: Curves.easeInOut,
//             delay: 0.ms,
//             duration: 350.ms,
//             begin: const Offset(-40.0, 0.0),
//             end: const Offset(0.0, 0.0),
//           ),
//         ],
//       ),
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     AuthProvider authProvider = Provider.of<AuthProvider>(context);
//     ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
//     User? currentUser = authProvider.user;
//     UserService userService =
//         UserService(); // Create an instance of UserService

//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: StreamBuilder<User>(
//         stream: userService.getUser(currentUser!.id),
//         builder: (context, snapshot) {
//           // Customize what your widget looks like when it's loading.
//           if (!snapshot.hasData) {
//             return Center(
//               child: SizedBox(
//                 width: 50,
//                 height: 50,
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//             );
//           }

//           final columnUsersRecord = snapshot.data!;

//           return Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               ProfileHeader(user: columnUsersRecord),
//               const ThemeSwitcher(),
//               AccountOptionItem(
//                 text: 'Account Details',
//                 onTap: () {
//                   print('Account Details');
//                 },
//                 animation: animationsMap['containerOnActionTriggerAnimation1']!,
//               ),
//               AccountOptionItem(
//                 text: 'Edit Profile',
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           EditProfileScreen(userProfile: currentUser),
//                     ),
//                   );
//                 },
//                 animation: animationsMap['containerOnActionTriggerAnimation1']!,
//               ),
//               AccountOptionItem(
//                 text: 'Other Settings',
//                 onTap: () {
//                   print('Other Settings');
//                 },
//                 animation: animationsMap['containerOnActionTriggerAnimation1']!,
//               ),
//               AccountOptionItem(
//                 text: 'Change Password',
//                 onTap: () {
//                   print('Change Password');
//                 },
//                 animation: animationsMap['containerOnActionTriggerAnimation1']!,
//               ),
//               if (columnUsersRecord.role == 'agent')
//                 Column(
//                   children: [
//                     AccountOptionItem(
//                       text: 'My Properties',
//                       onTap: () {
//                         print('My Properties');
//                       },
//                       animation:
//                           animationsMap['containerOnActionTriggerAnimation1']!,
//                     ),
//                     AccountOptionItem(
//                       text: 'My Showings',
//                       onTap: () {
//                         print('My Showings');
//                       },
//                       animation:
//                           animationsMap['containerOnActionTriggerAnimation1']!,
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Button(
//                             onPressed: () async {
//                               print('Add Property');
//                             },
//                             text: 'Add Property',
//                             options: ButtonOptions(
//                               width: 240,
//                               height: 60,
//                               padding: const EdgeInsetsDirectional.fromSTEB(
//                                   0, 0, 0, 0),
//                               iconPadding: const EdgeInsetsDirectional.fromSTEB(
//                                   0, 0, 0, 0),
//                               color: Theme.of(context).primaryColor,
//                               textStyle: Theme.of(context)
//                                   .textTheme
//                                   .titleSmall!
//                                   .copyWith(
//                                     fontFamily: 'Plus Jakarta Sans',
//                                     color: Colors.white,
//                                     letterSpacing: 0,
//                                   ),
//                               elevation: 2,
//                               borderSide: const BorderSide(
//                                 color: Colors.transparent,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               const LogoutButton(),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../components/button.dart';
import '../../components/logout_button.dart';
import '../../constants.dart';
import '../../models/user.dart';
import '../../provider/auth_provider.dart';
import '../../provider/theme_provider.dart';
import '../../services/user_service.dart';
import '../edit_profile/edit_profile_screen.dart';
import '../welcome/welcome_screen.dart';
import '../../components/theme_switcher.dart';
import 'components/account_options_item.dart';
import 'components/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasContainerTriggered1 = false;
  var hasContainerTriggered2 = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();

    animationsMap.addAll({
      'containerOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.ms,
            duration: 350.ms,
            begin: const Offset(40.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.ms,
            duration: 350.ms,
            begin: const Offset(-40.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    User? currentUser = authProvider.user;
    UserService userService = UserService();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: StreamBuilder<User>(
        stream: userService.getUser(currentUser!.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            );
          }

          final columnUsersRecord = snapshot.data!;

          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ProfileHeader(user: columnUsersRecord),
              const ThemeSwitcher(),
              AccountOptionItem(
                text: 'Account Details',
                onTap: () {
                  print('Account Details');
                },
                animation: animationsMap['containerOnActionTriggerAnimation1']!,
              ),
              AccountOptionItem(
                text: 'Edit Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditProfileScreen(userProfile: currentUser),
                    ),
                  );
                },
                animation: animationsMap['containerOnActionTriggerAnimation1']!,
              ),
              AccountOptionItem(
                text: 'Other Settings',
                onTap: () {
                  print('Other Settings');
                },
                animation: animationsMap['containerOnActionTriggerAnimation1']!,
              ),
              AccountOptionItem(
                text: 'Change Password',
                onTap: () {
                  print('Change Password');
                },
                animation: animationsMap['containerOnActionTriggerAnimation1']!,
              ),
              if (columnUsersRecord.role == 'agent')
                Column(
                  children: [
                    AccountOptionItem(
                      text: 'My Properties',
                      onTap: () {
                        print('My Properties');
                      },
                      animation:
                          animationsMap['containerOnActionTriggerAnimation1']!,
                    ),
                    AccountOptionItem(
                      text: 'My Showings',
                      onTap: () {
                        print('My Showings');
                      },
                      animation:
                          animationsMap['containerOnActionTriggerAnimation1']!,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Button(
                            onPressed: () async {
                              print('Add Property');
                            },
                            text: 'Add Property',
                            options: ButtonOptions(
                              width: 240,
                              height: 60,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              color: Theme.of(context).primaryColor,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.white,
                                    letterSpacing: 0,
                                  ),
                              elevation: 2,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const LogoutButton(),
            ],
          );
        },
      ),
    );
  }
}
