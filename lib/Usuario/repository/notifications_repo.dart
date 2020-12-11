


import 'package:PsyBrain/Usuario/repository/notifications_api.dart';

class NotificationsRepo{

  final NotificationsApi _notificationsApi = NotificationsApi();

  get reciveMessage => _notificationsApi.messageStream;


  permitirNotificaciones(String uid){
    _notificationsApi.initNotifications(uid);
  }
  
  
}