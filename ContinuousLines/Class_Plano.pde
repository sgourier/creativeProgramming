class Plano {
  PVector pto1, pto2, pto3, plano, normal;
  String bandera, orientacion;

  Plano(PVector p1_, PVector p2_, String band, String or) {
    pto1 = p1_;
    pto2 = p2_;
    bandera = band;
    orientacion = or;
    if (bandera == "restar" && orientacion == "vertical") {
      pto3 = new PVector(pto2.x+20, pto2.y);
    } else if (bandera == "sumar" && orientacion == "vertical") {
      pto3 = new PVector(pto2.x-20, pto2.y);
    } else if (bandera == "restar" && orientacion == "horizontal") {
      pto3 = new PVector(pto2.x, pto2.y+20);
    } else if (bandera == "sumar" && orientacion == "horizontal") {
      pto3 = new PVector(pto2.x, pto2.y-20);
    }
    normal = PVector.sub(pto2, pto3);
    plano = PVector.sub(pto2, pto1);
    normal.normalize();
  }

}