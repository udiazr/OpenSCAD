/*module cycloid(order=30, r=1,n=10,k=1){
     order=n*order;
     R=n*r;
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [(R-r)*cos(th)+r*cos(th*(R-r)/r), (R-r)*sin(th)-r*sin(th*(R-r)/r)] ];
     rof=r*k*3.1415*.5;
     offset(r=rof,$fn=30)
     polygon(coords);
 }
*/

module cycloid(order=30,r=1,n=10,k=1){
     order=n*order;
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*(n+1)*cos(th)-r*cos((n+1)*th),r*(n+1)*sin(th)-r*sin((n+1)*th)] ];
 rof=-r*k*3.1415*.5;
     offset(r=rof,$fn=30)
     polygon(coords);
}

 module engrane(n=16,rmod=1,rmul=3,ndientes=14){
    n=round(n);
n1=n*ndientes;
omega=360/n1;
theta=180/n1;
r1=rmod*n;
r2=rmul*rmod;
coord=[ for (i=[0:n1-1]) [(r1+r2*sin(i*360/ndientes+theta))*cos(omega*i),(r1+r2*sin(i*360/ndientes+theta))*sin(omega*i)] ];
polygon(coord);
};
 module nema17_holes(d=3){
    for(i=[0:3]){
        translate([31/1.414*cos(90*i+45),31/1.414*sin(90*i+45)])
        circle(d=d,$fn=30);} }

module nema17_eje(s=1){
 scale([s,s])
difference(){
circle(d=5,$fn=100);
translate([4,0])
square(size=[4,10],center=true);
}


module nema17_nut(h=3,d=10,s=1,e=1){
linear_extrude(h)
difference(){
circle(d=d2,$fn=100);
translate([0,e])
nema17_eje(s=s);
}}}


module lever(l=108,h=3,d=7){
    l1=l;
union(){
linear_extrude(h)
difference(){
square(size=[14,l1],center=true);
translate([0,l1/2-7.])
square(size=[10.4,10.4],center=true);
for(i=[1:4])
     translate([0,l1*.5-i*50])
     circle(d=3);
}

translate([0,l1/2-7.])
linear_extrude(h+2)
difference(){
circle(d=10*1.414+d);
//square(size=[14,14],center=true);
square(size=[10.3,10.3],center=true);
}
}

}

module nema17(h=10,d=0){
linear_extrude(h)
difference(){
  intersection(){
square(42,center=true);
    circle(d=54);}
    nema17_holes();
    circle(d=d);
}
}
