import 'package:PsyBrain/ProfSalud/repository/watson_api.dart';

class WatsonRepo {
  WatsonAPI _watsonAPI = WatsonAPI();
  Future<Map<String, dynamic>> sendAnalysis(String text) =>
      _watsonAPI.sendAnalysis(text);
}
