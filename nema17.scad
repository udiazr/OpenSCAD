$fn=60;
//change the radius to what you want
r=1.3;
module cycloid(order=100, r=1,n=10,k=1){
     R=n*r;
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [(R-r)*cos(th)+r*cos(th*(R-r)/r), (R-r)*sin(th)-r*sin(th*(R-r)/r)] ];
     rof=r*k*3.1415*.5;
     offset(r=rof,$fn=30)
     polygon(coords);
 }
 
 
 
 fra=0.7;
 n=round(fra*(31/1.414)/r);
 r1=fra*(31/1.41)/n;
 h=6;
 echo(n);
 
 
 
 h1=h-2;
 translate([0,0,h+2])
 union(){
 linear_extrude(2*h1)
     difference(){
 cycloid(r=r1,n=n-3,k=1);
         circle(d=10);
     }
 linear_extrude(h1)
     difference(){
 cycloid(r=r1,n=n-1,k=1);
         circle(d=10);
         }}

 module nema17_holes(){
     union(){
         
 for (i =[0:3]){ translate([31/1.414*cos(i*90+45),31/1.414*sin(i*90+45)])
     circle(d=3.1);}}
 }
 
 linear_extrude(h)
 difference(){
 square(size=42.3,center=true);
 union(){
 cycloid(r=r1,n=n,k=1.1);
 nema17_holes();
 }
 }
 
d1=r1*2*(n+1);
 translate([0,0,2*h1+2*h])
 linear_extrude(h-1)
 difference(){
 circle(d=d1);
 cycloid(r=r1,n=n-2,k=1.1);
 }
 
 

translate([0,0,-3*h+1]) 
 difference(){
 linear_extrude(h+1){
     difference(){
 square(size=42.3,center=true);
 union(){
     circle(d=15);
 nema17_holes();}
 }
 }
 translate([0,0,1])
 cylinder(d=d1+2,h=h+2);
 }
 
 translate([0,0,5*h]){
 union(){
     cylinder(d=d1,h=1);
     cylinder(d1=15,d2=0,h=4);
     translate([0,0,10])
 cube(size=[6,6,20],center=true);}
 }
 
 