//Variables:------------------------------------------
int     columnas, filas, escala, ancho, alto, vel, R, r;
float   anguloX, anguloY, dAngX, dAngY;
color   c1, c2, c3, c4, c5;
boolean horizontal, first;
PImage  textura1, textura2;
PShape  modelo3D;
String[] archivos;  // Lista de archivos en la carpeta "data"
//-----------------------------------------------------

void setup() {
  size(900, 700, P3D);
  escala   = 20;             // número de pixeles por unidad
  
  ancho    = 600;            // ancho del plano
  alto     = 400;            // alto del plano
  
  vel      = 1;              // factor de velocidad
  
  anguloX  = 0;              // ángulo de rotación inicial en x
  anguloY  = 0;              // ángulo de rotación inicial en y
  
  dAngX    = PI*vel/1024;    // velocidad de rotación alrededor del eje x
  dAngY    = 0;              // velocidad de rotación alrededor del eje y
  
  archivos = listPaths(sketchPath("data"));
  
  // Filtrar solo las imágenes (JPG)
  ArrayList<String> imagenes = new ArrayList<String>();
  for (String archivo : archivos) {
    if (archivo.endsWith(".jpg")) {
      imagenes.add(archivo);
    }
    if (archivo.endsWith(".obj")) {
      println(archivo);
      modelo3D = loadShape(archivo);
    }
  }
  
  // Elegir una imagen aleatoria
  if (imagenes.size() > 0) {
    String rutaTextura = imagenes.get(int(random(imagenes.size())));
    textura1 = loadImage(rutaTextura);
    rutaTextura = imagenes.get(int(random(imagenes.size())));
    textura2 = loadImage(rutaTextura);
  } else {
    println("No se encontraron imágenes en la carpeta 'data'");
  }
  
  horizontal = false; // arranca rotando respecto del eje x
  first      = true;
}

void draw() {
  background(0);
  ambientLight(230, 245, 115);
  directionalLight(255, 100, 60, 1, -1, 0);
  noFill();
  
  if (!first){   // Recuperación de la última definición del sistema
    popMatrix();
  }
  else{          // Ajuste del sistema de referencia en la primera iteración
    rotateX(anguloX);
    rotateY(anguloY);
    translate(width/2, height/2);
    first = false;
  }
  
  rotateX(dAngX); // Rotación continua en X
  rotateY(dAngY); // Rotación continua en Y
  pushMatrix();   // Guarda la configuración del sstema
  
  drawAxes(500);  // Ejes de referencia

  //-------------------------------------------------------------------------------PLANO1
  rotateY(PI/2);
  plano(textura1, alto, ancho);
  rotateY(-PI/2);
  
  //-------------------------------------------------------------------------------PLANO2
  rotateX(PI/2);
  plano(textura2, ancho, alto);
  rotateY(-PI/2);
  //-------------------------------------------------------------------------------modelo3d
  scale(15*ancho/600);
  shape(modelo3D, 0, 0); 

}
void plano(PImage textura, float ancho, float alto){
  beginShape(QUADS);
  texture(textura);
  vertex(-ancho/2, -alto/2, 0, 0, 0);                         // Esquina superior izquierda
  vertex(ancho/2, -alto/2, 0, textura.width, 0);              // Esquina superior derecha
  vertex(ancho/2, alto/2, 0, textura.width, textura.height); // Esquina inferior derecha
  vertex(-ancho/2, alto/2, 0, 0, textura.height);             // Esquina inferior izquierda
  endShape();
}
void drawAxes(float size) {
  // Eje X (rojo)
  stroke(255, 0, 0);
  line(0, 0, 0, size, 0, 0); // Línea para el eje X

  // Eje Y (verde)
  stroke(0, 255, 0);
  line(0, 0, 0, 0, size, 0); // Línea para el eje Y

  // Eje Z (azul)
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, size); // Línea para el eje Z
}

void drawToroide(float r1, float r2) {
  int n1 = 40; // Número de segmentos a lo largo del círculo grande
  int n2 = 20; // Número de segmentos a lo largo del círculo pequeño

  for (int i = 0; i < n1; i++) {
    float theta1 = TWO_PI * i / n1;
    float theta2 = TWO_PI * (i+1) / n1;
    
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j <= n2; j++) {
      float phi = TWO_PI * j / n2;
      
      // Primer vértice
      float x1 = (r1 + r2 * cos(phi)) * cos(theta1);
      float y1 = (r1 + r2 * cos(phi)) * sin(theta1);
      float z1 = r2 * sin(phi);
      vertex(x1, y1, z1);
      
      // Segundo vértice
      float x2 = (r1 + r2 * cos(phi)) * cos(theta2);
      float y2 = (r1 + r2 * cos(phi)) * sin(theta2);
      float z2 = r2 * sin(phi);
      vertex(x2, y2, z2);
    }
    endShape();
  }
}

void keyPressed() {
  //Evento: presionar una tecla:
  if(key == CODED) {
    if(keyCode == UP) {
      horizontal = false;
      dAngX    = PI*vel/1024;   // velocidad de rotación alrededor del eje x
      dAngY    = 0;
    }
    if(keyCode == DOWN) {
      horizontal = false;
      dAngX    = -PI*vel/1024;   // velocidad de rotación alrededor del eje x
      dAngY    = 0;
    }
    if(keyCode == LEFT) {
      horizontal = true;
      dAngY    = PI*vel/1024;   // velocidad de rotación alrededor del eje x
      dAngX    = 0;
    }
    if(keyCode == RIGHT) {
      horizontal = true;
      dAngY    = -PI*vel/1024;   // velocidad de rotación alrededor del eje x
      dAngX    = 0;
    }
  }

  if (key == 'D' || key == 'd') {
    if(looping) {
      noLoop();
    } else {
      loop();
    }
  }

  if (key == 'E' || key == 'e') {
    //escala = escala + 1;
    ancho += 10;
    alto   = 400*ancho/600; 
  }
  
  if (key == 'W' || key == 'w') {
    //escala = escala - 1;
    ancho -= 10;
    alto   = 400*ancho/600; 
  }
  
  if (key == 'V' || key == 'v') {
    if (vel <= 32){
      vel    += 1;
      if (horizontal){
        if (dAngY < 0){
          dAngY   = -PI*vel/1024;
        }else{
          dAngY   = PI*vel/1024;
        }
      }else{
        if (dAngX < 0){
          dAngX   = -PI*vel/1024;
        }else{
          dAngX   = PI*vel/1024;
        }
      }
    }
  }
  if (key == 'L' || key == 'l') {
    if (vel > 1){
      vel -= 1;
      if (horizontal){
        if (dAngY < 0){
          dAngY   = -PI*vel/1024;   // velocidad de rotación alrededor del eje x
        }else{
          dAngY   = PI*vel/1024;   // velocidad de rotación alrededor del eje x
        }
      }else{
        if (dAngX < 0){
          dAngX   = -PI*vel/1024;   // velocidad de rotación alrededor del eje x
        }else{
          dAngX   = PI*vel/1024;   // velocidad de rotación alrededor del eje x
        }
      }
    }
  }
  
  if (key == 'R' || key == 'r') {
    setup();
  }
}
