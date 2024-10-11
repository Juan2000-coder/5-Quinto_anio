int     score = 0;           // Puntaje inicial
float   fuelinit  = 100;        // Combustible inicial
float   fuel = fuelinit;
boolean first = true;
float   x, y;                               // Posición de la nave
float   velX, velY;                         // Velocidad de la nave
float   landingVel = 0.6;                    // Velocidad de aterrizaje
float   tilt;                               // inclinación

PVector[][] estrellas;
int     NLandingSpots = 4;
float   land;                               // y del suelo
float   peak;                               // y del pico mas alto
boolean fin = false;

float   gravity  = 0.002;                   // Gravedad
float   thrust   = -0.0048;                 // Fuerza de empuje
boolean landed   = false;                   // Condición de aterrizaje

boolean t = false; //thrust
boolean l = false; //left
boolean r = false; //right

float[] terrenoY;                           // Array para almacenar las alturas del terreno
int  [] spots;
int NPuntos    = 500 ;                    // Número de puntos que definen el terreno

PImage nave;
float nave_width;
float nave_height;

void setup() {
  size(1250, 580);                        // Tamaño de la ventana
  surface.setLocation(55, 50);            // Posición de la ventana
  
  land = height - 20;                     // Nivel del suelo
  peak = height/1.8;                      // El mas alto pico
  
  x    = random(10, width - 10);          // Posición en x inicial aleatoria
  y    = random(10, 50);                  // Posición en y inicial aleatoria
  
  velX = 0;
  velY = 0;
  tilt = PI/2;
  
  terrenoY = new float[NPuntos];
  estrellas = new PVector[NPuntos][3]; 
  getLandscape();                         // Generar el terreno al inicio
  
  nave = loadImage("nave.JPG");
  nave_width  = 20;
  nave_height = nave_width*nave.height/nave.width;
}

void draw() {
  background(0);
  landscape();
  dynamics();
  stats();
  
  // Dibujar la nave
  pushMatrix();
  translate(x, y);
  rotate(tilt);
  fill(255);
  imageMode(CENTER);
  image(nave, 0, 0, nave_width, nave_height);
  popMatrix();
  
  /*PVector[] corners = getCorners(x, y, nave_width, nave_height, tilt);
  
  // Dibujar las esquinas como puntos
  stroke(255, 0, 0);
  for (PVector corner : corners) {
    point(corner.x, corner.y);
  }*/
  
  if (colision(x, y, tilt)){
    fill(255, 0, 0);
    textSize(32);
    text("Colisión!", width / 2 - 80, height / 2);
    if (fuel == 0){
      text("Sin combustible", width / 2 - 80, height / 2 + 35);
    }
    noLoop();  // Detener el juego
    score -= 10;
    fin   = true;
  }
  
  // Mostrar mensaje de aterrizaje
  if (landed) {
    fill(255, 0, 0);
    textSize(32);
    text("Alunizaje", width / 2 - 80, height / 2);
    if (fuel == 0){
      text("Sin combustible", width / 2 - 80, height / 2 + 35);
    }
    noLoop();  // Detener el juego
    score += 20;
    fin = true;
  }
}

void getLandscape() {
  // Generar alturas aleatorias para el terreno
  int           j  = 1;               // indice de bucle interno para generar los deniveles
  float     deltay = 0;               // incremento/decremento máximo en y en cada iteración
  float      prev  = land;            // valor previo de la altura del terreno
  float    actual  = land;            // valor actual de la altura del terreno
  boolean      up  = true;            // condición de ascenso/descenso de nivel
  boolean isSpot   = false;
  int         spot = int(random(20, (NPuntos/NLandingSpots) - 20));
  int spotIndex    = 0; 
  spots            = new int[NLandingSpots];
  spots[spotIndex] = spot;
  int           k  = 0;
  
  for (int i = 0; i < NPuntos; i++) { // bucle externo para completar el array
    if (!isSpot){ // no es lugar de aterrizaje
      isSpot  = i == spot;
      deltay  = random(12);                // incremento aleatorio
      
      // se utiliza una condición de ascenso/descenso parecida a la de un recocido simulado 
      // si el nivel sube cada vez se hace menos probable que comience a disminuir y viceversa (por el incremento de j)
      if (random(1) < exp(-0.33*j)){ // cambia el sentido de la variación de nivel
        if (up){                     // si el nivel va en ascenso se cambia a desenso y se obtiene la nueva altura
          up     = false; 
          actual = prev + deltay;
        }else{                        // si el nivel va en descenso se cambia a ascenso y se obtiene la nueva altura
          up     = true;
          actual = prev - deltay;
        }
        j        = 1;                // se reinicia el contador de j
      }else{                          // se conserrva el sentido de la variación de nivel
        if (up){
          actual = prev - deltay;
        }else{
          actual = prev + deltay;
        }
        j         +=1;             //se incrementa el contador de j
      }
      if (actual < peak){          //defecto al pico cuando la altura obtenida se encuentra por encima del pico
         terrenoY[i] = peak;
         up          = false;
         j           = 1;
      }else if(actual > land){     //defecto a suelo  cuando la altura obtenida se encuentra por debajo del suelo
        up           = true;
        terrenoY[i]  = land;
        j            = 1;
      }else{
        terrenoY[i]  = actual;    //de otro modo se conserva el valor
      }
      prev = terrenoY[i];
    }else{                        //es plataforma de aterrizaje
      terrenoY[i] = prev;
      k           += 1;
      if (k == 10){
        if (spotIndex < NLandingSpots-1){
          spot             = int((spotIndex + 1)*NPuntos/NLandingSpots + random(20, NPuntos/NLandingSpots - 20));
          spotIndex++;
          spots[spotIndex] = spot;
        }
        isSpot           = false;
        k                = 0;
      }
    }
    // Generar estrellas para cada valor de i
    int numEstrellas = int(random(4));
    for (int e = 0; e < numEstrellas; e++) {
      float starY = random(0, terrenoY[i] - 10);  // Altura de la estrella por encima del terreno
      estrellas[i][e] = new PVector(map(i, 0, NPuntos, 0, width), starY);  // Guardar coordenadas de las estrellas
    }
  }
}

void stats() {
  // Establecer el color y el tamaño del texto
  fill(255);
  textSize(16);
  
  // Mostrar las velocidades y la altura en la esquina superior derecha
  textAlign(RIGHT, TOP);
  text("Velocidad X: " + nf(velX, 1, 2) + " px/s", width - 10, 10);
  text("Velocidad Y: " + nf(velY, 1, 2) + " px/s", width - 10, 30);
  text("Altura: " + nf(height - y, 1, 2) + " px", width - 10, 50);
  
  // Mostrar el nivel de combustible y el puntaje en la esquina superior izquierda
  textAlign(LEFT, TOP);
  text("Combustible: " + nf(fuel, 1, 2), 10, 10);
  text("Puntaje: " + score, 10, 30);
}

void landscape() {
  // Dibujar el terreno usando líneas entre los puntos
  float x1, x2;
  boolean isSpot = false;
  for (int i = 0; i < NPuntos - 1; i++) {
    x1 = map(i, 0, NPuntos, 0, width);
    x2 = map(i + 1, 0, NPuntos, 0, width);
    for (int p: spots){
      if ((i < p + 9)&&(i >=p)){
        isSpot =true;
        break;
      }
    }
    if (isSpot){
      stroke(255,0,0);
    }
    else{
      stroke(255);
    }
    line(x1, terrenoY[i], x2, terrenoY[i + 1]);
    isSpot       = false;
    for (int e = 0; e < 3; e++) {
      if (estrellas[i][e] != null) {  // Si hay una estrella en esta posición
        stroke(255);
        point(estrellas[i][e].x, estrellas[i][e].y);
      }
    }
  }
}
void dynamics(){
  if (t){
    if (fuel > 0) {
        velY += thrust*cos(tilt);
        velX -= thrust*sin(tilt);
        fuel -= 0.1; // Ajustar el valor según el consumo de combustible
        if (fuel < 0){
          fuel = 0;
        }
      }
    }
    if (r){
      if (tilt < PI/2){
        tilt += 0.1;
      }
    }
    if (l){
      if (tilt > -PI/2){
          tilt -= 0.1;
      }
    }
  // Aplicar gravedad
  velY += gravity;
  
  // Actualizar posición
  y    += velY;
  x    += velX;
}

// Función para obtener las esquinas de la imagen
PVector[] getCorners(float cx, float cy, float w, float h, float angle) {
  PVector[] corners = new PVector[4];
  
  float halfW = w / 2;
  float halfH = h / 2;
  
  // Las esquinas antes de la rotación (relativas al centro)
  PVector topLeft = new PVector(-halfW, -halfH);
  PVector topRight = new PVector(halfW, -halfH);
  PVector bottomRight = new PVector(halfW, halfH);
  PVector bottomLeft = new PVector(-halfW, halfH);
  
  // Rotar las esquinas
  corners[0] = rotatePoint(topLeft, angle).add(cx, cy);
  corners[1] = rotatePoint(topRight, angle).add(cx, cy);
  corners[2] = rotatePoint(bottomRight, angle).add(cx, cy);
  corners[3] = rotatePoint(bottomLeft, angle).add(cx, cy);
  
  return corners;
}

// Función para rotar un punto alrededor del origen (0,0)
PVector rotatePoint(PVector point, float angle) {
  float xNew = point.x * cos(angle) - point.y * sin(angle);
  float yNew = point.x * sin(angle) + point.y * cos(angle);
  return new PVector(xNew, yNew);
}

boolean colision(float xNave, float yNave, float tilt) {
  // Convertir la posición de la nave en un índice dentro del array de terreno
  PVector[] corners = getCorners(x, y, nave_width, nave_height, tilt);
  int indiceNave    = int(map(xNave, 0, width, 0, NPuntos - 1));
  int min, mid,max      = 0;
  float ymin, ymid, ymax;
  
  // Verificar si la nave está colisionando con alguna parte del terreno
  // Si la nave está por debajo del terreno y no es una zona de aterrizaje
  boolean enZonaDeAterrizaje = false;
  boolean colided = false;
  for (int p: spots) {
    if (indiceNave >= p && indiceNave < p + 10) {
      enZonaDeAterrizaje = true;
      break;
    }
  }
  
  // Si la nave está por debajo del terreno en una zona que no es de aterrizaje, colisiona
  if (tilt > 0){
    min = int(map(corners[3].x, 0, width, 0, NPuntos - 1));
    max = int(map(corners[1].x, 0, width, 0, NPuntos - 1));
    mid = int(map(corners[2].x, 0, width, 0, NPuntos - 1));
    
    ymin = corners[3].y;
    ymid = corners[2].y;
    ymax = corners[1].y;
    
  }else if(tilt < 0){
    min = int(map(corners[0].x, 0, width, 0, NPuntos - 1));
    max = int(map(corners[2].x, 0, width, 0, NPuntos - 1));
    mid = int(map(corners[3].x, 0, width, 0, NPuntos - 1));
    
    ymin = corners[0].y;
    ymid = corners[2].y;
    ymax = corners[3].y;
  }
  else{
    min = int(map(corners[0].x, 0, width, 0, NPuntos - 1));
    max = int(map(corners[1].x, 0, width, 0, NPuntos - 1));
    mid = min;
    
    ymin = corners[0].y;
    ymid = corners[1].y;
    ymax = corners[0].y;
  }
  
  for (int i = min; i < mid; i++){
    if (terrenoY[i] < map(i, min, mid, ymin, ymid)){
      colided = true;
      break;
    }
  }
  if (!colided){
    for (int i = mid; i < max; i++){
      if (terrenoY[i] < map(i, mid, max, ymid, ymax)){
        colided = true;
        break;
      }
    }
  }
  landed = colided&&enZonaDeAterrizaje&&(velY < landingVel)&&((tilt < 0.8)&&(tilt > -0.8));
  return colided&&(!landed);
}
void resetGame() {
  // Reiniciar la posición de la nave
  x    = random(10, width - 10);
  y    = random(10, 50);
  
  // Reiniciar velocidad, inclinación y otras variables
  velX = 0;
  velY = 0;
  tilt = PI/2;
  landed = false;
  first = true;
  
  if (fuel == 0){
    score = 0;
    fuel  = fuelinit;
  }
  
  // Volver a iniciar el ciclo del juego
  loop();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      t = true;
    }
    if (keyCode == RIGHT){
      r = true;
    }
    if (keyCode == LEFT){
      l = true; 
    }
  }
  if (key == 'R' || key == 'r') {
    if (fin){
      resetGame();
    }
  }
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      t = false;
    }
    if (keyCode == RIGHT){
      r = false;
    }
    if (keyCode == LEFT){
      l = false;
    }
  }
}
