**Diseño y Pruebas Basadas en VR/AR de Sistemas Mecatrónicos Avanzados**

**Pruebas Basadas en AR y VR de Sistemas Mecatrónicos Avanzados**

Para el desarrollo de un sistema mecatrónico avanzado como el RailCab, primero aplicamos la técnica de especificación, que se introdujo en la sección anterior, para definir una solución de principio del RailCab. Basándonos en esta solución de principio, luego desarrollamos numerosos prototipos virtuales y bancos de pruebas para prototipos reales, con el fin de analizar y evaluar el comportamiento de los componentes y módulos seleccionados del RailCab. Sin embargo, el análisis y la evaluación del RailCab y sus componentes pueden volverse complejos y consumir mucho tiempo, debido a dos razones principales:

- El RailCab puede mostrar un comportamiento bastante complejo, por ejemplo, cuando un RailCab se une o se separa de un convoy. Estos procesos ocurren rápidamente e involucran numerosas variables y datos, lo que dificulta que el ingeniero comprenda el curso de acción y mantenga una visión general de todo el procedimiento.
- Algunos prototipos de los componentes del RailCab, por ejemplo, el banco de pruebas del tren de rodaje del RailCab, operan rápidamente y sus partes se mueven mayormente solo unos pocos milímetros. Para el ingeniero, tales movimientos diminutos son difíciles de percibir.

Por estas razones, aplicamos dos enfoques, uno basado en AR y otro en VR, para facilitar el análisis y la evaluación de prototipos seleccionados y sus bancos de pruebas:

- Para el enfoque basado en AR, combinamos variables y datos de prueba del prototipo y su banco de pruebas, y utilizamos la tecnología AR para aumentar la vista del ingeniero sobre el sistema, superponiendo información relevante en su campo de visión.
- Para el enfoque basado en VR, aplicamos la tecnología VR para visualizar componentes faltantes, como por ejemplo la pista de pruebas, con el fin de simular cómo se desempeña el prototipo del tren de rodaje en pistas de prueba alternativas, distintas a nuestra pista de prueba real en el campus de Paderborn.

En las siguientes subsecciones, describimos estos dos ejemplos, que demuestran nuestros enfoques basados en AR y VR para facilitar los procedimientos de análisis y evaluación de dos prototipos del RailCab.

**6.1 Análisis Visual Basado en AR del Comportamiento del Convoy**

En el primer ejemplo, aplicamos la tecnología AR para facilitar el análisis del proceso de formación de convoyes de varios RailCabs en la pista de pruebas en el campus de la universidad en Paderborn. Como solo tenemos un prototipo real de RailCab disponible para conducir en la pista de pruebas, necesitamos simular RailCabs virtuales adicionales para poder simular procesos de formación de convoyes. Basándonos en la tecnología AR, proyectamos los RailCabs virtuales en un video del RailCab real que está circulando por la pista de pruebas. La aplicación AR combina y visualiza toda la información relevante directamente en la pantalla, de modo que el ingeniero puede observar fácilmente el proceso de formación de convoyes en un solo monitor. Además, la aplicación AR permite comprobar qué tan bien coopera una versión alternativa del software de control con versiones anteriores durante un proceso de formación de convoyes.

Para evaluar el concepto del manejo de convoy y el controlador en un entorno realista, se ha desarrollado un sistema de hardware-in-the-loop (HIL) [14]. En este sistema HIL, un RailCab real y cuatro RailCabs simulados se han combinado en un convoy. El principio se muestra en la Fig. 23. El RailCab real circula por la pista de pruebas en el campus de la universidad y sirve como líder del convoy. La unidad de control del convoy dentro de este vehículo gestiona todo el convoy. El concepto de convoyes autónomos requiere que los RailCabs circulen consecutivamente a una distancia de menos de un metro sin ningún acoplamiento mecánico [15-17]. Para lograr esto, los RailCabs deben comunicarse entre sí. Por lo tanto, el RailCab líder transmite su posición y velocidad líder a los cuatro vehículos simulados, que usan esta información para guiarse. Todos los sensores, actuadores y las partes mecánicas de los RailCabs virtuales están simulados. Para evitar colisiones entre los RailCabs dentro del convoy, cada vehículo es controlado en cuanto a distancia por un controlador de velocidad subordinado. La distancia se regula en relación con la posición del RailCab que circula delante.


**Fig. 23** Principio de la prueba hardware-in-the-loop del convoy RailCab

La limitación de la simulación HIL es que los RailCabs simulados no son visibles en la pista de pruebas. Su movimiento solo puede ilustrarse mediante un gráfico temporal. Sin embargo, al usar el banco de pruebas basado en HIL, es difícil probar diferentes estrategias de control y configuraciones de parámetros de manera interactiva durante los experimentos en línea. Por lo general, el ingeniero debe realizar un experimento en la pista de pruebas, recopilar y guardar los datos para su posterior análisis en el laboratorio. Cambiar las estrategias o configuraciones de parámetros de forma interactiva durante un experimento en curso es limitado y complicado. Una visualización basada en AR de los RailCabs simulados y los datos correspondientes, que explique su comportamiento, permite una prueba interactiva de la simulación HIL.

Por esta razón, hemos desarrollado una aplicación basada en AR para visualizar los RailCabs simulados y parámetros adicionales en la pista de pruebas real. Facilitamos un análisis visual del comportamiento del convoy en el banco de pruebas basado en HIL. Esto permite a los ingenieros comprender el comportamiento de la prueba HIL durante un experimento en línea. Una pregunta crucial para el análisis es: ¿Es capaz el convoy de moverse sin colisiones utilizando diferentes estrategias de control y parámetros? Para esto, visualizamos la forma de los RailCabs simulados y su movimiento en la pista de pruebas real, así como datos de control abstractos como la posición y velocidad de cada RailCab, la distancia entre dos RailCabs, la distancia de frenado y la velocidad líder. A continuación, presentamos cuatro temas para el análisis, con el fin de ilustrar cómo la visualización basada en AR facilita las pruebas del banco de pruebas basado en HIL y la evaluación del comportamiento del convoy.

**Convoyes:** Una pregunta importante para una operación energéticamente eficiente de los RailCabs es cómo se puede establecer y mantener un convoy de manera efectiva. La Figura 24 muestra un convoy que consiste en un RailCab real seguido por tres RailCabs virtuales. Ver los RailCabs simulados superpuestos en la pista de pruebas ayuda a los ingenieros a reconocer si los RailCabs están conduciendo en un convoy o si un RailCab pierde contacto con el convoy. En la Figura 24, el último RailCab ha perdido contacto con el convoy, y la distancia entre el último RailCab y el convoy precedente es demasiado grande para aprovechar el rebufo.

- RailCab simulado ha perdido contacto con el convoy.
- RailCab real (líder del convoy)
- RailCabs simulados conducen en convoy.

**Figura 24** Visualización AR de un RailCab que pierde contacto con el convoy

Las **colisiones** pueden ocurrir cuando los RailCabs intentan minimizar su distancia con respecto a los RailCabs precedentes en un convoy, con el fin de reducir la resistencia del aire y ahorrar energía. La Figura 25 ilustra el análisis basado en AR de una colisión entre dos RailCabs. Si dos RailCabs chocan, sus formas se resaltan en rojo. Si la distancia entre dos RailCabs cae por debajo de un límite especificado, una advertencia de colisión indica una posible colisión inminente. En la visualización, esto se indica mediante un RailCab parpadeante.

La calidad del control es un indicador importante que ayuda a evitar condiciones críticas mientras se conduce en un convoy. En la aplicación basada en AR, visualizamos dichas cantidades abstractas mediante códigos de color plausibles y fáciles de entender. La Figura 26 muestra una visualización de la calidad del control de cada RailCab utilizando dicho código de color.

Aquí, los RailCabs se destacan en una gama de colores que va desde el verde, pasando por el amarillo, hasta el rojo. Los tonos de color indican qué tan bien el controlador en cada RailCab del convoy es capaz de seguir cualquier valor de referencia que el controlador del convoy en el RailCab líder, que funciona como el líder del convoy, comunica a todos los miembros del convoy.


**Figura 25** Análisis basado en AR de una colisión ocurrida en un convoy

**Figura 26** Supervisión de la calidad del control

**Distancia de frenado:** En caso de una falla en el sistema o en algún componente, uno de los parámetros cruciales para el controlador del convoy es la distancia de frenado de cada RailCab en el convoy. La distancia de frenado influye directamente en el comportamiento del convoy y ayuda a prevenir colisiones por alcance para una operación segura del convoy. Para una conducción segura del convoy, la distancia de frenado de un RailCab que sigue a otro en un convoy debe, en todo momento, ser menor que la distancia de frenado del RailCab que lo precede. Para visualizar la distancia de frenado, se superpone una barra roja en la pista (ver Figura 27). La sección resaltada de la pista indica la distancia de frenado estimada del RailCab. La barra roja vertical al final de la sección resaltada de la pista indica la posición final esperada en la que el RailCab se detendrá por completo.


**Figura 27** Análisis visual basado en AR de la distancia de frenado y la posición final de un RailCab

**6.2 Realización del Sistema de Realidad Aumentada**

La Figura 28 muestra la configuración del banco de pruebas HIL a la izquierda y la configuración del sistema de AR a la derecha. Un servidor de comunicaciones está integrado entre ambos componentes. La mitad inferior de la Figura 28 muestra la mesa de control del operador para observar la pista de pruebas.

El banco de pruebas HIL está compuesto por un RailCab real y un sistema de prototipado en tiempo real, producido por dSpace. En el sistema en tiempo real, se está ejecutando una simulación de cuatro RailCabs reales bajo condiciones de tiempo real estricto. El RailCab real en la pista de pruebas es el líder del convoy simulado. Este RailCab se comunica con el sistema de simulación a través de un sistema de bus interno y propietario.

El sistema de simulación envía datos de posición y velocidad de todos los RailCabs al servidor de comunicaciones. El servidor se utiliza como una interfaz entre el banco de pruebas HIL, que opera bajo condiciones de tiempo real estricto, y el sistema de AR, que funciona bajo condiciones de tiempo real flexible. Cada 10 ms, el banco de pruebas HIL envía datos de los RailCabs al servidor de comunicaciones. Dado que el sistema de AR solo renderiza una nueva imagen cada 40 ms, recibe cada cuarto paquete de datos del servidor de comunicaciones.

El sistema de AR está compuesto por una PC con un procesador Pentium 4 de 2.8 GHz Dual Core, una tarjeta gráfica NVIDIA 8800 GTX y 2 GB de RAM. El dispositivo de salida para el video es un monitor HDTV con una relación de aspecto amplia de 16:9. Para grabar el video de la pista de pruebas, se utiliza una cámara de video Sony HVR-VIE HDV. Tanto el monitor como la cámara tienen una resolución de 1980 × 1080 píxeles. Necesitamos la alta resolución para poder monitorear no solo los RailCabs que pasan cerca de la cámara, sino también aquellos RailCabs que circulan en el lado más lejano de la pista de pruebas.

La aplicación de software de AR fue implementada en C++ y el kit de herramientas gráficas 3D OpenSceneGraph, que ofrece varias funciones para renderizar objetos 3D animados. La imagen de video se renderiza como una imagen 2D en el fondo con el fragment shader de la tarjeta gráfica. Para mostrar los RailCabs simulados en la aplicación de AR, se integraron modelos CAD del RailCab real en la aplicación.