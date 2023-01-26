//nema planetario precision
include <libnema.scad>
$ndiente=14;
$fn=100;
r1=0.5;
rmul=4;
d1=33;
n=round(d1/r1/2);
r=d1/n/2;
ratio=2.0;
n1=round(n/(1+ratio));
n2=n-2*n1-1;
h=5;

r3=(n+rmul+4)*r+0;

//base
difference(){
linear_extrude(2*h+2.5)
difference(){
intersection(){
    square(42,center=true);
    circle(d=54);}
nema17_holes();
engrane(n=n,rmod=r,rmul=rmul);
}
translate([0,0,h+2])
cylinder(r=r3,h=h+10);
}

//aro 
translate([0,0,2*h+3])
linear_extrude(h+0.3)
difference(){
    circle(r=r3-0.25);
engrane(n=n-2,rmod=r*n/(n-2),rmul=rmul);
    }

//engrane nema
linear_extrude(2*h)
difference(){
  rotate([0,0,0])
engrane(n=n1,rmod=r,rmul=rmul);
    nema17_eje(s=1.06);
}

//engrane
translate([(n1+n2)*r,0,2+3*h+2])
linear_extrude(2*h)
difference(){
engrane(n=n2,rmod=r,rmul=rmul);
}
/*translate([-(n1+n2)*r,0,15+h+2])
linear_extrude(h)
difference(){
engrane(n=n2,rmod=r,rmul=rmul);
}
*/

echo("n=",n);
echo("ratio",n*n/n1);
echo("res=",n*n);