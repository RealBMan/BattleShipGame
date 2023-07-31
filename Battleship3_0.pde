import processing.sound.*;

SoundFile file;

SoundFile sound;

int screen;

int wins;

int lastwins;

PFont bestFont;

PImage bestimage;

PImage water;

PImage win;

PImage loose;

PImage royale;

PImage bang;

PImage war;

PImage enemy;

PImage setting;

PImage point;

int scorePlayer, computerScore;

int [][] ship = new int [10][10];

int clicked, clickedY;

int count, countY;

int shipR, shipL;

int fade;

int difficulty;

String [] data = new String[20];

String lastname;

String name = "";

void setup() {

  size(800, 600);

  screen = 6;//Sets the game to the deafualt start screen once opened

  difficulty = 7;//Sets the game to default easiest difficulty 

  wins = 0;//Restes the win values

  //defaultName = "Matt";

  leader();//Runs data saving code for the game users


  /*
  
   0- Main menu
   1- Settings
   2- Main game
   3- Win screen
   4- loose screen
   
   */

  file = new SoundFile(this, "explosion.mp3"); //Declaring Sound file for explosions

  sound = new SoundFile(this, "click.mp3");// Declaring Sound file for button clicks

  bestFont = createFont("Impact", 20);//Font of the whole program

  textFont(bestFont);//Calling the font previously declared

  //Declaring all umages used within the program

  bestimage = loadImage("ship.jpg");// Loads the image for the main screen and menu background

  win = loadImage("win.jpg");// Loads the image for the win background

  loose = loadImage("loose.jpg");// Loads the image for the loose background 

  royale = loadImage("royale.png");// Loads the image for the win text

  water = loadImage("water.jpg");// Loads the image for the water background

  bang = loadImage("bang.png");// Loads the image for the explosion

  war = loadImage("war.png");// Loads the image for the player ship

  enemy = loadImage("enemy.png");// Loads the image for the enemy ship

  setting = loadImage("setting.png");// Loads the image for the setting screen 

  point = loadImage("point.png");// Loads the image for the Mouse Aimer 

  pointer();//Runs the code via a function for the mouse aimer and pinter assignments 

  /*for (int i = 0; i < 5; i = i+1) {//enemey ship placement
   
   clicked = floor(random(7));
   clickedY = floor(random(6));
   
   while (ship[clicked][clickedY] != 0) {
   clicked = floor(random(7));
   clickedY = floor(random(6));
   }
   ship[clicked][clickedY] = 1;
   }*/

  fade = 255;//Fade value for Place ship and Play now text. Sets it back tio intial value. 
}

void draw() {

  background(0, 250, 10);//This sets the background colour

  if (screen ==0) {//Main menu

    background(0, 50, 10);//This sets the background colour

    image(bestimage, 0, 0, width, height);//This is the command that sets the background to an image

    fill(0);//Colour of the text

    textSize(40);

    text("BattleShip: Dare To Desrtoy", 175, 100);//This is the text command that draws the text on screen

    fill(0);

    rect(205, 235, 150, 100, 20); //Draws New Game button

    rect(445, 235, 150, 100, 20); // Draws Settings button

    rect(325, 375, 150, 100, 20); // Draws Quit button

    fill(255);//Colour of the button text

    textSize(20);

    text("New Game", 225, 290);//Draws text on screen for the button

    text("Settings", 455, 290);//Draws text on screen for the button

    text("Quit", 350, 430);//Draws text on screen for the button

    if (mouseX > 205 && mouseX < 355 && mouseY > 235 &&  mouseY < 335) {//New game button outline

      fill(250, 70);//Tint of the button

      rect(193, 223, 175, 125, 20);//Draws the outline of the button
    } else if (mouseX > 445 && mouseX < 550 && mouseY > 235 &&  mouseY < 335) {//Settings button outline

      fill(250, 70);//Tint of the button

      rect(433, 223, 175, 125, 20);//Draws the outline of the button
    } else if (mouseX > 325 && mouseX < 475 && mouseY > 375 &&  mouseY < 505) {//Quit button outline

      fill(250, 70);//Tint of the button

      rect(313, 363, 175, 125, 20);//Draws the outline of the button
    }
  } else if (screen == 1) {//Settings

    background(200, 250, 10);//Sets the background colour

    fill(255);//Colour of the button text

    //These rect functions draw the various rectangles on the screen such as the buttons and the title

    rect(650, 450, 100, 50, 20);//Buttons at the bottom right of the page

    rect(650, 515, 100, 50, 20);//Buttons at the bottom right of the page

    rect(65, 175, 150, 100, 20);//Difficulty Settings button

    rect(65, 300, 150, 100, 20);//Difficulty Settings button

    rect(65, 425, 150, 100, 20);//Difficulty Settings button

    rect(122, 20, 550, 70, 20);//Title rectangle

    image(setting, 350, 170, 300, 300);//Draws an image in the screen

    fill(0);//text colour

    textSize(15);

    text("Main Menu", 665, 480);//The button text

    text("Quit", 675, 545);//The button text

    text("Beginner mode", 75, 230);//The difficulty button text

    text("Semi - Pro mode", 75, 350);//The difficulty button text

    text("Impossible mode", 75, 480);//The difficulty button text

    textSize(40);//Text size for title

    text("Settings: Choose Your Mode", 160, 75);//The title text for the settings page


    if (mouseX > 650 && mouseX < 750 && mouseY > 450 &&  mouseY < 500) {//Main menu button outline

      fill(0, 0, 0, 30);//The colour for the button outline

      rect(643, 445, 115, 60, 20);//The dimesions of the button outline
    } else if (mouseX > 650 && mouseX < 750 && mouseY > 515 &&  mouseY < 565) {//Quit button outline

      fill(0, 0, 0, 30);//The colour for the button outline

      rect(643, 510, 115, 60, 20);//The dimesions of the button outline
    } else if (mouseX > 65 && mouseX < 215 && mouseY > 175 &&  mouseY < 275) {//SuperEasy button outline

      fill(0, 0, 0, 30);//The colour for the button outline

      rect(53, 163, 175, 125, 20);//The dimesions of the button outline
    } else if (mouseX > 65 && mouseX < 215 && mouseY > 300 &&  mouseY < 400) {//Easy button outline

      fill(0, 0, 0, 30);//The colour for the button outline

      rect(53, 285, 175, 125, 20);//The dimesions of the button outline
    } else if (mouseX > 65 && mouseX < 215 && mouseY > 425 &&  mouseY < 525) {//Hard button outline

      fill(0, 0, 0, 30);//The colour for the button outline

      rect(53, 412, 175, 125, 20);//The dimesions of the button outline
    }
  } else if (screen == 2) {//Main game

    background(156, 211, 219);//Sets the background colour

    image(water, 0, 0, width, height);//Sets the image of the game screen

    stroke (10);//The thickness of the lines

    for (int y = 0; y < 6; y = y + 1) {//This is the for loop that creates the grid. The for loop draws 6 boxes wide and 7 boxes down

      for (int i = 0; i < 7; i = i + 1) {//This makes sure the code runs 7 times.

        //Number Assignments for each grid which allows to control what happens to ships after they have been hit and where specific ships are placed
        if (ship[i][y] == 0) {
        } else  if (ship[i][y] == 0) {//empty water. If the grid is empty water then it draws what is in the if statement
          fill(0);//These draw values dont actually appear as the background covers them it was more or less to check that both the if statement and for loop were working
          rect(i*100, y*100, 100, 100);//These draw values dont actually appear as the background covers them it was more or less to check that both the if statement and for loop were working
        } else  if (ship[i][y] == 1) {//enemy ship.  If the grid is enemy ship then it draws what is in the if statement
          //image(enemy, i*100, y*100 - 20, 100, 100);
        } else  if (ship[i][y] == 2) {//player ship.  If the grid is player ship then it draws what is in the if statement
          image(war, i*100, y*100 + 30, 100, 50);//This draws the player ship
        } else  if (ship[i][y] == 3) {//exploded empty water. If the grid is exploded empty water then it draws what is in the if statement
          fill(100, 255, 60);//These draw values dont actually appear as the background covers them it was more or less to check that both the if statement and for loop were working
          rect(i*100, y*100, 100, 100);//These draw values dont actually appear as the background covers them it was more or less to check that both the if statement and for loop were working
        } else  if (ship[i][y] == 4) {//exploded enemy ship. If the grid is exploded enemy ship then it draws what is in the if statement
          image(bang, i*100, y*100 + 10, 90, 90);//This draws an explosion each time a ship has been exploded
        } else  if (ship[i][y] == 5) {//exploded player ship. If the grid is exploded player ship then it draws what is in the if statement
          image(bang, i*100, y*100 + 10, 90, 90);//This draws an explosion each time a ship has been exploded
        }
       
        if (difficulty == 7) { //This code means that if the difficulty is set to 7 (Easy mode) then enemy ships will appear on screen otherwise they would not

          if (ship[i][y] == 1) {//This code means that the enemy ships will grpahically appear on screen if the difficulty is set to easy mode

            image(enemy, i*100, y*100 - 20, 100, 100);//This is code responsible for drawing the enemy ships
          }
        }

        fill(156, 211, 219, 0);//Initial background coolour

        strokeWeight(5);//Controls the thickness of the grid lines 

        rect(i * 100, y * 100, 100, 100);//The rectangle draw code. This serves as the basis of the whole game as it draws the grid

        fill(255);//Colour for the grid coordnates

        textSize(20);//Grid text size

        //Grid coordinates

        text(i + "," + y, 10 + i * 100, 25 + y * 100);//Displays the grid coordinates on the grid
      }
    }

    //Fade value for text. This controls how long text stays on screen for when is tells the player to play
    fade = fade - 5;

    if ( fade < 0 ) {//Fadeaway code for top text

      fade = 0;//This sets the fade value to zero if it eventually goes below 0
    }

    fill(255, fade);//Fadeaway colour, The inisitla colour is white and fade to black. The fade vairiable in that piece of code allows the text to fade

    textSize(50);//Text size for play text

    text("Now Play", 275, 70);//This is the text that indicagtes the player when they can play

    fill(255);//

    textSize(20);//The size of the button text

    strokeWeight(2);//The weight the stroke lines around buttons

    rect(695, 450, 100, 50, 20);//Menu  and quit buttons

    rect(695, 515, 100, 50, 20);//Menu and quit buttons

    /*rect(650,385,100,50,20);
     
     rect(650,320,100,50,20);
     
     rect(650,255,100,50,20);
     
     rect(650,190,100,50,20);*/

    fill(255);//The colour of the player and enemy score box

    rect(695, 65, 100, 105, 20);//The player and enemy score box

    fill(0);//The colour for the text

    textSize(22);

    text("Player : " + scorePlayer, 705, 100);//Displays the players score in the mini scoreboard on the side

    text("Comp : " + computerScore, 705, 150);//Displays the AI's socre in the mini scoreboard on the side

    fill(0);//the colour of the button text

    textSize(15);

    text("Main Menu", 705, 480);//Button text

    text("Quit", 705, 545);//Button text

    /* text("loose" , 675, 415);
     
     text("Win", 675, 350);
     
     text("Level 3", 675, 285);
     
     text("Level 2", 675, 220);*/

    if (mouseX > 695 && mouseX < 795 && mouseY > 450 &&  mouseY < 500) {//Menu button outline

      fill(0, 0, 0, 30);//The colour and tint of the outline

      rect(687, 445, 115, 60, 20);//Draws the button outline
    } else if (mouseX > 695 && mouseX < 795 && mouseY > 515 &&  mouseY < 565) {//Quit button outline

      fill(0, 0, 0, 30);//The colour and tint of the outline

      rect(687, 510, 115, 60, 20);//Draws the button outline
    }/* else if (mouseX > 650 && mouseX < 750 && mouseY > 385 && mouseY < 435){
     
     fill(0,0,0,30);
     
     rect(643, 380, 115,60,20);
     
     } else if (mouseX > 650 && mouseX < 750 && mouseY > 320 && mouseY < 370){
     
     fill(0,0,0,30);
     
     rect(643, 315, 115,60,20);
     
     } else if (mouseX > 650 && mouseX < 750 && mouseY > 255 && mouseY < 305){
     
     fill(0,0,0,30);
     
     rect(643, 250, 115,60,20);
     
     }else if (mouseX > 650 && mouseX < 750 && mouseY > 190 && mouseY < 240){
     
     fill(0,0,0,30);
     
     rect(643, 185, 115,60,20);
     
     }*/
  } else if (screen == 3) {//Win 

    //This sets the cursor to the regular cursor 
    cursor(0);

    background(0, 50, 0);//initial background colour

    image(win, 0, 0, 850, height);//Sets the image background of the screen

    image(royale, 100, 0, 575, 375);//This is the win message image

    fill(255);//The colour of the text 

    textSize(55);

    text("You Win", 325, 570);//Displays the win message on the win screen

    fill(255);

    rect(650, 450, 100, 50, 20);//draws rectanlge for the button

    rect(650, 515, 100, 50, 20);//draws rectangle for the button

    //rect(650, 385, 100, 50, 20);

    fill(0);//colour of the text

    textSize(15);

    text("Main Menu", 665, 480);//Button text

    text("Quit", 675, 545);//Button text

    //text("Back", 675, 415);

    if (mouseX > 650 && mouseX < 750 && mouseY > 450 &&  mouseY < 500) {//Menu button outline

      fill(0, 0, 0, 30);//The colour and tint of the outline

      rect(643, 445, 115, 60, 20);//The colour and tint of the outline
    } else if (mouseX > 650 && mouseX < 750 && mouseY > 515 &&  mouseY < 565) {//Quit button outline

      fill(0, 0, 0, 30);//The colour and tint of the outline

      rect(643, 510, 115, 60, 20);//The colour and tint of the outline
    } /*else if (mouseX > 650 && mouseX < 750 && mouseY > 385 && mouseY < 435) {
     
     fill(0, 0, 0, 30);
     
     rect(643, 380, 115, 60, 20);
     }*/
  } else if (screen == 4) {//Loose

    //This sets the cursor to the regular cursor 
    cursor(0);

    background(200, 250, 210);//Initial background of the screen 

    image(loose, 0, 0, width, height);//Sets the image background of the screen

    fill(0);//The colour of the text

    textSize(55);

    text("You loose", 320, 70);//Displays the loose messgae on the screen

    text("Your Ships Were Destroyed", 120, 150);//Displays the loose messgae on the screen

    fill(255);//Colour of the rectangle

    rect(650, 450, 100, 50, 20);//draws the rectangle for the button

    rect(650, 515, 100, 50, 20);//draws the rectangle for the button

    // rect(650, 385, 100, 50, 20);

    fill(0);//The colour of the text

    textSize(15);

    text("Main Menu", 665, 480);//Button text

    text("Quit", 675, 545);//Button text

    //text("Back", 675, 415);

    if (mouseX > 650 && mouseX < 750 && mouseY > 450 &&  mouseY < 500) {//Menu button outline

      fill(250, 170);//The colour and tint of the outline

      rect(643, 445, 115, 60, 20);//The colour and tint of the outline
    } else if (mouseX > 650 && mouseX < 750 && mouseY > 515 &&  mouseY < 565) {//Quit button outline

      fill(250, 170);//The colour and tint of the outline

      rect(643, 510, 115, 60, 20);//The colour and tint of the outline
    } /*else if (mouseX > 650 && mouseX < 750 && mouseY > 385 && mouseY < 435) {
     
     fill(250, 170);
     
     rect(643, 380, 115, 60, 20);
     }*/
  } else if (screen == 5) {//PLayer HSip placement screen

    //This sets the cursor to the aim cursor to aid the players while playing the game

    cursor(point, 20, 20);//Sets the mouse cursor to aimer 

    background(156, 211, 219);//Initial background colour

    image(water, 0, 0, width, height);//The background image placement text

    stroke (10);

    //This is the mouse coordinates for the placement of the ship. Mouse index location
    count = mouseX/100;

    countY = mouseY/100;

    for (int y = 0; y < 6; y = y + 1) {//This for loop creates an empty identical grid for the placement of ships

      for (int i = 0; i < 7; i = i + 1) {//THis for loop ensures the code for the appropriate amount of time which is 7.

        if (ship[i][y] == 2) {//player ship placement code for users to choose
        
          image(war, i*100, y*100 + 30, 100, 50);//This is the image of the ship
        } 

        fill(156, 211, 219, 0);//.Initial colour of the grid which was replaced by the water

        strokeWeight(5); // weight of the grid lines

        rect(i * 100, y * 100, 100, 100);//Grid rectangle thst draw within the for loop so the full grid

        fill(255);//Colour of the of the grid coordinate text

        textSize(20);

        text(i + "," + y, 10 + i * 100, 25 + y * 100);//This draws the grid coordinagtes on the grid
      }
    }

    //This is the code that controls the disspapearing of the text after a period of time for the player to place their ships
    fade = fade - 5;

    if ( fade < 0 ) {//Fade away value

      fade = 0;//Sets the fade value to 0 if it eventually becomes less than 0
    }

    fill(255, fade);//This is the initial colour of the fading text with "fade" as the tint which allows it to fade

    textSize(50);  

    text("Place your ships", 175, 70);//etxt that lets the player know when they can place their ships

    fill(255);//TExt colour

    textSize(20);

    strokeWeight(2);//weight of the button outlines 

    fill(255);

    rect(695, 450, 100, 50, 20);//draws enemy and exit buttons

    rect(695, 515, 100, 50, 20);//draws enemy and exit buttons

    fill(255);//colour of the scoreboard

    rect(695, 65, 100, 105, 20);//player and computer scoreboard

    fill(0);//colour of the text

    textSize(22);

    text("Player : " + scorePlayer, 705, 100);// It shows the players score and a default name which is player
    
    text("Comp : " + computerScore, 705, 150);//Shows the score for the computer in the scoreboard.

    fill(0);//Text colour

    textSize(15);

    text("Main Menu", 705, 480);//Button text

    text("Quit", 705, 545);//Button text

    if (mouseX > 695 && mouseX < 795 && mouseY > 450 &&  mouseY < 500) {//Menu button outline

      fill(0, 0, 0, 30);//The colour and tint of the outline

      rect(687, 445, 115, 60, 20);//The colour and tint of the outline
    } else if (mouseX > 695 && mouseX < 795 && mouseY > 515 &&  mouseY < 565) {//Quit button outline

      fill(0, 0, 0, 30);//The colour and tint of the outline

      rect(687, 510, 115, 60, 20);//The colour and tint of the outline
    }
  } else if (screen == 6) {//Sign in Screen

    image(bestimage, 0, 0, width, height);//Image background

    fill(0);//Text colour 

    textSize(40);

    text("BattleShip: Dare To Desrtoy", 175, 100);//Text title

    fill(255);//The user input rectangle colour

    rect(174, 140, 390, 50);//The user input rectangle

    fill(0);//Text colour 

    textSize(30);

    text("username: " + name + " | ", 45, 175); //The code that allows the user input their name

    textSize(40);

    fill(255);//Rectangle colour

    rect(15, 240, 450, 150, 20);//Draws a rectangle which is a background for the mini leaderboard

    fill(0);//Text colour

    text("Last user score ", 45, 300);//Leaderboard text

    text(lastname + " : " + lastwins, 45, 355);//Displays the previous player score gathered from the txt file

    fill(255);//Text colour

    rect(650, 450, 100, 50, 20);//Exit and Main menu buttons

    rect(650, 515, 100, 50, 20);//Exit and Main menu buttons

    //rect(650, 385, 100, 50, 20);

    fill(0);//colour of button text

    textSize(15);//size of the button text

    text("Main Menu", 665, 480);//Button text

    text("Quit", 675, 545);//Button text

    //text("Back", 675, 415);

    if (mouseX > 650 && mouseX < 750 && mouseY > 450 &&  mouseY < 500) {//Menu button outline

      fill(255, 130);//The colour and tint of the outline

      rect(643, 445, 115, 60, 20);//The colour and tint of the outline
    } else if (mouseX > 650 && mouseX < 750 && mouseY > 515 &&  mouseY < 565) {//Quit button outline

      fill(255, 130);//The colour and tint of the outline

      rect(643, 510, 115, 60, 20);//The colour and tint of the outline
    } /*else if (mouseX > 650 && mouseX < 750 && mouseY > 385 && mouseY < 435) {
     
     fill(255, 130);
     
     rect(643, 380, 115, 60, 20);
     }*/
  }
}

void keyPressed () {

  if (screen == 6 ) {//This code controls wht heppens when the enter button is clicked and the when the player types his user name

    if (keyCode == ENTER) {//This means that if enter is clicked the screen switches to the main menu

      screen = 0;
    } else if (keyCode == BACKSPACE && name.length () > 0) {//This says that if the backspace button is pressed it erases the letters already typed

      name = name.substring(0, name.length()-1);//This code means that if the backspace button is pressed it removes the previous letter typed
    } else {

      if (key >= int ('A') && key <= int('z')) {//This code limits the input from the keyboard to only the alphabet on the keyboard so charcters such as * would not be accepted

        name = name + key;//When a key is pressed it adds it onto the already preivously tyoed key if there was one there from before
      }
    }
  }
}

void mousePressed() {

  if (screen ==0) {//Main menu

    //Reset code. These reset variable values when on the main menu. 

    reset();//Reset function

    reset2();//2nd Reset function


    /* for (int i = 0; i < 5; i = i+1) {//enemey ship placement
     
     clicked = floor(random(7));
     clickedY = floor(random(6));
     
     while (ship[clicked][clickedY] != 0) {
     clicked = floor(random(7));
     clickedY = floor(random(6));
     }
     
     ship[clicked][clickedY] = 1;
     }*/
    if (mouseX > 205 && mouseX < 355 && mouseY > 235 &&  mouseY < 335) {//New game button mechincis so if button pressed do the following
      sound.play();//Play sound

      pointer();//Runs pointer function

      screen = 5;//changes screen
    } else if (mouseX > 445 && mouseX < 550 && mouseY > 235 &&  mouseY < 335) {//Settings button mechincis so if button pressed do the following
      sound.play();//Play sound

      pointer();//Runs pointer function

      screen = 1;//changes screen
    } else if (mouseX > 325 && mouseX < 475 && mouseY > 375 &&  mouseY < 505) {//Quit button mechincis so if button pressed do the following
      sound.play();//Play sound 

      exit();//Quits program
    }
  } else if (screen == 1) {//Settings

    reset();//Runs reset function

    if (mouseX > 650 && mouseX < 750 && mouseY > 450 &&  mouseY < 500) {//Menu button mechincis so if button pressed do the following
      sound.play();//Play sound

      screen = 0;//Changes screen
      pointer();//Runs the code via a function to chnage the cursor through a series of if staements
    } else if (mouseX > 650 && mouseX < 750 && mouseY > 515 &&  mouseY < 565) {//Quit button mechincis so if button pressed do the following
      sound.play();//Play sound

      exit();//Exits program
    } else if (mouseX > 65 && mouseX < 215 && mouseY > 175 &&  mouseY < 275) {//Easy button mechincis so if button pressed do the following
      sound.play();//Play sound

      difficulty = 7;//Changes the difficulty
      screen = 0;//Changes screen
    } else if (mouseX > 65 && mouseX < 215 && mouseY > 300 &&  mouseY < 400) {//Medium button mechincis so if button pressed do the following
      sound.play();//Play sound

      difficulty = 8;//Changes difficulty
      screen = 0;//Changes screen
    } else if (mouseX > 65 && mouseX < 215 && mouseY > 425 &&  mouseY < 525) {//Hard button mechincis so if button pressed do the following
      sound.play();//Play sound

      difficulty = 9;//Changes the difficulty
      screen = 0;//Changes screen
    }
  } else if (screen == 2) {//Main game

    //Mouse index location for the grid which aids in creating the clicking program
    clicked = mouseX/100;

    clickedY = mouseY/100;

    //This if statement contorls what happens when each individual grid is pressed. For example if an enemy grid is pressed change it to suncken ship location 
    //This if statement is the foundation for the battleship program
    //It also handles adding scores, explosion grpahics and sounds
    //This is the if statement for player mechanics

    if (ship[clicked][clickedY] == 0) {
    } else  if (ship[clicked][clickedY] == 0) {//empty water. This is for what happens if empty water is clicked
      println("empty water");//Displays a message
      ship[clicked][clickedY] = 3;//Changes it to already exploded empty water
    } else  if (ship[clicked][clickedY] == 1) {//enemy ship. This is for if enemy ship is hit or clicked
      println("score");//Displays this message
      ship[clicked][clickedY] = 4;//Changes the ship to already exploded enemy water
      file.play();//PLays the explosion sound to signify ship going down
      scorePlayer = scorePlayer + 1;//Adds a score for the player
    } else  if (ship[clicked][clickedY] == 2) {//player ship. This is for if your own ship is hit
      println("you hit your ship");//Displays this message
    } else  if (ship[clicked][clickedY] == 3) {//exploded empty water. This is for what happens when already exploed waters have been hit
      println("exploded water");//Displays this message
    } else  if (ship[clicked][clickedY] == 4) {//exploded enemy ship This is for what happens when already exploed enemy ships have been hit
      println("already exploded");//Displays this message
    } else  if (ship[clicked][clickedY] == 5) {//exploded player ship. This is for what happens when already exploded player ships have been hit
      println("already exploded your own ship");//Displays this message
    }

    //AI detection. It picks a random location each time
    clicked = floor(random(7));//Enemy detection
    clickedY = floor(random(6));//Enemy detection

    println(clicked, clickedY);//Printline for enemey detection coordinates

    //This if statement contorls what happens when each individual grid is pressed. For example if an enemy grid is pressed change it to suncken ship location 
    //This if statement is the foundation for the battleship program
    //It also handles adding scores, explosion grpahics and sounds
    //This is the if statement for loop for AI mechanics

    if (ship[clicked][clickedY] == 0) {
    } else  if (ship[clicked][clickedY] == 0) {//empty water. This is for what happens if empty water is clicked
      println("empty water");//Displays a message
      ship[clicked][clickedY] = 3;//Changes it to already exploded empty water
    } else  if (ship[clicked][clickedY] == 1) {//enemy ship. This is for if enemy ship is hit or clicked
      println("Enemy Ship");//Displays a message for the AI that it hit its own ship
    } else  if (ship[clicked][clickedY] == 2) {//player ship, This is for ifa player ship is hit
      println("Your ship is down");//Displays this message
      ship[clicked][clickedY] = 5;//Changes it to already exploded enemy ship
      file.play();//Plays explosion sound
      computerScore = computerScore + 1;//Adds score for computer
    } else  if (ship[clicked][clickedY] == 3) {//exploded empty water. This is for what happens when water hit has already been exploded
      println("exploded water");//Displays this message
    } else  if (ship[clicked][clickedY] == 4) {//exploded enemy ship. This is for what happens when enemy ship hit has already been exploded
      println("ship already exploded");//Displays this message
    } else  if (ship[clicked][clickedY] == 5) {//exploded player ship. This is for what happens when player ship hit has already been exploded
      println("already exploded");//Displays this message
    }

    //This is the difficulty mechanics

    if (difficulty == 7) {//Easy mode

      clicked = floor(random(7));
      clickedY = floor(random(6));
    } else if (difficulty == 8) {//Medium nothing changes it is the same as easy is just that the enemy ships are not shown
    } else if (difficulty == 9) {//Hard mode

      while (ship[clicked][clickedY] != 2) {//This while loop make sures that each time the AI hits the exact location of the player ship and is the hardest mode

        clicked = floor(random(7));//AI Enemy detection code. Chooses a random value to check grid location
        clickedY = floor(random(6));//AI Enemy detection. Chooses a random value to check grid location
      }
    }
    if (ship[clicked][clickedY] == 2) {//Adds computer score if detected player ship

      ship[clicked][clickedY] = 5;//Changes the ship number assignment after it has been hit
      computerScore = computerScore + 1;//Adds the score for the computer
    }

    if (scorePlayer == 5) {//Scoring system. Changes to win screen once player hits 5 points

      screen = 3;//Changes to the win screen

      leader2();//Runs the data storing function to save the amount of wins
    } else if (computerScore == 5) {//Scoring system. Changes to loose screen once AI hits 5 points

      screen = 4;//Changes screen to the loose screen
    }

    if (mouseX > 695 && mouseX < 795 && mouseY > 450 &&  mouseY < 500) {//Main Menu button

      sound.play();//Plays sound

      cursor(0);//Sets the cursor value back to the originsl which is basic mouse cursor everyone is used to

      screen = 0;//Changes screen

      scorePlayer = 0;//Resets player score

      computerScore = 0;//Resets computer score

      reset();
    } else if (mouseX > 695 && mouseX < 795 && mouseY > 515 &&  mouseY < 565) {//Exit button
      sound.play();//Plays sound

      exit();//Exits program
    } /*else if (mouseX > 650 && mouseX < 750 && mouseY > 385 && mouseY < 435){
     
     screen = 3;
     
     } else if (mouseX > 650 && mouseX < 750 && mouseY > 320 && mouseY < 370){
     
     screen = 4;
     
     } else if (mouseX > 650 && mouseX < 750 && mouseY > 255 && mouseY < 305){
     
     screen = 6;
     
     }else if (mouseX > 650 && mouseX < 750 && mouseY > 190 && mouseY < 240){
     
     screen = 5;
     
     }*/
  } else if (screen == 3) {//Win  

    wins++;//Adds the win vslue each time the screen is visited

    leader2();//Runs the function for the data saving to record the number of times the playeyr has succesfully made it to the win screen

    if (mouseX > 650 && mouseX < 750 && mouseY > 450 &&  mouseY < 500) {//Main menu button
      sound.play();//Play sound

      screen = 0;//Changes screen
      
      pointer();//Runs the code via a function for the image and value of the cursor
    } else if (mouseX > 650 && mouseX < 750 && mouseY > 515 &&  mouseY < 565) {// Exit button
      sound.play();//Play sound

      exit();//Exits program
    } /*else if (mouseX > 650 && mouseY < 750 && mouseY > 385 && mouseY <  435) {
     
     screen = 2;
     }*/
  } else if (screen == 4) {//Loose screen

    if (mouseX > 650 && mouseX < 750 && mouseY > 450 &&  mouseY < 500) {//Main menu buttonmechincis so if button pressed do the following
      sound.play();//Play sound

      screen = 0;//Changes screen
      pointer();
    } else if (mouseX > 650 && mouseX < 750 && mouseY > 515 &&  mouseY < 565) {//Exit button mechincis so if button pressed do the following
      sound.play();//Play sound

      exit();//Exits program
    } /*else if (mouseX > 650 && mouseY < 750 && mouseY > 385 && mouseY <  435) {
     
     screen = 2;
     }*/
  } else if ( screen == 5) {//Ship placement screen

    if (mouseX > 650 && mouseX < 750 && mouseY > 450 &&  mouseY < 500) {//Main menu button mechincis so if button pressed do the following
      sound.play();//Play sound

      screen = 0;//Changes screen
      pointer();
    } else if (mouseX > 650 && mouseX < 750 && mouseY > 515 &&  mouseY < 565) {//Exit button mechincis so if button pressed do the following
      sound.play();//Play sound

      exit();//Exits program
    } /*else if (mouseX > 650 && mouseY < 750 && mouseY > 385 && mouseY <  435) {//Game
     
     screen = 2;
     }*/

    //This is the code that allows the players to place their ship. So if a locations is pressed place ships and once 5 ships are placed it moves to the acctual game.

    ship[count][countY] = 2;//Means once the ship loactaion has been pressed place the ship

    shipL = shipL + 1;//Keeps tracks of the number of ships placed

    if (shipL == 5) {//Once the number of ships has been placed it switches screen

      screen = 2;//Switches to game screen

      /*  for (int i = 0; i < 5; i = i+1) {//enemey ship placement
       
       clicked = floor(random(7));
       clickedY = floor(random(6));
       
       while (ship[clicked][clickedY] != 0) {
       clicked = floor(random(7));
       clickedY = floor(random(6));
       }
       ship[clicked][clickedY] = 1;
       }*/

      fade = 255;//Resest the fade value to the maximum
    }
  } else if (screen == 6) {// Sign in page


    if (mouseX > 650 && mouseX < 750 && mouseY > 450 &&  mouseY < 500) {//Menu button what happens if this button is clicked

      screen = 0;//Changes screen
    } else if (mouseX > 650 && mouseX < 750 && mouseY > 515 &&  mouseY < 565) {//Quit button what happens if this button is clciked

      exit();//Exits program
    } /*else if (mouseX > 650 && mouseY < 750 && mouseY > 385 && mouseY <  435) {
     
     screen = 2;
     }*/
  }
}

void reset() {//This functions resets the ship locations once the game is over or the player exits to the main menu or the quits the program

  for (int y = 0; y < 6; y = y + 1) {//Reset value

    for (int i = 0; i < 7; i = i + 1) {//This resets all the ships locations
      ship[i][y] = 0;//Resets and clears all ships on the grid
    }
  }

  for (int i = 0; i < 7; i = i+1) {//enemey ship placement, For loop contorls how many ships are to be placed

    clicked = floor(random(7));//This allows the ship to choose a random x location to detec the player ships
    clickedY = floor(random(6));//This allows the ship to choose a random y location to detec the player ships

    while (ship[clicked][clickedY] != 0) {//This while loops makes sure that the computer doe not pick the same location for the ship
      clicked = floor(random(7));//This allows the ship to choose a random x location to detec the player ships
      clickedY = floor(random(6));//This allows the ship to choose a random y location to detec the player ships
    }

    ship[clicked][clickedY] = 1;//Places the enemey ship down at a location
  }
}

void reset2() {//This resets values once at the main menu

  screen = 0;//Resets the game screen to the main menu

  pointer();//Runs the pointyer function

  scorePlayer = 0;//Resets the player's score

  computerScore = 0;//Resets the player's the computer's score

  shipL = 0;//Resets the ship placement that the player chose

  fade = 255;//Resets the fade value of the text to the maximum
}

void shipPlace() {//This contorls the random placement of enemy ships within the grid

  for (int i = 0; i < 5; i = i+1) {//enemey ship placement, For loop contorls how many ships are to be placed

    clicked = floor(random(7));//This allows the ship to choose a random x location to detec the player ships
    clickedY = floor(random(6));//This allows the ship to choose a random y location to detec the player ships

    while (ship[clicked][clickedY] != 0) {//This while loops makes sure that the computer doe not pick the same location for the ship
      clicked = floor(random(7));//This allows the ship to choose a random x location to detec the player ships
      clickedY = floor(random(6));//This allows the ship to choose a random y location to detec the player ships
    }
    ship[clicked][clickedY] = 1;//Places the enemy ship on the grid
  }
}

void pointer() {//This changes the image of cursor when it is on different screens for example while on game screen it is at the battleship cursor.

  if (screen == 2) {// If it is screen 2 make mouse aimer

    cursor(point, 20, 20);//Sets the cursor to the aimer cursor
  } else if (screen == 5) {//If it is screen 5 make mouse aimer

    cursor(point, 20, 20);//Sets the cursor to the aimer cursor
  } else if (screen == 0) {//If it is screen 0 make mouse original

    cursor(0);//Sets the cursor to defualt cursor
  } else if (screen == 3) {//If it is screen 0 make mouse original

    cursor(0);//Sets the cursor to defualt cursor
  } else if (screen == 4) {//If it is screen 0 make mouse original

    cursor(0);//Sets the cursor to defualt cursor
  } else if (screen == 1) {//If it is screen 0 make mouse original

    cursor(0);//Sets the cursor to defualt cursor
  }
}
void leader2() {//This is supposed save the player data such as the username and the number of times the player visited the game screen

  data[0] = name;//Assigns the assigns the username to an array to save it

  data[1]= wins + "";//Assigns the nymber of wins to an array to save it

  saveStrings("GameData.txt", data);//Saves everything in a txt file
}

void leader() {//This is supposed to load the player data from the txt file

  data = loadStrings("GameData.txt");//This loads the game data from the txt file which is named in the brackets

  lastname = data[0];//This assigns the data in the txt file to an array so that it can be called in the program

  lastwins = Integer.parseInt(data[1]);//This assigns and tranforms the number of wins to a string and sassigns it to an arry so that it can be called in the program
}
