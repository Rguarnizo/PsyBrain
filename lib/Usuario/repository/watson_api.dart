import 'dart:convert';
import 'dart:io';

import 'package:watson_assistant_v2/watson_assistant_v2.dart';
import 'package:http/http.dart' as http;

class WatsonAPI {
  final String ASSISTANT_ID = "2c7b4c65-89e2-4bc8-ac5b-6b62adba1a84";
  final String ASSISTANT_URL =
      "https://api.us-south.assistant.watson.cloud.ibm.com/instances/835e40d4-a4eb-4f8b-bfac-a20df7103881";
  // final String ANALYSIS_URL =
  //     "https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/e36711d7-84aa-4b47-814a-6173e3095506/v1/analyze?version=2019-07-12";
  final String TRANSLATOR_URL =
      "https://api.us-south.language-translator.watson.cloud.ibm.com/instances/51523ed1-4524-4e89-9e21-a0ebb847d8d3/v3/translate?version=2018-05-01";

  Future<Map<String, dynamic>> getSessionID() async {
    String APIURL =
        "$ASSISTANT_URL/v2/assistants/$ASSISTANT_ID/sessions?version=2020-04-01";
    var response;
    response = await http.post(
      APIURL,
      headers: {
        HttpHeaders.authorizationHeader:
            'Basic YXBpa2V5OmR1RVhyUEVkV3dkTWRBVHdUb1ptZGZiQUI5VTdrYkNOellxV3h2MFExR29m',
      },
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> sendMessage(
      String text, String sessionID) async {
    String APIURL =
        "$ASSISTANT_URL/v2/assistants/$ASSISTANT_ID/sessions/$sessionID/message?version=2020-04-01";
    var data = json.encode({
      "input": {"text": text}
    });
    var response = await http.post(APIURL,
        headers: {
          HttpHeaders.authorizationHeader:
              'Basic YXBpa2V5OmR1RVhyUEVkV3dkTWRBVHdUb1ptZGZiQUI5VTdrYkNOellxV3h2MFExR29m',
          "Content-Type": 'application/json',
        },
        body: data);
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> sendAnalysis(String text) async {
    var textTranslated = await _translate(text);
    var textStringTranslated = textTranslated['translations'][0]['translation'];
    var data = json.encode({
      "text": textStringTranslated,
      "features": {
        "sentiment": {"document": true},
        "emotion": {"document": true}
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

  Future<Map<String, dynamic>> _translate(String text) async {
    var data = json.encode({"text": text, "model_id": "es-en"});
    var response = await http.post(TRANSLATOR_URL,
        headers: {
          'Authorization':
              'Basic YXBpa2V5OmN5UU5kTmN1TXFfWFFYZ1dCd1lMRmJVRFBrNS1jZVdMcVQ4eUFCQU5DLTJw',
          'Content-Type': 'application/json'
        },
        body: data);
    //print('Estoy traduciendo'+ response.body.toString());
    return json.decode(response.body.toString());
  }
}
