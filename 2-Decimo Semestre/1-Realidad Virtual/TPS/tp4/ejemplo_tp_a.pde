//TP4
//Ejercicio 2:

//Variables:------------------------------------------
int columnas, filas, escala, ancho, alto;
float anguloX, anguloY, dAngX, dAngY;
color c1, c2, c3, c4, c5;
boolean horizontal;
//-----------------------------------------------------

void setup()
{//Configuración:
  size(900, 700, P3D);
  escala = 20;
  ancho = 600;
  alto = 400;
  anguloX = PI/4;
  anguloY = PI/4;
  columnas = ancho/escala;
  filas = alto/escala;
  dAngX=PI/128;
  dAngY=PI/128;
  c1 = color(random(255),random(255),random(255));
  c2 = color(random(255),random(255),random(255));
  c3 = color(random(255),random(255),random(255));
  c4 = color(random(255),random(255),random(255));
  c5 = color(random(255),random(255),random(255));
  horizontal = true;
}

void draw()
{//Bucle de dibujo:

  background(0); //Borra el contenido actual y aplica fondo negro. 
  ambientLight(200, 100, 50);
  directionalLight(255, 255, 255, -1, 1, 0); // luz direccional desde la ezquina superior izquierda
  noFill();

  translate(width/2, height/2); //Traslada el origen de coordenadas al centro del ambiente.
  rotateX(anguloX);
  rotateY(anguloY);

  //PLANO 1:------------------------------------
  stroke(0); //líneas negras
  translate(-ancho/2, -alto/2); //trasladar el origen de coordenadas al extremo
  for(int i=0; i<columnas; i++) 
  {
    for(int j=0; j<filas; j++) 
    {
      if((i%2==0 && j%2!=0)||(i%2!=0 && j%2==0))
      {
        fill(c1);
      }
      else
      {
        fill(c2);
      }
      rect(i*escala, j*escala, escala, escala);
    }
  }
  //-------------------------------------------
  
  //CUERPO:---------------------
  stroke(255); //líneas blancas
  fill(c3);
  translate(ancho/2, alto/2, 0);
  sphere(10*escala);
  //----------------------------
  
  //PLANO 2:-------------------------------------
  stroke(0); //líneas negras
  translate(-ancho/2, 0, -alto/2);
  rotateX(PI/2); //a 90° del primer plano
  for(int i=0; i<columnas; i++) 
  {
    for(int j=0; j<filas; j++) 
    {
      if((i%2==0 && j%2!=0)||(i%2!=0 && j%2==0))
      {
        fill(c4);
      }
      else
      {
        fill(c5);
      }
      rect(i*escala, j*escala, escala, escala);
    }
  }
  //----------------------------------------------
  
  //Rotación permanente:
  if(!horizontal)
  {
    anguloX += dAngX;
  }
  else
  {
    anguloY += dAngY;
  }
  //--------------------
  
  //Información por pantalla:---------------
  textSize(20);
  fill(0);
  text("Realidad Virtual\nIng. Mecatr.\nD.E.R.S.", 12, 60, 5);
  //----------------------------------------
  
}

void keyPressed() 
{//Evento: presionar una tecla:
  // ROTAR CONJUNTO AL PRESIONAR FLECHAS
  if(key == CODED) 
  {
    if(keyCode == UP)
    {
      horizontal = false;
      dAngX=-PI/128;
      dAngY=0;
    }
    if(keyCode == DOWN)
    {
      horizontal = false;
      dAngX=PI/128;
      dAngY=0;
    }
    if(keyCode == LEFT)
    {
      horizontal = true;
      dAngY=-PI/128;
      dAngX=0;
    }
    if(keyCode == RIGHT)
    {
      horizontal = true;
      dAngY=PI/128;
      dAngX=0;
    }
  }

  if (key == 'D' || key == 'd') 
  {//detener o reanudar animación:
    if(looping)
    {
      noLoop();
    }
    else
    {
      loop();
    }
  }

  if (key == 'E' || key == 'e') 
  {//Aumentar escala
    escala = escala + 1;
  }
  
  if (key == 'R' || key == 'r') 
  {//Disminuir escala
    escala = escala - 1;
  }
  
  if (key == 'S' || key == 's') 
  {//Reiniciar
    setup();
  }
}
