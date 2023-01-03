




module engrane(n=16,rmod=1,rmul=3,ndientes=12){
    n=round(n);
n1=n*ndientes;
omega=360/n1;
theta=180/n1;
r1=rmod*n;
r2=rmul*rmod;
coord=[ for (i=[0:n1-1]) [(r1+r2*sin(i*360/ndientes+theta))*cos(omega*i),(r1+r2*sin(i*360/ndientes+theta))*sin(omega*i)] ];
polygon(coord);
}

rim=1.4;






d1=54;
rmod=0.6;
n=round(d1/rmod/2-7);
rmul=2.6;
h=3.;
d2=d1+2*rim;
difference(){
    linear_extrude(h+10)
    difference(){
circle(d=d2,$fn=100);
engrane(n=n,rmod=rmod,rmul=rmul);
    }
translate([0,0,h+2])
linear_extrude(20)
intersection(){
circle(d=d1,$fn=100);
square(42,center=true);
}

}

translate([0,0,10+3*h])
difference(){
linear_extrude(8+3*h+2)
difference(){
    circle(d=d2+2*rim+0.4,$fn=100);
    engrane(n=n-1,rmod=rmod*n/(n-1),rmul=rmul);
}
translate([0,0,h])
    cylinder(d=d2+0.5,h=3*h+10,$fn=50);
}

nmenos=4;
translate([nmenos*rmod,0,10*h+5])
linear_extrude(2*h+2)
difference(){
engrane(n=n-nmenos,rmod=rmod*1,rmul=rmul*1.04);
circle(r=(n-nmenos-rmul)*rmod-rim,$fn=100);
}
$fn=50;
d4=12.2;
translate([0,0,2*h+1])
linear_extrude(2*h)
difference(){
    circle(r=(n-nmenos-rmul)*rmod-rim-0.4,$fn=100);
    circle(d=d4+0.4);
}


linear_extrude(2*h)
difference(){
circle(d=d4,$fn=100);
translate([0,nmenos*rmod*1.05])
scale([1.07,1.07])
difference(){
circle(d=5,$fn=100);
translate([4,0])
square(size=[4,10],center=true);
}
}