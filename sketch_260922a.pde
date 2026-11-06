/*
 * Chaos Game by CowOfJustice aka dicpic aka PONOSNARASSVETE aka HipsterWaffle aka Dan
 */

 /* ==========================GLOBAL VARIABLES========================== */

// import processing.sound.*;

int[] ITTERATIONS = {10000, 1000000, 100000000};
int pgRes_preview = 1024;
int pgRes_display = pgRes_preview * 2;
int pgRes_export = pgRes_display * 4;

int time_of_last_interaction = 0;
int total_time = 1000;

boolean firstMousePress = false;
boolean drawn = true;
boolean hopOn = false;
boolean simOn = false;

color[] colours = new color[100];
color[] colourGradient = new color[4];

color BLACK = color(0,0,0);
color RED = color(255,0,0);
color GREEN = color(0,255,0);
color BLUE = color(0,0,255);
color YELLOW = color(255,255,0);
color MAGENTA = color(255,0,255);
color CYAN = color(0,255,255);
color DARK_GREY = color(85,85,85);
color GREY = color(128,128,128);
color LIGHT_GREY = color(211,211,211);
color WHITE = color(255,255,255);

color MINT = color(92, 182, 189);
color MINT_ICECREAM = color(206, 240, 233);
color BACKGROUND_CLR = BLACK;

float gradient_minimal = 0.33, gradient_middle = 0.66, gradient_maximum = 0.99;

Fractal frac_preview, frac_display, frac_export;
FracSettings current_settings;

UIPanel[] panels = new UIPanel[2];
UILabeled txt1;
UISlider hs1, hs2, hs3; //PVector coords, PVector size, boolean prvw, PVector values, boolean notVertical, boolean integers
UISlider vs1, vs2, vs3, vs4;
UISlider gvs1, gvs2, gvs3;
UIPressable b1; //PVector coords, PVector size, boolean prvw, boolean default_state, boolean lockable
UIPressable s1, s2, s3, s4, s5;

PVector display_size = new PVector(600,600);
int hSlider_girth = 20;
int font_size = 16;

// Amplitude amp;
// AudioIn in;

int DEBUG_counter = 0;

/* ==========================FUNctions========================== */

void setup() {
	size(700,700);
	background(BACKGROUND_CLR);
	
	current_settings = new FracSettings(3, false, false, 0, -1, 0, 0, 1, 1.0, false, false, false); // int vert, boolean mid, boolean cnt, int cMode, float move, int rest, int hop, int sim, float zom, boolean logC, boolean mirrorHop, boolean manualColour
	
	panels[0] = new UIPanel(new PVector(0, display_size.y), new PVector(width, height - display_size.y));
	panels[1] = new UIPanel(new PVector(display_size.x, 0), new PVector(width - display_size.x, height));

	for(int i = 0; i < panels.length; i++){
		panels[i].setColour(DARK_GREY);
	}

	txt1 = new UILabeled(new PVector(display_size.x/2 - 1, 15), new PVector(2, 1));
	txt1.setLabel("Manual Colour Mode");
	txt1.setLabelSize(16);
	txt1.hidden = true;

	// Trully abhorent creation of math and madness (don't try this at home)
	hs1 = new UISlider(new PVector(5, ((height - display_size.y)/2 - hSlider_girth)/2 + display_size.y + 5), new PVector(width - 10, hSlider_girth), true, new PVector(0.0, 2.0, 0.5), true, false); // CUSTOM R
	hs1.setLabel("Custom R");
	hs2 = new UISlider(new PVector(5, ((height - display_size.y)/2 - hSlider_girth)/2 + display_size.y/2 + height/2 + 5), new PVector(width/2 - 10, hSlider_girth), true, new PVector(3.0, 20.0, current_settings.vertexAmount), true, true); // SIDE AMOUNT
	hs2.setLabel("Amount of Sides");
	hs3 = new UISlider(new PVector(width/2 + 5, ((height - display_size.y)/2 - hSlider_girth)/2 + display_size.y/2 + height/2 + 5), new PVector(width/2 - 10, hSlider_girth), true, new PVector(0.0, 2.0, current_settings.restriction), true, true); // RESTRICTIONS
	hs3.setLabel("Restriction Rule");

	vs1 = new UISlider(new PVector(((width - display_size.x)/2 - hSlider_girth)/2 + display_size.x + 5, 5), new PVector(hSlider_girth, display_size.y/2-10), true, new PVector(0, 2, current_settings.colourMode), false, true); // COLOUR MODE
	vs1.setLabel("Colour Mode");
	vs2 = new UISlider(new PVector(((width - display_size.x)/2 - hSlider_girth)/2 + display_size.x/2 + width/2 + 5, 5), new PVector(hSlider_girth, display_size.y/2-10), true, new PVector(0.1, 4.0, current_settings.zoom), false, false); // ZOOM
	vs2.setLabel("Zoom");
	vs3 = new UISlider(new PVector(((width - display_size.x)/2 - hSlider_girth)/2 + display_size.x + 5, display_size.y/2 + 10), new PVector(hSlider_girth, display_size.y/2-10), true, new PVector(0, 2, current_settings.customHop), false, true); // HOP
	vs3.setLabel("Cannot be X away from previous");
	vs3.hidden = true;
	vs4 = new UISlider(new PVector(((width - display_size.x)/2 - hSlider_girth)/2 + display_size.x/2 + width/2 + 5, display_size.y/2 + 10), new PVector (hSlider_girth, display_size.y/2-10), true, new PVector(0, 2, current_settings.customSim), false, true); // SIM
	vs4.setLabel("If previous X are the same");
	vs4.hidden = true;

	gvs1 = new UISlider(new PVector(display_size.x - 20, 40), new PVector(hSlider_girth/2, display_size.y/8), true, new PVector(0.01, 0.99, gradient_minimal), false, false); // COLOUR MODE
	gvs1.setLabel("MIN");
	gvs1.setLabelSize(12);
	gvs1.hidden = true;
	gvs2 = new UISlider(new PVector(display_size.x - 40, 40), new PVector(hSlider_girth/2, display_size.y/8), true, new PVector(0.01, 0.99, gradient_middle), false, false); // ZOOM
	gvs2.setLabel("MID");
	gvs2.setLabelSize(12);
	gvs2.hidden = true;
	gvs3 = new UISlider(new PVector(display_size.x - 60, 40), new PVector(hSlider_girth/2, display_size.y/8), true, new PVector(0.01, 0.99, gradient_maximum), false, false); // HOP
	gvs3.setLabel("MAX");
	gvs3.setLabelSize(12);
	gvs3.hidden = true;
	
	b1 = new UIPressable(new PVector(20,20), new PVector(10,10), false, false, false);
	b1.setLabel("Export");
	b1.setLabelSize(12);

	s1 = new UIPressable(new PVector(20, 60), new PVector(10,10), true, current_settings.center, true);
	s1.setLabel("Center");
	s1.setLabelSize(12);
	s2 = new UIPressable(new PVector(20, 100), new PVector(10,10), true, current_settings.middlePoints, true);
	s2.setLabel("Mid Points");
	s2.setLabelSize(12);
	s3 = new UIPressable(new PVector(display_size.x - 40, 20), new PVector(10,10), true, current_settings.logGradient, true);
	s3.setLabel("Log Colour");
	s3.setLabelSize(12);
	s3.hidden = true;
	s4 = new UIPressable(new PVector(display_size.x - 40, display_size.y - 20), new PVector(10,10), true, current_settings.mirrorHop, true);
	s4.setLabel("Mirror Hop");
	s4.setLabelSize(12);
	s4.hidden = true;
	s5 = new UIPressable(new PVector(20, 140), new PVector(10,10), true, current_settings.manualColour, true);
	s5.setLabel("Manual Colour");
	s5.setLabelSize(12);
	s5.hidden = true;

	frac_preview = new Fractal(pgRes_preview, current_settings);
	frac_display = new Fractal(pgRes_display, current_settings);
	frac_export = new Fractal(pgRes_export, current_settings);

	colour_setup();

	time_of_last_interaction = millis();

	preview();
}

void colour_setup(){
	colours[0] = color(0,0,0,0);
	colours[1] = WHITE;
	colours[2] = RED;
	colours[3] = GREEN;
	colours[4] = BLUE;
	colours[5] = YELLOW;
	colours[6] = MAGENTA;
	colours[7] = CYAN;
	colours[8] = color(255, 128, 0); // ORANGE
	colours[9] = color(128, 255, 0); // LIME
	colours[10] = color(255, 0, 128); // PINK
	colours[11] = color(128, 0, 255); // PURPLE
	colours[12] = color(0, 255, 128); // MINT
	colours[13] = color(0, 128, 255); // LIGHT BLUE
	colours[14] = color(255, 128, 128); // SALMON
	colours[15] = color(128, 255, 128); // LIGHT GREEN
	colours[16] = color(128, 128, 255); // LIGHT PURPLE
	for (int i = 17; i < 100; i++){
		colours[i] = color(random(0, 255), random(0, 255), random(0, 255));
	}

	//colourGradient[0] = color(0,0,0,0);
	colourGradient[0] = BLACK;
	colourGradient[1] = MINT;
	colourGradient[2] = CYAN;
	colourGradient[3] = WHITE;
}

// WIP COLOUR MODE GRADIENT FUNCTION
color getGradientColour(float occ_precent){ // you have 4 colours and percentage is always somewhere between them and depending on occurrences it will make colourMode closer to the end of gradient
	color new_colour;

	if (occ_precent < gradient_minimal){
		new_colour = color(int(occ_precent * red(colourGradient[1]) + (1 - occ_precent) * red(colourGradient[0])),
						 int(occ_precent * green(colourGradient[1]) + (1 - occ_precent) * green(colourGradient[0])),
						  int(occ_precent * blue(colourGradient[1]) + (1 - occ_precent) * blue(colourGradient[0])),
						 int(occ_precent * alpha(colourGradient[1]) + (1 - occ_precent) * alpha(colourGradient[0])));
	} else if (occ_precent >= gradient_minimal && occ_precent < gradient_middle){
		new_colour = color(int(occ_precent * red(colourGradient[2]) + (1 - occ_precent) * red(colourGradient[1])),
						 int(occ_precent * green(colourGradient[2]) + (1 - occ_precent) * green(colourGradient[1])),
						  int(occ_precent * blue(colourGradient[2]) + (1 - occ_precent) * blue(colourGradient[1])));
	} else if (occ_precent >= gradient_middle && occ_precent < gradient_maximum){
		new_colour = color(int(occ_precent * red(colourGradient[3]) + (1 - occ_precent) * red(colourGradient[2])),
						 int(occ_precent * green(colourGradient[3]) + (1 - occ_precent) * green(colourGradient[2])),
						  int(occ_precent * blue(colourGradient[3]) + (1 - occ_precent) * blue(colourGradient[2])));
	} else{
		new_colour = WHITE;
	}

	return new_colour;
}

void mousePressed(){
	if (!firstMousePress){
		firstMousePress = true;
	}
}

void draw() {
	// Updates
	{
		txt1.update();

		hs1.update();
		hs2.update();
		hs3.update();

		vs1.update();
		vs2.update();
		vs3.update();
		vs4.update();

		gvs1.update();
		gvs2.update();
		gvs3.update();

		b1.update();

		s1.update();
		s2.update();
		s3.update();
		s4.update();
		s5.update();
	}
	
	// Functions of UI elements
	{
		if (hs1.hold){
			current_settings.setR(hs1.evaluate());
		} // CUSTOM R
		if (hs2.hold){
			current_settings.setVertAmount(round(hs2.evaluate()));
			vs3.valueMax = round(hs2.evaluate());
			vs3.evaluate();
			vs4.valueMax = round(hs2.evaluate())-1;
			vs4.evaluate();
		} // VERTEX AMOUNT
		if (hs3.hold){
			current_settings.setRest(round(hs3.evaluate()));
			switch(round(hs3.evaluate())){
				case 0:{
					vs3.hidden = true;
					vs4.hidden = true;
					s4.hidden = true;
					break;
				}
				case 1:{
					vs3.hidden = false;
					vs4.hidden = true;
					s4.hidden = false;
					break;
				}
				case 2:{
					vs3.hidden = false;
					vs4.hidden = false;
					s4.hidden = false;
					break;
				}
			}
		} // RESTRICTIONS
		if (vs1.hold){
			current_settings.setCMode(round(vs1.evaluate()));
			s3.hidden = (round(vs1.evaluate()) == 2)?(false):(true);
			gvs1.hidden = (round(vs1.evaluate()) == 2)?(false):(true);
			gvs2.hidden = (round(vs1.evaluate()) == 2)?(false):(true);
			gvs3.hidden = (round(vs1.evaluate()) == 2)?(false):(true);
		} // COLOUR MODE
		if (vs2.hold){
			current_settings.setZoom(vs2.evaluate());
		} // ZOOM
		if (vs3.hold){
			current_settings.setHop(round(vs3.evaluate()));
		} // CUSTOM HOP
		if (vs4.hold){
			current_settings.setSim(round(vs4.evaluate()));
		} // CUSTOM SIM
		if (gvs1.hold){
			gvs2.valueMin = gvs1.evaluate();
			gvs3.valueMin = gvs2.evaluate();
			gradient_minimal = gvs1.evaluate();
			gradient_middle = gvs2.evaluate();
			gradient_maximum = gvs3.evaluate();
		}
		if (gvs2.hold){
			gvs1.valueMax = gvs2.evaluate();
			gvs3.valueMin = gvs2.evaluate();
			gradient_minimal = gvs1.evaluate();
			gradient_middle = gvs2.evaluate();
			gradient_maximum = gvs3.evaluate();
		}
		if (gvs3.hold){
			gvs2.valueMax = gvs3.evaluate();
			gvs1.valueMax = gvs2.evaluate();
			gradient_minimal = gvs1.evaluate();
			gradient_middle = gvs2.evaluate();
			gradient_maximum = gvs3.evaluate();
		}
		if (b1.released){
			frac_export.apply_settings(current_settings);
			frac_export.updateFractal();
			frac_export.export();
		} // EXPORT
		if (s1.released){
			s1.switchState();
			current_settings.setCentPoint(s1.state);
		} // CENTER
		if (s2.released){
			s2.switchState();
			current_settings.setMidPoint(s2.state);
		} // SIDES MIDDLE POINTS
		if (s3.released){
			s3.switchState();
			current_settings.setGradient(s3.state);
		} // LOG COLOUR FOR GRADIENT
		if (s4.released){
			s4.switchState();
			current_settings.setMirrorHop(s4.state);
		} // MIRROR HOP
		if (s5.released){
			s5.switchState();
			current_settings.setManualColour(s5.state);
		} // MANUAL COLOUR
	}	

	if ((millis() - time_of_last_interaction > total_time)&&!drawn){
		frac_display.apply_settings(current_settings);
		frac_display.updateFractal();
		frac_display.build(1);
		frac_display.display();
		drawn = true;
	}	
	if (firstMousePress){
		firstMousePress = false;
	}

	// Displays
	{
		for(int i = 0; i < panels.length; i++){
			panels[i].display();
		}	

		txt1.display();

		hs1.display();
		hs2.display();
		hs3.display();

		vs1.display();
		vs2.display();
		vs3.display();
		vs4.display();

		gvs1.display();
		gvs2.display();
		gvs3.display();

		b1.display();

		s1.display();
		s2.display();
		s3.display();
		s4.display();
		s5.display();
	}
}

void preview(){
	if (frameCount % 8 == 0){
		frac_preview.apply_settings(current_settings);
		frac_preview.colourMode = 0;
		frac_preview.updateFractal();
		frac_preview.build(0);
		frac_preview.display();
	}
}


/* ==========================CLASSES========================== */

/* --------------------------Fractal-------------------------- */
class Fractal {
	int pgRes;
	PGraphics pgFractal;
	Display display;
	float verticalOffset = 0.0;
	
	int colourMode;
	boolean logColour;
	boolean middlePoints;
	boolean center;
	float zoom = 4.0;

	int restriction;
	int customHop = 0;
	int customSim = 1;
	boolean mirrorHop = false;

	int vertexAmount;
	float R;
	
	PVector[] vertex = new PVector[100];
	PVector currentVert;
	PVector nextVert;
	IntList vertIdHistory = new IntList();

	int start_vertex_id = 1;
	int end_vertex_id;


	Fractal(int resolution, FracSettings sett){ 
		pgRes = resolution;
		pgFractal = createGraphics(pgRes, pgRes);
		display = new Display(pgRes);

		apply_settings(sett);

		_calculate_points();
		currentVert = vertex[0];
		nextVert = vertex[1];
		
		vertIdHistory.append(0);
		end_vertex_id = vertexAmount;
	}

	void updateFractal(){
		clear();
		display = new Display(pgRes);

		_calculate_points();
		currentVert = vertex[0];
		nextVert = vertex[1];

		vertIdHistory.clear();
		vertIdHistory.append(0);
		end_vertex_id = vertexAmount;
	}

	void apply_settings(FracSettings sett){
		vertexAmount = sett.vertexAmount;
		middlePoints = sett.middlePoints;
		center = sett.center;
		
		colourMode = sett.colourMode;
		logColour = sett.logGradient;
		R = sett.R;
		
		restriction = sett.restriction;
		customHop = sett.customHop;
		customSim = sett.customSim;
		mirrorHop = sett.mirrorHop;
		
		zoom = sett.zoom;
	}

	void build(int i_itterations){
		println("Building...");
		DEBUG_counter = 0;
		display = new Display(pgRes);
		
		if(center){
			start_vertex_id = 0;
		} else {
			start_vertex_id = 1;
		}

		if(middlePoints){
			end_vertex_id = vertexAmount*2;
		} else {
			end_vertex_id = vertexAmount;
		}

		for (int i = 0; i < ITTERATIONS[i_itterations]; i++){
			_cycle();
		}
	}

	void write(){
		pgFractal.beginDraw();

		float ratio;

		if (logColour){
			ratio = log(1.0 + display.max);
		} else {
			ratio = 1.0 / display.max;
		}

		for (int i = 0; i < pgRes; i++){
			for(int j = 0; j < pgRes; j++){
				if (colourMode != 2){
					pgFractal.set(i, j, colours[display.pixels[i][j]]);
				} else if (display.pixels[i][j] != 0){
					if (logColour){
						pgFractal.set(i, j, getGradientColour(log(1.0 + display.pixels[i][j])/ratio));
					} else {
						pgFractal.set(i, j, getGradientColour(display.pixels[i][j] * ratio));
					}
				} else {
					pgFractal.set(i, j, BLACK);
				}
			}
		}

		pgFractal.endDraw();
	}

	void display(){
		write();
		background(BACKGROUND_CLR);
		image(pgFractal, 0, 0, display_size.x, display_size.y);
	}

	void export(){
		build(2);
		write();
		
		pgFractal.save("CGame_" + vertexAmount + "_Sides_" + nf(R, 0, 2) + "_R_" + second() + minute() + hour() + day() + month() + year() + ".png");
		
		println("Image exported!");
		display();
	}

	void clear(){
		pgFractal.beginDraw();
		background(BACKGROUND_CLR);
		pgFractal.clear();
		pgFractal.endDraw();
	}

	void _calculate_points(){
		vertex = new PVector[vertexAmount*2+1]; // making an array of all verts with additional middle points and with center point, center is always the first and middle points are always after
		
		vertex[0] = new PVector(0, 0);
		vertex[1] = new PVector(0, -pgRes/(2*zoom)); // /2 - the number here is the scale with smaller number being more zoomed in (2 is max recommended).

		float minY = vertex[0].y;
		float maxY = vertex[0].y;

		if (!middlePoints){
			for (int i = 2; i < vertexAmount+1; i++){
				vertex[i] = _rotatePoint(vertex[i-1], 2*PI/vertexAmount);
			}
		} else {
			for (int i = 3; i < vertexAmount*2+1; i+=2){
				vertex[i] = _rotatePoint(vertex[i-2], 2*PI/vertexAmount);
			}
			for (int i = 2; i < vertexAmount*2; i+=2){
				vertex[i] = _getPoint(vertex[i-1], vertex[i+1], 0.5);
			}
			vertex[vertexAmount*2] = _getPoint(vertex[vertexAmount*2-1], vertex[1], 0.5);
		}


		for (int i = 0; i < (middlePoints?(vertexAmount*2 + 1):(vertexAmount + 1)); i++){
			if (vertex[i].y<minY){
				minY = vertex[i].y;
			}
			if (vertex[i].y>maxY){
				maxY = vertex[i].y;
			}
		}

		verticalOffset = (maxY + minY) * 0.5;
	}
	
	PVector _getPoint(PVector p1, PVector p2, float t){
		float dist_x = p2.x - p1.x;
		float dist_y = p2.y - p1.y;
		
		PVector new_point = new PVector(0, 0);
	
		new_point.x = p1.x + t * dist_x;
		new_point.y = p1.y + t * dist_y;
	
		return new_point;
	}

	PVector _rotatePoint(PVector cpoint, float rot_angle){
		PVector new_point = new PVector(0,0);

		new_point.x = cpoint.x*cos(rot_angle) + cpoint.y*sin(rot_angle);
		new_point.y = -cpoint.x*sin(rot_angle) + cpoint.y*cos(rot_angle);

		return new_point;
	}

	void _cycle(){
		
		_next_vert();
		
		currentVert = _getPoint(currentVert, nextVert, R);
		
		_write_colour_info(vertIdHistory.get(0));
	}

	void _next_vert(){
		int random_id = vertIdHistory.get(0);
		DEBUG_counter++;
		switch(restriction){
			case 0: 
				random_id = _rule_one();
				break;
			case 1:
				random_id = _rule_two(random_id);
				break;
			case 2:
				random_id = _rule_three(random_id);
				break;
			case 3:
				random_id = _rule_four(random_id);
		}
		
		_add_to_first(vertIdHistory, random_id);
		nextVert = vertex[random_id];
	}
	
	int _rule_one(){
		return int(random(start_vertex_id, end_vertex_id+1));
	}

	int _rule_two(int last_vertex_id){
		int new_vertex_id = 0;

		if (last_vertex_id == 0) {
			new_vertex_id = int(random(start_vertex_id, end_vertex_id+1));
		} else {
			if (!mirrorHop){
				int forbidden_id = (last_vertex_id + customHop) % end_vertex_id; 
				if (forbidden_id >= 0) forbidden_id++;
				
				new_vertex_id = int(random(start_vertex_id, end_vertex_id));
				
				if (new_vertex_id >= forbidden_id){
					new_vertex_id++;
				}
			} else {
				int right_forbidden_id = (last_vertex_id + customHop + end_vertex_id+1);
				int left_forbidden_id = (last_vertex_id - customHop + end_vertex_id+1);

				// if (DEBUG_counter %10000 == 0) {
				// 	println("last_vertex_id =", last_vertex_id);
				// 	println("CustomHop =", customHop);
				// 	println("Start_Vertex_id =", start_vertex_id);
				// 	println("End_Vertex_id =", end_vertex_id);
				// 	println("Left_Forbidden_id =", left_forbidden_id);
				// 	println("Right_Forbidden_id =", right_forbidden_id);
				// 	println("Left_Forbidden_id -evi+1 =", left_forbidden_id - end_vertex_id - 1);
				// 	println("Right_Forbidden_id -evi+1 =", right_forbidden_id - end_vertex_id - 1);
				// 	println("-----------------------------------------");
				// }

				if (right_forbidden_id >= end_vertex_id*2+2) right_forbidden_id++;
				if (left_forbidden_id <= end_vertex_id+1) left_forbidden_id--;

				// if (DEBUG_counter %10000 == 0) {
				// 	println("Left_Forbidden_id with 0 =", left_forbidden_id);
				// 	println("Right_Forbidden_id with 0 =", right_forbidden_id);
				// 	println("Left_Forbidden_id with 0 -evi+1 =", left_forbidden_id - end_vertex_id - 1);
				// 	println("Right_Forbidden_id with 0 -evi+1 =", right_forbidden_id - end_vertex_id - 1);
				// 	println("-----------------------------------------");
				// }

				left_forbidden_id %= end_vertex_id+1;
				right_forbidden_id %= end_vertex_id+1;

				// if (DEBUG_counter %10000 == 0) {
				// 	println("Left_Forbidden_id modulated =", left_forbidden_id);
				// 	println("Right_Forbidden_id modulated =", right_forbidden_id);
				// 	println("-----------------------------------------");
				// }

				if (right_forbidden_id < left_forbidden_id){
					int temp = left_forbidden_id;
					left_forbidden_id = right_forbidden_id;
					right_forbidden_id = temp;
				}

				// if (DEBUG_counter %10000 == 0) {
				// 	println("Left_Forbidden_id swapped =", left_forbidden_id);
				// 	println("Right_Forbidden_id swapped =", right_forbidden_id);
				// 	println("-----------------------------------------");							
				// }

				if (right_forbidden_id != left_forbidden_id){
					new_vertex_id = int(random(start_vertex_id, end_vertex_id-1));
				} else {
					new_vertex_id = int(random(start_vertex_id, end_vertex_id));
				}
				
				// if (DEBUG_counter %10000 == 0) {
				// 	println("new_vertex_id =", new_vertex_id);
				// 	println("-----------------------------------------");
				// }

				if (new_vertex_id >= left_forbidden_id){
					new_vertex_id++;
				}
				if (new_vertex_id >= right_forbidden_id && right_forbidden_id != left_forbidden_id){
					new_vertex_id++;
				}

				// if (DEBUG_counter %10000 == 0) {
				// 	println("new_vertex_id with forbidden ids =", new_vertex_id);
				// 	println("-----------------------------------------");
				// }
			}

			new_vertex_id %= end_vertex_id+1;
		}

		return new_vertex_id;
	}

	int _rule_three(int last_vertex_id){
		if (_are_last_sim()){
			return _rule_two(last_vertex_id);
		} else {
			return _rule_one();
		}
	}

	int _rule_four(int last_vertex_id){
		if (_are_last_sim()){
			return _inversed_rule_two(last_vertex_id);
		} else {
			return _rule_one();
		}
	}

	int _inversed_rule_two(int last_vertex_id){
		int new_vertex_id = 0;

		if (last_vertex_id == 0 || !mirrorHop) {
			new_vertex_id = int(random(start_vertex_id, end_vertex_id+1));
		} else {
				int right_forbidden_id = (last_vertex_id + customHop + end_vertex_id+1);
				int left_forbidden_id = (last_vertex_id - customHop + end_vertex_id+1);
				
				// if (DEBUG_counter %10000 == 0) {
				// 	println("last_vertex_id =", last_vertex_id);
				// 	println("CustomHop =", customHop);
				// 	println("Start_Vertex_id =", start_vertex_id);
				// 	println("End_Vertex_id =", end_vertex_id);
				// 	println("Left_Forbidden_id =", left_forbidden_id);
				// 	println("Right_Forbidden_id =", right_forbidden_id);
				// 	println("Left_Forbidden_id -evi+1 =", left_forbidden_id - end_vertex_id - 1);
				// 	println("Right_Forbidden_id -evi+1 =", right_forbidden_id - end_vertex_id - 1);
				// 	println("-----------------------------------------");
				// }

				if (right_forbidden_id >= end_vertex_id*2+2) right_forbidden_id++;
				if (left_forbidden_id <= end_vertex_id+1) left_forbidden_id--;

				// if (DEBUG_counter %10000 == 0) {
				// 	println("Left_Forbidden_id with 0 =", left_forbidden_id);
				// 	println("Right_Forbidden_id with 0 =", right_forbidden_id);
				// 	println("Left_Forbidden_id with 0 -evi+1 =", left_forbidden_id - end_vertex_id - 1);
				// 	println("Right_Forbidden_id with 0 -evi+1 =", right_forbidden_id - end_vertex_id - 1);
				// 	println("-----------------------------------------");
				// }
			
				left_forbidden_id %= end_vertex_id+1;
				right_forbidden_id %= end_vertex_id+1;
		
				// if (DEBUG_counter %10000 == 0) {
				// 	println("Left_Forbidden_id modulated =", left_forbidden_id);
				// 	println("Right_Forbidden_id modulated =", right_forbidden_id);
				// 	println("-----------------------------------------");
				// }
					
				if (right_forbidden_id < left_forbidden_id){
					int temp = left_forbidden_id;
					left_forbidden_id = right_forbidden_id;
					right_forbidden_id = temp;
				}
						
				new_vertex_id = (int(random(0,2))>1?(right_forbidden_id):(left_forbidden_id));
			}

			new_vertex_id %= end_vertex_id+1;
			return new_vertex_id;
		}

	boolean _are_last_sim(){ // are last customSim amount of points the same? (if 0 - frfr )
		boolean sim_check = true;

		if (customSim != 0){
			if (vertIdHistory.size()-1 < customSim){ // if size (not included first one) is less than customSim - doesn't matter, we don't check
				return false;
			}
			
			for (int i = 1; i <= customSim; i++){
				if(vertIdHistory.get(0) != vertIdHistory.get(i)){
					sim_check = false;
				}
			}
		}
		return sim_check;
	}

	void _add_to_first(IntList list, int item){
		list.reverse();
		list.append(item);
		list.reverse();

		if (list.size() > vertexAmount*2+1){
			list.remove(vertexAmount*2+1);
		}
	}

	void _write_colour_info(int colour_id){
		switch(colourMode){
			case 0: // NO COLOUR
				display.setPixel(round(currentVert.x + pgRes/2), round(currentVert.y - verticalOffset + pgRes/2), 1);
				break;
			case 1: // VERTEX BASED
				display.setPixel(round(currentVert.x + pgRes/2), round(currentVert.y - verticalOffset + pgRes/2), colour_id+2);
				break;
			case 2: // OCCURRENCE BASED
				display.setPixel(round(currentVert.x + pgRes/2), round(currentVert.y - verticalOffset + pgRes/2));
				break;
		}
	}
}

class Display {
	int[][] pixels; // if colourMode 0 - 1, if 1 - colour id, if 2 - amount of occurrences
	int max = 0;
	int size = 0;
	
	Display(int sz){
		size = sz;
		pixels = new int[sz][sz];

		for (int i = 0; i < sz; i++){
			for (int j = 0; j < sz; j++){
				pixels[i][j] = 0;
			}
		}
	}

	void setPixel(int pixel_x, int pixel_y){
		if (pixel_x >= size || pixel_y >= size || pixel_x < 0 || pixel_y < 0){
			return;
		}

		pixels[pixel_x][pixel_y] += 1;

		if (pixels[pixel_x][pixel_y] > max){
			max = pixels[pixel_x][pixel_y];
		}
	}
	void setPixel(int pixel_x, int pixel_y, int num){
		if (pixel_x >= size || pixel_y >= size || pixel_x < 0 || pixel_y < 0){
			return;
		}

		pixels[pixel_x][pixel_y] = num;

		if (pixels[pixel_x][pixel_y] > max){
			max = pixels[pixel_x][pixel_y];
		}
	}
}

class FracSettings {
	int vertexAmount = 3;
	boolean middlePoints = false;
	boolean center = false;
	
	int colourMode = 0;
	boolean manualColour = false;
	boolean logGradient = false;
	float R = 0.5;
	float zoom = 1.0;
	
	int restriction = 0;
	int customHop = 0;
	int customSim = 1;
	boolean mirrorHop = false;

	FracSettings(int vert, boolean mid, boolean cnt, int cMode, float move, int rest, int hop, int sim, float zom, boolean logC, boolean mirror, boolean manualC){
		vertexAmount = vert;
		middlePoints = mid;
		center = cnt;
		
		colourMode = cMode;
		manualColour = manualC;
		logGradient = logC;
		R = move;
		if (move == -1){
			calculate_R();
		}
		zoom = zom;
		
		restriction = rest;
		customHop = hop;
		customSim = sim;
		mirrorHop = mirror;
	}

	void setVertAmount(int vert){
		vertexAmount = vert;
	}
	void setMidPoint(boolean mid){
		middlePoints = mid;
	}
	void setCentPoint(boolean cnt){
		center = cnt;
	}
	void setCMode(int cMode){
		colourMode = cMode;
	}
	void setR(float move){
		R = move;
	}
	void setRest(int rest){
		restriction = rest;
	}
	void setHop(int hop){
		customHop = hop;
	}
	void setSim(int sim){
		customSim = sim;
	}
	void setZoom(float zom){
		zoom = zom;
	}
	void setGradient(boolean isLog){
		logGradient = isLog;
	}
	void setMirrorHop(boolean mirror){
		mirrorHop = mirror;
	}
	void setManualColour(boolean manualC){
		manualColour = manualC;
	}

	void calculate_R(){
		if(vertexAmount%4 == 0){
			R = 1/(1 + tan(PI/vertexAmount));
		}else if(vertexAmount%4 == 2){
			R = 1/(1 + sin(PI/vertexAmount));
		}else{
			R = 1/(1 + 2*sin(PI/(2*vertexAmount)));
		}
	}
}

/* ----------------------------UI----------------------------- */
class UIElement { // base class for every ui element
	PVector coordinates = new PVector(0,0); 
	PVector size = new PVector(0,0);

	boolean hidden = false;

	color c_default = MINT_ICECREAM; // yum!


	UIElement(PVector coords, PVector sz){
		coordinates = coords;
		size = sz;
	}

	void setColour(color colour){
		c_default = colour;
	}

	void update(){
		if (hidden) return;
	};

	void display(){
		if (hidden) return;
		noStroke();
	}
}

class UIPanel extends UIElement {
	UIPanel(PVector coords, PVector sz){
		super(coords, sz);
	}

	void display(){
		if (hidden) return;
		super.display();

		fill(c_default);
		rect(coordinates.x, coordinates.y, size.x, size.y);
	}
}

class UILabeled extends UIElement {
	String label = "";
	boolean showLabel = false;

	PVector labelPosition = new PVector(coordinates.x + size.x/2,coordinates.y + size.y/2);
	PVector labelOffset = new PVector(0,0);
	int fontSize = font_size;
	
	UILabeled(PVector coords, PVector sz){
		super(coords, sz);
	}

	void setLabel(String lbl){
		label = lbl;
		showLabel = true;
	}

	void setLabelSize(int f_size){
		fontSize = f_size;
	}

	void update(){
		if (hidden) return;
		super.update();
	}

	void display(){
		if (hidden) return;
		super.display();

		if(showLabel){
			textSize(fontSize);
			fill(WHITE);
			textAlign(CENTER, BOTTOM);
			if (size.x >= size.y){
				text(label, labelPosition.x + labelOffset.x, labelPosition.y + labelOffset.y);
			} else {
				pushMatrix();
				translate(labelPosition.x + labelOffset.x, labelPosition.y + labelOffset.y);
				rotate(radians(-90));
				text(label, 0,0);
				popMatrix();
			}
		}
	}
}

class UIInteractable extends UILabeled { // interactable elements, duh
	boolean preview = false; // needed for elements that refresh the display

	boolean over = false; // when mouse is hovering
	boolean pressed = false;
	boolean hold = false;
	boolean released = false;

	color c_over = LIGHT_GREY;
	color c_pressed = GREY;
	color c_hold = BLACK;

	UIInteractable(PVector coords, PVector size, boolean prvw){
		super(coords, size); // suuuperrr!!! (a construct of parent class)
		preview = prvw;
	}

	boolean overEvent() {
		if (mouseX > coordinates.x && mouseX < coordinates.x + size.x && mouseY > coordinates.y && mouseY < coordinates.y + size.y) {
			return true;
		} else {
			return false;
		}
	}
	
	void interactionEvent(){
		time_of_last_interaction = millis();
		if (preview){
			preview();
			drawn = false;
		}
	}

	void pressedEvent(){
		interactionEvent();
		pressed = true;
		hold = true; // in case it won't happen it becomes false in !mousePressed 
	}
	
	void holdEvent(){
		interactionEvent();
		hold = true;
	}

	void update(){
		if (hidden) return;
		super.update();

		over = overEvent();
		released = false;
		pressed = false;

		if (over && firstMousePress) { // first press
			pressedEvent();
		}

		if (!mousePressed && hold) { // if it's unpressed
			hold = false;
			released = true;
		}

		if (hold){ // if it's still pressed
			holdEvent();
		}
	}

	void display(){
		if (hidden) return;
		super.display();
	}
}

class UISlider extends UIInteractable {
	float sliderPos, sliderOffset = 0.0; // initial position and offset for mouse interacting
	float sliderMin, sliderMax;
	float value, valueMin, valueMax;

	boolean horizontal = true;
	boolean roundNumbers = false;

	color c_slider = MINT;

	UISlider(PVector coords, PVector size, boolean prvw, PVector values, boolean notVertical, boolean integers){
		super(coords, size, prvw);

		valueMin = values.x;
		valueMax = values.y;
		value = values.z;
		horizontal = notVertical;
		roundNumbers = integers;
		
		setLabelOffset();
		setSlider();
	}

	void setSlider(){
		sliderMin = horizontal?(coordinates.x):(coordinates.y);
		sliderMax = horizontal?(coordinates.x + size.x):(coordinates.y + size.y);
		sliderPos = map(value, valueMin, valueMax, sliderMin, sliderMax - (horizontal?size.y:size.x));
		evaluate();
	}

	void setLabelOffset(){
		labelOffset.x = horizontal?(0):(-size.x/2);
		labelOffset.y = horizontal?(-size.y/2):(0);
	}

	float evaluate() {
		value = map(sliderPos, sliderMin, sliderMax - (horizontal?size.y:size.x), valueMin, valueMax);
		return constrain(value, valueMin, valueMax);
	}

	float constrain(float val, float min_val, float max_val) {
		return min(max(val, min_val), max_val);
	}

	void interactionEvent(){
		super.interactionEvent();
		evaluate();
	}

	void pressedEvent(){
		super.pressedEvent();
		sliderOffset = sliderPos - (horizontal?mouseX:mouseY);
	}

	void holdEvent(){
		super.holdEvent();
		sliderPos = constrain((horizontal?mouseX:mouseY) + sliderOffset, sliderMin, sliderMax - (horizontal?size.y:size.x));
	}


	void display(){
		if (hidden) return;
		super.display();

		fill(c_default);
		rect(coordinates.x, coordinates.y, size.x, size.y);

		if (over && !hold) {
			fill(c_over);
		} else if(hold){
			fill(c_pressed);
		} else {
			fill(c_slider);
		}

		if (horizontal){
			rect(sliderPos, coordinates.y, size.y, size.y);
		} else {
			rect(coordinates.x, sliderPos, size.x, size.x);
		}

		textSize(fontSize);
		
		fill(WHITE);
		textAlign((horizontal?(LEFT):(RIGHT)), (horizontal?(BOTTOM):(TOP)));
		text(nf(round(valueMin)), labelPosition.x + labelOffset.x - (horizontal?(size.x/2):(fontSize/4)), labelPosition.y + labelOffset.y - (horizontal?(0):(size.y/2))); // Lowest
		textAlign(RIGHT, BOTTOM);
		text(nf(round(valueMax)), labelPosition.x + labelOffset.x + (horizontal?(size.x/2):(-fontSize/4)), labelPosition.y + labelOffset.y + (horizontal?(0):(size.y/2))); // Highest
		
		fill(BLACK);
		if (horizontal){
			if (sliderPos > coordinates.x + size.x/2) {			
				textAlign(RIGHT, CENTER);
				text(roundNumbers?(nf(round(value))):(nf(value, 0, 4)), sliderPos + labelOffset.x - fontSize/4, labelPosition.y + labelOffset.y + size.y/2);
			} else {
				textAlign(LEFT, CENTER);
				text(roundNumbers?(nf(round(value))):(nf(value, 0, 4)), sliderPos + labelOffset.x + size.y + fontSize/4, labelPosition.y + labelOffset.y + size.y/2);
			}
		} else {
			pushMatrix();
			if (sliderPos > coordinates.y + size.y/2) {
				translate(labelPosition.x + labelOffset.x + size.x/2, sliderPos + labelOffset.y - fontSize/4);
				rotate(radians(-90));
				textAlign(LEFT, CENTER);
				text(roundNumbers?(nf(round(value))):(nf(value, 0, 4)), 0,0);
			} else {
				translate(labelPosition.x + labelOffset.x + size.x/2, sliderPos + labelOffset.y + size.x + fontSize/4);
				rotate(radians(-90));
				textAlign(RIGHT, CENTER);
				text(roundNumbers?(nf(round(value))):(nf(value, 0, 4)), 0,0);
			}
			popMatrix();
		}
	}
}

class UIPressable extends UIInteractable {
	boolean state; // boolean state for toggles
	boolean lock; // keep current state or reset to default ones like buttons

	color c_button = MINT;

	UIPressable(PVector coords, PVector size, boolean prvw, boolean default_state, boolean lockable){
		super(coords, size, prvw);

		state = default_state;
		lock = lockable;

		setLabelOffset();
	}

	void setLabelOffset(){
		labelOffset.x = 0;
		labelOffset.y = -size.x/2 - fontSize/4;
	}

	void setState(boolean new_state){
		state = new_state;
	}

	void switchState(){
		state = !state;
	}

	void update(){
		if (hidden) return;
		super.update();
	}

	void display(){
		if (hidden) return;
		super.display();

		if (lock){ // switch
			fill(c_default);
			rect(coordinates.x, coordinates.y, size.x, size.x);

			if(hold){
				fill(c_pressed);
			} else if(state == true){
				fill(c_hold);
			} else {
				fill(c_button);
			}
			rect(coordinates.x + size.x/4, coordinates.y + size.y/4, size.x/2, size.x/2);

		} else { // button
			fill(c_default);
			circle(coordinates.x + size.x/2, coordinates.y + size.x/2, size.x);

			if (over && !hold) {
				fill(c_over);
			} else if(hold){
				fill(c_pressed);
			} else {
				fill(c_button);
			}
			circle(coordinates.x + size.x/2, coordinates.y + size.x/2, size.x/2);
		}
	}
}