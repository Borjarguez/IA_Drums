import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import ddf.minim.*;

Minim minim;
Capture video;
int espacio = 30, altura = 360, anchura = 282;
Zona[] zonas = new Zona[4];
int indicador_musica = 0;
int indicador_instrumento = 1;
AudioSample[] piano = new AudioSample[4];
AudioSample[] bateria = new AudioSample[4];
AudioSample[] guitarra = new AudioSample[4];
String[] instrumentos = {"Piano","Bateria","Guitarra"};

void setup() {
  minim = new Minim(this);
  size(1280, 720);
  video = new Capture(this, 1280, 720);

  video.start();
  initializeZones();
}

void draw() {
  video.loadPixels();
  image(video, 0, 0);
  noFill();
  initializeRectangles();

  for (int x = 29; x < video.width; x++) {
    for ( int y = 25; y < 400; y++) {
      int loc = x + y * video.width;
      color currentColor = video.pixels[loc];

      float red = red(currentColor);
      float blue = blue(currentColor);
      float green = green(currentColor);

      if (red > 250 && blue < 150 && green < 150) {
        if (zonas[0].checkZone(x, y)) {
          indicador_musica = 0;
          play(indicador_musica, indicador_instrumento);
        } else {
            if (zonas[1].checkZone(x, y)) {
              indicador_musica = 1;
              play(indicador_musica, indicador_instrumento);
          } else {
              if (zonas[2].checkZone(x, y)) {
                indicador_musica = 2;
                play(indicador_musica, indicador_instrumento);
              } else {
                  if (zonas[3].checkZone(x, y)) {
                    indicador_musica = 3;
                    play(indicador_musica, indicador_instrumento);
          }
        }
      }
    }
  }
}
  }
  
  textSize(100);
  text(instrumentos[indicador_instrumento], 450,675);
}

void initializeZones() {
  piano[0] = minim.loadSample("piano1.mp3"); //piano[0] = minim.loadSample("piano-iii0.mp3"); 
  piano[1] = minim.loadSample("piano2.mp3"); //piano[0] = minim.loadSample("piano-iii1.mp3"); 
  piano[2] = minim.loadSample("piano3.mp3"); //piano[0] = minim.loadSample("piano-ddd2.mp3"); 
  piano[3] = minim.loadSample("piano4.mp3"); //piano[0] = minim.loadSample("piano-ddd3.mp3"); 
  
  bateria[0] = minim.loadSample("platillo1.mp3");
  bateria[1] = minim.loadSample("tambor1.mp3"); 
  bateria[2] = minim.loadSample("tambor2.mp3");
  bateria[3] = minim.loadSample("platillo2.mp3");
  
  
  guitarra[0] =  minim.loadSample("guitarra1.mp3");
  guitarra[1] =  minim.loadSample("guitarra2.mp3");
  guitarra[2] =  minim.loadSample("guitarra3.mp3");
  guitarra[3] =  minim.loadSample("guitarra4.mp3");
  
  zonas[0] = new Zona(espacio, espacio, espacio+anchura, altura);
  zonas[1] = new Zona(espacio+anchura+espacio, espacio, anchura*2+espacio*2, espacio+altura);
  zonas[2] = new Zona(espacio+anchura*2+espacio*2, espacio, anchura*3+espacio*3, espacio+altura);
  zonas[3] = new Zona(espacio+anchura*3+espacio*3, espacio, anchura*4+espacio*4, espacio+altura);
}

void initializeRectangles() {
  stroke(255, 0, 0);
  strokeWeight(4);
  rect(espacio, espacio, anchura, altura); // x_inicio = 30, x_final = 312, y_inicio = 30, y_final = 360
  rect(espacio+anchura+espacio, espacio, anchura, altura); // x_inicio = 342, x_final = 624, y_inicio = 30, y_final = 360
  rect(espacio+anchura*2+espacio*2, espacio, anchura, altura); // x_inicio = 654, x_final = 936, y_inicio = 30, y_final = 360
  rect(espacio+anchura*3+espacio*3, espacio, anchura, altura); // x_inicio = 966, x_final = 1248, y_inicio = 30, y_final = 360
}

void movieEvent(Movie movie) {
  movie.read();
}

void captureEvent(Capture c) {
  c.read();
}

void play(int pista, int instrumento) {
    if(instrumento==0){
      piano[pista].trigger();
    }
    if(instrumento==1){
      bateria[pista].trigger();
    }
    if(instrumento==2){
      guitarra[pista].trigger();
    }
    
  }
  
void keyPressed(){
    
    if(key==CODED){
     if(keyCode == RIGHT && indicador_instrumento<2){
       indicador_instrumento++;
     }
     if(keyCode == LEFT && indicador_instrumento>0){
       indicador_instrumento--;
    }
  }
}
