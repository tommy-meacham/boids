import g4p_controls.*;

public class GuiLayer {
  
  private GSlider slider;
  
  public GuiLayer(PApplet app) {
    
    slider = new GSlider(app, width-200, height-100, 200, 100, 50);
    slider.setShowValue(true);
    slider.setLimits(1.5,0.0,2.0);
  } 
}
