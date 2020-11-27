import 'package:PsyBrain/Usuario/repository/watson_api.dart';

class WatsonRepo {
  final WatsonAPI _watsonAPI = WatsonAPI();
  Future<Map<String, dynamic>> getSessionID() => _watsonAPI.getSessionID();
  Future<Map<String, dynamic>> sendMessage(String text, String sessionID) =>
      _watsonAPI.sendMessage(text, sessionID);
  Future<Map<String, dynamic>> sendAnalysis(String text) =>
      _watsonAPI.sendAnalysis(text);
}
