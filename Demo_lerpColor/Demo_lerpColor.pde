
PVector left;
PVector right;
color cl, cr;
color cmix;
float ratio;

void setup() {
  size(1280, 720);

  left=new PVector(width*0.25, height/3);
  right=new PVector(width*0.75, height/3);

  cl=color(120, 130, 240);
  cr=color(130, 255, 20);
  cmix=cl;


}


void draw() {
  background(0);
  translate(0,-height/8);

  strokeWeight(4);
  for (float x=left.x; x<right.x; x++) {
    color c=lerpColor(cl, cr, map(x, left.x, right.x, 0, 1));
    stroke(c);
    point(x, left.y);
  }


  noStroke();
  fill(cl);
  ellipse(left.x, left.y, 30, 30);
  denoteColor(cl, left.x-70, left.y);


  fill(cr);
  ellipse(right.x, right.y, 30, 30);

  denoteColor(cr, right.x+70, right.y);
  
  ratio=constrain(map(mouseX,left.x,right.x,0,1),0,1);
  float xpos=map(ratio,0,1,left.x,right.x);
  
  cmix=lerpColor(cl,cr,ratio);
  fill(cmix);
  ellipse(xpos,height*0.667,40,40);
  denoteColor(cmix, xpos+70, height*0.667);
  
  strokeWeight(1);
  stroke(cmix);

  line(xpos,height*0.667,xpos,height/3+20);
  line(xpos,height/3+20,xpos-6,height/3+32);
  line(xpos,height/3+20,xpos+6,height/3+32);
  
  println(red(cmix),green(cmix),blue(cmix));
  writeFormula(width/2-400,height*0.9,cmix);
  
  
}

void denoteColor(color c, float x, float y) {
   textSize(24);
  fill(c);
  textAlign(CENTER, CENTER);
  text("R: "+int(red(c)), x, y-28);
  text("G: "+int(green(c)), x, y);
  text("B: "+int(blue(c)), x, y+28);
}

void writeFormula(float x,float y,color mc){
  textSize(36);
  textAlign(LEFT,CENTER);
  noStroke();
  
  fill(mc);
  text("MixCol",x,y);  

  rect(x,y-40,100,10);

  
  fill(150);
  text("= lerpColor(          ,           ,           );",x+120,y);
  
  textSize(24);
  text("lerp:   Linear Interpolation ", x+120,y+60);
  
  textSize(36);

  fill(cl);
  text("ColA",x+340,y);
  rect(x+340,y-40,100,10);
  
  fill(cr);
  text("ColB",x+480,y);
  rect(x+480,y-40,100,10);
  
  fill(255);
  text("Ratio",x+620,y);
  textSize(24);
  text(nf(ratio,0,3),x+620,y-40);
  
}
