
class ProfSalud {


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
    this.cedula
  });

  factory ProfSalud.fromJson(json){
    return ProfSalud(
        nombres: json['Nombres'],
        apellidos: json['Apellidos'],
        correo: json['Correo'],
        fechaNacimiento: json['FechaNacimiento'],
        licencia: json['Licencia'],
        cedula: json['Cedula'],
        telefono: json['Telefono'],
    );
  }

  Map<String,dynamic> json(){
    return {
          'Nombres'        : nombres,
          'Apellidos'      : apellidos,
          'Correo'         : correo,
          'FechaNacimiento': fechaNacimiento,
          'Licencia'       : licencia,
          'Cedula'         : cedula,
          'Telefono'       : telefono,
        };
  }

}
