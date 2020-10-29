int statut = 2;// Statut de départ par défaut
final int MENU_PRINCIPAL = 0;
final int JEU = 1;
final int MENU_GAMEOVER = 2;
final int MENU_GAMEOVER_APROPOS = 3;
final int TEST2 = 4;

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

FantomeRouge fantomeRouge;
FantomeBleu fantomeBleu;
FantomeRose fantomeRose;
FantomeOrange fantomeOrange;
FantomeTest2 fantomeTest2;

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

  fantomeRouge = new FantomeRouge();
  fantomeBleu = new FantomeBleu();
  fantomeRose = new FantomeRose();
  fantomeOrange = new FantomeOrange();
  fantomeTest2 = new FantomeTest2();
}

public void draw() {
  switch(statut) {
  case MENU_PRINCIPAL:

    background(0, 0, 0);
    afficheMenuPrincipal();
    break;

  case JEU:
    afficheCarteJeu();
    pacman.avance();

    fantomeRouge.apparait();
    fantomeRouge.deplacement();
    
    fantomeBleu.apparait();
    //fantomeBleu.deplacement();
    
    fantomeRose.apparait();
    //fantomeRose.deplacement();
    fantomeOrange.apparait();
    //fantomeOrange.deplacement();

    pacman.dessine();

    break;

  case TEST2:
    afficheCarteJeuDeTest();

    fantomeTest2.apparait();
    fantomeTest2.deplacement();

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
      statut = 4; // On va au test 2 du jeu
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

public void afficheCarteJeuDeTest() { //Affiche la carte du jeu pacman pour nos tests
  image(carte_img, 0, 0);
  stroke(128,0,128);
  fill(128,0,128);
}


public void keyPressed() {//controls for pacman
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

PVector getCarreauNonMurProche(PVector cible) { // retourne le carreau non-mur le plus proche
  float minimum = 1000;
  int minimumJ =0;
  int minimumI =0;
  for (int i =0; i<28; i++) { // parcours de tout les carreaux
    for (int j =0; j<31; j++) {
      if (!carreaux[j][i].mur) { // si non-mur
        if (dist(i, j, cible.x, cible.y)<minimum) { // si c'est la cible la plus proche
          minimum = dist(i, j, cible.x, cible.y);
          minimumJ= j;
          minimumI = i;
        }
      }
    }
  }
  return new PVector(minimumI, minimumJ); // retourne un PVector au carreau
}

public Chemin AlgoRechercheAEtoile(Noeud depart, Noeud arrive, PVector deplacement) {

  LinkedList<Chemin> listChemin = new LinkedList<Chemin>(); //On y mets tout les chemins possible
  Chemin etendre = new Chemin(); //un chemin temporaire qui sera etendu par l'ajout d'un nouveau noeud
  Chemin cheminFinal = new Chemin(); //Le chemin final
  Chemin etendu = new Chemin(); //le chemin etendu
  LinkedList<Chemin> triChemin = new LinkedList<Chemin>(); //tri tout les chemins par leur distance
  boolean cheminTrouver = false; // Si un chemin est trouver du point de depart à l'arriver

  etendre.ajoutNoeudAuChemin(depart, arrive); // on ajoute le noeud de depart au chemin temporaire
  etendre.direction = new PVector(deplacement.x, deplacement.y); //evite au fantome de tourner
  listChemin.add(etendre); //ajoute le noeud de départ du chemin

  while (true) { //tant qu'on ne trouve pas de chemin
    etendre = listChemin.pop(); //Prend le chemin au sommet de la pile (le chemin a etendre)
    if (etendre.chemin.getLast().equals(arrive)) {//Verifie si le dernier noeud du chemin est egal au noeud d'arriver
      if (!cheminTrouver) {// si le chemin est trouver
        cheminTrouver = true;
        cheminFinal = etendre.dupliquer(); //defini le cheminFinal car on l'a trouver
      } else { 
        if (cheminFinal.distance > etendre.distance) {//si le chemin actuel est plus court que le cheminFinal
          cheminFinal = etendre.dupliquer(); //Defini le nouveau cheminFinal
        }
      }
      if (listChemin.isEmpty()) {//Si ce chemin etait le dernier (a cause de la methode pop) alors on le retourne
        return cheminFinal.dupliquer();
      } else {//Si ce n'est pas le dernier chemin de la liste alors on va au prochain car celui-ci est deja a la fin
        etendre = listChemin.pop(); //On va au prochaine chemin
      }
    }


    if (!etendre.chemin.getLast().verifier || etendre.distance < etendre.chemin.getLast().plusPetiteDistanceAuTarget) {//Si le noeud d'arriver du chemin choisi a deja été verifié et que la distance a l'arriver est plus court que le chemin actuelle choisi alors le chemin choisi n'est pas le bon

      if (!cheminTrouver || etendre.distance + dist(etendre.chemin.getLast().x, etendre.chemin.getLast().y, arrive.x, arrive.y) < cheminFinal.distance) { //On ne regarde pas les chemins qui sont plus long qu'un chemin qui a deja atteint l'arriver

        //Si c'est le premier chemin a atteindre l'arriver ou le plus court chemin a atteindre le noeud alors on défini la distance la plus courte jusqu'a l'arriver par celle de ce chemin 
        etendre.chemin.getLast().plusPetiteDistanceAuTarget = etendre.distance;

        //move all paths to sorting form big then add the new paths (in the for loop)and sort them back into big.

        //On copie tout les chemins trouver dans la variable triChemin puis on ajoute le nouveau chemin (on tri le tout) et on retourne le tout dans listChemin
        triChemin = (LinkedList) listChemin.clone();
        Noeud noeudTemporaire = new Noeud(0, 0); //crée un noeud temporaire ou le réinitialise

        if (etendre.chemin.size() > 1) { //si le chemin actuelle contient au moins 2 noeud
          noeudTemporaire = etendre.chemin.get(etendre.chemin.size() -2); //Défini le noeud temporaire comme l'avant dernier noeud du chemin actuelle
        }

        for (int i=0; i<etendre.chemin.getLast().listeNoeud.size(); i++) { //Pour chaque noeud connecter au noeud final du chemin à étendre (le chemin actuelle)

          if (noeudTemporaire != etendre.chemin.getLast().listeNoeud.get(i)) { // Si on ne va pas en arriere (verifie que le nouveau noeud n'est pas le noeud qui se trouver derriere) 
            //Si la direction vers le nouveau noeud est a l'opposer de la direction vers laquel le chemin aller alors on ne compte pas ce chemin
            PVector directionVersLeNoeud = new PVector(etendre.chemin.getLast().listeNoeud.get(i).x - etendre.chemin.getLast().x, etendre.chemin.getLast().listeNoeud.get(i).y - etendre.chemin.getLast().y);
            directionVersLeNoeud.limit(deplacement.mag());

            if (directionVersLeNoeud.x == -1* etendre.direction.x && directionVersLeNoeud.y == -1* etendre.direction.y ) {
              //on ne fait rien car le noeud est a l'opposé
            } else {// si le noeud n'est pas a l'opposé et donc le fantome ne fait pas demi tour
              etendu = etendre.dupliquer(); // Duplique le chemin actuelle
              etendu.ajoutNoeudAuChemin(etendre.chemin.getLast().listeNoeud.get(i), arrive); //Ajoute le noeud au chemin actuelle dupliquer
              etendu.direction = new PVector(directionVersLeNoeud.x, directionVersLeNoeud.y); //Defini la direction vers le noeud
              triChemin.add(etendu.dupliquer());//ajoute le chemin actuelle dupliquer a la liste des chemins a trié
            }
          }
        }

        //Trie tout les chemins contenu dans triChemin en plus du nouveau chemin ajouter
        //ajoute le chemin avec la plus grande distance en premier comme ça il sera le dernier de la variable listChemin

        listChemin.clear();//vide la liste
        while (!triChemin.isEmpty()) {// tant que la liste des chemins a trier n'est pas vide
          float maximum = -1;
          int intMax = 0;
          for (int i=0; i < triChemin.size(); i++) {
            if (maximum < triChemin.get(i).distance + triChemin.get(i).distanceRestante) { //A* utilise la distance jusqu'a l'objectif + la longueur du chemin pour déterminer l'ordre de tri
              intMax = i;
              maximum = triChemin.get(i).distance + triChemin.get(i).distanceRestante;
            }
          }
          listChemin.addFirst(triChemin.remove(intMax).dupliquer()); // ajout le chemin devant comme ça celui avec la meilleur distance sera dernier et le plus proche sera premier
        }
      }
    }

    etendre.chemin.getLast().verifier = true;

    //Si aucun chemin n'est trouver
    if (listChemin.isEmpty()) {
      if (cheminTrouver ==false) //Il n'y a aucun chemin du debut a la fin
      {
        print("Houston on a un probleme");//message d'erreur 
        return null;
      } else {//Si un chemin a été trouver alors celui si a été stocker dans cheminFinal alors on retourne cheminFinal
        return cheminFinal.dupliquer();
      }
    }
  }
}
