// For Creating GUI Controllers

// for creating a button
void createButton(String name , int btnX, int btnY, int btnHeight, int btnWidth, ControlP5 gui) {
	gui.addButton(name)
	.setValue(1)
	.setPosition(btnX, btnY)
	.setSize(btnWidth, btnHeight)
	.setFont(createFont("arial", 20))
	.setColorFont(color(255,0,0));
} 

// for adding an input
void createInput(String name, int inpX, int inpY, int inpH, int inpW, int colorCode, ControlP5 gui) {
	gui.addTextfield(name)
	.setPosition(inpX, inpY)
	.setSize(inpW, inpH)
	.setFont(createFont("arial", 20))
	.setAutoClear(false)
	.setColor(color(colorCode, 0, 0));
}      

// for displaying graph
void createGraph1() {
  rect(50, 100, 650, 550);
  for (int i=100; i<700; i+=50) {
    stroke(220);
    line(50, i, 700, i);	// the horizontal grid pattern
    fill(0);
    text(650-i, 20, i);		// scale
  }
  for (int i=50; i<=700; i+=50) {
    stroke(220);
    line(i, 100, i, 650);
    fill(0);
    text(i-50, i, 665);
  }
}