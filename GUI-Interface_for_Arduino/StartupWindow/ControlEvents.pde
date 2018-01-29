// for capturing the occuring events

/* events triggered by controllers are automatically forwarded to 
     the controlEvent method. by checking the name of a controller one can 
     distinguish which of the controllers has been changed.
  */ 
 
  /* check if the event is from a controller otherwise you'll get an error
     when clicking other interface elements like Radiobutton that don't support
     the controller() methods
  */

void controlEvent(ControlEvent theEvent) {
	if(theEvent.isController()) {
		println("control event from : " +theEvent.getController().getName() );

		if(theEvent.getController().getName() == "Start") {
			plot_graph();
		}
	}
}
