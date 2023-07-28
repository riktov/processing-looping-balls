
// https://twitter.com/Theslimevids/status/1683814804765696000?s=20

final float thetaStep = QUARTER_PI / 16 ;

import java.util.ArrayList ;

ArrayList<OscillatingPVector> opvs = new ArrayList<OscillatingPVector>();

/* A PVector whose magnitude oscillates sinusoidally between mag and -mag, where mag is the initial maximum magnitude
*/
class OscillatingPVector extends PVector {
  private float theta ;
  final float baseMag ;
  final float baseTilt ;
  
  OscillatingPVector(float mag, float tilt, float theta) {
    this.theta = theta ;
    this.baseMag = mag ;
    this.set(baseMag, 0);
    this.baseTilt = tilt ;
    this.rotate(tilt) ;
    
    update() ;
  }
  
  void update() {
    float scale = sin(theta) ;
    //we rebuild the vector, to avoid getting in a rut trying to rescale a zero vector.
    this.set(baseMag, 0) ;
    this.rotate(baseTilt) ;
    this.mult(scale) ;
} //<>//
  
  void advance() {
    this.theta = (this.theta + thetaStep) % TWO_PI ;
    update() ;
  }
  
  void drawLine(float centerX, float centerY) {
    PVector pv = new PVector(this.x, this.y) ;
    pv.setMag(this.baseMag) ;
    line(centerX - pv.x, centerY - pv.y, centerX + pv.x, centerY + pv.y) ;
  }
  
  void drawBall(float centerX, float centerY) {
    circle(centerX + this.x, centerY + this.y, 20) ;
  }
}

void setup() {
  size(800, 800) ;
  
  int numPaths = 8 ;
  for(int i = 0 ; i < numPaths ; i++) {
    opvs.add(new OscillatingPVector(200, i * PI / numPaths, i * PI / numPaths)) ; 
  }
}

void draw() {
  background(200, 128, 240) ;
  
  for(OscillatingPVector opv: opvs) {
    opv.drawLine(float(width / 2), float(height / 2)) ;
    opv.drawBall(float(width / 2), float(height / 2)) ;
    opv.advance() ;
  }
  
}
