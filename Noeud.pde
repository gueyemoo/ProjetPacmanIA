public class Noeud{

  float x;   //position de x du Noeud
  float y;  // position de y du Noeud
  LinkedList<Noeud> listeNoeud = new LinkedList<Noeud>(); //Linked list de tout les noeuds auxquels ce Noeud est connecté


  //Constructeur//
  Noeud(float x, float y){
    this.x = x;
    this.y = y;
  }


  public void dessine(){ //dessine un cercle
    fill(0, 80, 80);
    ellipse(x*16+8, y*16+8)
  }



  public void ajoutNoeud(ArrayList<Noeud> noeuds){ //ajoute tout les noeuds adjacent à ce noeud
    for(int i=0; i < noeuds.size(); i++){ //parcours les noeuds de la liste
      if( noeuds.get(i).y == y ^ noeuds.get(i).x == x ){ //Si la positon du noeud en y et en x correspondent
        if(noeuds.get(i).y == y){// Si ce noeud est sur la meme ligne horizontal (rappel les x et y sont inversé)
          float premierNoeudHorizon = min(noeuds.get(i).x, x) + 1 ; //On recupere le premier noeud, celui le plus à gauche
          float dernierNoeudHorizon = max(noeuds.get(i).x, x); //On recupere le dernier noeud, celui le plus à droite


          boolean leNoeud = true;

          while(premierNoeudHorizon < dernierNoeudHorizon){ //On regarde du premier noeud au dernier afin de savoir si il y a un mur
            if(carreau[(int)y][(int)premierNoeudHorizon].mur){
              leNoeud = false; //C'est pas un noeud puis ce que ca veut dire qu'il y a un mur
              break;
            }
            premierNoeudHorizon++; //On incrémente de 1
          }
            if(leNoeud){
              listeNoeud.add(noeuds.get(i)); //On ajoute le noeud à la liste car ce n'est pas un mur
            }
          } else if(noeuds.get(i).x == x){// Si ce noeud est sur la même ligne vertical (rappel les x et y sont inversé)
            float premierNoeudVerti = min(noeuds.get(i).y, y) + 1; //On recupere le premier noeud, celui le plus en haut
            float dernierNoeudVerti = max(noeuds.get(i).y, y); //On recupere le dernier noeud celui le plus en bas

            boolean leNoeud = true;

            while(premierNoeudVerti < dernierNoeudVerti){ //On regarde du premier noeud tout en haut à celui tout en haut
              if(carreau[(int)premierNoeudVerti][(int)x].mur){
                leNoeud = false;
                break;
              }
              premierNoeudVerti++; //On incrémente de 1
            }
            if(leNoeud){
              listeNoeud.add(noeuds.get(i));
            }

          }

        }

      }

    }

  }
