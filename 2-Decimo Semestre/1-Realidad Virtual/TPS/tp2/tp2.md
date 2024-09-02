# Comparativa de Dispositivos de Interacción


| **Nombre** | **Tipo de Dispositivo** | **Tipo de Interacción**| **Realim. Háptica**|**Precisión**| **Aplicaciones**|
|-|-|-|-|-|-|
| **Meta Quest Touch Pro Controllers** |Control de movimiento| Seguimiento de manos, gestos, dedos (Self tracking). Sensores de presión para grips, etc.| 2(linear resonance actuator); 1(voice coil modulator)|Alta| Juegos, simulaciones, productividad|
|------------|---------------|-------------------|--------------------|----------|----------------|
| **Valve Index Controllers** |Control de movimiento|Seguimiento de dedos, gestos (requiere estación base). Sensores de presión (permiten agarre natural).| Vibración | Muy alta|Juegos, realidad virtual interactiva|
|------------|---------------|-------------------|--------------------|----------|----------------|
| **HTC Vive Trackers**| Disp. de seguimiento | Seguimiento corporal y de objetos (requiere estación base)| No tiene | Muy alta | Juegos, captura de movimiento, simulaciones con seguimiento de elementos (i.e el extremo de un remo)|
|------------|---------------|-------------------|--------------------|----------|----------------|
| **Manus Prime II Haptic Gloves** | Guantes hápticos | Seguimiento de manos y dedos| Motores de vibración | Alta | Entrenamiento, simulación, interacción avanzada|
|------------|---------------|-------------------|--------------------|----------|----------------|
| **HaptX Gloves**               | Guantes hápticos             | Seguimiento de manos, retroalimentación  | Retroalimentación táctil avanzada (permite construcción de memoria muscular/sensorial real)| Muy alta               | Simulaciones, entrenamiento profesional (medicina, operaciones, etc.)            |
|------------|---------------|-------------------|--------------------|----------|----------------|
| **bHaptics TactSuit X40**      | Chaleco háptico              | Retroalimentación corporal completa      | 40 Motores hápticos distribuidos en el torso | -                   | Juegos, simulaciones, aplicaciones de inmersión corporal       |
|------------|---------------|-------------------|--------------------|----------|----------------|
| **Pimax Sword Controllers**    | Controladores de movimiento| Seguimiento de manos (requiere estación base)        | tiene                        | Regular                   | Juegos, realidad virtual interactiva                           |
|------------|---------------|-------------------|--------------------|----------|----------------|
| **Tundra Tracker**             | Dispositivo de seguimiento   | Seguimiento corpora (requiere estación base)           | No tiene                        | Buena | Juegos, captura de movimiento, simulaciones                    |


# Diseño de Experiencia Interactiva

**Descripción de la escena**

La experiencia virtual consiste en un entrenamiento de soldadura con diferentes tipos de métodos (MIG/MAG, TIG, SMAW, etc.). En la escena virtual se presentará un banco de soldatura junto con la representación de la máquina de soldadura correspondiente, la posibilidad de seleccionar distintos elementos (tubos, planchas metálicas, etc.) y tipos de uniones a realizar (uniones en bisel, a tope, etc.), el casco para protección al realizar la soldadura y los electrodos para realizar la soldadura en caso de que sean necesarios.

**Mecanismo de desplazamiento**

Cómo es una experiencia de habitación no hace falta pensar en mecanismos de desplazamiento.

**Descripción de la experiencia**

La persona en entrenamiento tendrá la tarea de realizar cierto tipo de unión con determinados materiales y con ciertos requisitos de terminación o contaminación admisible de la unión. Entonces deberá seleccionar algún método de soldadura adecuado para realizar la unión junto con los elementos apropiados (tipo de electrodos por ejemplo). Si selecciona adecuadamente el procedimiento se presentará en el esenario el banco de soldadura junto con todos los elementos mencionados antes. El aprendiz entonces realizará el procedimiento de soldadura completo (incluye la preparación de la máquina y de los elementos) y al final de realizar el procedimiento obtendrá una puntuación del procedimiento realizado.

Se preveé además un esenario alternativo de entrenamiento en el que además el aprendiz tendrá indicación de variables de la soldadura como por ejemplo la inclinación del electrodo, la velocidad de pasada, guías que delimiten el cordón que se debe realizar, etc.

Para esta experiencia entonces se considera el uso de 
los **Valve Index Controllers**. Se utilizarán para la selección de opciones por un lado básico. Pero además tendrá una representación en el escenario virtual en la forma del portaelectrodos/pinza de soldadura para la mano derecha y simplemente la mano en la mano izquierda para poder sostener un material de aporte en el caso de los tipos de soldadura TIG por ejemplo. Se considera que son buena opción dado que tienen sensores de presión que permiten representar la acción de "grip" de los distintos elementos. Además debido a que incorporan realimentación háptica en la forma de vibración, se puede utilizar una vibración suave para la operación normal y una vibración fuerte para cuando, por ejemplo, el aprendiz acerca demasiado el electrodo al material o la máquina está mal regulada y se pega el electrodo.

# Solución de Problemas de Interacción

Un ejemplo son los **Valve Index Controllers**.

| Medio-Anular-Meñique | Índice | Pulgar | Trackpad o Menu | Trigger | Grip |
|----------------------|--------|--------|-----------------|---------|------|
|        Falso         | Falso  | Falso  |      Falso      |  Falso  | Falso|
|        Falso         | Falso  | Verdadero |    Verdadero   |  Falso  | Falso|
|        Falso         | Verdadero | Falso  |    Falso       |  Verdadero | Falso|
|        Falso         | Verdadero | Verdadero | Verdadero | Verdadero | Falso|
|        Verdadero     | Falso  | Falso  |      Falso      |  Falso  | Verdadero|
|        Verdadero     | Falso  | Verdadero |  Verdadero    |  Falso  | Verdadero|
|        Verdadero     | Verdadero | Falso |   Falso       |  Verdadero | Verdadero|
|        Verdadero     | Verdadero | Verdadero | Verdadero | Verdadero | Verdadero|
