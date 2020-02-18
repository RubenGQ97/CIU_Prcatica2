Object2D objetoInicial;
Object3D objetoFinal;
PShape figura;
float angulo=PI/20;
boolean menu=true;
boolean instrucciones;
int count;


void setup(){
  size (650 , 650 ,P3D);
  background(0);
  stroke(255);
  strokeWeight(2);
  objetoInicial= new Object2D();
  count=0;
}
void draw(){
  background(0);
  fill(255);
  if(menu && instrucciones==false )mostrarMenu();
  if(instrucciones)MostrarInstrucciones();
  if(objetoFinal==null){
    if(instrucciones==false)mostrarPuntos();   
  }else{
    
    translate(mouseX,mouseY-200,-200);

    shape(objetoFinal.getFigura());
  }
  
  
}


 void keyPressed(){
    if(key=='m'  || key=='M' )menu=!menu;
    if(key=='i' || key=='I')instrucciones=!instrucciones;
    if(key==ENTER && !objetoInicial.getPuntos().isEmpty() && instrucciones==false){
      objetoFinal= new Object3D();
      figura= objetoFinal.getFigura();
      figura.stroke(255);
      figura.strokeWeight(2);
      figura.fill(random(0,255),random(0,255),random(0,255));
      crearObjecto3D();
         figura.endShape();
    }
    if(key=='c'&& instrucciones==false || key=='C' && instrucciones==false){
      objetoFinal=null;
      objetoInicial.getPuntos().clear();
    }
  }
  
 void MostrarInstrucciones(){
   count++;
   background(255);
   fill(0);
     textSize(40);
     text("3D viewer",20,40);
     textSize(20);
     text("3D viewer es una aplicación para la creación de objetos 3D \nde manera muy simple.\n\nPara crear una figura solo debes dibujar la traza clicando\ncon el botón izquierdo del ratón, si te equivocas puedes\ndeshacer usando el click derecho \n\nUna vez finalices la traza solo debes pulsar 'ENTER' para \nvisualizar el resultado.\n\nPuedes limpiar el marco para dibujar otra pulsado la tecla 'C'\n\nPuedes ocultar el menu pulsando la tecla 'M'  ",20,100);
     textSize(15);
     text("Creado por Rubén Garcia Quintana",width/3,height-30);
       fill(0,143,57);
       textSize(25);
       text("Pulsa 'I' para salir",width/3,height-90);
       
     
 }
 
 
 void mostrarMenu(){
     textSize(40);
     text("3D viewer",20,40);
     textSize(15);
     text("M: Dejar de ver opciones",20,height-90);
     text("I: Ver informacion detallada",20,height-60);
     text("C: Limpiar trabajo",20,height-30);
 }
 
 void mousePressed(){
   if(instrucciones)return;
   if(mouseX>width/2 && objetoFinal==null && instrucciones==false){
       if(mouseButton == RIGHT)objetoInicial.removeLastPoint();
       if(mouseButton == LEFT)objetoInicial.newPoint();
   
   }
 }
 
 void mostrarPuntos(){
   ArrayList<Float> puntos = objetoInicial.getPuntos();
   rect(width/2, 0, 1, height);
   if(puntos.size()==3)point(puntos.get(0),puntos.get(1));
   if(puntos.size()>3){
     for(int i = 0; i < puntos.size() - 3; i=i+3){
        line(puntos.get(i), puntos.get(i+1), puntos.get(i+3), puntos.get(i+4));
      
   }
 }
}
 
 private class Object2D{
   ArrayList puntos = new ArrayList<Float>();
   
   void newPoint(){
     puntos.add((float)mouseX);
     puntos.add((float)mouseY);
     puntos.add((float)0.0);
 }
   ArrayList<Float> getPuntos(){return puntos;}
   void removeLastPoint(){
     if(puntos.isEmpty())return;
     puntos.remove(puntos.size()-1);
     puntos.remove(puntos.size()-1);
     puntos.remove(puntos.size()-1);
 }
   
 }
 
 
 void crearObjecto3D(){
   
   ArrayList<Float> puntos = objetoInicial.getPuntos();

   for(int i = 0; i < puntos.size() - 3; i=i+3){
     
       float x1=puntos.get(i)-300;
       float z1=puntos.get(i+2);       
       float x2=puntos.get(i+3)-300;
       float z2=puntos.get(i+5);       
       float x1_2;
       float z1_2;
       float x2_2;
       float z2_2;
       
       for(float j=0; j< 361; j+= angulo){         
         x1_2=x1 * cos(angulo) - z1 * sin(angulo);
         z1_2=x1 * sin(angulo) + z1 * cos(angulo);         
         x2_2=x2 * cos(angulo) - z2 * sin(angulo);
         z2_2=x2 * sin(angulo) + z2 * cos(angulo);         

         figura.vertex(x1_2, puntos.get(i+1), z1_2 );
         figura.vertex(x2_2, puntos.get(i+4),z2_2 );                  
          x1=x1_2;
          z1=z1_2;
          x2=x2_2;
          z2=z2_2;
          
       }
   }
 }
