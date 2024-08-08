// import 'package:flutter/material.dart';
// import '../models/autocomplete_prediction.dart';
// import '../services/google_places_service.dart';
// import '../services/api_service.dart';

// class AutoCompleteAddressField extends StatefulWidget {
//   final TextEditingController controller;
//   // validator
//   final String? Function(String?)? validator;

//   const AutoCompleteAddressField({super.key, required this.controller, this.validator});

//   @override
//   State<AutoCompleteAddressField> createState() =>
//       _AutoCompleteAddressFieldState();
// }

// class _AutoCompleteAddressFieldState extends State<AutoCompleteAddressField> {
//   late GooglePlacesService googlePlacesService;
//   List<AutocompletePrediction> suggestions = [];
//   bool isAddressValidated = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeServices();
//   }

//   void _initializeServices() {
//     final apiService = ApiService(baseUrl: 'https://places.googleapis.com/v1/');
//     googlePlacesService = GooglePlacesService(apiService: apiService);
//   }

//   void _getSuggestions(String input) async {
//     if (input.isEmpty) {
//       setState(() {
//         suggestions = [];
//       });
//       return;
//     }

//     try {
//       final response =
//           await googlePlacesService.getAutocompleteSuggestions(input);
//       setState(() {
//         suggestions = response.predictions;
//       });
//     } catch (e, stackTrace) {
//       print('Error fetching autocomplete suggestions: $e');
//       print('Stack trace: $stackTrace');
//       setState(() {
//         suggestions = [];
//       });
//     }
//   }

//   Future<void> _getPlaceDetails(String placeId) async {
//     try {
//       List<String> fields = [
//         'id',
//         'displayName',
//         'formattedAddress',
//         'location',
//         'types',
//         'internationalPhoneNumber',
//         'nationalPhoneNumber',
//         'websiteUri',
//         'currentOpeningHours',
//         'regularOpeningHours',
//         'priceLevel',
//         'rating',
//         'userRatingCount',
//         'reviews',
//         'plusCode',
//         'photos',
//         'businessStatus'
//       ];

//       final PlaceDetailsResult response =
//           await googlePlacesService.getPlaceDetails(placeId, fields: fields);

//       setState(() {
//         // Validate the formatted address
//         isAddressValidated = response.formattedAddress != null;
//       });

//       print(response.formattedAddress);
//     } catch (e, stackTrace) {
//       print('Error fetching place details: $e');
//       // print('Stack trace: $stackTrace');
//       setState(() {
//         isAddressValidated = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
//       child: Column(
//         children: [
//           TextField(
//             controller: widget.controller,
//             decoration: InputDecoration(
//               prefixIcon: const Icon(
//                 Icons.map_outlined,
//                 color: Color(0xFF95A1AC),
//               ),
//               suffixIcon: IconButton(
//                 icon: const Icon(
//                   Icons.cancel_outlined,
//                   color: Color(0xFF95A1AC),
//                 ),
//                 onPressed: () {
//                   widget.controller.clear();
//                   setState(() {
//                     suggestions = [];
//                     isAddressValidated = false;
//                   });
//                 },
//               ),
//               labelText: 'Address (Optional)',
//               hintText: 'Enter your address here...',
//               labelStyle: isAddressValidated
//                   ? const TextStyle(
//                       color: Colors.green,
//                     )
//                   : Theme.of(context).inputDecorationTheme.labelStyle,
//               enabledBorder: isAddressValidated ? const OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color:Colors.green,
//                 ),
//               ) : Theme.of(context).inputDecorationTheme.enabledBorder,
//             ),
//             focusNode: FocusNode(),
//             keyboardType: TextInputType.streetAddress,
//             onChanged: (String value) {
//               _getSuggestions(value);
//             },
//           ),
//           if (suggestions.isNotEmpty)
//             Container(
//               color: Colors.white,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: suggestions.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(suggestions[index].description),
//                     onTap: () async {
//                       widget.controller.text = suggestions[index].description;
//                       await _getPlaceDetails(suggestions[index].placeId);
//                       setState(() {
//                         suggestions = [];
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/autocomplete_prediction.dart';
import '../services/google_places_service.dart';
import '../services/api_service.dart';

class AutoCompleteAddressField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final ValueChanged<String?> onAddressValidated;

  const AutoCompleteAddressField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.validator,
    required this.onAddressValidated,
  });

  @override
  State<AutoCompleteAddressField> createState() =>
      _AutoCompleteAddressFieldState();
}

class _AutoCompleteAddressFieldState extends State<AutoCompleteAddressField> {
  late GooglePlacesService googlePlacesService;
  List<AutocompletePrediction> suggestions = [];
  bool isAddressValidated = false;
  String? validatedAddress;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  void _initializeServices() {
    final apiService = ApiService(baseUrl: 'https://places.googleapis.com/v1/');
    googlePlacesService = GooglePlacesService(apiService: apiService);
  }

  void _getSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() {
        suggestions = [];
      });
      return;
    }

    try {
      final response =
          await googlePlacesService.getAutocompleteSuggestions(input);
      setState(() {
        suggestions = response.predictions;
      });
    } catch (e, stackTrace) {
      print('Error fetching autocomplete suggestions: $e');
      print('Stack trace: $stackTrace');
      setState(() {
        suggestions = [];
      });
    }
  }

  Future<void> _getPlaceDetails(String placeId) async {
    try {
      List<String> fields = [
        'id',
        'displayName',
        'formattedAddress',
        'location',
        'types',
        'internationalPhoneNumber',
        'nationalPhoneNumber',
        'websiteUri',
        'currentOpeningHours',
        'regularOpeningHours',
        'priceLevel',
        'rating',
        'userRatingCount',
        'reviews',
        'plusCode',
        'photos',
        'businessStatus'
      ];

      final PlaceDetailsResult response =
          await googlePlacesService.getPlaceDetails(placeId, fields: fields);

      setState(() {
        // Validate the formatted address
        isAddressValidated = response.formattedAddress != null;
        validatedAddress = response.formattedAddress;
        widget.onAddressValidated(validatedAddress);
      });

      print(response.formattedAddress);
    } catch (e, stackTrace) {
      print('Error fetching place details: $e');
      setState(() {
        isAddressValidated = false;
        validatedAddress = null;
        widget.onAddressValidated(validatedAddress);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.map_outlined,
                color: Color(0xFF95A1AC),
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Color(0xFF95A1AC),
                ),
                onPressed: () {
                  widget.controller.clear();
                  setState(() {
                    suggestions = [];
                    isAddressValidated = false;
                    validatedAddress = null;
                    widget.onAddressValidated(validatedAddress);
                  });
                },
              ),
              labelText: 'Address (Optional)',
              hintText: 'Enter your address here...',
              labelStyle: isAddressValidated
                  ? const TextStyle(
                      color: Colors.green,
                    )
                  : Theme.of(context).inputDecorationTheme.labelStyle,
              enabledBorder: isAddressValidated
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    )
                  : Theme.of(context).inputDecorationTheme.enabledBorder,
            ),
            keyboardType: TextInputType.streetAddress,
            onChanged: (String value) {
              _getSuggestions(value);
            },
          ),
          if (suggestions.isNotEmpty)
            Container(
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(suggestions[index].description),
                    onTap: () async {
                      widget.controller.text = suggestions[index].description;
                      await _getPlaceDetails(suggestions[index].placeId);
                      setState(() {
                        suggestions = [];
                      });
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

