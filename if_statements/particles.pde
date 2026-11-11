
int amount = 1000;
Bubble[] b = new Bubble[amount];
int maxSize = 6;
int minSize = 1;

void setup(){
	size(800,800);
	for (int i = 0; i< amount; i++){
		b[i] = new Bubble(random(0,width),random(0,height),random(minSize,maxSize));
	}
}

void draw(){
	background(0);
	
	for (int i = 0; i< amount; i++){
		b[i].update();
		b[i].render();
	}
}


class Bubble{
	PVector coords = new PVector(0,0);
	float size;
	float speed;
	float x_speed = random(-0.1, 0.1);

	Bubble(float pos_x, float pos_y, float sz){
		coords.x = pos_x;
		coords.y = pos_y;
		size = sz;
		speed = size/maxSize;
	}

	void update(){
		coords.y += speed;
		coords.x += x_speed;
		if (coords.y > height + maxSize){
			coords.y = -maxSize;
		}
		if (coords.y < -maxSize){
			coords.y = height+maxSize;
		}
		if (coords.x > width + maxSize){
			coords.x = -maxSize;
		}
		if (coords.x < -maxSize){
			coords.x = width + maxSize;
		}
	}

	void render(){
		float colour = map(size, minSize, maxSize, 64, 255);
		fill(colour);
		noStroke();
		circle(coords.x, coords.y, size);
	}
}
