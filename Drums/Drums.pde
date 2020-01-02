import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import ddf.minim.*;

Minim minim;
Capture video;
int espacio = 30, altura = 360, anchura = 282;
Zona[] zonas = new Zona[4];
int indicador_musica = 0;

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
          zonas[0].play(indicador_musica);
        } else if (zonas[1].checkZone(x, y)) {
          zonas[1].play(indicador_musica);
        } else if (zonas[2].checkZone(x, y)) {
          zonas[2].play(indicador_musica);
        } else if (zonas[3].checkZone(x, y)) {
          zonas[3].play(indicador_musica);
        }
      }
    }
  }
}

void initializeZones() {
  AudioSample[] audios0 = {minim.loadSample("i0.mp3"), minim.loadSample("i1.mp3"), minim.loadSample("d2.mp3"), minim.loadSample("d3.mp3")};
  AudioSample[] audios1 = {minim.loadSample("ii0.mp3"), minim.loadSample("ii1.mp3"), minim.loadSample("dd2.mp3"), minim.loadSample("dd3.mp3")};
  AudioSample[] audios2 = {minim.loadSample("iii0.mp3"), minim.loadSample("iii1.mp3"), minim.loadSample("ddd2.mp3"), minim.loadSample("ddd3.mp3")};
  AudioSample[] audios3 = {minim.loadSample("iiii0.mp3"), minim.loadSample("iiii1.mp3"), minim.loadSample("dddd2.mp3"), minim.loadSample("dddd3.mp3")};

  zonas[0] = new Zona(espacio, espacio, anchura, altura, audios0);
  zonas[1] = new Zona(espacio+anchura+espacio, espacio, anchura*2+espacio*2, altura, audios1);
  zonas[2] = new Zona(espacio+anchura*2+espacio*2, espacio, anchura*3+espacio*3, altura, audios2);
  zonas[3] = new Zona(espacio+anchura*3+espacio*3, espacio, anchura*4+espacio*4, altura, audios3);
}

void initializeRectangles() {
  stroke(255, 0, 0);
  strokeWeight(4);
  rect(espacio, espacio, anchura, altura); // x_inicio = 30, x_final = 312, y_inicio = 30, y_final = 390
  rect(espacio+anchura+espacio, 30, anchura, altura); // x_inicio = 342, x_final = 624, y_inicio = 30, y_final = 390
  rect(espacio+anchura*2+espacio*2, 30, anchura, altura); // x_inicio = 654, x_final = 936, y_inicio = 30, y_final = 390
  rect(espacio+anchura*3+espacio*3, 30, anchura, altura); // x_inicio = 966, x_final = 1248, y_inicio = 30, y_final = 390
}

void movieEvent(Movie movie) {
  movie.read();
}

void captureEvent(Capture c) {
  c.read();
}
