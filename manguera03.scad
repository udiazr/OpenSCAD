//garden hose adapter

d1=1.0625*25.4;
p1=25.4/11.5;
n1=3.5;
w1=5;
n3=5;

n2=1.5; //rosca cople
d2=22; //diamcople

h1=4;
//+n3*p1;
p2=2.5;
$fn=40;


//linear_extrude(n1*p1,twist=-360*n1)

difference(){
    union(){
translate([0,0,-p2*2])
linear_extrude(p2*2,twist=-360*2)
    translate([p2/5,0])
    circle(d=22+1+5);
cylinder(d1=22+1+5,d2=d1+5,h=4);
translate([0,0,4])
cylinder(d=d1+5,h=n1*p1);}
translate([0,0,-p2*2-0.1])
cylinder(d=d2,h=p2*2+n1*p1+4+1);
translate([0,0,4])
linear_extrude((n1+1)*p1,twist=-360*(n1+1))
translate([p1/3.5,0])
    circle(d=d1);
}

h3=1.5;
translate([2*d1,0])
union(){
linear_extrude(h3)
    difference(){
        circle(d=22+1+5+5+1.1);
        circle(d=20 );
    }
linear_extrude(p2*(2+h3/p2),twist=-360*(2+1/p2))
difference(){
    circle(d=22+1+5+5+1);
    translate([p2/5,0])
    circle(d=22+1+5+1);
}

}



h4=19;

translate([0,2*d1])
difference(){
union(){
    linear_extrude(1,twist=-360*0/p1)
    translate([p1/500,0])
        circle(d=d1-0.6);
    cylinder(d=d2,h=5);
    cylinder(d1=20.5,d2=15,h=h4);
}   
   translate([0,0,-0.1])
    cylinder(d1=16,d2=11,h=h4+0.5);
}
