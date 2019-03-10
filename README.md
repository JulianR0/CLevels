# CLevels
Plugin SCXPM utilizado en los servidores de Imperium Sven Co-op.
#
Bueno, he aqui mi plugin SCXPM, que llevo programando desde comienzos del 2012. Ha cambiado mucho y cuando lo examines seguramente notes que para ser un SCXPM parecer ser un plugin completamente diferente.

Aun asi no creo estar seguro que este SCXPM haya tenido un buen comienzo. Si bien es una edicion masiva de su version original en AMXX, cuando tube que adaptarlo a AngelScript he tenido bastantes problemas ya sea por ser novato en el nuevo lenguaje como tambien problemas que la API del AngelScript tenia en sus primeros dias. Es bastante probable que notes HORRORES escritos ahi, son remanentes de las primeras versiones del SCXPM en AngelScript y hoy en dia todabia siguen ahi.

Al menos todo ese trabajo que me puse a mi mismo logro su objetivo: Fui, y sigo siendo la primera y unica(?) persona que escribio un SCXPM en AngelScript!

Por lastima, no puedo decir que el proyecto este bien escrito y organizado, cuando examines el codigo y/o los archivos notaras que los plugins que yo utilize en su momento para uno de los servidores de la comunidad de Imperium Sven Co-op, tienen contenido mixto, algunos son plugins AngelScript mientras que otros son de AMX Mod X.

La realidad es que me fui obligado a mezclar ambos motores para poder hacer funcionar esto, y si bien te dare la razon que hubiera sido mejor dejar todo en un solo lenguaje, no todas las funciones del AMX Mod X existen en AngelScript, lo que me obligo a crear un segundo plugin "auxiliar" para complementar al SCXPM. Escuchame y sabras que no seria posible en ninguno de los dos lados:

AngelScript carece de ciertas utilidades especificas que solo el AMX Mod X tiene. Con el paso del tiempo AngelScript fue mejorando sus capacidades y logre mover algunas funciones del AMXX de regreso al AngelScript, pero aun asi esta muy lejos de reemplazarlo por completo. El mas primordial ejemplo es la posibilidad de hookear cualquier funcion de cualquier entidad, algo completamente inexistente en AngelScript. Estos hooks son utilizados por el SCXPM para detectar algunos logros, los cuales permiten que sean desbloqueados automaticamente. Si no pudiese hookear **Ham_Killed**, por poner un ejemplo, no seria posible hacer funcionar esos logros que requieran matar a un NPC en especifico.

Esto lleva a un segundo problema, como puedes ver, estoy utilizando el modulo *HamSandwich* del AMXX para hacer estos hooks, las cuales requieren que sus funciones esten especificados y actualizados en el archivo de configuracion **hamdata.ini**. El unico problema con esto es que dicho archivo debia actualizarse constantemente, ya que cada actualizacion del Sven Co-op que los desarrolladores hagan, implicaba que alguno de esos numeros se cambiasen. Si intentase detectar las muertes de los NPCs por AngelScript, la unica forma seria iterar por todas las entidades y revisar la condicion **pev->deadflag != DEAD_NO**. El hecho de iterar por todas las entidades constantemente haria el plugin poco eficiente y consumiria muchos recursos si ha de usarse en un map "intensivo".

Y finalmente tercer y ultimo problema, si intentase dejar todo en AMXX. Si bien AMXX puede hacer TODO -*y hablo de literalmente todo*- lo que el AngelScript ya puede hacer, AngelScript ya tiene punteros a ciertos miembros de algunas clases, lo que permite utilizar sus datos de manera muy sencilla y directa. Para hacer esto mismo en AMXX, haria falta buscar entre la memoria del juego y extraer el dato desde ahi. O resumidamente como lo llamo yo: **Offset Hacking**. Si yo quiero acceder a *CBasePlayerWeapon::m_flNextPrimaryAttack* para alterar la velocidad de disparo de un arma, en AngelScript lo puedo hacer muy facil con tan solo escribir **pWeapon.m_flNextPrimaryAttack = 0.1**. En AMXX tengo que buscar entre la memoria del juego para adquirir el numero de offset, extraer sus datos y modificarlo desde ahi. Esto lleva nuevamente al problema numero dos, que los numeros de las funciones deben actualizarse en cada actualizacion de SC. Con una sola funcion como la que he especificado en el ejemplo, no sera problema. Pero si tienes 10+ funciones diferentes, actualizar tu mismo y a mano los offsets se vuelve una tarea **DEMENCIAL Y TEDIOSA**.
#
Pero bueno, suficiente escribiendo y hacer este archivo README.md mas largo de lo que deberia, todo esto es libre. Adelante, explora, modifica, utiliza. Tal vez podamos trabajar juntos en mejorar este SCXPM asquerosamente escrito -*ya lo notaras cuando examines su codigo*-. E inclusive mejorar este README ya que estamos en ello, no?

Good luck, and have fun!
