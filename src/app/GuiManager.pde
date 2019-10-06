import g4p_controls.*;

public abstract class GuiManager {
  
  private final PApplet app;
  private HashMap<String, GSlider> sliders;
  
  public GuiManager(PApplet app) {
    this.app = app;
    sliders = new HashMap();
  }
  
  public PApplet getApplet() {
    return app;
  }
  
  public void addSlider(String name, GSlider slider) {
    sliders.put(name, slider);
  }
  
  public GSlider getSlider(String name) {
    return sliders.get(name);
  }
}
