import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;

import '../../components/button.dart';
import '../../constants.dart';
import '../../models/listing.dart';
import '../../models/user.dart';


class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({
    super.key,
    this.listing,
  });

  final Listing? listing;

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen>
    with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 70.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 80.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 90.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 100.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.4, 0.0),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        final currencyFormatter = NumberFormat.currency(symbol: '\$');

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: 320,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDBE2E7),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: ExpandedImageWidget(
                                              image: CachedNetworkImage(
                                                fadeInDuration:
                                                    const Duration(milliseconds: 500),
                                                fadeOutDuration:
                                                    const Duration(milliseconds: 500),
                                                imageUrl:
                                                    valueOrDefault<String>(
                                                  widget
                                                      .listing?.images?[0],
                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/oowrriphtb4n/hero_home@3x.jpg',
                                                ),
                                                fit: BoxFit.contain,
                                              ),
                                              allowRotation: false,
                                              tag: valueOrDefault<String>(
                                                widget.listing?.images?[0],
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/oowrriphtb4n/hero_home@3x.jpg',
                                              ),
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: valueOrDefault<String>(
                                          widget.listing?.images?[0],
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/oowrriphtb4n/hero_home@3x.jpg',
                                        ),
                                        transitionOnUserGestures: true,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                const Duration(milliseconds: 500),
                                            fadeOutDuration:
                                                const Duration(milliseconds: 500),
                                            imageUrl: valueOrDefault<String>(
                                              widget.listing?.images?[0],
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/oowrriphtb4n/hero_home@3x.jpg',
                                            ),
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {},
                                              
                                              child: Card(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                color: const Color(0x3A000000),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: CustomIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  buttonSize: 46,
                                                  icon: const Icon(
                                                    Icons.arrow_back_rounded,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                widget.listing!.formattedAddress,
                                style: Theme.of(context).textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0,
                                    ),
                              ).animateOnPageLoad(
                                  animationsMap['textOnPageLoadAnimation1']!),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                // format for money
                                currencyFormatter.format(widget.listing!.price),
                                style: Theme.of(context).textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontFamily: 'Lexend Deca',
                                      color: const Color(0xFF8B97A2),
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ).animateOnPageLoad(
                                  animationsMap['textOnPageLoadAnimation2']!),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {print('Navigate to back');},
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.remove_red_eye_rounded,
                                color: Color(0xFFFFA130),
                                size: 24,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                child: Text(
                                  '12',
                                  style: Theme.of(context).textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF8B97A2),
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                                child: Text(
                                  'Viewings',
                                  style: Theme.of(context).textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF8B97A2),
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),


                        ).animateOnPageLoad(
                            animationsMap['rowOnPageLoadAnimation1']!),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'DESCRIPTION',
                              style: Theme.of(context).textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontFamily: 'Lexend Deca',
                                    // color: Theme.of(context)
                                    //     .primaryText,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ).animateOnPageLoad(
                            animationsMap['rowOnPageLoadAnimation2']!),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Text(
                                  // widget.propertyRef!.propertyDescription,
                                  'Description',
                                  style: Theme.of(context).textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontFamily: 'Lexend Deca',
                                        color: const Color(0xFF8B97A2),
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ).animateOnPageLoad(
                                    animationsMap['textOnPageLoadAnimation3']!),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Amenities',
                              style: Theme.of(context).textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontFamily: 'Lexend Deca',
                                    // color: Theme.of(context)
                                        // .primaryText,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ).animateOnPageLoad(
                            animationsMap['rowOnPageLoadAnimation3']!),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 0, 0),
                        child: 
                        // StreamBuilder<List<AmenititiesRecord>>(
                        //   stream: queryAmenititiesRecord(
                        //     queryBuilder: (amenititiesRecord) =>
                        //         amenititiesRecord.where(
                        //       'propertyRef',
                        //       isEqualTo: widget.listing?.formattedAddress
                        //     ),
                        //     singleRecord: true,
                        //   ),
                        //   builder: (context, snapshot) {
                        //     // Customize what your widget looks like when it's loading.
                        //     if (!snapshot.hasData) {
                        //       return Center(
                        //         child: SizedBox(
                        //           width: 50,
                        //           height: 50,
                        //           child: CircularProgressIndicator(
                        //             valueColor: AlwaysStoppedAnimation<Color>(
                        //               Theme.of(context).primaryColor,
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     }
                        //     List<AmenititiesRecord>
                        //         amenitiesRowAmenititiesRecordList =
                        //         snapshot.data!;
                        //     // Return an empty Container when the item does not exist.
                        //     if (snapshot.data!.isEmpty) {
                        //       return Container();
                        //     }
                        //     final amenitiesRowAmenititiesRecord =
                        //         amenitiesRowAmenititiesRecordList.isNotEmpty
                        //             ? amenitiesRowAmenititiesRecordList.first
                        //             : null;

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.wifi_rounded,
                                          // color: Theme.of(context).primaryText,
                                          size: 24,
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 4, 0, 0),
                                          child: Text(
                                            'Amennity 1',
                                            style: Theme.of(context).textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontFamily: 'Lexend Deca',
                                                  // color: Theme.of(context)
                                                  //     .primaryText,
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // if (amenitiesRowAmenititiesRecord
                                  //         ?.evCharger ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel1,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.ev_station,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord?.pool ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel2,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.pool_rounded,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord
                                  //         ?.extraOutlets ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel3,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.power_rounded,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord?.ac ?? true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel4,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.ac_unit_rounded,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord
                                  //         ?.dogFriendly ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel5,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.pets_rounded,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord?.washer ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel6,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons
                                  //               .local_laundry_service_outlined,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord?.dryer ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel7,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.local_laundry_service_rounded,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord?.workout ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel8,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.fitness_center_rounded,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord
                                  //         ?.nightLife ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel9,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.nightlife,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord?.hip ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel10,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.theater_comedy,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // if (amenitiesRowAmenititiesRecord?.heater ??
                                  //     true)
                                  //   Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         0, 0, 8, 0),
                                  //     child: wrapWithModel(
                                  //       model: _model.amenitityIndicatorModel11,
                                  //       updateCallback: () => setState(() {}),
                                  //       child: AmenitityIndicatorWidget(
                                  //         icon: Icon(
                                  //           Icons.wb_sunny_rounded,
                                  //           color: Theme.of(context)
                                  //               .grayIcon,
                                  //         ),
                                  //         background:
                                  //             Theme.of(context)
                                  //                 .secondaryBackground,
                                  //         borderColor:
                                  //             Theme.of(context)
                                  //                 .lineGray,
                                  //       ),
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ).animateOnPageLoad(
                                animationsMap['rowOnPageLoadAnimation4']!)
                        //   },
                        // ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 260,
                      //     decoration: BoxDecoration(
                      //       color:
                      //           Theme.of(context).primaryColor,
                      //     ),
                      //     child: Padding(
                      //       padding:
                      //           const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.max,
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsetsDirectional.fromSTEB(
                      //                 24, 0, 24, 0),
                      //             child: Row(
                      //               mainAxisSize: MainAxisSize.max,
                      //               children: [
                      //                 Text(
                      //                   'What people are saying',
                      //                   style: Theme.of(context).textTheme
                      //                       .bodySmall!
                      //                       .copyWith(
                      //                         fontFamily: 'Plus Jakarta Sans',
                      //                         letterSpacing: 0,
                      //                       ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           Expanded(
                      //             child: Padding(
                      //               padding: const EdgeInsetsDirectional.fromSTEB(
                      //                   0, 8, 0, 0),
                      //               child: StreamBuilder<List<ReviewsRecord>>(
                      //                 stream: queryReviewsRecord(
                      //                   queryBuilder: (reviewsRecord) =>
                      //                       reviewsRecord
                      //                           .where(
                      //                             'propertyRef',
                      //                             isEqualTo: widget
                      //                                 .listing?.formattedAddress,
                      //                           )
                      //                           .orderBy('ratingCreated',
                      //                               descending: true),
                      //                 ),
                      //                 builder: (context, snapshot) {
                      //                   // Customize what your widget looks like when it's loading.
                      //                   if (!snapshot.hasData) {
                      //                     return Center(
                      //                       child: SizedBox(
                      //                         width: 50,
                      //                         height: 50,
                      //                         child: CircularProgressIndicator(
                      //                           valueColor:
                      //                               AlwaysStoppedAnimation<
                      //                                   Color>(
                      //                             Theme.of(context)
                      //                                 .primaryColor,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     );
                      //                   }
                      //                   List<ReviewsRecord>
                      //                       pageViewReviewsRecordList =
                      //                       snapshot.data!;
                      //                   if (pageViewReviewsRecordList.isEmpty) {
                      //                     return Center(
                      //                       child: Image.asset(
                      //                         'assets/images/noRatingsEmpty@2x.png',
                      //                         width: 300,
                      //                       ),
                      //                     );
                      //                   }
                      //                   return Container(
                      //                     width: double.infinity,
                      //                     height: 200,
                      //                     child: Stack(
                      //                       children: [
                      //                         Padding(
                      //                           padding: const EdgeInsetsDirectional
                      //                               .fromSTEB(0, 0, 0, 30),
                      //                           child: PageView.builder(
                      //                             controller: 
                      //                                 PageController(
                      //                                     initialPage: max(
                      //                                         0,
                      //                                         min(
                      //                                             0,
                      //                                             pageViewReviewsRecordList
                      //                                                     .length -
                      //                                                 1))),
                      //                             scrollDirection:
                      //                                 Axis.horizontal,
                      //                             itemCount:
                      //                                 pageViewReviewsRecordList
                      //                                     .length,
                      //                             itemBuilder:
                      //                                 (context, pageViewIndex) {
                      //                               final pageViewReviewsRecord =
                      //                                   pageViewReviewsRecordList[
                      //                                       pageViewIndex];
                      //                               return Padding(
                      //                                 padding:
                      //                                     const EdgeInsets.all(12),
                      //                                 child: Container(
                      //                                   width: 100,
                      //                                   decoration:
                      //                                       BoxDecoration(
                      //                                     color: Theme
                      //                                             .of(context).colorScheme
                      //                                         .secondary,
                      //                                     boxShadow: const [
                      //                                       BoxShadow(
                      //                                         blurRadius: 5,
                      //                                         color: Color(
                      //                                             0x24090F13),
                      //                                         offset: Offset(
                      //                                           0.0,
                      //                                           2,
                      //                                         ),
                      //                                       )
                      //                                     ],
                      //                                     borderRadius:
                      //                                         BorderRadius
                      //                                             .circular(16),
                      //                                   ),
                      //                                   child: Padding(
                      //                                     padding:
                      //                                         const EdgeInsets.all(
                      //                                             12),
                      //                                     child: Column(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       children: [
                      //                                         StreamBuilder<
                      //                                             User>(
                      //                                           stream: User
                      //                                               .getDocument(
                      //                                                   pageViewReviewsRecord
                      //                                                       .userRef!),
                      //                                           builder: (context,
                      //                                               snapshot) {
                      //                                             // Customize what your widget looks like when it's loading.
                      //                                             if (!snapshot
                      //                                                 .hasData) {
                      //                                               return Center(
                      //                                                 child:
                      //                                                     SizedBox(
                      //                                                   width:
                      //                                                       50,
                      //                                                   height:
                      //                                                       50,
                      //                                                   child:
                      //                                                       CircularProgressIndicator(
                      //                                                     valueColor:
                      //                                                         AlwaysStoppedAnimation<Color>(
                      //                                                       Theme.of(context).primaryColor,
                      //                                                     ),
                      //                                                   ),
                      //                                                 ),
                      //                                               );
                      //                                             }
                      //                                             final rowUsersRecord =
                      //                                                 snapshot
                      //                                                     .data!;
                      //                                             return Row(
                      //                                               mainAxisSize:
                      //                                                   MainAxisSize
                      //                                                       .max,
                      //                                               mainAxisAlignment:
                      //                                                   MainAxisAlignment
                      //                                                       .spaceBetween,
                      //                                               children: [
                      //                                                 Column(
                      //                                                   mainAxisSize:
                      //                                                       MainAxisSize.max,
                      //                                                   mainAxisAlignment:
                      //                                                       MainAxisAlignment.center,
                      //                                                   crossAxisAlignment:
                      //                                                       CrossAxisAlignment.start,
                      //                                                   children: [
                      //                                                     Text(
                      //                                                       rowUsersRecord.name ?? 'Guest',
                      //                                                       style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      //                                                             fontFamily: 'Outfit',
                      //                                                             letterSpacing: 0,
                      //                                                           ),
                      //                                                     ),
                      //                                                     Padding(
                      //                                                       padding: const EdgeInsetsDirectional.fromSTEB(
                      //                                                           0,
                      //                                                           4,
                      //                                                           0,
                      //                                                           0),
                      //                                                       child:
                      //                                                           RatingBarIndicator(
                      //                                                         itemBuilder: (context, index) => const Icon(
                      //                                                           Icons.star_rounded,
                      //                                                           color: Color(0xFFFFA130),
                      //                                                         ),
                      //                                                         direction: Axis.horizontal,
                      //                                                         rating: pageViewReviewsRecord.rating ?? 0,
                      //                                                         unratedColor: const Color(0xFF95A1AC),
                      //                                                         itemCount: 5,
                      //                                                         itemSize: 24,
                      //                                                       ),
                      //                                                     ),
                      //                                                   ],
                      //                                                 ),
                      //                                                 Container(
                      //                                                   width:
                      //                                                       50,
                      //                                                   height:
                      //                                                       50,
                      //                                                   clipBehavior:
                      //                                                       Clip.antiAlias,
                      //                                                   decoration:
                      //                                                       const BoxDecoration(
                      //                                                     shape:
                      //                                                         BoxShape.circle,
                      //                                                   ),
                      //                                                   child: Image
                      //                                                       .network(
                      //                                                     valueOrDefault<
                      //                                                         String>(
                      //                                                       rowUsersRecord.profilePictureUrl,
                      //                                                       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/9s7dlqs0q8jj/user_1.5@2x.jpg',
                      //                                                     ),
                      //                                                   ),
                      //                                                 ),
                      //                                               ],
                      //                                             );
                      //                                           },
                      //                                         ),
                      //                                         Padding(
                      //                                           padding:
                      //                                               const EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       8,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Row(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             children: [
                      //                                               Expanded(
                      //                                                 child:
                      //                                                     Padding(
                      //                                                   padding: const EdgeInsetsDirectional.fromSTEB(
                      //                                                       0,
                      //                                                       0,
                      //                                                       0,
                      //                                                       24),
                      //                                                   child:
                      //                                                       AutoSizeText(
                      //                                                     pageViewReviewsRecord
                      //                                                         .ratingDescription ?? 'Rating description',
                      //                                                     //     .maybeHandleOverflow(
                      //                                                     //   maxChars:
                      //                                                     //       130,
                      //                                                     //   replacement:
                      //                                                     //       '…',
                      //                                                     // ),
                      //                                                     style: Theme.of(context).textTheme
                      //                                                         .bodySmall!
                      //                                                         .copyWith(
                      //                                                           fontFamily: 'Lexend Deca',
                      //                                                           color: const Color(0xFF8B97A2),
                      //                                                           fontSize: 14,
                      //                                                           letterSpacing: 0,
                      //                                                           fontWeight: FontWeight.normal,
                      //                                                         ),
                      //                                                   ),
                      //                                                 ),
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                               );
                      //                             },
                      //                           ),
                      //                         ),
                      //                         Align(
                      //                           alignment:
                      //                               const AlignmentDirectional(0, 1),
                      //                           child: Padding(
                      //                             padding: const EdgeInsetsDirectional
                      //                                 .fromSTEB(0, 0, 0, 10),
                      //                             child: smooth_page_indicator
                      //                                 .SmoothPageIndicator(
                      //                               controller:
                      //                                   PageController(
                      //                                       initialPage: max(
                      //                                           0,
                      //                                           min(
                      //                                               0,
                      //                                               pageViewReviewsRecordList
                      //                                                       .length -
                      //                                                   1))),
                      //                               count:
                      //                                   pageViewReviewsRecordList
                      //                                       .length,
                      //                               axisDirection:
                      //                                   Axis.horizontal,
                      //                               onDotClicked: (i) async {print('Page indicator clicked ...');},
                      //                               effect: smooth_page_indicator
                      //                                   .ExpandingDotsEffect(
                      //                                 expansionFactor: 2,
                      //                                 spacing: 8,
                      //                                 radius: 16,
                      //                                 dotWidth: 8,
                      //                                 dotHeight: 8,
                      //                                 dotColor:
                      //                                     Theme.of(
                      //                                             context).colorScheme
                      //                                         .primary,
                      //                                 activeDotColor:
                      //                                     Theme.of(
                      //                                             context).colorScheme
                      //                                         .secondary,
                      //                                 paintStyle:
                      //                                     PaintingStyle.fill,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  // color: Theme.of(context).primaryText,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      spreadRadius: BlurEffect.neutralBlur,
                      color: Color(0x55000000),
                      // offset: Offset(
                      //   0.0,
                      //   -2,
                      // ),
                    )
                  ],
                  // borderRadius: BorderRadius.only(
                  //   bottomLeft: Radius.circular(0),
                  //   bottomRight: Radius.circular(0),
                  //   topLeft: Radius.circular(16),
                  //   topRight: Radius.circular(16),
                  // ),
                ),
                child: 
                        Button(
                          onPressed: () async {},
                          text: 'Schedule a viewing',
                          icon: const Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          options: ButtonOptions(
                            width: double.infinity,
                            height: 60,

                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding:
                                const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: const Color(0xFF4B39EF),
                            textStyle: Theme.of(context).textTheme
                                .titleSmall!
                                .copyWith(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 24,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                            elevation: 3,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                        ),
                //     ],
                //   ),
                // ),
              ),
            ],
          ),);
        
      // },
    // );
  }
  
  queryAmenititiesRecord({required Function(dynamic amenititiesRecord) queryBuilder, required bool singleRecord}) {}
  
  queryReviewsRecord({required Function(dynamic reviewsRecord) queryBuilder}) {}
}

class ReviewsRecord {
  String? userRef;
  double? rating;
  String? ratingDescription;
}

class AmenititiesRecord {
}







class ExpandedImageWidget extends StatelessWidget {
  const ExpandedImageWidget({super.key, 
    required this.image,
    this.allowRotation = false,
    this.useHeroAnimation = true,
    this.tag,
  });

  final Widget image;
  final bool allowRotation;
  final bool useHeroAnimation;
  final Object? tag;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: PhotoView.customChild(
                minScale: 1.0,
                maxScale: 3.0,
                enableRotation: allowRotation,
                heroAttributes: useHeroAnimation
                    ? PhotoViewHeroAttributes(tag: tag!)
                    : null,
                onScaleEnd: (context, details, value) {
                  if (value.scale! < 0.3) {
                    Navigator.pop(context);
                  }
                },
                child: image,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                    color: Colors.black,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}





