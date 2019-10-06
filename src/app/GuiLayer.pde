
public class GuiLayer extends GuiManager {

  private boolean mouseLock;
  
  public GuiLayer(PApplet app) {
    super(app);
    mouseLock = false;
    
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
