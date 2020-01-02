import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture video;
int espacio = 30, altura = 360, anchura = 282;

void setup() {
  size(1280, 720);
  video = new Capture(this, 1280, 720);

  video.start();
}

void draw() {
  image(video, 0, 0);
  noFill();
  stroke(255,0,0);
  strokeWeight(4);
  
  rect(espacio, espacio, anchura, altura);
  rect(espacio+anchura+espacio, 30, anchura, altura);
  rect(espacio+anchura*2+espacio*2, 30, anchura, altura);
  rect(espacio+anchura*3+espacio*3, 30, anchura, altura);
}

void movieEvent(Movie movie) {
  movie.read();
}

void captureEvent(Capture c) {
  c.read();
}
