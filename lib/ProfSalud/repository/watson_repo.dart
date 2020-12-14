import 'package:PsyBrain/ProfSalud/repository/watson_api.dart';

class WatsonRepo {
  WatsonAPI _watsonAPI = WatsonAPI();
  /// Manda el analisis a la API de IBM Watson. Retorna el analisis lanzado por la API en formato Json.
  Future<Map<String, dynamic>> sendAnalysis(String text) =>
      _watsonAPI.sendAnalysis(text);
}
