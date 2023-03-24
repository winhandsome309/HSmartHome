// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hsmarthome/data/models/adafruit_get.dart';
import 'package:http/http.dart' as http;

class getDataAPI {
  static String username = 'huyhoang16';
  static String? aioKey = dotenv.env['API_Key'].toString();

  static String alarmFeed = 'smart-home-alarm';
  static String doorFeed = 'smart-home-door';
  static String fanFeed = 'smart-home-fan';
  static String gasFeed = 'smart-home-gas';
  static String gasAlarmFeed = 'smart-home-gas-alarm';
  static String ledFeed = 'smart-home-led';
  static String lightFeed = 'smart-home-light';
  static String lightLedFeed = 'smart-home-light-led';
  static String tempFeed = 'smart-home-temp';
  static String tempFanFeed = 'smart-home-temp-fan';
  static String mainURL = 'https://io.adafruit.com/api/v2/';

  // alarmFeed
  static Future<AdafruitGET> getAlarmData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$alarmFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateAlarmData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$alarmFeed/data'),
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

  // doorFeed
  static Future<AdafruitGET> getDoorData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$doorFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateDoorData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$doorFeed/data'),
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

  // fanFeed
  static Future<AdafruitGET> getFanData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$fanFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateFanData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$fanFeed/data'),
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

  // gasFeed
  static Future<AdafruitGET> getGasData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$gasFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateGasData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$gasFeed/data'),
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

  // gasAlarmFeed
  static Future<AdafruitGET> getGasAlarmData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$gasAlarmFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateGasAlarmData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$gasAlarmFeed/data'),
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

  // ledFeed
  static Future<AdafruitGET> getLedData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$ledFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateLedData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$ledFeed/data'),
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

  // lightFeed
  static Future<AdafruitGET> getLightData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$lightFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateLightData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$lightFeed/data'),
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

  // lightLedFeed
  static Future<AdafruitGET> getLightLedData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$lightLedFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateLightLedData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$lightLedFeed/data'),
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

  // tempFeed
  static Future<AdafruitGET> getTempData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$tempFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateTempData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$tempFeed/data'),
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

  // tempFanFeed
  static Future<AdafruitGET> getTempFanData() async {
    http.Response response = await http.get(
      Uri.parse('$mainURL$username/feeds/$tempFanFeed'),
      headers: <String, String>{'X-AIO-Key': aioKey!},
    );
    if (response.statusCode == 200) {
      return AdafruitGET.fromRawJson(response.body);
    } else {
      throw Error();
    }
  }

  static Future<bool> updateTempFanData(String value) async {
    http.Response response = await http.post(
      Uri.parse('$mainURL$username/feeds/$tempFanFeed/data'),
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

//   // Temperature
//   static Future<AdafruitGET> getTempData() async {
//     http.Response response = await http.get(
//       Uri.parse('$mainURL$username/feeds/$tempFeed'),
//       headers: <String, String>{'X-AIO-Key': aioKey!},
//     );
//     if (response.statusCode == 200) {
//       return AdafruitGET.fromRawJson(response.body);
//     } else {
//       throw Error();
//     }
//   }

//   static Future<bool> updateTempData(String value) async {
//     http.Response response = await http.post(
//       Uri.parse('$mainURL$username/feeds/$tempFeed/data'),
//       headers: <String, String>{
//         'X-AIO-Key': aioKey!,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "datum": {"value": value}
//       }),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Error();
//     }
//   }

//   // Gas
//   static Future<AdafruitGET> getGasData() async {
//     http.Response response = await http.get(
//       Uri.parse('$mainURL$username/feeds/$gasFeed'),
//       headers: <String, String>{'X-AIO-Key': aioKey!},
//     );
//     if (response.statusCode == 200) {
//       return AdafruitGET.fromRawJson(response.body);
//     } else {
//       throw Error();
//     }
//   }

//   static Future<bool> updateGasData(String value) async {
//     http.Response response = await http.post(
//       Uri.parse('$mainURL$username/feeds/$gasFeed/data'),
//       headers: <String, String>{
//         'X-AIO-Key': aioKey!,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "datum": {"value": value}
//       }),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Error();
//     }
//   }

//   // Led

//   static Future<AdafruitGET> getLedData() async {
//     http.Response response = await http.get(
//       Uri.parse('$mainURL$username/feeds/$ledFeed'),
//       headers: <String, String>{'X-AIO-Key': aioKey!},
//     );
//     if (response.statusCode == 200) {
//       return AdafruitGET.fromRawJson(response.body);
//     } else {
//       throw Error();
//     }
//   }

//   static Future<bool> updateLedData(String value) async {
//     http.Response response = await http.post(
//       Uri.parse('$mainURL$username/feeds/$ledFeed/data'),
//       headers: <String, String>{
//         'X-AIO-Key': aioKey!,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "datum": {"value": value}
//       }),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Error();
//     }
//   }

//   static Future<AdafruitGET> getLedColorData() async {
//     http.Response response = await http.get(
//       Uri.parse('$mainURL$username/feeds/$ledColorFeed'),
//       headers: <String, String>{'X-AIO-Key': aioKey!},
//     );
//     if (response.statusCode == 200) {
//       return AdafruitGET.fromRawJson(response.body);
//     } else {
//       throw Error();
//     }
//   }

//   static Future<bool> updataLedColorData(String value) async {
//     http.Response response = await http.post(
//       Uri.parse('$mainURL$username/feeds/$ledColorFeed/data'),
//       headers: <String, String>{
//         'X-AIO-Key': aioKey!,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "datum": {"value": value}
//       }),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Error();
//     }
//   }

//   // Fan

//   static Future<AdafruitGET> getFanSwitchData() async {
//     http.Response response = await http.get(
//       Uri.parse('$mainURL$username/feeds/$fanSwitchFeed'),
//       headers: <String, String>{'X-AIO-Key': aioKey!},
//     );
//     if (response.statusCode == 200) {
//       return AdafruitGET.fromRawJson(response.body);
//     } else {
//       throw Error();
//     }
//   }

//   static Future<bool> updateFanSwitchData(String value) async {
//     http.Response response = await http.post(
//       Uri.parse('$mainURL$username/feeds/$fanSwitchFeed/data'),
//       headers: <String, String>{
//         'X-AIO-Key': aioKey!,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "datum": {"value": value}
//       }),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Error();
//     }
//   }

//   static Future<AdafruitGET> getFanSpeedData() async {
//     http.Response response = await http.get(
//       Uri.parse('$mainURL$username/feeds/$fanSpeedFeed'),
//       headers: <String, String>{'X-AIO-Key': aioKey!},
//     );
//     if (response.statusCode == 200) {
//       return AdafruitGET.fromRawJson(response.body);
//     } else {
//       throw Error();
//     }
//   }

//   static Future<bool> updateFanSpeedData(String value) async {
//     http.Response response = await http.post(
//       Uri.parse('$mainURL$username/feeds/$fanSpeedFeed/data'),
//       headers: <String, String>{
//         'X-AIO-Key': aioKey!,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "datum": {"value": value}
//       }),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Error();
//     }
//   }

//   // Alarm

//   static Future<AdafruitGET> getAlarmData() async {
//     http.Response response = await http.get(
//       Uri.parse('$mainURL$username/feeds/$alarmFeed'),
//       headers: <String, String>{'X-AIO-Key': aioKey!},
//     );
//     if (response.statusCode == 200) {
//       return AdafruitGET.fromRawJson(response.body);
//     } else {
//       throw Error();
//     }
//   }

//   static Future<bool> updateAlarmData(String value) async {
//     http.Response response = await http.post(
//       Uri.parse('$mainURL$username/feeds/$alarmFeed/data'),
//       headers: <String, String>{
//         'X-AIO-Key': aioKey!,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "datum": {"value": value}
//       }),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Error();
//     }
//   }

//   // Door

//   static Future<AdafruitGET> getDoorData() async {
//     http.Response response = await http.get(
//       Uri.parse('$mainURL$username/feeds/$doorFeed'),
//       headers: <String, String>{'X-AIO-Key': aioKey!},
//     );
//     if (response.statusCode == 200) {
//       return AdafruitGET.fromRawJson(response.body);
//     } else {
//       throw Error();
//     }
//   }

//   static Future<bool> updateDoorData(String value) async {
//     http.Response response = await http.post(
//       Uri.parse('$mainURL$username/feeds/$doorFeed/data'),
//       headers: <String, String>{
//         'X-AIO-Key': aioKey!,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "datum": {"value": value}
//       }),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Error();
//     }
//   }

//   // Pass

//   static Future<AdafruitGET> getPassData() async {
//     http.Response response = await http.get(
//       Uri.parse('$mainURL$username/feeds/$passFeed'),
//       headers: <String, String>{'X-AIO-Key': aioKey!},
//     );
//     if (response.statusCode == 200) {
//       return AdafruitGET.fromRawJson(response.body);
//     } else {
//       throw Error();
//     }
//   }

//   static Future<bool> updatePassData(String value) async {
//     http.Response response = await http.post(
//       Uri.parse('$mainURL$username/feeds/$passFeed/data'),
//       headers: <String, String>{
//         'X-AIO-Key': aioKey!,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "datum": {"value": value}
//       }),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Error();
//     }
//   }
}
