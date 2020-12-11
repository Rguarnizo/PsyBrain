import 'dart:async';
import 'dart:convert';
import 'package:PsyBrain/ProfSalud/repository/firestore_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http; 

class NotificationsApi{

  final FirebaseMessaging _firebaseMessagingApi = FirebaseMessaging();
  final FireStoreApi _fireStoreApi = FireStoreApi();
  final _messageStreamController  = StreamController<Map<String,dynamic>>.broadcast();
  Stream<Map<String,dynamic>> get messageStream => _messageStreamController.stream;
  final String serverToken = 'AAAA4KsKeqc:APA91bHjGohPKIBtI54tt28XG1aMuHm4cyMoiSpro0b8v1_O88g-DG-TotsUpraaij6CfsImrOklaXbtFGLDDz8LCPdo99KKNbsb7Qz78rnAu5K0pJXGRnGcJsG1KaLAv8HvLFVPRRy0';

  initNotifications(String uid)async{
    bool acepted = await _firebaseMessagingApi.requestNotificationPermissions();
    print(acepted);

    _firebaseMessagingApi.getToken().then((token) => _fireStoreApi.actulizarData({'DeviceToken': token},uid));

    _firebaseMessagingApi.configure(
        onLaunch: (message) {
          print(message);
        },

        onMessage: (message) async {

          _messageStreamController.sink.add(message['Data']);
        },

        onResume: (message) {
          print(message);
        },        
        
    );
  }

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

    Future<void> sendAndRetrieveMessage(String recivedToken,Map<String,dynamic> data) async {
      _firebaseMessagingApi.requestNotificationPermissions();

    _firebaseMessagingApi.configure();      
      
      await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '${data['Message']}',
            'title': 'Mensaje de ${data['Nombres']}'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'Data': data,
          },
          'to': recivedToken,
        },
        ),
      );
    }
}