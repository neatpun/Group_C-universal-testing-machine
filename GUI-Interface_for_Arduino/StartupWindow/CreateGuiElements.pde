// For Creating GUI Controllers

// for creating a button
void createButton(int btnX, int btnY, int btnHeight, int btnWidth, ControlP5 gui) {
	gui.addButton("Start")
	.setValue(1)
	.setPosition(btnX, btnY)
	.setSize(btnWidth, btnHeight);
} 

// for adding an input
void createInput(String name, int inpX, int inpY, int inpH, int inpW, ControlP5 gui) {
	gui.addTextfield(name)
	.setPosition(inpX, inpY)
	.setSize(inpW, inpH);
}      