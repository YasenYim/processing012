void setup(){
  size(400,400);
  background(255);
}

void draw(){  
}

void mousePressed(){
  if(mouseButton==LEFT){
    background(0,0,255);
  }
}

void keyPressed(){
  if(key=='r' || key=='R'){
    background(0);
  }
  if(key==' '){
    background(127);
  }
  if(keyCode==UP){    //UP,DOWN,LEFT,RIGHT
    background(255,255,0);
  }
}
  


    
