import g4p_controls.*;

public class GuiLayer extends GuiManager {

  private boolean mouseLock;
  
  public GuiLayer(PApplet app) {
    super(app);
    mouseLock = false;
    
    GSlider slider = new GSlider(super.getApplet(), width-200, height-100, 200, 100, 50);
    slider.setShowValue(true);
    slider.setLimits(1.5,0.0,2.0);
    super.addSlider("thing", slider);
    
    GSlider slider2 = new GSlider(super.getApplet(), width-200, height-200, 200, 100, 50);
    slider2.setShowValue(true);
    slider2.setLimits(0.3,0.0,2.0);
    super.addSlider("thing2", slider2);
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
