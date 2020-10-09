public class Chemin{
  float distance = 0; //Distance du chemin à parcourir
  PVector direction; //La direction suivi par l'ia pour aller jusqu'au dernier noeud du chemin
  LinkedList<Noeud> chemin = new LinkedList<Noeud>();
  float distanceRestante = 0; //Distance restante entre le dernier noeud du chemin (ajouter) et l'objectif final du chemin (notre target)


  //Constructeur//
  Chemin(){}//constructeur par défaut


  public void ajoutNoeudAuChemin(Noeud nouveauNoeud, Noeud dernierNoeud){ //On ajoute un noeud à la de l'array du chemin (on construit le chemin) et on calcule la distance du chemin

    if(!chemin.isEmpty()){//Si le chemin est vide
      distance = distance + dist(chemin.getLast().x, chemin.getLast().y, nouveauNoeud.x, nouveauNoeud.y); // On ajoute la distance du nouveau noeud au dernier noeud du chemin à la distance total
    }

  chemin.add(nouveauNoeud); //On ajoute le nouveau noeud au chemin
  distanceRestante = dist(chemin.getLast().x, chemin.getLast().y, dernierNoeud.x, dernierNoeud.y); // Permet de calculer la distance jusqu'a l'objectif final du chemin après l'ajout d'un nouveau noeud
  }

  public void detruire(){ // retire tout les noeuds du chemin et réinitialise la distance
     chemin.clear();
     distance = 0;
     distanceRestante = 0;
  }

  public Chemin dupliquer(){ //On retourne un duplicata du chemin
    Chemin cheminDup = new Chemin();
    cheminDup.chemin = (LinkedList) chemin.clone();
    cheminDup.distance = distance;
    cheminDup.distanceRestante = distanceRestante;
    cheminDup.direction = new PVector(direction.x, direction.y);

    return cheminDup;
  }

  public void dessineLigne(){
    strokeWeight(2.5); //Fonction de processing qui défini la largeur d'une ligne (fonction line() issue de processing aussi)
    for(int i=0; i < chemin.size()-1; i++){
      line(chemin.get(i).x*16+8, chemin.get(i).y*16+8, chemin.get(i+1).x*16+8, chemin.get(i+1).y*16+8);// Dessine la ligne avec les coordonnée du chemin
    }
    ellipse(chemin.get(chemin.size()-1).x*16)+8, (chemin.get(chemin.size()-1).y*16)+8, 8,8); //Dessine un cercle sur l'objectif final du chemin
  }




}
