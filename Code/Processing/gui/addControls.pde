// add controls
void add_controls()
{ // Top controls
    cp5.addBang("reset")
        //.setPosition(500*f1,20*f2)
        //.setSize(int(60*f1),int(19*f2))
        .setPosition(width*0.90625,height/2)//.setPosition(725, 300)
        .setSize(round(width*0.075),round(height*0.03166667))//.setSize(int(60), int(19))
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

        ;



    List l = Arrays.asList("Manual", " CYCLE ");//removed cycle from middle

     cp5.addScrollableList("choose_mode")
        .setPosition(width*0.775,height/30)//.setPosition(620, 20)
        .setSize(round(width*0.2),round(height/6))//.setSize(160, 100)
        .setBarHeight(round(height/30))//.setBarHeight(20)
        .setItemHeight(round(height/30))//.setItemHeight(20)
        .addItems(l)
        // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
        ;



    //Manual controls
    cp5.addBang("up")

        .setPosition(width*0.775,height/6)//.setPosition(620, 100)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        ;

    cp5.addBang("pause")

        .setPosition(width*0.775,height*0.2)//.setPosition(620, 120)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        ;

    cp5.addBang("down")
        .setPosition(width*0.775,height*7/30)//.setPosition(620, 140)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

        ;

    //Cycle Controls

    cp5.addTextfield("cycle_length")
        .setPosition(width*0.9,height*2/15)//.setPosition(720, 80)
        .setSize(round(width*0.0625),round(height/30))//.setSize(50, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Cycle length:")
        .getCaptionLabel()
        .toUpperCase(false)
        .align(ControlP5.LEFT_OUTSIDE, CENTER)

        .setFont(createFont("arial", 15))
        .getStyle().setPaddingLeft(-10);

    cp5.addBang("run")

        .setPosition(width*0.775,height*0.2)//.setPosition(620, 120)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        ;

    cp5.get(Textfield.class, "cycle_length").setInputFilter(ControlP5.FLOAT);


    cp5.addBang("pause_cycles")

        .setPosition(width*0.775,height*7/30)//.setPosition(620, 140)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .setCaptionLabel("Pause")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        //.toUpperCase(false)
        ;
    //3POINTCYCLE

    cp5.addBang("up3")

        .setPosition(width*0.775,height/6)//.setPosition(620, 100)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .setCaptionLabel("UP")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        ;

    cp5.addBang("pause3")

        .setPosition(width*0.775,height*0.2)//.setPosition(620, 120)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .setCaptionLabel("PAUSE")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        ;

    cp5.addBang("down3")
        .setPosition(width*0.775,height*7/30)//.setPosition(620, 140)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .setCaptionLabel("DOWN")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

        ;

    cp5.addBang("set_natural")

        .setPosition(width*0.775,height*0.1)//.setPosition(620, 60)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .setCaptionLabel("Set natural point")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        ;

    cp5.addBang("set_up")

        .setPosition(width*0.775,height*0.1)//.setPosition(620, 60)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .setCaptionLabel("Set uppermost point")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        ;


    cp5.addBang("set_down")

        .setPosition(width*0.775,height*0.1)//.setPosition(620, 60)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .setCaptionLabel("Set lowermost point")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        ;


    cp5.addBang("run3")

        .setPosition(width*0.775,height*0.2)//.setPosition(620, 120)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .setCaptionLabel("run")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        ;



    cp5.addBang("pause_cycles3")

        .setPosition(width*0.775,height*2/15)//.setPosition(620, 140)
        .setSize(round(width*0.2),round(height*0.03166667))//.setSize(160, 19)
        .setCaptionLabel("Pause")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        //.toUpperCase(false)
        ;



    //BOTTOM controls

 cp5.addBang("fix_input")
        .setPosition(width*0.2,height*0.95)//.setPosition(160, 570)
        .setSize(round(width*0.11875),round(height/30))//.setSize(95, 20)
        .setCaptionLabel("Fix Input")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

        ;

    cp5.addBang("export_table")
        .setPosition(width*0.8625,height*8/15)//.setPosition(690, 320)
        .setSize(round(width*0.11875),round(height*0.03166667))//.setSize(95, 19)
        .setCaptionLabel("Export Table")
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

    cp5.addBang("enable_arduino")
         .setPosition(width*0.8625,height*0.568333)//.setPosition(690, 341)
         .setSize(round(width*0.11875),round(height/30))//.setSize(95, 20)

         .setCaptionLabel("Reconnect Arduino")
         .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);


    //MOTOR SIMULATE

    cp5.addSlider("motor_simulate")
        .setPosition(width*0.775,height/3)//.setPosition(620, 200)
        .setSize(round(width*0.025),round(height*5/12))//.setSize(20, 250)
        .setRange(-1500,1500)
        .lock()

        ;

    // TUTORIAL



    cp5.addTextarea("tutorial")
        .setPosition(width*0.25,height/6)//.setPosition(200, 100)
        .setSize(round(width*3/8),round(height/3))//.setSize(300, 200)
        .setFont(createFont("arial", 15))
        .setLineHeight(14)
        .setColor(color(255))
        .setColorBackground(color(255, 0))
        .setColorForeground(color(0, 100));
    ;
    cp5.get(Textarea.class, "tutorial").setText("Please input speed and number of cycles. Then choose a mode. Either (1.) Manual or (2.) CYCLE : Automatic cycle control"
        +"\n"+"                                                                  Inputs: (Length , width , thickness)  and Outputs: (stress , load , strain)  are not yet implemented. Please ignore them."
        );






    cp5.get(Textarea.class, "tutorial").hide();//REMOVE IF YOU WANT TUTORIAL
}

// added inputs
void add_inputs()
{

    cp5.addTextfield("width")
        .setPosition(width*0.025,height*0.75)//.setPosition(20, 450)
        .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Width (in cm)")
        .getCaptionLabel()
        .toUpperCase(false)
        .setFont(createFont("arial", 15))
        ;



    cp5.addTextfield("length")
        .setPosition(width*0.2125,height*0.75)//.setPosition(170, 450)
        .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Length (in cm)")
        .getCaptionLabel()
        .toUpperCase(false)
        .setFont(createFont("arial", 15))
        ;


    cp5.addTextfield("thickness")
        .setPosition(width*0.4,height*0.75)//.setPosition(320, 450)
        .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Thickness (in mm)")
        .getCaptionLabel()
        .toUpperCase(false)
        .setFont(createFont("arial", 15))
        ;


    //   cp5.addTextfield("speed")
    //.setPosition(20,420)
    //.setSize(75,20)
    //.setFont(createFont("arial",15))
    //.setAutoClear(false)
    //.setCaptionLabel("Speed")
    //.getCaptionLabel()
    //.toUpperCase(false)
    //.setFont(createFont("arial",15))
    //;

    cp5.addSlider("speed_slider")
        .setPosition(width*0.025,height*0.868333)//.setPosition(20, 521)
        .setRange(0, 255)
        .setValue(120)
        .setSize(round(width/8),round(height/30))//.setSize(100, 20)
        .getCaptionLabel()
        .toUpperCase(false)
        .setFont(createFont("arial", 15))
        .align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE);

    cp5.addTextfield("no_of_cycles")
        .setPosition(width*0.2125,height*0.868333)//.setPosition(170, 520)
        .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("No. of cycles")
        .getCaptionLabel()
        .toUpperCase(false)
        .setFont(createFont("arial", 15))
        ;
    cp5.addTextfield("initial_distance")
        .setPosition(width*0.4,height*0.86833)//.setPosition(320, 520)
        .setSize(round(width*0.09375),round(height/30))//.setSize(75, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Initial distance (stretch)")
        .getCaptionLabel()
        .toUpperCase(false)
        .setFont(createFont("arial", 15))

        ;
    cp5.get(Textfield.class, "width").setInputFilter(ControlP5.FLOAT);
    cp5.get(Textfield.class, "length").setInputFilter(ControlP5.FLOAT);
    cp5.get(Textfield.class, "thickness").setInputFilter(ControlP5.FLOAT);
    //cp5.get(Textfield.class,"speed").setInputFilter(ControlP5.FLOAT);
    cp5.get(Textfield.class, "no_of_cycles").setInputFilter(ControlP5.INTEGER);
    cp5.get(Textfield.class, "initial_distance").setInputFilter(ControlP5.FLOAT);



    cp5.get(Textfield.class, "initial_distance").setValue(String.valueOf(0.0));
    cp5.get(Textfield.class, "no_of_cycles").setValue(String.valueOf(10));
    cp5.get(Textfield.class, "width").setValue(String.valueOf(5));
    cp5.get(Textfield.class, "length").setValue(String.valueOf(20));
    cp5.get(Textfield.class, "thickness").setValue(String.valueOf(1));
}

// input for live panel
void add_live_panel()
{

    //https://forum.processing.org/two/discussion/24244/controlp5-textfield-background-colour

    cp5.addTextlabel("debug")
        .setText("This will show stuff")
        .setPosition(width*0.025, height*0.5)//.setPosition(20, 300)
        .setColorValue(0xffffff00)
        .setFont(createFont("Georgia", 15))
        ;

    cp5.addTextfield("distance")
        .setPosition(width*0.6875, height*5/6)//.setPosition(550,500)
        .setSize(round(width*0.125), round(height/30))//.setSize(100,20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Distance:")
        .getCaptionLabel()
        .toUpperCase(false)
        .align(ControlP5.LEFT_OUTSIDE, CENTER)

        .setFont(createFont("arial", 15))
        .getStyle().setPaddingLeft(-10);

    cp5.addTextfield("PANEL_cycle")
        .setPosition(width*0.6875,height*0.875)//.setPosition(550, 525)
        .setSize(round(width*0.125), round(height/30))//.setSize(100, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Current cycle:")
        .getCaptionLabel()
        .toUpperCase(false)
        .align(ControlP5.LEFT_OUTSIDE, CENTER)

        .setFont(createFont("arial", 15))
        .getStyle().setPaddingLeft(-10);


    cp5.addTextfield("load")
        .setPosition(width*0.906,height*5/6)//.setPosition(725, 500)
        .setSize(round(width*0.0625),round(height/30))//.setSize(50, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Load:")
        .getCaptionLabel()
        .toUpperCase(false)
        .align(ControlP5.LEFT_OUTSIDE, CENTER)

        .setFont(createFont("arial", 15))
        .getStyle().setPaddingLeft(-10);



    cp5.addTextfield("strain")
        .setPosition(width*0.6875,height*11/12)//.setPosition(550, 550)
        .setSize(round(width*0.125),round(height/30))//.setSize(100, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Strain:")
        .getCaptionLabel()
        .toUpperCase(false)
        .align(ControlP5.LEFT_OUTSIDE, CENTER)

        .setFont(createFont("arial", 15))
        .getStyle().setPaddingLeft(-10);



    cp5.addTextfield("stress")
        .setPosition(width*0.906,height*11/12)//.setPosition(725, 550)
        .setSize(round(width*0.125),round( height/30))//.setSize(50, 20)
        .setFont(createFont("arial", 15))
        .setAutoClear(false)
        .setCaptionLabel("Stress:")
        .getCaptionLabel()
        .toUpperCase(false)
        .align(ControlP5.LEFT_OUTSIDE, CENTER)

        .setFont(createFont("arial", 15))
        .getStyle().setPaddingLeft(-10);

cp5.addTextfield("natural_point")
             .setPosition(width*0.90625,height/3)//.setPosition(725,200)
             .setSize(round(width*0.05),round( height/30))//.setSize(40,20)
             .setFont(createFont("arial",15))
             .setAutoClear(false)
             .setCaptionLabel("N.P:")
             .getCaptionLabel()
             .toUpperCase(false)
             .align(ControlP5.LEFT_OUTSIDE, CENTER)

             .setFont(createFont("arial",15))
             .getStyle().setPaddingLeft(-10);

             cp5.addTextfield("uppermost_point")
             .setPosition(width*0.90625,height*0.368333)//.setPosition(725,221)
             .setSize(round(width*0.075),round( height/30))//.setSize(40,20)
             .setFont(createFont("arial",15))
             .setAutoClear(false)
             .setCaptionLabel("U.P:")
             .getCaptionLabel()
             .toUpperCase(false)
             .align(ControlP5.LEFT_OUTSIDE, CENTER)

             .setFont(createFont("arial",15))
             .getStyle().setPaddingLeft(-10);

             cp5.addTextfield("lowermost_point")
             .setPosition(width*0.90625,height*0.403333)//.setPosition(725,242)
             .setSize(round(width*0.075),round( height/30))//.setSize(40,20)
             .setFont(createFont("arial",15))
             .setAutoClear(false)
             .setCaptionLabel("L.P:")
             .getCaptionLabel()
             .toUpperCase(false)
             .align(ControlP5.LEFT_OUTSIDE, CENTER)

             .setFont(createFont("arial",15))
             .getStyle().setPaddingLeft(-10);



    cp5.get(Textfield.class, "distance").lock();
    cp5.get(Textfield.class, "load").lock();
    cp5.get(Textfield.class, "strain").lock();
    cp5.get(Textfield.class, "stress").lock();
    cp5.get(Textfield.class, "PANEL_cycle").lock();



    cp5.get(Textfield.class, "distance").setColorBackground(0xfffaddff);// 0xff followed by hex value of color
    cp5.get(Textfield.class, "load").setColorBackground(0xfffaddff);
    cp5.get(Textfield.class, "strain").setColorBackground(0xfffaddff);
    cp5.get(Textfield.class, "stress").setColorBackground(0xfffaddff);
    cp5.get(Textfield.class, "PANEL_cycle").setColorBackground(0xfffaddff);

    cp5.get(Textfield.class, "distance").setColorValue(0xff000000);// 0xff followed by hex value of color
    cp5.get(Textfield.class, "load").setColorValue(0xff000000);
    cp5.get(Textfield.class, "strain").setColorValue(0xff000000);
    cp5.get(Textfield.class, "stress").setColorValue(0xff000000);
    cp5.get(Textfield.class, "PANEL_cycle").setColorValue(0xff000000);


    cp5.get(Textfield.class, "distance").setValue(String.valueOf(0.0));
    cp5.get(Textfield.class, "load").setValue(String.valueOf(0.0));
    cp5.get(Textfield.class, "strain").setValue(String.valueOf(0.0));
    cp5.get(Textfield.class, "stress").setValue(String.valueOf(0.0));
    cp5.get(Textfield.class, "PANEL_cycle").setValue(String.valueOf(0.0));
    cp5.get(Textfield.class, "uppermost_point").setValue(String.valueOf(0));
    cp5.get(Textfield.class, "lowermost_point").setValue(String.valueOf(0));
}