public class Pacman {

  PVector position;
  PVector changementDirection = new PVector(-1, 0);
  PVector direction = new PVector(-1, 0);

  boolean aTourner = false;
  int score = 30000;
  int vies = 2;
  boolean fin_de_partie = false;


  //Constructeur
  Pacman() {
    position = new PVector(13*16+8, 23*16 +8);
  }


  public void dessine() {
    fill(255, 255, 0);
    stroke(255, 255, 0);
    ellipse(position.x, position.y, 20, 20);
  }


  public void avance() {//fait avancer le pacman si il n'y a pas de mur
    if (verifiePosition()) {
      position.add(direction);
    }
  }


  public boolean verifiePosition() {

    if ((position.x-8)%16 == 0 && (position.y - 8)% 16 ==0) {//Si on est sur une position ou l'ont doit faire un choix pour bouger

      PVector positionArray = new PVector((position.x-8)/16, (position.y-8)/16);

      if (!carreaux[floor(positionArray.y)][floor(positionArray.x)].estManger) { //Verifie si le point de la position a deja été manger ou non
        carreaux[floor(positionArray.y)][floor(positionArray.x)].estManger=true;
        score = score + 1 ;
      }

      PVector positionApresChangement = new PVector(positionArray.x + changementDirection.x, positionArray.y + changementDirection.y); // On verfie le carreau ou le joueur compte aller en tournant

      if (carreaux[floor(positionApresChangement.y)][floor(positionApresChangement.x)].mur) {//Verifie si il n'y a pas de mur vers la positon ou le joueur veut tourner
        if (carreaux[floor(positionArray.y + direction.y)][floor(positionArray.x + direction.y)].mur) { //Verifie si un mur est devant le pacman ou non
          return false; //si aucun des deux n'est libre alors on empeche le pacman de bouger
        } else { //L'espace devant est libre
          return true;
        }
      } else {//Alors il est possible de tourner
        direction = new PVector(changementDirection.x, changementDirection.y);
        return true;
      }
    } else {
      if ((position.x+10*direction.x-8)%16 == 0 && (position.y + 10*direction.y-8)%16 == 0) { //Si on est à 10 carreau de rencontrer une zone de choix dans la direction ou le pacman avance

        PVector positionArray = new PVector((position.x+10*direction.x-8)/16, (position.y+10*direction.y-8)/16); //converti la postion matricielle (issue de la carte) en position d'array

        if (!carreaux[floor(positionArray.y)][floor(positionArray.x)].estManger) {//Si le carreau n'a pas été manger
          carreaux[floor(positionArray.y)][floor(positionArray.x)].estManger = true; // On lui donne le statut de manger
          score = score + 1;
          println("Score:", score);
        }
      }

      if (changementDirection.x + direction.x == 0 && direction.y + changementDirection.y == 0) {//Si le joueur change de direction
        direction = new PVector(changementDirection.x, changementDirection.y);//tourne le pacman
        return true;
      }
      return true; // si pas sur une position critique (mur)
    }
  }
}