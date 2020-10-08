class Carreau{
boolean point = false;
boolean pointBonus = false;
boolean estManger = false;
boolean mur = false;
Pvector position;

  //Constructeur//
  Carreau(float x, float y){
    position = new Pvector(this.x,this.y);
  }


  public void dessine(){
    if (point){ //si c'est un point

      if(!estManger){ //On dessine le point
        fill(255,255,0); //Colorie en jaune
        ellipse(position.x, position.y, 5, 5); //Dessine un cercle
      }

    } else if (pointBonus){ //si c'est un point bonus

      if(!estManger){//On dessine un point bonus
        fill(255,255,0); //Colorie en jaune
        ellipse(position.x, position.y, 12, 12); // On dessine un cercle
      }

    }

  }

}