//
$fn=50;
module cycloid(order=100, r=1,n=10,k=1){
     R=n*r;
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [(R-r)*cos(th)+r*cos(th*(R-r)/r), (R-r)*sin(th)-r*sin(th*(R-r)/r)] ];
     rof=r*k*3.1415*.5;
     offset(r=rof,$fn=30)
     polygon(coords);
 }
 
d1=24;
rmod=.85;
n1=12;
rim=2.5;
h1=2;


hbase1=7;

//lowerbase
translate([0,0,hbase1+5*h1+1])
difference(){
cylinder(d=d1+rim,h=hbase1+h1);
union(){
    translate([0,0,-0.01])
linear_extrude(h1+.1)
cycloid(r=rmod,n=n1,k=1.15);
translate([0,0,h1-.01])
cylinder(d=d1-.15,h=hbase1+1);
}
}

//upper base
translate([0,0,-1.5])
difference(){
cylinder(d=d1+2*rim+0.5,h=hbase1+5*h1+1.);
union(){
translate([0,0,-1])
cylinder(d=rmod*(n1-1.5)*2,h=2.1);
translate([0,0,1])
linear_extrude(h1+.1)
cycloid(r=rmod,n=n1+2,k=1.15);
translate([0,0,1+h1-.01])
cylinder(d=d1+rim+0.5,h=hbase1+3*h1+4);
}
}

//aro tapa inferior
translate([0,0,-6*h1])
linear_extrude(h1*2.5){
    difference(){
        circle(d=d1+rim+0.5);
        circle(d=d1+0.5);
        }
}


//tapa superior motor
translate([0,0,-2*h1])
linear_extrude(1){
    difference(){
    circle(d=d1-1);
        circle(d=6.2);
    }
}



rbal=6;
raxis=3.5;
// balero
translate([0,0,hbase1*2+10*h1])

difference(){
cylinder(r=rbal-0.2,h=h1*2);
    translate([0,0,-1])
    cylinder(r=raxis+.2,h=h1*2+2);
}


//perno
translate([0,0,hbase1*2+17*h1])
rotate([180,0,0])
difference(){
union(){
translate([0,rmod*1.1,0.01])
cylinder(r=raxis,h=2*h1);
translate([0,0,2*h1])
cylinder(r=raxis*1.1+.7,h=h1*2.5);
}
cylinder(d=2.7,h=10);}

//Doal gear

translate([0,0,hbase1*2+7*h1]){
    difference(){
        union(){
linear_extrude(h1*.95)
cycloid(r=rmod,n=n1+1);
linear_extrude(h1*1.9)
cycloid(r=rmod,n=n1-1);}
translate([0,0,-1])
cylinder(r=rbal,h=h1*2+2);
}}



