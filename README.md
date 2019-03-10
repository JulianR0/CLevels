# CLevels
Plugin SCXPM utilizado en los servidores de Imperium Sven Co-op.
## Que es esto?
Bueno, he aqui mi plugin SCXPM, que llevo programando desde comienzos del 2012. Ha cambiado mucho y cuando lo examines seguramente notes que para ser un SCXPM parecer ser un plugin completamente diferente.

Aun asi no creo estar seguro que este SCXPM haya tenido un buen comienzo. Si bien es una edicion masiva de su version original en AMXX, cuando tube que adaptarlo a AngelScript he tenido bastantes problemas ya sea por ser novato en el nuevo lenguaje como tambien problemas que la API del AngelScript tenia en sus primeros dias. Es bastante probable que notes HORRORES escritos ahi, son remanentes de las primeras versiones del SCXPM en AngelScript y hoy en dia todabia siguen ahi.

Al menos todo ese trabajo que me puse a mi mismo logro su objetivo: Fui, y sigo siendo la primera y unica(?) persona que escribio un SCXPM en AngelScript!

Por lastima, no puedo decir que el proyecto este bien escrito y organizado, cuando examines el codigo y/o los archivos notaras que los plugins que yo utilize en su momento para uno de los servidores de la comunidad de Imperium Sven Co-op, tienen contenido mixto, algunos son plugins AngelScript mientras que otros son de AMX Mod X.
## Porque mezclar tanto AngelScript como AMX Mod X para este sistema?
AngelScript carece de ciertas utilidades especificas que solo el AMX Mod X tiene. Con el paso del tiempo AngelScript fue mejorando sus capacidades y logre mover algunas funciones del AMXX de regreso al AngelScript, pero aun asi esta muy lejos de reemplazarlo por completo. El mas primordial ejemplo es la posibilidad de hookear cualquier funcion de cualquier entidad, algo completamente inexistente en AngelScript. Estos hooks son utilizados por el SCXPM para detectar algunos logros, los cuales permiten que sean desbloqueados automaticamente. Si no pudiese hookear **Ham_Killed**, por poner un ejemplo, no seria posible hacer funcionar esos logros que requieran matar a un NPC en especifico.

Esto lleva a un segundo problema, como puedes ver, estoy utilizando el modulo *HamSandwich* del AMXX para hacer estos hooks, las cuales requieren que sus funciones esten especificados y actualizados en el archivo de configuracion **hamdata.ini**. El unico problema con esto es que dicho archivo debia actualizarse constantemente, ya que cada actualizacion del Sven Co-op que los desarrolladores hagan, implicaba que alguno de esos numeros se cambiasen. Si intentase detectar las muertes de los NPCs por AngelScript, la unica forma seria iterar por todas las entidades y revisar la condicion **pev->deadflag != DEAD_NO**. El hecho de iterar por todas las entidades constantemente haria el plugin poco eficiente y consumiria muchos recursos si ha de usarse en un map "intensivo".

Y finalmente tercer y ultimo problema, si intentase dejar todo en AMXX. Si bien AMXX puede hacer TODO -*y hablo de literalmente todo*- lo que el AngelScript ya puede hacer, AngelScript ya tiene punteros a ciertos miembros de algunas clases, lo que permite utilizar sus datos de manera muy sencilla y directa. Para hacer esto mismo en AMXX, haria falta buscar entre la memoria del juego y extraer el dato desde ahi. O resumidamente como lo llamo yo: **Offset Hacking**. Si yo quiero acceder a *CBasePlayerWeapon::m_flNextPrimaryAttack* para alterar la velocidad de disparo de un arma, en AngelScript lo puedo hacer muy facil con tan solo escribir **pWeapon.m_flNextPrimaryAttack = 0.1**. En AMXX tengo que buscar entre la memoria del juego para adquirir el numero de offset, extraer sus datos y modificarlo desde ahi. Esto lleva nuevamente al problema numero dos, que los numeros de las funciones deben actualizarse en cada actualizacion de SC. Con una sola funcion como la que he especificado en el ejemplo, no sera problema. Pero si tienes 10+ funciones diferentes, actualizar tu mismo y a mano los offsets se vuelve una tarea **DEMENCIAL Y TEDIOSA**.
## Porque "CLevels"?
En el pasado le tenia miedo al comando interno del GoldSrc/Svenengine llamado como **dlfile**. Cuando note que el SC intenta descargar archivos **.as** que utilizen los mapas -*y fracasar, por cierto*- pense que se podria aplicar a plugins, o bien que el comando ese pueda utilizarse para descargar archivos internos del servidor, como por ejemplo **server.cfg**. Por paranoia mia para evitar que mi SCXPM fuese "robado" le cambie su nombre a uno no tan obvio, y CLevels termino siendo el mejor nombre generico para protegerlo. Hoy en dia no tengo que preocuparme por **PLUGINS**, pero sigo con el miedo, cuando se trata de **MAP SCRIPTS** que uno utiliza en los mapas.
## Archivos del proyecto
Este proyecto se maneja con los siguientes archivos:

1. **CLevels.as**
   - Este es el plugin SCXPM principal. La mayoria de sus funciones se encuentran aqui y son independientes, si los plugins adicionales no pueden correr, el SCXPM puede aun seguir ejecutandose para los jugadores, aunque con funcionabilidad limitada.
2. **CLevels_AHandler.as**
   - Este plugin se encarga de la mayoria de los logros implementados en el SCXPM. Su funcion es ayudar a la auto-deteccion de los objetivos escritos en el plugin principal. De esta manera, los jugadores pueden desbloquear logros por si solos sin necesidad de un admininistrador que los desbloquie de manera manual.
3. **CLevels_Helper.sma**
   - Este es un plugin auxiliar para asistir en las funciones del SCXPM. La mayoria de sus funciones son proveer de metodos de auto-deteccion de logros para que los jugadores puedan desbloquearlos. Pero este plugin tambien dispone de tres utilidades adicionales, que son la eliminacion de entidades no deseadas en los mapas y la eliminacion de cualquier puntaje adquirido al reparar torretas aliadas. Estos dos son para evitar que los jugadores se aprovechen de defectos del juego y/o del SCXPM en si para adquirir EXP facil. Mientras que la tercera y ultima utilidad es la eliminacion de cualquier entidad "anti-scxpm" que ajuste el daño de los enemigos. Si bien pensar asi no es inapropiado, no corresponde con nuestro SCXPM. La mayoria de SCXPM's alla afuera te permiten tener **600**+ vida/armadura. **TIENE SENTIDO** en esos casos. Pero en mi SCXPM el valor maximo que se puede alcanzar es de aproximadamente **250**. Sufrir daño elevado por un pequeño aumento de vida/armadura hace los mapas demasiado injustos e insoportables.
4. **MysteryGift.sma**
   - Plugin encargado de manejar todas las tareas realizadas a "Mystery Gift"/Regalo Misterioso. Este plugin originalmente fue escrito para funcionar en todos los servidores, pero por problemas de presopuesto solo fue programado en el servidor SCXPM, con recompensas y funciones *hardcodeados* dentro de esta.
5. **CP_System.as**
   - Plugin de cosmetica. En este se encuentran los sistemas de Glow, Trail, Hats, y Fireworks. En adicion a funciones adicionales que son compartidas por el plugin principal y Mystery Gift. Los fireworks en este plugin se encuentran 100% programados y funcionales, sin embargo han sido desactivados en el codigo, ya que los fireworks fueron creados para utilizarse en eventos especiales. -*Por ejemplo: Cumpleaños de la comunidad*-
## Una nota sobre los archivos
El proyecto solamente contendra el codigo fuente, no provere de los sonidos/models/sprites o cualquier otro archivo adicional que el proyecto utiliza en su codigo. Y solicito que por favor se mantenga asi, aunque estoy abierto a negociar esta regla.

Si decides compilar y utilizar los codigos para tu propio uso tendras que inventar sus propios archivos adicionales que el proyecto utilize, o bien desactivarlos por completo.
## Instrucciones de compilacion/instalacion
La compilacion de los diferentes archivos del proyecto se realizan de tarea manual con los siguientes pasos:

### Plugins AngelScript (Extension .as):
Para compilar estos plugins solo basta con subir los nuevos archivos al servidor, cuya ubicacion es **svencoop/scripts/plugins**. Hecho eso se debe editar el archivo **default_plugins.txt** ubicado en la carpeta **svencoop** BASE. Y agregar nuestro plugin a la lista, esto solo se hace una vez, y estas nuevas entradas en la lista se deben ver de la siguiente manera:

```
"plugin"
{
  "name" "SCXPM"
  "script" "CLevels"
}

"plugin"
{
  "name" "SCXPM_AHandler"
  "script" "CLevels_AHandler"
}

"plugin"
{
  "name" "CP"
  "script" "CP_System"
}
```

Finalmente, vamos a la consola del servidor y escribimos el comando **as_reloadplugins** para recompilar todos los plugins de la lista. -*Es posible que sea necesario cambiar el mapa para que la compilacion se lleve a cabo*-. Si solamente queremos recompilar un solo plugin de esta lista, entonces escribimos el comando **as_reloadplugin "SCXPM"** para el plugin principal, **as_reloadplugin "SCXPM_AHandler"** para el plugin de logros, o bien **as_reloadplugin "CP"** para la cosmetica.

Dare enfasis a las palabras **consola del servidor**, si estas usando un dedicado escribir los comandos "asinomas" no tendra efecto alguno, deberas escribir los comandos desde **RCON** para que sean enviados al servidor.

Si la compilacion falla, los errores seran mostrados en la consola o bien en los logs del servidor, ubicado en **svencoop/logs/Angelscript** para su facil acceso.

### Plugins AMXX (Extension .sma):
El codigo de estos plugins fue escrito en AMXX 1.8.3 (Ahora 1.9). Debes descargar/instalar esas versiones experimentales del AMXX para poder compilarlos.

Hecho eso, copiamos nuestro archivo .sma a **addons/amxmodx/scripting**. Ahora, debemos ejecutar una linea de comandos en el simbolo de sistema. Asegurate que la terminal este apuntando al directorio mencionado anteriormente y ejecuta el siguiente comando: **amxxpc.exe CLevels_Helper.sma** o bien **amxxpc.exe MysteryGift.sma**. Si la compilacion es existosa, el programa creara su fichero compilado con extension **.amxx**. Este nuevo archivo es subido al servidor, en **addons/amxmodx/plugins**. Finalmente agregamos estos nuevos plugins a la lista de plugins AMXX, cuyo archivo de configuracion **plugins.ini** se encuentra en **addons/amxmodx/config**. Solo nos vamos al final del fichero y agregamos dos lineas, que seran CLevels_Helper.amxx y MysteryGift.amxx. Hecho! Si queremos recompilar los plugins solo modificamos el archivo .sma, compilamos y copiamos el nuevo archivo .amxx al servidor. -*Todos los cambios que realizemos solo tomaran efecto al cambiar de mapa*-.

Si no queremos utilizar el simbolo del sistema puedes crear un archivo **.bat** para simplificar la tarea. Que puede armarse de la manera siguiente: Crea un archivo .bat en **addons/amxmodx/scripting**, edita su contenido y agrega las siguientes lineas:

```
@echo off
amxxpc.exe CLevels_Helper.sma
amxxpc.exe MysteryGift.sma
pause
```

Cuando quieras recompilar los plugins, copia los nuevos .sma a la carpeta, ejecuta el .bat, y si la compilacion es exitosa tendras tus nuevos .amxx para utilizar.

Lamentablemente si las compilaciones fallan, estos no son exportados a un archivo .log el cual poder inspeccionar, deberas leer la ventana de la terminal para identificar y corregir fallos que se presenten. No obstante, si tienes buen conocimiento de los archivos .bat puedes editar las lineas y exportar manualmente el proceso de compilacion a un archivo para que sus errores sean legibles ahi.
# Finalizando
Suficiente escribiendo y haciendo este archivo README.md mas largo de lo que deberia, todo esto es libre. Adelante, explora, modifica, utiliza. Tal vez podamos trabajar juntos en mejorar este SCXPM asquerosamente escrito -*ya lo notaras cuando examines su codigo*-. E inclusive mejorar este README ya que estamos en ello, no?

Good luck, and have fun!
