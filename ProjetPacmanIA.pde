int statut = 0;// Statut de départ par défaut
final int MENU_PRINCIPAL = 0;
final int JEU = 1;
final int MENU_GAMEOVER = 2;

PImage bouton_bleu, bouton_rouge, menu_img, menu_titre;
String [] menu_option = {"Test 1", "Test 2", "Test 3"};
int N_MENUS = menu_option.length;
int position_curseur = 0;
int bouton_largeur = 80;
int bouton_longueur = 40;
int [] bouton_x1, bouton_y1, bouton_x2, bouton_y2;



void setup() {

  size(448, 496);

  bouton_x1 = new int[N_MENUS];
  bouton_y1 = new int[N_MENUS];
  bouton_x2 = new int[N_MENUS];
  bouton_y2 = new int[N_MENUS];
  
  menu_titre = loadImage("pacman_titre.png");
  menu_img = loadImage("pacman_menu.png");

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

void draw() {
  switch(statut){
  case MENU_PRINCIPAL:
  
  background(0, 0, 0);
  afficheMenu();
  
  break;
  
  case JEU:
  //A completer
  
  break;
  
  case MENU_GAMEOVER:
  // A completer
  
  break;
  }
}

void mouseMoved() {
  for(int i=0; i < N_MENUS; i++){
     if(mouseX > bouton_x1[i] && mouseX < bouton_x2[i] &&
     mouseY > bouton_y1[i] && mouseY < bouton_y2[i]){ 
       position_curseur = i;
     }
  }
}

void mouseClicked(){
  switch(position_curseur){
     case 0:
     println("test 1 clicked");
     break;
     
     case 1: 
     println("test 2 clicked");
     break;
     
     case 2:
     println("test 3 clicked");
     break;
  }
}

void afficheMenu() {
  fill(255);

  image(menu_titre, 80, 20);
  image(menu_img, 60, 150);
  
  fill(255,255,0);
  text("PACMAN", 170, 110);
  textSize(14);
  fill(255,255,255);
  text("par", 200, 135);
  textSize(15);
  text("Antoine Du Bois & Mohamed Gueye", 90,160);
  
  textSize(20);
 
  for (int i=0; i < N_MENUS; i++) {

    PImage image_actuel = (position_curseur == i) ? bouton_rouge : bouton_bleu;
    image(image_actuel, bouton_x1[i], bouton_y1[i]);
    int x1 = (bouton_largeur - (int)textWidth(menu_option[i]) ) /2;
    text(menu_option[i], bouton_x1[i] + x1 + 15, 42 + bouton_y1[i]);
  }
}
