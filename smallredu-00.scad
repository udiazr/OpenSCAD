include <libnema.scad>

$t=1*0.5*$t;
$fn=100;   // precision
rmod=1.0; //size of the teeth
r=rmod;
d1=38;   // approximate diameter of the base gear.
n=round(d1/rmod/2)-1;  // number of teeth
h=4;   // height of each gear
rim=0;   // add extra diameter to inner gear
nmenos=n-6; // How many teeth the inner gear has. It is better 1.
ncentral=6;
tang=4; // twist angle. Degrees/height .
d2=rmod*nmenos*2+5+2.8; // Eccentric axis diameter Should be the smallest posible (here this is the smallest 3d printable and functional that I can make)
k=1 ; //k inner gear k=1.0 has the same post radius than the circle radius. It should be greater than 1., for example 1.1 to be a bit loose, 1.0 you need 0 tolerance to fit (maybe with a TPU gear).
kmul=1.12;

//BASE
color([1,0,0])
difference(){
linear_extrude(2*h+2)
difference(){
intersection(){
    square(42,center=true);
    circle(d=54);
}
nema17_holes();
cycloid(n=n,r=r,k=k);
}
translate([0,0,h+2])
cylinder(r=(n+1)*r,h=h+1);
}


//INNER GEAR
color([0,1,0])
translate([r*cos($t*360),r*sin($t*360),3*h+4])
rotate([0,0,-$t*360/(n-1)])
union(){
linear_extrude(h)
difference(){
cycloid(n=n-1,r=r,k=k*kmul);
cycloid(n=ncentral+1,r=r,k=k*kmul);
}
linear_extrude(2*h)
difference(){
cycloid(n=n-3,r=r,k=k*kmul);
cycloid(n=ncentral+1,r=r,k=k);
}

}

//OUTPUT RING
translate([0,0,2*h+3])
linear_extrude(h)
difference(){
    circle(r=(n+1)*r-0.2);
    cycloid(n=n-2,r=r,k=1.04);
}

//PINION
echo("t=",$t);
translate([0,0,5*h+5])
rotate([0,0,360/(ncentral)/2-$t*360*ncentral/n*.6])
union(){
linear_extrude(2*h)
    difference(){
cycloid(n=ncentral,r=r,k=k*kmul*1.1);
nema17_eje(s=1.05);
    }
}
    
    //eccentric nut
//for (ecc=[1.05,1.15,1.25])
//translate([nmenos*rmod,(ecc-1.05)*300-50,-2*h])
//nema17_nut(h=h,d=d2,s=1.07,e=nmenos*rmod*ecc);
echo("r=",r,"h=",h);
echo("n=",n);
echo("ratio:",n*(n-2)/2/ncentral);