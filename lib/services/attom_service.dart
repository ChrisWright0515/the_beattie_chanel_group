import 'dart:convert';

import '../models/listing.dart';
import 'api_service.dart';

class AttomService {
  final String _baseUrl =
      'https://api.gateway.attomdata.com/propertyapi/v1.0.0/';
  late final ApiService _apiService;
  final String _apiKey = '6e077375ffcfcc66980c72ed08b27bfe';

  AttomService() {
    _apiService = ApiService(baseUrl: _baseUrl);
  }

  Future<void> fetchAllListings() async {
    final response = await _apiService.getRequest(
      'property/detail',
      headers: {
        'Accept': 'application/json',
        'APIKey': _apiKey,
      },
    );

    final List<dynamic> responseData = json.decode(response.body)['property'];

    print(responseData);
  }
}
