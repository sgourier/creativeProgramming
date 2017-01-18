// SnowFlakeModoki_3.0
class Snowflake {
int TY = 400 ;

int K[][] = new int[TY][TY] ;
int NK[][] = new int[TY][TY] ;
int X ; int Y ; int Q ; int I ; int II ; float W ;
int C ; int M ; int P ; int HP ; int T ; int S ;


Snowflake() {
  }


void setupSnow(){
  
   background(0,0,0) ;
  
  for ( I = 0 ; I < TY ; I++ ){
    for ( II = 0 ; II < TY ; II++ ){
       K[I][II] = 0 ;  
    }
  }
  HP = 250 ;
  S = int(random(0,4)) ;
  W = random(-0.5,+0.8) ;
  K[TY/2][TY/2-1] = HP*10+1  ; K[TY/2+1][TY/2-1] = HP*10+2 ;
  K[TY/2-1][TY/2] = HP*10+3 ; K[TY/2+1][TY/2] = HP*10+3 ;
  K[TY/2-1][TY/2+1] = HP*10+2 ; K[TY/2][TY/2+1] = HP*10+1 ;
  K[TY/2][TY/2] = HP*10+3 ;
  T = 0 ;
 
} // seup()



void drawSnow(){
  
  T = 0 ;
  
  for ( X = 1 ; X < TY-1 ; X++ ){
    for ( Y = 1 ; Y < TY-1 ; Y++ ){
    C = 0 ; M = 0 ; P = 0 ; NK[X][Y] = K[X][Y] ;
    if ( K[X][Y-1] > 0 ){ M = M + 1 ; C = 1 ; HP = int(K[X][Y-1]/10) ; }  
    if ( K[X+1][Y-1] > 0 ){ M = M + 1 ; C = 2 ; HP = int(K[X+1][Y-1]/10) ;; }
    if ( K[X+1][Y] > 0 ){ M = M + 1 ; C = 3 ; HP = int(K[X+1][Y]/10) ; }
    if ( K[X][Y+1] > 0 ){ M = M + 1 ; C = 1 ; HP = int(K[X][Y+1]/10) ; }
    if ( K[X-1][Y+1] > 0 ){ M = M + 1 ; C = 2 ;HP = int(K[X-1][Y+1]/10) ; }
    if ( K[X-1][Y] > 0 ){ M = M + 1 ; C = 3 ; HP = int(K[X-1][Y]/10) ; }
    if ( K[X][Y-1]-(int(K[X][Y-1]/10)*10) == 1 ){ P = 1 ; }  
    if ( K[X+1][Y-1]-(int(K[X+1][Y-1]/10)*10) == 2 ){ P = 1 ; }
    if ( K[X+1][Y]-(int(K[X+1][Y]/10)*10) == 3 ){ P  = 1 ; }
    if ( K[X][Y+1]-(int(K[X][Y+1]/10)*10) == 1 ){ P = 1 ; }
    if ( K[X-1][Y+1]-(int(K[X-1][Y+1]/10)*10) == 2 ){ P = 1 ; }
    if ( K[X-1][Y] -(int(K[X-1][Y]/10)*10)== 3 ){ P = 1 ; }
    if ( M == 1 && P == 1 && HP > 0 ){ NK[X][Y] = C+((HP-S)*10) ; }
    if ( M == 1 && P == 0 && HP > 0 ){ NK[X][Y] = C+(int(HP*W)*10) ; }
    if ( NK[X][Y] != K[X][Y] ){ 
        T = 1 ;
        I = X*(800/TY)+(Y*(800/TY)/2)-((TY/2)*(800/TY)/2) ; II = int(Y*(800/TY)*sqrt(3)/2) ;
        HP = int(NK[X][Y]/10) ;
        fill(HP/2+100,HP/2+100,255) ;
        ellipse(I,II,800/TY,800/TY) ;
      }
    }
  }
  
  for ( X = 1 ; X < TY-1 ; X++ ){
    for ( Y = 1 ; Y < TY-1 ; Y++ ){
       K[X][Y] = NK[X][Y] ;   
    }
  }
    
  if ( random(0,100) > 90 ){ 
    W = random(-0.5,+0.8) ; 
    S = int(random(0,4)) ;
  }
  
  if ( T == 0 ){ setup() ; }
  
} // draw()

}// mousePressed()