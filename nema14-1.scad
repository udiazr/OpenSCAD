//$fn is resolution
$fn=60;
//r = approximated teeth radius
r=1.2;
//fraction of the nema17 used by the first gear
fra=0.75;
//number of teeth
n=round(fra*(25/1.414)/r);
//real radius of the teeth
r1=fra*(25/1.41)/n;
//height of the each part (everything is scalated by this height)
h=5;
echo(n);
 
 
 //axiliar height 
h1=h-2;
module cycloid(order=100, r=1,n=10,k=1){
     R=n*r;
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [(R-r)*cos(th)+r*cos(th*(R-r)/r), (R-r)*sin(th)-r*sin(th*(R-r)/r)] ];
     rof=r*k*3.1415*.5;
     offset(r=rof,$fn=30)
     polygon(coords);
 }
 
 
 
 
 
 
 //DUAL GEAR
 translate([0,0,h+2])
 union(){
 linear_extrude(2*h1+0.75)
     difference(){
 cycloid(r=r1,n=n-3,k=1);
         circle(d=12.2);
     }
 linear_extrude(h1+0.5)
     difference(){
 cycloid(r=r1,n=n-1,k=1);
         circle(d=12.2);
         }}

 module nema17_holes(){
     union(){
         
 for (i =[0:3]){ translate([26/1.414*cos(i*90+45),26/1.414*sin(i*90+45)])
     circle(d=3.1);}}
 }
 
 
 //LOWER BASE
 linear_extrude(h)
 difference(){
 square(size=35.2,center=true);
 union(){
 cycloid(r=r1,n=n,k=1.15);
 nema17_holes();
 }
 }
 
 
d1=r1*2*(n+1)+1;
 
 // OUTPUT GEAR
 translate([0,0,2*h1+2*h])
 linear_extrude(h-1)
 difference(){
 circle(d=d1);
 cycloid(r=r1,n=n-2,k=1.15);
 }
 
 
// UPPER BASE
translate([0,0,-3*h+3]) 
 difference(){
 linear_extrude(h+1){
     difference(){
 square(size=35.2,center=true);
 union(){
 circle(d=12.2);
 nema17_holes();}
 }
 }
 translate([0,0,1])
 cylinder(d=d1+0.2,h=h+2);
 }
 
 
 //OUTPUT AXIS
 translate([0,0,4*h+0]){
 difference(){
     union(){
     cylinder(d=d1,h=1);
     cylinder(d1=12,d2=12,h=3);
     translate([0,0,8])
    cube(size=[8,8,10],center=true);}
    translate([0,0,-1])
 cylinder(d=5.4,h=40);
    }
 
 }
 
 // EXCENTRIC NUT
 translate([0,0,-4*h]){
linear_extrude(2*h1+0.75)
     difference(){
     translate([0,-r1*1.15,0])
     circle(d=12);
         difference(){
     circle(d=5.2);
         translate([-5,2])
         square(size=[10,10]);}
     
    }
    
 // EXCENTRIC NUT1
 translate([0,0,-1*h+3]){
linear_extrude(2)
     difference(){
     translate([0,0,0])
     circle(d=9);
         difference(){
     circle(d=5.2);
         translate([-5,2])
         square(size=[10,10]);}
     
    }
 }
    
 
 //Bottom plate
 translate([0,0,18]) 
 difference(){
 linear_extrude(2){
     difference(){
 square(size=35.2,center=true);
 union(){
 circle(d=9.2);
 nema17_holes();}
 }
 }
 translate([0,0,1])
 cylinder(d=d1+0.5,h=h+2);
 }
 
 }
