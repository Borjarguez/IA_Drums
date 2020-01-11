import ddf.minim.*;

class Zona {
  int x_inicial, x_final, y_inicial, y_final;

  Zona(int x_inicial, int y_inicial, int x_final, int y_final) {
    this.x_inicial = x_inicial; 
    this.x_final = x_final;
    this.y_inicial = y_inicial;  
    this.y_final = y_final;
  }

  boolean checkZone(int x, int y) {
    return x >= x_inicial && x <= x_final && y >= y_inicial && y <= y_final;
  }

}
