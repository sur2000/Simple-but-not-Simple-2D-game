//2D game project 
//Simple but not Simple

class Player{
  //attributes (affected by arguments)
  int _PlayerX; //x position of the player object
  int _PlayerY; //y position of the player object
  int _PlayerSize; //size of the player object
  int _startY; //starting y position of the player object, used to determine where the "floor" is
  
  //attributes (not affected by arguments)
  int gravity = 6; //gravity that the player object is affected by
  int jumpCounter = 0; //counter used to determine how long the jump lasts
  int jumpCounterLimit = 20; //the limit for the jumpCounter
  boolean isJumping = false; //boolean used to trigger jump
  float jumpAngle = 0; //the angle at which player object is rotated
  float incrementAngle = PI/20; //the increment at which the jumpAngle will be changed when jumping
  boolean notInAir = true; //used to determine when player object is allowed to jump

  Player(int x, int y, int size){ //the Player object has three arguments x & y position and size
    //settings attributes to be equal to arguments that are passed in
    _PlayerX = x;
    _PlayerY = y;
    _PlayerSize = size;
    _startY = y; //used to determine when gravity is active
  }
  
  void jump(){ //makes the Player jump, this will be controlled by the person playing the game
    if(notInAir){ //if the player is on the ground == true
      isJumping = true; //sets boolean to true, which triggers the jump in "physics()" 
    }
  }
  
  void physics(){ //is put into the "draw()" to constantly update
    //gravity
    if(_PlayerY < _startY){ //if player object's y position is less than the starting y position
      _PlayerY += gravity; //increment player object's y position by gravity
      notInAir = false; //player object is not in the air, stopping "jump()" from working
    }else{
      notInAir = true; //if player is on the "floor" = true, allowing "jump()" to work
    }
    
    //jump triggered by "jump()" method
    if(isJumping){
      _PlayerY -= 12; //increments the y position of the player simulating a jump
      jumpCounter += 1; //increments the jumpCounter, which determines when to stop jumping 
    }
    if(jumpCounter >= jumpCounterLimit){ //when the counter reaches the limit the jump stops
      isJumping = false;
      jumpCounter = 0; //the counter is reset
    }
    //spin while in air
    if(!notInAir){
      jumpAngle += incrementAngle; //increments the jumpAngle, activating the rotate in "display()"
    }
    if(notInAir){
      jumpAngle = 0; //reset the jumpAngle so that the Player object is always even when on the "floor"
    }
  }
  
  //get methods to use when checking for collision with obstacles
  int getX(){ 
    return _PlayerX + _PlayerSize/2; //returns the location of the player's front coordinate
  }
  int getY(){
    return _PlayerY + _PlayerSize/2; //returns the location of the players's bottom coordinate
  }

  void display(){ //is put into "draw()" to constantly update
    pushMatrix(); //matrix necessary to contain the rotate transformation
    
    rectMode(CENTER); //set rectMode
    translate(_PlayerX, _PlayerY); //sets the 0,0 to be inside itself, used for rotating correctly
    rotate(jumpAngle); //is always rotating, but the jumpAngle is set to 0, which means no rotating
    
    //similar to the scenery function it has gradient colours
    strokeWeight(2);
    stroke(22, 85, 60);
    fill(53, 240, 165);
    rect(0, 0, _PlayerSize, _PlayerSize);
    
    popMatrix();//matrix necessary to contain the rotate transformation
  }
}
