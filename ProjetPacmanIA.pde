int statut = 2;// Statut de départ par défaut
final int MENU_PRINCIPAL = 0;
final int JEU = 1;
final int MENU_GAMEOVER = 2;

PImage bouton_bleu, bouton_rouge, menu_img, menu_titre, menu_gameover_img;
String [] menu_option = {"Test 1", "Test 2", "Test 3"};
String[] menu_gameover = {"Menu","Quitter", "A Propos"};
int N_MENUS = menu_option.length;
int N_MENUS_GAMEOVER = menu_gameover.length;
int position_curseur = 0;
int bouton_largeur = 80;
int bouton_longueur = 40;
int [] bouton_x1, bouton_y1, bouton_x2, bouton_y2;



public void setup() {

  size(448, 496);

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

  for (int i=0; i < N_MENUS; i++) {

    bouton_x1[i] = 20 + x1;
    bouton_y1[i] = 350;
    bouton_x2[i] = bouton_x1[i] + bouton_largeur;
    bouton_y2[i] = bouton_y1[i] + bouton_longueur;

    x1 += bouton_largeur + padding;
  }
}

public void draw() {
  switch(statut){
  case MENU_PRINCIPAL:
  
  background(0, 0, 0);
  afficheMenuPrincipal();
  
  break;
  
  case JEU:
  //A completer
  
  break;
  
  case MENU_GAMEOVER:
  background(0, 0, 0);
  afficheMenuGameOver();
  
  break;
  }
}

public void mouseMoved() {
  if(statut == 0 ){
  for(int i=0; i < N_MENUS; i++){
     if(mouseX > bouton_x1[i] && mouseX < bouton_x2[i] &&
     mouseY > bouton_y1[i] && mouseY < bouton_y2[i]){ 
       position_curseur = i;
     }
    }
  } else if(statut == 2){
    for(int i=0; i < N_MENUS_GAMEOVER; i++){
     if(mouseX > bouton_x1[i] && mouseX < bouton_x2[i] &&
     mouseY > bouton_y1[i] && mouseY < bouton_y2[i]){ 
       position_curseur = i;
     }
    }
  
  }
}

public void mouseClicked(){
  switch(position_curseur){
     case 0:
     if(statut == 0){
          println("test 1 clicked Menu jeu");
     } else if(statut == 2){
          println("test 1 clicked Menu gameover");
          statut = 0; //retourne au menu principal
     }
     break;
     
     case 1: 
     if(statut == 0){
          println("test 2 clicked Menu jeu");
     } else if(statut == 2){ // Le bouton quit du menu gameover
          println("test 2 clicked Menu gameover");
          exit();// fonction de Processing pour finir un programme après la complétion de la fonction draw()
     }     
     break;
     
     case 2:
     if(statut == 0){
          println("test 3 clicked Menu jeu");
          statut = 2;
     } else if(statut == 2){
          println("test 3 clicked Menu gameover");
     }     
     break;
  }
}

public void afficheMenuPrincipal() {
  fill(255);

  image(menu_titre, 90, 20);
  image(menu_img, 70, 150);
  
  fill(255,255,0);
  text("PACMAN", 180, 110);
  textSize(14);
  fill(255,255,255);
  text("par", 210, 135);
  textSize(15);
  text("Antoine Du Bois & Mohamed Gueye", 100,160);
  
  textSize(20);
 
  for (int i=0; i < N_MENUS; i++) {

    PImage image_actuel = (position_curseur == i) ? bouton_rouge : bouton_bleu;
    image(image_actuel, bouton_x1[i], bouton_y1[i]);
    int x1 = (bouton_largeur - (int)textWidth(menu_option[i]) ) /2;
    text(menu_option[i], bouton_x1[i] + x1 + 15, 42 + bouton_y1[i]);
  }
}

public void afficheMenuGameOver(){
  fill(255);

  image(menu_titre, 90, 20);
  image(menu_gameover_img, 90, 90);
  
  fill(255,255,0);
  text("GAMEOVER", 170, 110);

  fill(255,255,255);
  textSize(20);
 
  for (int i=0; i < N_MENUS_GAMEOVER; i++) {

    PImage image_actuel = (position_curseur == i) ? bouton_rouge : bouton_bleu;
    image(image_actuel, bouton_x1[i], bouton_y1[i]);
    int x1 = (bouton_largeur - (int)textWidth(menu_gameover[i]) ) /2;
    text(menu_gameover[i], bouton_x1[i] + x1 + 17, 42 + bouton_y1[i]);
  }
}
