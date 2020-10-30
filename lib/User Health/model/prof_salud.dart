





import 'package:PsyBrain/User%20Health/repository/firestore_repo.dart';

class ProfSalud {

  FireStoreRepo fireStoreRepo = FireStoreRepo();

  String id;
  String nombres;
  String apellidos;
  String telefono;
  String correo;
  String cedula;
  String licencia;
  DateTime fechaNacimiento;
  String contrasena;


  ProfSalud({
    this.id,
    this.nombres,
    this.apellidos,
    this.telefono,
    this.correo,
    this.licencia,
    this.fechaNacimiento,
  });



}
