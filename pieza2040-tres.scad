L1=6.05;// 6.2mm funciona con tolerancia de 0.20mm
L2=11;
h2=1.64;
h1=4.3-h2;
L3=5.68; 
w1=1.8;  // grosor de pestaña
t1=0.160; // mpultimate 0.17 funciona 
//kobraeno 0.175 
// 2040 funciona con t1=0.20
//funciona 0.10
L4=25; //ancho pieza
w2=3;
cor=[[-L2/2,-h2],[-L2/2,0],[-L3/2,h1],[L3/2,h1],[L2/2,0],[L2/2,-h2]];
hex=4;
module p2020(){
translate([0,w1]){
linear_extrude(hex)
offset(-t1){
translate([0,h2])
polygon(cor);
polygon([[-L1/2,0],[L1/2,0],[L1/2,-w1-t1],[-L1/2,-w1-t1]]);
translate([0,-w1-t1])
polygon([[-L4/2,0],[L4/2,0],[L4/2,-w2],[-L4/2,-w2]]);

intersection(){
translate([0,-5.2]) //-5.0 is tight -5.2 loose
rotate(45)
square([11.,11.],center=true);
square([10,9],center=true);
}
}
}
}

p2020();
translate([10,10])
rotate(90)
p2020();
translate([-10,10])
rotate(-90)
p2020();
