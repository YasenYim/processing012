
Agent[]as;

PVector center;

void setup() {
  size(1080, 1000);
  background(0);

  stroke(255, 5);

  as=new Agent[500];
  for (int i=0; i<as.length; i++) {
    as[i]=new Agent();
  }

  center=new PVector(0, 0);
}

void draw() {


  PVector mp= new PVector(mouseX, mouseY);
  PVector spd=PVector.sub(mp, center);
  spd.mult(0.1);
  center.add(spd);

  if (mousePressed) {
    background(0);
  }

  for (int i=0; i<as.length; i++) {
    as[i].update(center);
  }
}



class Agent {

  PVector pos;
  PVector prevPos;
  PVector spd; 
  float individualFactor;

  Agent() {
    pos=new PVector(random(width), random(height));
    prevPos=pos.copy();

    spd=new PVector(0, 0);    
    individualFactor=random(0.2, 5);
  }

  void update(PVector target) {
    PVector acc=PVector.sub(target, pos);
    acc.mult(0.01);
    acc.mult(individualFactor);

    spd.add(acc);
    pos.add(spd);

    spd.mult(0.96);

    line(pos.x, pos.y, prevPos.x, prevPos.y);

    prevPos=pos.copy();
  }
}
