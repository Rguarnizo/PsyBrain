import 'dart:convert';
import 'package:http/http.dart' as http;

class WatsonAPI {
  Future<Map<String, dynamic>> sendAnalysis(String text) async {
    var data = json.encode({
      "text": text,
      "features": {
        "keywords": {
          "sentiment": true,
          "limit": 10,
        }
      }
    });
    var response = await http.post(
        "https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/e36711d7-84aa-4b47-814a-6173e3095506/v1/analyze?version=2019-07-12",
        headers: {
          'Authorization':
              'Basic YXBpa2V5OnpYOG41WTNOWVF0MFVkcVpJNVp5V2NFM3Bxamo0UWtveVI4SlFoSkItQ2FW',
          'Content-Type': 'application/json'
        },
        body: data);
    return json.decode(response.body);
  }
}
