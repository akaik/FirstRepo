import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/bmi.dart';
import '../models/fitness_user.dart';

class ApiCalls {
  Map<String, String> requestHeaders = {
    'X-RapidAPI-Host': 'fitness-calculator.p.rapidapi.com',
    'X-RapidAPI-Key':
        'e4586705dcmsh7f2f6a0ddfcbbd0p115593jsnc7297f9a68b8' //TODO
  };

  Future<Bmi> fetchBmi(FitnessUser user) async {
    String baseURL = 'https://fitness-calculator.p.rapidapi.com/bmi';

    Map<String, String> queryParams = {
      'age': user.age.toString(),
      'weight': user.weight.toString(),
      'height': user.height.toString(),
    };

    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(Uri.parse(baseURL + '?' + queryString),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      //TODO return Bmi object
      return Bmi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load bmi');
    }
  }

  void fetchDailyCalorie() {
    //TODO
  }

  void fetchBurnedCalories() {
    //TODO
  }
}
