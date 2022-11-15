//create a nema17 cycloidal base + 2 gear
$fn=40;

//Function to create a cycloidal gear polygon.
//Extrude to create a gear.

module cycloid(order=100, r=1,n=10,k=1){
     R=n*r;
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [(R-r)*cos(th)+r*cos(th*(R-r)/r), (R-r)*sin(th)-r*sin(th*(R-r)/r)] ];
     rof=r*k*3.1415*.5;
     offset(r=rof,$fn=30)
     polygon(coords);
 }
 
 r=1.5;
 fra=0.7;
 n=round(fra*(31/1.414)/r);
 r1=fra*(31/1.41)/n;
 h=6;
 echo(n);
 
 
 //DOUBLE GEAR
 translate([0,0,h+1])
 union(){
 linear_extrude(2*(h-1))
     difference(){
 cycloid(r=r1,n=n-3,k=1);
         circle(d=10);
     }
 linear_extrude(h-1)
     difference(){
 cycloid(r=r1,n=n-1,k=1);
         circle(d=10);
         }}

 //NEMA17 BASE
 linear_extrude(h)
 difference(){
 square(size=42.3,center=true);
 union(){
 cycloid(r=r1,n=n,k=1.1);
 for (i =[0:3]){ translate([31/1.414*cos(i*90+45),31/1.414*sin(i*90+45)])
     circle(d=3.1);}}
 }
 
 
 
     
 
