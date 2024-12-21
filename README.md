# Internal Platform


## Descripción
Internal Platform es una aplicación que permite a los empleados postular a las ofertas de trabajo internas de la empresa. Facilita la gestión de ofertas de trabajo y aplicaciones, mejorando la comunicación y el proceso de selección dentro de la organización.


## Funcionamiento de la Aplicación

La aplicación Internal Platform permite a los empleados postular a ofertas de trabajo internas de la empresa. El flujo de trabajo es el siguiente:

1. **Generación de Invitaciones**: El administrador puede generar invitaciones para que los usuarios se registren en la plataforma. Estas invitaciones se envían a través de correo electrónico, permitiendo a los empleados crear su cuenta y acceder a las ofertas de trabajo disponibles.

2. **Registro e Inicio de Sesión**: Los usuarios que reciben una invitación pueden registrarse en la aplicación y, posteriormente, iniciar sesión para acceder a su perfil y a las ofertas de trabajo.

3. **Postulación a Ofertas de Trabajo**: Los empleados pueden navegar por las ofertas de trabajo disponibles y postularse a aquellas que les interesen. 

4. **Interfaz de Usuario**: Excepto por la vista `admin/applications`, que utiliza un poco de JavaScript para mejorar la experiencia del usuario, el sitio está desarrollado en Ruby on Rails utilizando ERB (Embedded Ruby) casi en su totalidad. Esto permite una integración fluida entre el código Ruby y el HTML, facilitando la creación de vistas dinámicas y responsivas.

La aplicación está diseñada para ser intuitiva y fácil de usar, asegurando que los empleados puedan hacer sus postulaciones de manera eficiente, y el administrador poder ver las nuevas controlar las postulaciones, ofertas laborales y usuarios.


## Interfaz de usuarios y administradores

Contamos con un navbar en la parte superior de la aplicación con opciones generales y un asidebar con la informacion y opciones relevantes para el usuario.

El administrador tiene el menú de dashboard para administrar y gestionar sus usuarios, actuales y futuras ofertas de trabajo, y las postulaciones que realizan los usuarios.


## Estado del Proyecto
En desarrollo


## Instalación

Para instalar y ejecutar la aplicación, sigue estos pasos:

1. **Clona el repositorio**
    git clone https://github.com/tripleG-Master/plataforma_interna.git

2. **Navega al directorio del proyecto**
    cd plataforma_interna

3. **Instalar las gemas necesarias**
    bundle install

4. **Configura la base de datos**
    Edita el archivo ubicado en <code>config/database.yml</code> con los datos de tu base de datos.

5. **Crea la base de datos**
    rails db:create

6. **Ejecutemos las migraciones**
    rails db:migrate

7. **Poblamos la base de datos con datos de prueba**
    rails db:seed
    *IMPORTANTE*
    Cambia dentro del archivo seed el email de administrador por tu email, o uno que quieras utilizar.

8. **Iniciamos el servidor**
    rails s

## Acceso a la Aplicación
* Accede a la aplicación en tu navegador en la siguiente dirección: <code>http://127.0.0.1:3000/</code>


## Permisos y Roles
- **Administrados**: Pueden crear, editar y eliminar ofertas de trabajo, así como gestionar usuarios y las aplicaciones a loas ofertas laborales.
- **Empleados**: Pueden ver ofertas de trabajo y postularse a ellas.
- **CABE DESTACAR**
- Las contraseñas generadas en la seed para users es "123456". Puedes utilizar cualquiera de los email generados y con la misma contraseña entrar con su perfil para realizar pruebas de usuario.


## Rutas públicas

- **GET /sign_in**: Ingreso a la aplicación. Necesitas haber recibido la invitación a tu email, o usar un usuario generado por la seed.
- **GET /sign_out**: Cerrar session.
  
## Rutas protegidas

- **GET /joboffers**: Listado de las ofertas laborales.
- **GET /joboffers/:id/applications**: Listado de tus postulaciones actuales.
- **GET /users/**: Ver y editar la información de tu perfil de usuario.
-  
- **GET /admin/**: Accede al dashboard con el crud disponible de usuarios, ofertas laborales y postulaciones.


## Tecnologías Utilizadas
- Ruby on Rails
- PostgreSQL (o el sistema de base de datos que estés utilizando)
- Devise (para autenticación)
- Active Storage (para subir imágenes)
- Faker (para generar información aleatoria)

## REPOSITORIO
- El repositorio se encuentra en el siguiente enlace: 

  [Plataforma-Interna](https://github.com/tripleG-Master/plataforma_interna)