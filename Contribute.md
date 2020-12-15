# ¿Quieres contribuir al proyecto?

##Flutter

Para contribuir con este proycto tienes que tener el framework flutter instalado, por lo que si no lo tienes aún aqui
tienes una guia de como hacerlo para tu sistema operativo:  [https://flutter.dev/docs/get-started/install](Guía Oficial Instalación Flutter) 

## Guía para usar GIT

### Instalación
> sudo apt-get install git

### Clonar repositorio

1. Crear carpeta deonde se guardará el repositorio
> sudo mkdir git  
> cd git

2. Descargar el repositorio desde GitHub
> sudo git clone http://github.com/usuario/repositorio.git

Descripción | Comandos
------------|---------
Verificar estado | `git status`
Comprobar actualizaciones | `git fetch`
Agregar modificaciones al índice | `git add .`
Guardar cambios en el repositorio local | `git commit -m "mensaje"`
Subir cambios al repositorio remoto | `git push`
Descargar cambios del repositorio remoto | `git pull`
Ayuda sobre los comandos | `git comando --help`

### Procedimiento para subir archivo al repositorio remoto

1. Comprobar que no haya actualizaciones
> git fetch  
> git status  

   En caso de haber actualizaciones, descargarlas con `git pull`
2. Agregar modificaciones al índice
> git add .
3. Guardar cambios en el repositorio local
> git commit -m "mensaje"
4. Subir cambios al repositorio remoto
> git push
5. Verificar estado
> git status