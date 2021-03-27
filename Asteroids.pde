int screen;
PImage inGame, galaxy, mainMenu;
int arraySize;
float[] astX, astY, sx, sy;
float playerWidth, playerHeight, playerX, playerY, speedX, speedY, astSize;
int buttonWidth, buttonHeight, playButtonX, playButtonY, shopButtonX, shopButtonY;
int blackHoleHeight, blackHoleWidth, blackHoleX, blackHoleY, blackHoleCountdown, blackHoleShownTimer, blackHoleFlag;
int coins, coinDisplayX, coinDisplayY, coinDisplayWidth, coinDisplayHeight;
int coinRushTimer, coinRushFlag;
int backdropArraySize = 300;
int[] backdropX, backdropY, backdropSpeedX, backdropSpeedY;
int backButtonWidth, backButtonHeight, backButtonX, backButtonY; 
int mainMenuBackButtonFlag, gameReturnBackButtonFlag;
int boostShopX, boostShopY, sizeShopX, sizeShopY;
int score, lives; 
int boostUpgradeFlag, sizeUpgradeFlag;
float guessX, guessY;
boolean isGood;
int shopButtonHeight, shopButtonWidth, shopButton2X, shopButton2Y;

ArrayList<Float> laserX = new ArrayList<Float>();
ArrayList<Float> laserY = new ArrayList<Float>();
ArrayList<Float> laserSX = new ArrayList<Float>();
ArrayList<Float> laserSY = new ArrayList<Float>();


void setup() {


  size(860, 500);

  //screen & buttons varaibles
  screen = 0;
  /*
  0 - main menu 
   1 - in game
   2 - portal univerise
   3 - shop
   4 - game over
   */

  //background impage for game screens
  inGame = loadImage ("in_game.png");
  galaxy = loadImage ("galaxy.jpg");
  mainMenu = loadImage ("main_menu.jpg");



  //player variables
  playerWidth = 10;
  playerHeight = 10;
  playerX = 200;
  playerY = 300;
  speedX = 0; 
  speedY = 0;                                      

  //astrioid variables
  astSize = 15;
  arraySize = 10;

  //button variables
  buttonWidth = 200; 
  buttonHeight = 60;
  playButtonX = 320;
  playButtonY = 240;
  shopButtonX = 320;
  shopButtonY = 320;

  //blackhole variable
  blackHoleHeight = 30;
  blackHoleWidth = 30;
  blackHoleX = floor(random(0, 700));
  blackHoleY = floor(random(150, 400));
  blackHoleCountdown = 500;
  blackHoleShownTimer = 500;
  blackHoleFlag = 0;

  //coin variables
  coins = 0;
  coinDisplayX = 5;
  coinDisplayY = 5;
  coinDisplayWidth = 150;
  coinDisplayHeight = 50;
  coinRushTimer = 500;
  coinRushFlag = 1;

  //back button variables
  backButtonWidth = 150;
  backButtonHeight = 50;
  backButtonX = 5;
  backButtonY = 5;

  //return and main menu flags
  mainMenuBackButtonFlag = 0;
  gameReturnBackButtonFlag = 0;

  //power-up variables 
  boostShopX = 150;
  boostShopY = 350;
  sizeShopX = 400;
  sizeShopY = 350;
  boostUpgradeFlag = 0;
  sizeUpgradeFlag = 0;

  //shop buttons
  shopButtonWidth = 60;
  shopButtonHeight = 40;
  shopButton2X = 300; 
  shopButton2Y = 5;

  //astroids movemnt using arrays 
  astX = new float[arraySize];
  astY = new float[arraySize];
  sx = new float[arraySize];
  sy = new float[arraySize];
  for (int i=0; i < astX.length; i = i+1) { //loop for the length of astX
    astX[i] = 640 + random(width); //determins the X position
    astY[i] = random(height); //determins the Y position

    sx[i] = random(2) - 1; //gives the astroid a random speed 
    sy[i] = random(2) - 1; //gives the astroid a random speed
  }

  //lasers
  laserX.add(100.0);
  laserY.add(100.0);
  laserSX.add(5.0);
  laserSY.add(3.0);

  //stars backdrop 
  backdropX = new int[backdropArraySize];
  backdropY = new int[backdropArraySize];
  backdropSpeedX = new int[backdropArraySize];
  backdropSpeedY = new int[backdropArraySize];
  for (int i=0; i < backdropX.length; i = i+1) {
    backdropX[i] = 640 + floor(random(100));
    backdropY[i] = floor(random(height));

    backdropSpeedX[i] = 1 + floor(random(4));
    backdropSpeedY[i] = 1 + floor(random(4));
  }



  //perfect spawn
  for (int i=0; i < arraySize; i=i+1) { //loop over this when i is less than arraySize
    guessX = random(width); //sets guessX to a random number from 0 to the width of the screen
    guessY = random(height); //sets guessY to a random number from 0 to the height of the screen

    isGood = false; //sets is good to false

    while (isGood == false) { 
      guessX = random(width); //sets X coord to random position
      guessY = random(height); //sets Y coord to random position
      isGood = true;
      for (int j=0; j < i; j=j+1) { //nested for loop, thus we are looping over this for j is less than i
        if (dist(astX[j], astY[j], guessX, guessY) < astSize *2) { //calculates the distance between the two points
          isGood = false; //resets is good to false
        }
      }
    }

    astX[i] = guessX;
    astY[i] = guessY;
  }
}

void draw() {

  //main menu screen
  if (screen == 0) {
    background(mainMenu);

    //play button
    fill(#ffffff);
    rect(playButtonX, playButtonY, buttonWidth, buttonHeight); 
    fill(#000000);
    textSize(30);
    text("Play", playButtonX + 70, playButtonY + 40);

    //shop button
    fill(#ffffff);
    rect(shopButtonX, shopButtonY, buttonWidth, buttonHeight);
    fill(#000000);
    textSize(30);
    text("Shop", shopButtonX + 70, shopButtonY + 40);
  }

  //in game screen
  if (screen == 1) {
    background(inGame);

    //player movement
    fill(#ffffff);

    //if player passes the screen the reappear from the opposite side
    if (playerX < 0) playerX = width; 
    else if (playerX > width) playerX = 0;
    if (playerY < 0) playerY = height;
    else if (playerY > height)playerY = 0;

    if (sizeUpgradeFlag == 0) { //if the size upgrade is not purchased then maintain normal size
      ellipse(playerX, playerY, playerWidth, playerHeight);
    }

    if (sizeUpgradeFlag == 1) { //if size upgrade is purchased then increase player size by 15
      ellipse(playerX, playerY, playerWidth + 15, playerHeight + 15);
    }
    playerX = playerX + speedX;
    playerY = playerY + speedY;

    if (boostUpgradeFlag == 1) { //if the boost upgrade is purchased then multiply the speed by 1.5 
      playerX = playerX + (speedX * 1.5);
      playerY = playerY + (speedY * 1.5);
    }




    //astorids spawing
    fill(#999D77);
    for (int i=0; i < arraySize; i = i + 1) { 
      ellipse(astX[i], astY[i], astSize, astSize);

      //speed of astroids 
      astX[i] = astX[i] + sx[i];
      astY[i] = astY[i] + sy[i];

      //spawns the astroids at the edge of the screen
      if (astX[i] < 0) astX[i] = width; 
      else if (astX[i] > width) astX[i] = 0;
      if (astY[i] < 0) astY[i] = height;
      else if (astY[i] > height) astY[i] = 0;


      //player vs astroid collision
      if (dist(playerX, playerY, astX[i], astY[i]) < astSize/2 + 5) { //calculates the distance between two points, if distance is less than astSize/2 + 5 then game over
        screen = 4; //sets screen to the gameover screen
      }
    }


    //lasers
    for (int i=0; i < laserX.size(); i=i+1) { //loop for the size of laserX
      fill(#E52A2A);
      ellipse(laserX.get(i), laserY.get(i), 7, 7); //draws the laser

      laserX.set(i, laserX.get(i) + laserSX.get(i)); //laser movement
      laserY.set(i, laserY.get(i) + laserSY.get(i)); //laser movement
    }


    //Garbage Collection 
    for (int i=0; i < laserX.size(); i=i+1) {
      if (laserX.get(i) < 0 || laserX.get(i) > width || laserY.get(i) < 0 || laserY.get(i) > height) { //if there are random lasers that are not on the screen then remove them
        laserX.remove(i);
        laserY.remove(i);
        laserSX.remove(i);
        laserSY.remove(i);
      }
    }


    // laser vs asteriod collision, asteriods are index i, lasers are index j
    for (int i=0; i < 10; i = i + 1) { //For all asteroids
      for (int j = 0; j < laserX.size(); j=j+1) { //Look at all lasers
        if (dist(astX[i], astY[i], laserX.get(j), laserY.get(j)) < 15) { //calculates the distance between the astroid and laser
          astX[i] = -100;
          laserX.set(j, -100.0);
          score = score + 1;
        }
      }
    }


    //scoreboard
    fill(#6F23D6);
    rect(5, 5, 110, 40);
    fill(#ffffff);
    textSize(25);
    text("Score: " + score, 13, 35);

    //blackhole
    if (blackHoleFlag == 0) {
      blackHoleCountdown = blackHoleCountdown - 1; //blackhole countdown
      if (blackHoleCountdown < 0) { //when blackhole countdown reaches less than zero draw the blackhole on the screen 
        fill(#FA00FF); //i know its called a blackhole but I made it pink so its more visible lol
        rect(blackHoleX, blackHoleY, blackHoleWidth, blackHoleHeight);
        blackHoleShownTimer = blackHoleShownTimer - 1; //countdown for how long the blackhole is on display
        if (blackHoleShownTimer == 0) blackHoleCountdown = 500; //resets the blackHoleCountdown once its done being on display
        if (playerX > blackHoleX && playerX < blackHoleX + blackHoleWidth && playerY > blackHoleY && playerY <blackHoleY + blackHoleHeight) { //if the player and blackhole collide
          screen = 2;
          coinRushFlag = 1;
          blackHoleFlag = 1;
        }
      }
    }

    //background stars
    fill(#6806BF);
    for (int i=0; i < backdropArraySize; i = i + 1) {
      backdropX[i] = backdropX[i] - backdropSpeedX[i];
      backdropY[i] = backdropY[i] - backdropSpeedY[i];
      if (backdropX[i] < 0) backdropX[i] = 640 + floor(random(width));
      if (backdropY[i] < 0) backdropY[i] = 480 + floor(random(width));

      rect(backdropX[i], backdropY[i], backdropSpeedX[i], backdropSpeedY[i]);
    }      

    //go to shop button
    fill(#ffffff);
    rect(shopButton2X, shopButton2Y, shopButtonWidth, shopButtonHeight);
    textSize(20);
    fill(#000000);
    text("SHOP", shopButton2X + 5, shopButton2Y + 25);
  }

  //coin rush screen
  if (screen == 2) {

    background(galaxy);


    if (coinRushTimer > 0 && coinRushFlag == 1 && blackHoleFlag == 1) { //countdown for how long the user has to collect as many coins as they can
      coinRushTimer = coinRushTimer - 1;


      //player 
      fill(#ffffff);
      if (playerX < 0) playerX = width;
      else if (playerX > width) playerX = 0;
      if (playerY < 0) playerY = height;
      else if (playerY > height)playerY = 0;
      ellipse(playerX, playerY, playerWidth, playerHeight);
      playerX = playerX + speedX;
      playerY = playerY + speedY;

      //coin movement 
      fill(#7111D3);
      for (int i=0; i < arraySize; i = i + 1) {
        astX[i] = astX[i] - sx[i];
        astY[i] = astY[i] - sy[i];
        if (astX[i] < 0) astX[i] = 640 + floor(random(width));
        if (astY[i] < 0) astY[i] = 480 + floor(random(width));
        ellipse(astX[i], astY[i], astSize, astSize);

        //player vs coin collision
        if (dist(playerX, playerY, astX[i], astY[i]) < astSize/2 + 5) {
          coins = coins + 1;
        }
      }

      //coin display (how much coins the user has)
      fill(#ffffff);
      rect(coinDisplayX, coinDisplayY, coinDisplayWidth, coinDisplayHeight);
      fill(#000000);
      textSize(20);
      text("Coins: " + coins, coinDisplayX + 30, coinDisplayY + 30);

      if (coinRushTimer == 0) { //when the countdown is finished reset certain variables
        coinRushTimer = 500;
        coinRushFlag = 0;
        screen = 1;
      }
    }
  }

  //shop screen
  if (screen == 3) {
    background(120);

    //welcome title
    fill(#000000);
    textSize(25);
    text("Welcome to the shop", 300, 50);


    //back button
    fill(#ffffff);
    rect(backButtonX, backButtonY, backButtonWidth, backButtonHeight);
    fill(#000000);
    textSize(15);
    text("<-- Back Button", backButtonX + 5, backButtonY + 30);

    //coin display
    fill(#ffffff);
    rect(725, 5, 120, 50);
    textSize(25);
    fill(#000000);
    text("Coins " + coins, 740, 40);

    //boost upgrade
    fill(#ffffff);
    rect(boostShopX, boostShopY, buttonWidth, buttonHeight);
    textSize(15);
    fill(#000000);
    text("Boost Upgrade - 20 coins", boostShopX + 10, boostShopY + 40);

    //lives upgrade
    fill(#ffffff);
    rect(sizeShopX, sizeShopY, buttonWidth, buttonHeight);
    textSize(15);
    fill(#000000);
    text("Size Upgrade - 30 coins", sizeShopX + 10, sizeShopY + 40);
  }

  //game over screen
  if (screen == 4) {
    background(120);

    //game over display and final score
    textSize(25);
    fill(#000000);
    text("Game over!", 350, 100);
    text("Your score was: " + score, 300, 150);
  }
}




void keyPressed() {

  //player movement using arrow keys
  if (screen == 1 || screen == 2) {
    if (keyCode == UP) {
      speedY = -2;
    } else if (keyCode == DOWN) {
      speedY = 2;
    } else if (keyCode == RIGHT) {
      speedX = 2;
    } else if (keyCode == LEFT) {
      speedX = - 2;
    }
  }
}

void mousePressed() {

  if (mouseX > playButtonX && mouseX < playButtonX+ buttonWidth && mouseY > playButtonY && mouseY < playButtonY + buttonHeight && screen == 0) { //play button 
    screen = 1;
  }

  if (mouseX > shopButtonX && mouseX < shopButtonX+ buttonWidth && mouseY > shopButtonY && mouseY < shopButtonY + buttonHeight && screen == 0) { //shop button
    screen = 3;
    mainMenuBackButtonFlag = 1;
  }

  if (mouseX > backButtonX && mouseX < backButtonX + backButtonWidth && mouseY > backButtonY && mouseY < backButtonY + backButtonHeight) { //backButton button
    if (mainMenuBackButtonFlag == 1) {
      screen = 0;
    }

    if (gameReturnBackButtonFlag == 1) {
      screen = 1;
    }

    if (screen == 3) {
      screen = 1;
    }
  }

  if (mouseX > boostShopX && mouseX < boostShopX + buttonWidth && mouseY > boostShopY && mouseY < boostShopY + buttonHeight && screen == 3 && coins >= 20) { //in store purchase (boost upgrade)

    boostUpgradeFlag = 1;
    screen = 1;
    coins = coins - 20;
  }

  if (mouseX > sizeShopX && mouseX < sizeShopX + buttonWidth && mouseY > sizeShopY && mouseY < sizeShopY + buttonHeight && screen == 3 && coins >= 30) { //in store purchase (size upgrade)
    sizeUpgradeFlag = 1;
    screen = 1;
    coins = coins - 30;
  }

  if (mouseX > shopButton2X && mouseX < shopButton2X + shopButtonWidth && mouseY > shopButton2Y && mouseY < shopButton2Y + shopButtonHeight && screen == 1) {//second shop button
    screen = 3;
  }


  if (laserX.size() < 5) { //To control how many you are allowed to fire at once, game balancing and all that
    float speedx;
    float speedy;

    speedx = 10 * (mouseX - playerX) / dist(mouseX, mouseY, playerX, playerY);
    speedy = 10 * (mouseY - playerY) / dist(mouseX, mouseY, playerX, playerY);

    laserX.add(playerX);
    laserY.add(playerY);

    laserSX.add(speedx);
    laserSY.add(speedy);
  }
}
