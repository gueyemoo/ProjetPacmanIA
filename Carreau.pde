public class Carreau {
  boolean point = false;
  boolean pointBonus = false;
  boolean estManger = false;
  boolean mur = false;
  PVector position;

  //Constructeur//
  Carreau(float x, float y) {
    position = new PVector(x, y);
  }


  public void dessine() { //Permet de dessiner les point bonus et les points que le Pacman va manger
    if (point) { //si c'est un point

      if (!estManger) { //On dessine le point
        fill(255, 255, 0); //Colorie en jaune
        ellipse(position.x, position.y, 5, 5); //Dessine un cercle
      }
    } else if (pointBonus) { //si c'est un point bonus

      if (!estManger) {//On dessine un point bonus
        fill(255, 255, 0); //Colorie en jaune
        ellipse(position.x, position.y, 12, 12); // On dessine un cercle
      }
    }
  }
}
