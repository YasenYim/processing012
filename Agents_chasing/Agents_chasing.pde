

int count=0;      //timer for clearing screen
int num=80;        //how many agents

color[]colorPool;      //all available colors put here
Agent[]agents;      //all agents

void setup() {
  size(720, 720);

  colorPool=new color[8];      //color quantity

  agents=new Agent[num];      //create array for agents
  reset();        //reset everything
}

void draw() {
  for (int i=0; i<num; i++) {    //all agents moves and leave a trail
    agents[i].update();
    agents[i].display();
  }

  count++;      //update timer
  if (count>600) {      //clear and reset for every 600 frames
    count=0;
    reset();
  }
}

void mousePressed() {      //click mouse to reset
  reset();
}

void reset() {
  for (int i=0; i<colorPool.length; i++) {    //randomly generate colors and put them in the color pool 
    colorPool[i]=color(random(100), random(100, 255), random(100, 255));
  }

  background(0);
  for (int i=0; i<num; i++) {      //reset all agents
    PVector spd=PVector.random2D();
    spd.mult(random(2, 4));
    agents[i]=new Agent(random(width), random(height), spd.x, spd.y, i);
    agents[i].findPair();      //find chasing target
  }
}


color getRandomColor() {      //select a random color from pool
  return colorPool[int(random(colorPool.length))];
}

class Agent {
  PVector pos;      //position
  PVector spd;      //speed
  PVector acc;      //acceleration

  int pair;      //the index of chasing target
  int index;      //the position of current object in the array
  color col;        //color
  int step=30;      //marching speed

  Agent(float x, float y, float xs, float ys, int idx) {  //constructor
    pos=new PVector(x, y);
    spd=new PVector(xs, ys);
    acc=new PVector();

    index=idx;
    col=getRandomColor();
  }
  
  void findPair() {      //select a random agent as target
    pair=(index+int(random(1, num)))%num;
  }

  void update() {    //moves toward target agent, elastic effect
    acc=PVector.sub(agents[pair].pos, pos);
    acc.mult(0.001);

    spd.add(acc);
    pos.add(spd);
    spd.mult(0.95);
  }

  void display() {
    for (int i=0; i<step; i++) {    //how many steps repeat in a single frame
      float angle=random(TWO_PI);

      PVector sub=PVector.sub(pos, agents[pair].pos);    //distance to target
      sub.mult(0.5);
      PVector add=PVector.add(pos, agents[pair].pos);    //sum
      add.mult(0.5);
      PVector dd=PVector.mult(sub, sin(angle));    //calculate the vertex
      dd.add(add);

      stroke(col, 20);
      point(dd.x, dd.y);    //render the point

      dd=PVector.mult(sub, -sin(angle));
      dd.add(add);

      stroke(col, 30);
      point(dd.x, dd.y);
    }
  }
}
