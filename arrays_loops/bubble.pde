int BORDER = 50;
int BASE_CIRCLE_SIZE = 10;
int LIST_SIZE = 20;
int ANIMATION_SPEED = 5; //it is delay in milliseconds

IntList LIST;
bubble_reader BR;

int last_index, i = 0, j = 0;
boolean same_cycle = true;
boolean sorted = true;
int last_used_index = -1;

void setup(){
  size(1000,200);
  background(0);
  noStroke();
  colorMode(HSB); // to use hue for the rainbow effect
  
  LIST = new IntList();
  for(int i = 0; i < LIST_SIZE; i++){
    LIST.append(int(random(0,21)));
  }
  showArray();
  
  BR = new bubble_reader(LIST);
  BR.draw_step();
  
  last_index = LIST.size() - 1;
}

void showArray(){
  for(int i = 0; i < LIST_SIZE; i++){
    print(LIST.get(i), " ");
  }
  println();
}

void draw(){  // pure magic of nesting (sorry)
  delay(ANIMATION_SPEED);
  if (i < LIST.size()-1){ // i-loop if
    if (same_cycle){
      if (j < last_index){ // j-loop if
        if (LIST.get(j) > LIST.get(j+1)){
          //magic
          LIST.set(j, LIST.get(j) + LIST.get(j+1));
          LIST.set(j+1, LIST.get(j) - LIST.get(j+1));
          LIST.set(j, LIST.get(j) - LIST.get(j+1));
          sorted = false;
          last_used_index = j;
        }
        BR.draw_step();
        j++;
      } else {
        same_cycle = false;
      }
    } else if (!sorted){
      BR.draw_step();
      i++;
      j = 0;
      last_used_index = -1;
      sorted = true;
      same_cycle = true;
      showArray();
    } else {
      println("Done!");
      noLoop();
    }
  } else { //extra way to end just in case, tho should be not needed
    println("Done!"); 
    noLoop();
  }
  
  //for(int i = 0; i < LIST.size()-1; i++){
  //  int last_used_index = -1;
  //  boolean sorted = true;
    
  //  for (int j = 0; j < last_index; j++){
  //    if (LIST.get(j) > LIST.get(j+1)){
  //      //magic
  //      LIST.set(j, LIST.get(j) + LIST.get(j+1));
  //      LIST.set(j+1, LIST.get(j) - LIST.get(j+1));
  //      LIST.set(j, LIST.get(j) - LIST.get(j+1));
  //      sorted = false;
  //      last_used_index = j;
  //    }
  //    BR.draw_step();
  //  }
    
  //  last_index = last_used_index;
  //  BR.draw_step();  
    
  //  if (sorted){
  //    return;
  //  }
  //}
  
}

class bubble_reader{
  IntList current_step;
  float pixel_step;
  
  bubble_reader(IntList step){
    current_step = step;
    pixel_step = (width - 2*BORDER)/(LIST_SIZE); // (size of window without borders) / (amount of circles)
  }
  
  void draw_step(){
    background(0);
    for(int i = 0; i < current_step.size();i++){
      fill(color(LIST.get(i)*15,200,200));
      circle(BORDER+(pixel_step/2)+pixel_step*i,height/2,BASE_CIRCLE_SIZE+LIST.get(i));
    }
  }
}
