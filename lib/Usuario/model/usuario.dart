class Usuario {
  String id;
  String nombres;
  String apellidos;
  String telefono;
  String correo;
  String cedula;
  String licencia;
  DateTime fechaNacimiento;
  String contrasena;

  Usuario({
    this.id,
    this.nombres,
    this.apellidos,
    this.telefono,
    this.correo,
    this.fechaNacimiento,
  });

  factory Usuario.fromJson(json) {
    return Usuario(
      nombres: json['Nombres'],
      apellidos: json['Apellidos'],
      correo: json['Correo'],
      fechaNacimiento: json['FechaNacimiento'],
      telefono: json['Telefono'],
    );
  }

  Map<String, dynamic> json() {
    return {
      'Nombres': nombres,
      'Apellidos': apellidos,
      'Correo': correo,
      'FechaNacimiento': fechaNacimiento,
      'Telefono': telefono
    };
  }

  factory Usuario.fromJsonPassword(Map<String,dynamic> data) {
    
    Usuario usuario = Usuario(
      nombres: data['Nombres'],
      apellidos: data['Apellidos'],
      correo: data['Correo'],
      fechaNacimiento: DateTime.now(),
      telefono: data['Telefono'],
    );
    
    usuario.contrasena = data['Contraseña'];

    return usuario;
  }
}
