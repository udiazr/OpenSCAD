include <libnema.scad>
$ndiente=16;
n=3;
n1=8;
r=2;
k=1;
//$t=0;
//ratio
//w2=w0*n/(n+1)*n1/(n1+1)
//w2'=w2-w2=0
//w1'=w1-w2=w0*n/(n+1)(1-n1/(n1+1))
//w0'=w0-w2=w0(1-n/(n+1)*n1/(n1+1))
//a1=n/(n+1)
//a2=n1/(n1+)
//a1*(1-a2)/(1-a1*a2)


$t=10*$t;

angle02=$t*360*n/(n+1)*n1/(n1+1);
angle00=$t*360-angle02;
angle01=$t*360*n/(n+1)-angle02;

// w0=w0
// w2=w2/(w0-w2)=(w2-w0+w0)/(w0-w2)=w0/(w0-w2)-1
//w2=n*n1/((n1+1)*(n+1))/(1-n*n1/(n
//w1=(w1-w2)/(w0-w2)

angle0=$t*360;
angle1=$t*360*angle01/angle00;
angle2=$t*360*angle02/angle00;

//pinion
color([0,1,0])
rotate([0,0,angle0])
linear_extrude(4)
cycloid(n=n,r=r,k=k);

//internal gear
color([1,0,0])
translate([-r*cos(angle2),r*sin(angle2),0])
linear_extrude(2)
rotate([0,0,angle1])
difference(){
cycloid(n=n1,r=r,k=k);
cycloid(n=n+1,r=r,k=k);
}
//external gear

translate([0,0,0])
rotate([0,0,-180])
difference(){
    circle(r=(n1+2)*r);
    cycloid(n=n1+1,r=r);
}