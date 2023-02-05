//nema planetario precision
// telescope mount
include <libnema.scad>
$ndiente=20;
$fn=100;
tang=20;
r1=0.55;
//rmul=4.5;
rmul=3.8;
d1=52;
n=round(d1/r1/2);
r=d1/n/2;
ratio=1.0;

echo("n=",n);
nc0=11;
n1=floor((n-nc0)*.5);
n2=n-2*n1;

echo("nn=",n,n2+2*n1);
echo("n1=",n1,"n2=",n2);
h=7;
r3=(n+rmul+5)*r+0;


//

translate([0,0,-12*h])
    
linear_extrude(18){
    difference(){
        union(){
    nema17_holes(d=10);
    square([38,38],center=true);
        }
        nema17_holes();
        circle(d=26/4);
        rotate([0,0,45])
        nema17_holes(d=20);
    }
}


//montura 
translate([0,0,-15*h])
linear_extrude(10){
    difference(){
    union(){
    circle(d=d1+9+4);
   nema17_holes(d=7,r=(d1+9+4+3)*.5);
    
    }
    //circle(d=30);
    nema17_holes();
    difference(){
    circle(r=25);
        nema17_holes(d=16);
    }
    //rotate([0,0,10])
   //cycloid(r=2,n=8,k=1);
    nema17_holes(d=3,r=(d1+9+4+3)*.5);
}}


//tapa inferior
translate([0,0,-6*h])
linear_extrude(3){
    difference(){
    union(){
    circle(d=d1+9+4);
   nema17_holes(d=7,r=(d1+9+4+3)*.5);
    }
    circle(d=55);
    
    nema17_holes(d=3,r=(d1+9+4+3)*.5);
    }}
//external gear
translate([0,0,-3*h-10])
difference(){
linear_extrude(6+h+h+1+0.6){
   
    
    difference(){
        union(){
    circle(d=d1+9+4);
            nema17_holes(d=7,r=(d1+9+4+3)*.5);
        }
        circle(d=30);
    nema17_holes(d=3,r=(d1+9+4+3)*.5);
    
        }
}

translate([0,0,1])
linear_extrude(h+1,twist=tang*(h+1)/(n*r))
engrane(n=n-1,rmod=r*n/(n-1),rmul=rmul);
translate([0,0,1.3+h])
cylinder(d=d1+9+0.5,h=15);

}



//geared base
difference(){
linear_extrude(6+h)
difference(){
    circle(d=d1+9);
    circle(d=30);
    nema17_holes();
}
translate([0,0,4])
linear_extrude(5)
nema17_holes(d=6.3);
translate([0,0,6])
linear_extrude(h+4,twist=tang*(h+4)/(r*n))
engrane(n=n,rmod=r,rmul=rmul);
}
//pinion
translate([0,0,0])
rotate([0,0,-2])
linear_extrude(2*h,twist=-tang*(2*h)/(n2*r))
difference(){
    engrane(n=n2,rmod=r,rmul=rmul);
nema17_eje(s=1.08);
}

//engranes

translate([r*(n2+n1),0,2*h+4])
linear_extrude(2*h,twist=tang*2*h/(n1*r*0.98))
engrane(n=n1,rmod=r*0.98,rmul=rmul);

