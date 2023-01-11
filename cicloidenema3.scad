include <libnema.scad>

// d1=54 circular nema17
// size=[42,42] square nema17
$fn=100;   // precision
rmod=1; //size of the teeth
d1=33;   // approximate diameter of the base gear.
n=round(d1/rmod/2)-1;  // number of teeth
h=3.5;   // height of each gear
rim=0;   // add extra diameter to inner gear
nmenos=1; // How many teeth the inner gear has. It is better 1.
tang=2; // twist angle. Degrees/height .
d2=rmod*nmenos*2+5+2.8; // Eccentric axis diameter Should be the smallest posible (here this is the smallest 3d printable and functional that I can make)
kinner=1.1; //k inner gear k=1.0 has the same post radius than the circle radius. It should be greater than 1., for example 1.1 to be a bit loose, 1.0 you need 0 tolerance to fit (maybe with a TPU gear).

//COVER
translate([0,0,-4*h-10])
linear_extrude(2)
difference(){
intersection(){
circle(d=54,$fn=100);
square(42,center=true);}
    circle(d=d1-5);
    nema17_holes();
}

//GEARED BASE

difference(){
linear_extrude(2*h+2+1.6) 
difference(){
intersection(){
circle(d=54,$fn=100);
square(42,center=true);}
nema17_holes();
}
translate([0,0,-0.01])
linear_extrude(2*h+4,twist=(2*h+4)*tang)
    cycloid(n=n,r=rmod);
translate([0,0,2+h])
cylinder(d=d1+2*rim+0.4,h=h+5);

}


//OUTPUT RING
translate([0,0,2*h+4.5])
linear_extrude(h,twist=-tang*h)
difference(){
    circle(d=d1+2*rim-0.2);
    cycloid(n=n-2,r=rmod);
}

//OUTPUT SHAFT
translate([0,0,-4*h-7])
difference(){
union(){
cylinder(h=1,d=d1+2*rim-0.3);
hcube=12;
translate([0,0,hcube*0.5])
cube(size=[10,10,hcube],center=true);
    }
translate([0,0,-0.1])
cylinder(d=5.6,h=20);
}


//INNER GEAR

translate([nmenos*rmod,0,3*h+6])
union(){
linear_extrude(h,twist=tang*h)
difference(){
cycloid(n=n-nmenos,r=rmod,k=kinner);
circle(d=d2+0.6);
}
linear_extrude(2*h,twist=-tang*2*h)
difference(){
cycloid(n=n-nmenos-2,r=rmod,k=kinner);
circle(d=d2+0.6);
}
}
//eccentric nut
for (ecc=[1.10,1.20,1.30,1.45])
translate([nmenos*rmod,(ecc-1.05)*300-50,-2*h])
nema17_nut(h=2*h-1.3,d=d2,s=1.07,e=nmenos*rmod*ecc);

echo("n=",n);
echo("n=",n-2);
echo("ratio=",n*(n-2)*0.5);