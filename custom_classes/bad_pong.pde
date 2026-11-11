
MousePlayer first;
EnemyPlayer second;
Ball theBall;

PVector[] surface;


void setup(){
  size(600,600);
  background(0);
  
  surface = new PVector[4];
  surface[0] = new PVector(1,0); // left side
  surface[1] = new PVector(0,1); // top side
  surface[2] = new PVector(-1,0); // right side
  surface[3] = new PVector(0,-1); // bottom side
  for(int i = 0; i < 4; i++){
    surface[i].normalize();
  }
  
  theBall = new Ball();
  first = new MousePlayer(height - 50);
  second = new EnemyPlayer(50, theBall);
}

void draw(){
  theBall.update();
  first.update();
  second.update();
  
  if (theBall.checkCollision(first.coords, first.size)){
    //println("BOTTOM");
    theBall.collisionEvent(3);
  } 
  if(theBall.checkCollision(second.coords, second.size)){
    //println("TOP");
    theBall.collisionEvent(1);
  } 
  if(theBall.position.x < 0){
    //println("LEFT");
    theBall.collisionEvent(0);
  } 
  if(theBall.position.x > width){
    //println("RIGHT");
    theBall.collisionEvent(2);
  }

if (theBall.position.y > height || theBall.position.y < 0){
  theBall.position = new PVector(width/2, height/2);
}
  
  background(0);
  theBall.display();
  first.display();
  second.display();
}

class Ball{
  PVector position;
  PVector direction;
  float speed = 4;
  float size = 10;
  float speed_increment = 0.1;
  
  //boolean justCollided = false; // I was trying to fix a bug but I don't wanna do it anymore
  
  
  Ball(){
    position = new PVector(width/2, height/2);
    direction = new PVector(2,1);
  }
  
  boolean checkCollision(PVector object_position, PVector object_size){
    if ((position.x + size/2) > (object_position.x - object_size.x/2) && (position.x - size/2) < (object_position.x + object_size.x/2)){
      if ((position.y + size/2) > (object_position.y - object_size.y/2) && (position.y - size/2) < (object_position.y + object_size.y/2)){
        return true;
      }
    } 
    return false;
  }
  
  void collisionEvent(int side){// direction - 2*(direction * surface[side]) * surface[side] = new reflected vector
    float dot = direction.dot(surface[side]); 
    PVector mult = new PVector (surface[side].x, surface[side].y);
    mult.mult(2*dot); // I hate that you can't just do things with vectors, you need to call methods(
    direction.sub(mult); 
    
    if (side%2 == 1){
      speed += speed_increment;
    }
  }
  
  void update(){
    direction.normalize();
    position = position.add(direction.mult(speed));
  }
  
  void display(){
    circle(position.x, position.y, size);
  }
}

class Player{
  PVector coords;
  PVector size;
  Player(float y_coord){
    coords = new PVector(width/2, y_coord);
    size = new PVector(80,10);
  }
  
  void update(){
  
  }
  
  void display(){
    rect(coords.x - size.x/2, coords.y, size.x, size.y);
  }
}

class MousePlayer extends Player{
  
  MousePlayer(float y_coord){
    super(y_coord);
  }
  
  void update(){
    super.update();
    coords.x = mouseX;
  }
}

class EnemyPlayer extends Player{
  Ball ball;
  float level;
  float speed = 0.1;
  
  EnemyPlayer(float y_coord, Ball bal){
    super(y_coord);
    level = y_coord;
    
    ball = bal;
  }
  
  void update(){
    super.update();
    coords.lerp(ball.position, speed);
    coords.y = level;
  }
}
