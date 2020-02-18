class Object3D{

  PShape figura;
  
  Object3D(){
    figura= createShape();
    figura.beginShape(TRIANGLE_STRIP);
  }
  
  PShape getFigura(){return figura;}
}
