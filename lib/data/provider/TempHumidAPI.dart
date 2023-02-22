import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hsmarthome/data/models/adafruit_get.dart';
import 'package:http/http.dart' as http;

class TempHumidAPI {
  static String username = 'winhandsome';
  static String? aioKey = dotenv.env['API_Key'].toString();
  static String led1Feed = 'bbc-led';
  static String mainURL = 'https://io.adafruit.com/api/v2/';

  static Future<AdafruitGET> getLed1Data() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$led1Feed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateLed1Data(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$led1Feed/data'),
      headers: <String, String>{
        'X-AIO-Key': aioKey!,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "datum": {"value": value}
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Error();
    }
  }
}
