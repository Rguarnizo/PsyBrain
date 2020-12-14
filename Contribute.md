# ¿Quieres contribuir al proyecto?

## Flutter

Para contribuir con este proyecto tienes que tener el framework Flutter instalado, por lo que si no lo tienes aún aquí tienes una guía de como hacerlo para tu sistema operativo:  [Guia de instalación Flutter, Multiples sistemas operativos.](https://flutter.dev/docs/get-started/install)

Ya que tengas Flutter instalado clona este repositorio y ejecútalo en tu IDE favorito, luego de ello haz las modificaciones que creas pertinentes, añade tus archivos a tu repositorio local y súbelos a tu rama remota.

### Crea un Pull-Request
Crea tu pull request con el trabajo que hiciste, alguno de nuestros colaboradores revisará tu PR y dará el visto bueno para que sea anexado al la rama Main de nuestro proyecto. Si aun no tienes mucho conocimiento en git te recomendamos ver esta guía. [Guía Rapida de Git y GitHub](https://rogerdudler.github.io/git-guide/index.es.html)


## Estructuración del proyecto


### Arquitectura
Este proyecto se trabaja bajo la Arquitectura BLoC,  (Si aún no la conoces puedes ir a [Bloc (bloclibrary.dev)](https://bloclibrary.dev/#/) y aprender más de ella) la organización de carpetas se hace por entidades y esas entidades tienen sus respectivos Repositorios y API's con la que se conectan. 

### Directorios
Si deseas agregar una nueva entidad los pasos a seguir serán crear una carpeta con el nombre de la entidad y allí se necesitará crear otros directorios así:

<a href="https://imgbb.com/"><img src="https://i.ibb.co/2qwYbsf/directories.png" alt="directories" border="0"></a>

Crearas la carpeta BloC donde estará el bloc de la entidad, Model, donde estará el modelo, Repository donde estará la información de transacciones entre API's y UI en donde estarán dos subdirectorios, uno para widgets que tengan que ver con la entidad y otro con pages completas que tengan que ver con la entidad también.

Si dado el caso tienes que definir una nueva ruta lo harás en el archivo routes.dart en el directorio routes.

Si tienes que definir una Interfaz Grafica que no tenga que ver con ninguna entidad lo harás en la carpeta UI, y dependiendo si es una page completa o un widget solamente lo harás en la carpeta correspondiente.

### Librerías.
Recuerda que si tienes que agregar alguna librería extra lo harás en el archivo pubspec.yaml, que se encuentra en el directorio raíz del proyecto:

<a href="https://ibb.co/dgF28B5"><img src="https://i.ibb.co/Hd6z57H/Pubspect.png" alt="Pubspect" border="0"></a>

Te recomendamos agregar el paquete sin el numero de la versión a utilizar, esto con el fin de que Flutter traiga la ultima versión de ese paquete. 

Para ver los paquetes disponibles para Flutter visita [Dart packages (pub.dev)](https://pub.dev/)


## Github Guidelines

Si deseas colaborar y poder hacer PR a la rama main tendrás que seguir las siguientes directrices: 

 1. Crea una **nueva rama** desde la rama **Desarrollo** con el nombre de la funcionalidad a implementar y **tu nombre y apellido** despues de esta.
 2. Crea **commits** suficientemente **seguidos**, una buena metrica sería **1 cada 5 funciones implementadas**. Esto con el fin de **no iterar posibles bugs**.
 3. Crea un Pull Request **claro**, añadele una **descripción** y un **titulo** que sea diciente.
 4. Enfocate en crear y construir un mundo mejor 😉

Si alguna de estas directrices no es respetada, se dará por inhabilitado el PR, y se dará prioridad a aquellos PR que si sigan estas directrices. 

## Documentación.

Recuerda que cada función que realices tiene que tener su respectiva documentación, para ayudarte en ello en el repositorio encontraras las siguientes clases documentadas en su totalidad. 

auth_api.dart, cloud_storage_api.dart, firestore_api.dart, profsalud_bloc.dart. 

Así luce la documentación de las funciones en el IDE de Visual Studio Code:

<a href="https://ibb.co/Bch1CbX"><img src="https://i.ibb.co/TYQCg6V/Documentacion-Final.png" alt="Documentacion-Final" border="0"></a>

Recuerda que si pasas el ratón por encima de cada función encontraras la documentación de la misma lo que te ayudará enormemente a entender mejor el código y poder usarlo de manera correcta.


## Firebase y Azure DevOps.

Si deseas tener acceso a las Bases de datos, Funciones de Firebase y estar al tanto de lo que hay por realizar y las futuras proyecciones de la App no dudes en contactarte con uno de los colaboradores de PsyBrain, el te dará acceso a las opciones de Firebase como también te añadirá al grupo de trabajo de Azure DevOps.


## Contactanos.

Si tienes alguna duda que no se aclaro en este documento puedes comunicarte con nosotros y ten por seguro que estaremos dispuestos a colaborarte en cualquier asusto que requieras.
