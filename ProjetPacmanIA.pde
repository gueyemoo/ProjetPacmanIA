int statut = 2;// Statut de départ par défaut
final int MENU_PRINCIPAL = 0;
final int JEU = 1;
final int MENU_GAMEOVER = 2;
final int MENU_GAMEOVER_APROPOS = 3;

PImage bouton_bleu, bouton_rouge, menu_img, menu_titre, menu_gameover_img, carte_img;
String [] menu_option = {"Play", "Test 2", "Test 3"};
String[] menu_gameover = {"Menu", "Quitter", "A Propos"};
int N_MENUS = menu_option.length;
int N_MENUS_GAMEOVER = menu_gameover.length;
int position_curseur = 0;
int bouton_largeur = 80;
int bouton_longueur = 40;
int [] bouton_x1, bouton_y1, bouton_x2, bouton_y2;

Pacman pacman;

Carreau[][] carreaux = new Carreau[31][28]; // on fait correspondre les carreaux à la map du pacman en insérant par [y][x]
int[][] carte = {
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 4, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 4, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 4, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 4, 1}, 
  {1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

// 0 point / 1 Mur / 3 espace sans point / 4 gros point
//--------------------------------------------------------------------------------------------------------------------------------------------------



public void setup() {

  frameRate(100);
  size(448, 496);

  carte_img = loadImage("carte_jeu.png");


  bouton_x1 = new int[N_MENUS];
  bouton_y1 = new int[N_MENUS];
  bouton_x2 = new int[N_MENUS];
  bouton_y2 = new int[N_MENUS];

  menu_titre = loadImage("pacman_titre.png");
  menu_img = loadImage("pacman_menu.png");
  menu_gameover_img = loadImage("game_over.png");

  bouton_rouge = loadImage("bouton_rouge.png");
  bouton_bleu = loadImage("bouton_bleu.png");



  int x1 = 0;
  int padding = 60;

  for (int i=0; i < N_MENUS; i++) { //affiche les boutons du menu avec des espaces

    bouton_x1[i] = 20 + x1;
    bouton_y1[i] = 350;
    bouton_x2[i] = bouton_x1[i] + bouton_largeur;
    bouton_y2[i] = bouton_y1[i] + bouton_longueur;

    x1 += bouton_largeur + padding;
  }

  initCarteJeu();
  pacman = new Pacman(); //Initialise le pacman
}

public void draw() {
  switch(statut) {
  case MENU_PRINCIPAL:

    background(0, 0, 0);
    afficheMenuPrincipal();

    break;

  case JEU:
    //A completer
    afficheCarteJeu();
    pacman.avance();
    pacman.dessine();


    break;

  case MENU_GAMEOVER:
    background(0, 0, 0);
    afficheMenuGameOver();

    break;

  case MENU_GAMEOVER_APROPOS:
    background(0, 0, 0);
    afficheMenuAPropos();

    break;
  }
}

public void mouseMoved() {
  if (statut == 0 ) {
    for (int i=0; i < N_MENUS; i++) {
      if (mouseX > bouton_x1[i] && mouseX < bouton_x2[i] &&
        mouseY > bouton_y1[i] && mouseY < bouton_y2[i]) {
        position_curseur = i;
      }
    }
  } else if (statut == 2) {
    for (int i=0; i < N_MENUS_GAMEOVER; i++) {
      if (mouseX > bouton_x1[i] && mouseX < bouton_x2[i] &&
        mouseY > bouton_y1[i] && mouseY < bouton_y2[i]) {
        position_curseur = i;
      }
    }
  } else if (statut == 3) {
    for (int i=0; i < 2; i++) {
      if (mouseX > bouton_x1[i] && mouseX < bouton_x2[i] &&
        mouseY > bouton_y1[i] && mouseY < bouton_y2[i]) {
        position_curseur = i;
      }
    }
  }
}

public void mouseClicked() {
  switch(position_curseur) {
  case 0:
    if (statut == 0) {
      println("play clicked Menu jeu");
      statut = 1; // On va au jeu
    } else if (statut == 2) {
      println("test 1 clicked Menu gameover");
      statut = 0; //retourne au menu principal
    } else if (statut == 3) {
      println("test 1 clicked Menu a propos");
      statut = 0;
    }
    break;

  case 1:
    if (statut == 0) {
      println("test 2 clicked Menu jeu");
    } else if (statut == 2) { // Le bouton quit du menu gameover
      println("test 2 clicked Menu gameover");
      exit();// fonction de Processing pour finir un programme après la complétion de la fonction draw()
    } else if (statut == 3) { // bouton quit du menu a propos
      println("test 2 clicked Menu a propos");
      exit(); // quitte le jeu
    }
    break;

  case 2:
    if (statut == 0) {
      println("test 3 clicked Menu jeu");
      statut = 2;
    } else if (statut == 2) {
      println("test 3 clicked Menu gameover");
      statut = 3;
    }
    break;
  }
}

public void afficheMenuPrincipal() {
  fill(255);

  image(menu_titre, 90, 20);
  image(menu_img, 70, 150);

  fill(255, 255, 0);
  text("PACMAN", 180, 110);
  textSize(14);
  fill(255, 255, 255);
  text("par", 210, 135);
  textSize(15);
  text("Antoine Du Bois & Mohamed Gueye", 100, 160);

  textSize(20);

  for (int i=0; i < N_MENUS; i++) {

    PImage image_actuel = (position_curseur == i) ? bouton_rouge : bouton_bleu;
    image(image_actuel, bouton_x1[i], bouton_y1[i]);
    int x1 = (bouton_largeur - (int)textWidth(menu_option[i]) ) /2;
    text(menu_option[i], bouton_x1[i] + x1 + 15, 42 + bouton_y1[i]);
  }
}

public void afficheMenuGameOver() {

  image(menu_titre, 90, 20);
  image(menu_gameover_img, 90, 90);

  fill(255, 255, 0);
  text("GAMEOVER", 170, 110);

  fill(255, 255, 255);
  textSize(20);

  for (int i=0; i < N_MENUS_GAMEOVER; i++) {

    PImage image_actuel = (position_curseur == i) ? bouton_rouge : bouton_bleu;
    image(image_actuel, bouton_x1[i], bouton_y1[i]);
    int x1 = (bouton_largeur - (int)textWidth(menu_gameover[i]) ) /2;
    text(menu_gameover[i], bouton_x1[i] + x1 + 17, 42 + bouton_y1[i]);
  }
}

public void afficheMenuAPropos() {
  image(menu_titre, 90, 20);
  text("S/o le projet", 150, 150);
  fill(255, 255, 0);
  text("A Propos", 170, 110);

  fill(255, 255, 255);
  textSize(20);

  for (int i=0; i < 2; i++) {

    PImage image_actuel = (position_curseur == i) ? bouton_rouge : bouton_bleu;
    image(image_actuel, bouton_x1[i], bouton_y1[i]);
    int x1 = (bouton_largeur - (int)textWidth(menu_gameover[i]) ) /2;
    text(menu_gameover[i], bouton_x1[i] + x1 + 17, 42 + bouton_y1[i]);
  }
}

public void initCarteJeu() { //Initialise la carte du jeu pacman, afin de faire correspondre les espaces de la carte à la bone catégorie du carreau
  for (int i = 0; i< 28; i++) {
    for (int j = 0; j< 31; j++) {
      carreaux[j][i] = new Carreau(16*i +8, 16*j+8);
      switch(carte[j][i]) {
      case 1: // 1 signifie un mur
        carreaux[j][i].mur = true;
        break;
      case 0: // 0 signifie un point
        carreaux[j][i].point = true;
        break;
      case 3:// 3 signifie un carreau sans point(un carreau dont le point est manger)
        carreaux[j][i].estManger = true;
        break;
      case 4: // 4 signifie un point bonus
        carreaux[j][i].pointBonus = true;
        break;
      }
    }
  }
}

public void afficheCarteJeu() { //Affiche la carte du jeu pacman
  image(carte_img, 0, 0);
  stroke(255);
  for (int i = 0; i< 28; i++) {
    for (int j = 0; j< 31; j++) {
      carreaux[j][i].dessine();
    }
  }
}

//--------------------------------------------------------------------------------------------------------------------------------------------------

void keyPressed() {//controls for pacman
  switch(key) {
  case CODED:
    switch(keyCode) {
    case UP:
      pacman.changementDirection = new PVector(0, -1);
      pacman.aTourner = true;
      break;
    case DOWN:
      pacman.changementDirection = new PVector(0, 1);
      pacman.aTourner = true;
      break;
    case LEFT:
      pacman.changementDirection = new PVector(-1, 0);
      pacman.aTourner = true;
      break;
    case RIGHT:
      pacman.changementDirection = new PVector(1, 0);
      pacman.aTourner = true;
      break;
    }
  }
}

PVector getCarreauNonMurProche(PVector cible){ // retourne le carreau non-mur le plus proche 
  float minimum = 1000;
  int minimumJ =0;
  int minimumI =0;
  for(int i =0; i<28; i++) { // parcours de tout les carreaux
   for (int j =0; j<31; j++) {
     if (!carreaux[j][i].mur) { // si non-mur
       if(dist(i,j, cible.x, cible.y)<minimum) { // si c'est la cible la plus proche
        minimum = dist(i,j, cible.x, cible.y);
        minimumJ= j;
        minimumI = i;
       }
     }
    }
  }
  return new PVector(minimumI, minimumJ); // retourne un PVector au carreau
}
