//PROCESSING PONG

//Juego por Alberto Yúfera Daza 
//IES Vicente Aleixandre 2ºBachillerato Tecnológico
//Creado en la clase de programación y computación
//Versión 1.0 
//Enero 2017

//Declara la matriz de bloques de 3 filas y 7 columnas
int filas=4;
int columnas=7;

Bloque[] miBloque = new Bloque[columnas];
Bloque[] mi2Bloque =new Bloque [columnas];
Bloque[] mi3Bloque =new Bloque [columnas];

//variables pelota
int radio=10;

float posXpelota;
float posYpelota;

float VXpelota=5;
float VYpelota=2;

float velXmax=6;
float VXpelotaMax=5;
float VYpelotaMin=2;

//Colores de la pelota
float Rpaleta=random (0, 255);
float Gpaleta=random(0, 255);
float Bpaleta=random (0, 255);

//variables paleta
int posXpaleta=mouseX;
int posypaleta;

int largopaleta=100;
int anchopaleta=30;

//Colores de la paleta
float Rpelota=random(0, 255);
float Gpelota=random(0, 255);
float Bpelota=random (0, 255);

//Variable que almacena la diferencia de posiciones en X de la bola y la pala, para que salga en un ángulo determinado
float diferenciaPosicionesX;

//Inicia el juego en el menú
int pantalla=0;

int vidas=4;

int puntuacion=0;
//Indica el número de puntos necesarios para ganar
int ganar=21;

//color del fondo
int barWidth = 20;
int lastBar = -1;
//Setup------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void setup() {
  size(1000, 600);
  dibujarBloques();
  posypaleta=height-100;
    frameRate(100);

}
//Ejecuta todo-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void draw() {
  switch (pantalla) {
  case 0:
    pantallainicial();
    break;
  case 1:
    pantallajuego();
    break;
  case 2:
    Loose();
    break;
  case 3:
    win();
    break;
  }
}

//Diferentes pantallas-----------------------------------------------------------------------------------------------------------------------------------------------------------------

void pantallainicial() {
  fill(0);
  textSize(40);
  text("PRESS 'P' TO PLAY", width/2-170, height/2);

  fill(0);
  textSize(25);
  text("Game by Alberto Yúfera Daza", width/2-185, height*0.8);

  //Cambiar el color del fondo
  cambiarColorFondo();
}

void pantallajuego() {
  background(255);
  //rótulo de vidas 
  fill(0);
  stroke(0);
  textSize(30);
  text("Vidas: " + vidas, 50, height*0.9);

  //rótulo de puntos
  fill(0);
  stroke(0);
  textSize(30);
  text("Puntos: " + puntuacion, width-200, height*0.9);

  pelota();
  paleta();
  rebote();
  restarVida();
  iniciarBloques();
  puntuacion();
}

void Loose() {
  background(255);
  fill(0);
  stroke(0);
  textSize(50);
  text("'e' to replay 's' to exit", width/4, height/2);
}

void puntuacion() {
  if (puntuacion==ganar)
    pantalla=3;
}

void win() {
  background(255);

  //volver al menú o salir
  fill(0);
  stroke(0);
  strokeWeight(3);
  textSize(50);
  text("'e' to replay 's' to exit", width/4, height/2);

  //you win
  fill(0);
  textSize(50);
  text("YOU WIN", width/2-70, height/4);
}

//Elementos principales----------------------------------------------------------------------------------------

void paleta() {
  //Dibuja la paleta
  stroke(0);
  strokeWeight(3);
  fill( Rpelota, Gpelota, Bpelota);
  rect(posXpaleta, posypaleta, largopaleta, anchopaleta);

  //Varía su posición
  posXpaleta=mouseX-45;

  //Almacena la diferencia de posiciones
  diferenciaPosicionesX=posXpelota-posXpaleta-45;
}


void pelota () {
  //Dibuja la pelota
  stroke(0);
  strokeWeight(3);
  fill(Rpelota, Gpelota, Bpelota);
  ellipse(posXpelota, posYpelota, radio*2, radio*2);

  //Varia la posición de la pelota
  posXpelota=posXpelota+VXpelota;
  posYpelota=posYpelota+VYpelota;
}

//Interaciones y choques-----------------------------------------------------------------------------------------------------------------------------------------------------------------

void rebote () {
  // rebote de la pelota con la paleta
  if ( (posXpelota>=posXpaleta) && (posXpelota<=posXpaleta+largopaleta) && (posYpelota>=posypaleta-radio)) {
    reboteconPala();
    cambiarColorPelota();
    cambiarColorPaleta();
  }
  //Rebote de la pelota con las paredes
  if (posXpelota>=width-radio || posXpelota<=radio) {
    VXpelota=VXpelota*(-1);
    cambiarColorPelota();
  }  
  if (posYpelota<=radio) {
    VYpelota=VYpelota*(-1);
    cambiarColorPelota();
  }
}

void reboteconPala() {
  //Rebote con la paleta para que salga en un ángulo determinado
  VXpelotaMax=sqrt(sq(velXmax)+sq(VYpelotaMin));
  VXpelota= diferenciaPosicionesX*velXmax/(90/2+radio);

  if (diferenciaPosicionesX <0) {
    VYpelota= -(-diferenciaPosicionesX*(VYpelotaMin-VXpelotaMax)/(90/2+radio)+VXpelotaMax);
  } else {
    VYpelota= -(diferenciaPosicionesX*(VYpelotaMin-VXpelotaMax)/(90/2+radio)+VXpelotaMax);
  }
}

//Cambia el color de la pelota cuando choca con las paredes, bloques o paleta
void cambiarColorPelota() {
  Rpelota=random (0, 255);
  Gpelota=random(0, 255);
  Bpelota=random (0, 255);
}

//Cambia el color de la paleta cuando choca con la bola
void cambiarColorPaleta() {
  Rpaleta=random (0, 255);
  Gpaleta=random(0, 255);
  Bpaleta=random (0, 255);
}

//Cambia el color del fondo en función de las posición en X del ratón
void cambiarColorFondo() {
  colorMode(HSB, height, height, height);  

  int whichBar = mouseX / barWidth;
  if (whichBar != lastBar) {
    int barX = whichBar * barWidth;

    noStroke();
    fill(mouseY, height, height);
    rect(barX, 0, barWidth, height);
    lastBar = whichBar;
  }
}


void restarVida() {
  if (posYpelota>=height-radio) {
    vidas=vidas-1;
    posXpelota=width*0.5;
    posYpelota=height*0.7;
  }
  if (vidas==0) {
    pantalla=2;
    puntuacion=0;
  }
}

//Teclas-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void keyPressed () {
  if (key=='e') {
    pantalla=0;
    vidas=2;
    puntuacion=0;
    dibujarBloques();
    posXpelota=width*0.5;
    posYpelota=height*0.7;
  }
  if (key=='s') {
    exit();
  }
  if (key=='p') {
    pantalla=1;
    posXpelota=width*0.5;
    posYpelota=height*0.7;
  }
}

//Bloques-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void iniciarBloques() {
  for (int i=0; i< columnas; i++) {
    miBloque[i].dibujar();
    miBloque[i].quitarBloque();
  }

  for (int h=0; h< columnas; h++) {
    mi2Bloque[h].dibujar();
    mi2Bloque[h].quitarBloque();
  }
  for (int a=0; a< columnas; a++) {
    mi3Bloque[a].dibujar();
    mi3Bloque[a].quitarBloque();
  }
}

void dibujarBloques() {
  for (int i=0; i< columnas; i++) {
    miBloque[i]= new Bloque(((width/miBloque.length*i)+25), height/10, 1);
  }
  for (int h=0; h< columnas; h++) {
    mi2Bloque[h]= new Bloque(((width/mi2Bloque.length*h)+25), (height/10)*2, 1);
  }
  for (int a=0; a< columnas; a++) {
    mi3Bloque[a]= new Bloque(((width/mi3Bloque.length*a)+25), (height/10)*3, 1);
  }
}

class Bloque {
  int x, y, z, ancho, largo;

  Bloque (int posX, int posY, int estado) {  //constructor
    x=posX;
    y=posY;
    z=estado;
    ancho=50;
    largo=10;
  }

  void dibujar() {
    if (z==1) {
      rect(x, y, ancho, largo);
    }
  }

  void quitarBloque() {
    if (posXpelota>x-ancho/2-15 && posXpelota<x+ancho/2+15 && posYpelota>y-largo/2-15 && posYpelota<y+largo/2+15 && z==1) {
      z=0;
      VYpelota= VYpelota*(-1);
      puntuacion++;
    }
  }
}
