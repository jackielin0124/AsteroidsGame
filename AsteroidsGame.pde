//your variable declarations here
private SpaceShip bob;
private Asteroid rock;
Star[] sky=new Star[100];

public void setup() 
{
  //your code here
  size(600, 600);
  for(int i=0; i<sky.length; i++){
    sky[i]=new Star();
  }
  bob=new SpaceShip();
  rock=new Asteroid();
  
}

public void draw() 
{
  background(0);
  for(int i=0; i<sky.length; i++){
    sky[i].show();
  }
  bob.move();
  bob.show();
  rock.show();
}

public void keyPressed()
{
  if(keyCode==37){bob.rotate(-10);}
  if(keyCode==39){bob.rotate(10);}
  if(keyCode==38){bob.accelerate(0.3);}
  if(keyCode==40){bob.accelerate(-0.3);}
  if(key=='f'){bob.hyperSpace();}
}




class Asteroid extends Floater{
  private int rotSpeed;
  public void Asteroid(){
    if(Math.random()<0.5){
      rotSpeed=(int)(Math.random()*7);
    }
    else 
      rotSpeed=(int)(Math.random()*7)-6;
    myCenterX=(Math.random()*600);
    myCenterY=(Math.random()*600);
    myPointDirection=(Math.random()*2*PI);
    myDirectionX=(Math.random()*600);
    myDirectionY=(Math.random()*600);
    myColor=100;
    corners=8;
    xCorners=new int[corners];
    yCorners=new int[corners];
    xCorners[0] = -10;
    yCorners[0] = 0;
    xCorners[1] = -8;
    yCorners[1] = 6;
    xCorners[2] = 0;
    yCorners[2] = 10;
    xCorners[3] = 5;
    yCorners[3] = 3;
    xCorners[4] = 9;
    yCorners[4] = 0;
    xCorners[5] = 7;
    yCorners[5] = -8;
    xCorners[6] = 2;
    yCorners[6] = -8;
    xCorners[7] = -6;
    yCorners[7] = -10;
  }
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY=y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection=degrees;}
  public double getPointDirection(){return myPointDirection;}
}





class SpaceShip extends Floater  
{   
  public void SpaceShip(){
    myCenterX=300;
    myCenterY=300;
    myPointDirection=0;
    myDirectionX=0;
    myDirectionY=0;
    myColor=255;
    corners=4;
    xCorners=new int[corners];
    yCorners=new int[corners];
    xCorners[0] = -8;
    yCorners[0] = -8;
    xCorners[1] = 16;
    yCorners[1] = 0;
    xCorners[2] = -8;
    yCorners[2] = 8;
    xCorners[3] = -2;
    yCorners[3] = 0;
  }

  public void hyperSpace(){
    myCenterX=Math.random()*600;
    myCenterY=Math.random()*600;
    myDirectionX=0;
    myDirectionY=0;
  }

  //completing set and get functions
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY=y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection=degrees;}
  public double getPointDirection(){return myPointDirection;}
}





abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 





class Star
{
  private int mySize;
  private double myX, myY;
  public Star(){
    myX=Math.random()*600;
    myY=Math.random()*600;
    mySize=(int)(Math.random()*3)+1;
  }
  public void show(){
    ellipse((float)myX,(float)myY,mySize,mySize);
  }
}
