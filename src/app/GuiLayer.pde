import g4p_controls.*;

public class GuiLayer {
  
  private GSlider slider;
  private boolean mouseLock;
  
  public GuiLayer(PApplet app) {
    mouseLock = false;
    
    slider = new GSlider(app, width-200, height-100, 200, 100, 50);
    slider.setShowValue(true);
    slider.setLimits(1.5,0.0,2.0);
  } 
  
  public void drawScene() {
    pushMatrix();
    translate(width/2, height/2, 0);
    stroke(0);
    noFill();
    box(width);
    popMatrix();  
  }
  
  public boolean isMouseLocked() {
    return mouseLock;
  }

  public void setMouseLock(boolean b) {
    mouseLock = b;
  }
}
