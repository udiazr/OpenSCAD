module llave(n=6,scale=1){
p=25.4/11.5;
e=sqrt(3)/2*p/2;
d=1.0625*25.4;

difference(){
cylinder(d=d+6.7,h=n*p);
    translate([0,0,-0.1])
thread(d=d,n=n+1,p=p,e=e,scale=scale);
}
}

module rack(p=2,n=5,rmul=0.5,h=0){
coord=[ for(i=[0:$ndiente*n])
    [p*i/$ndiente,rmul*p*0.5*cos(i*360/$ndiente)]];
polygon(concat(coord,[[n*p,p*rmul*0.5+h],[0,p*rmul*.5+h]]));

}

module cycloid(n=10,r=1,k=1,ndiente=$ndiente){
coord=[ for (i=[0:ndiente*n]) [ r*(n+1)*cos(360*i/(ndiente*n))-r*cos((n+1)*360*i/(ndiente*n)),
    r*(n+1)*sin(i*360/ndiente/n)-r*sin((n+1)*i*360/ndiente/n)  ] ];

offset(-k*r*3.14159/2,$fn=ndiente)
    polygon(coord);
}
module cycloid1(n=10,r=1,k=1,ndiente=$ndiente){
coord=[ for (i=[0:ndiente*n]) [ r*(n+1)*cos(360*i/(ndiente*n))+r*cos((n+1)*360*i/(ndiente*n)),
    r*(n+1)*sin(i*360/ndiente/n)-r*sin((n+1)*i*360/ndiente/n)  ] ];

offset(-k*r*3.14159/2,$fn=ndiente)
    polygon(coord);
}

module cycloid2(n=10,r=1,k=1,ndiente=$ndiente){
coord=[ for (i=[0:ndiente*n]) [ r*(n+1)*cos(360*i/(ndiente*n))-r*cos((n+1)*360*i/(ndiente*n)),
    r*(n+1)*sin(i*360/ndiente/n)+r*sin((n+1)*i*360/ndiente/n)  ] ];

offset(-k*r*3.14159/2,$fn=ndiente)
    polygon(coord);
}

module thread(e=1,p=3.1415,n=5,d=15,scale=1){
linear_extrude(n*p,twist=-360*n,scale=scale)
translate([e,0])
circle(d=d);
}

 module engrane(n=16,rmod=1,rmul=3,ndientes=14){
    n=round(n);
n1=n*ndientes;
omega=360/n1;
theta=90/n1*0;
r1=rmod*n;
r2=rmul*rmod;
coord=[ for (i=[0:n1-1]) [(r1+r2*sin(i*360/ndientes+theta))*cos(omega*i),(r1+r2*sin(i*360/ndientes+theta))*sin(omega*i)] ];
polygon(coord);
};

module a2212_holes(d=3){
for(i=[0:3]) 
    translate([(17.5+1.5*cos(i*180))*cos(i*90)*0.5,(17.5+1.5*cos(i*180))*sin(i*90)*0.5])
    circle(d=d);}
module herring(h=10,n=16,tang=2,rmod=1,rmul=2,ndientes=14){
    union(){
    linear_extrude(h*.5,twist=h*.5*tang/(n*rmod))
 engrane(n=n,rmod=rmod,rmul=rmul,ndientes=ndientes);
    translate([0,0,h*.5])
    rotate([0,0,-tang*h*0.5/(n*rmod)])
    linear_extrude(h*.5,twist=-h*.5*tang/(n*rmod))
 engrane(n=n,rmod=rmod,rmul=rmul,ndientes=ndientes);
    }
}


module nema17_holes(d=3,r=21.92){
    for(i=[0:3]){
        translate([r*cos(90*i+45),r*sin(90*i+45)])
        circle(d=d,$fn=$fn);} }



module nema17_eje(d1=5,d2=4.5,s=1){
 scale([s,s])
    intersection(){
circle(d=d1);
translate([-d1*0.5,0])
square([d2*2,d1*10],center=true);
}

/*difference(){
circle(d=d1,$fn=100);
translate([d1-d2*0.5,0])
square(size=[d2,20],center=true);
}*/
}

module nema17_nut(h=3,d=10,s=1,e=1){
linear_extrude(h)
difference(){
    circle(d=d,$fn=100);
translate([0,e])
nema17_eje(s=s);
}}



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



module tornillo(r=10,r2=0,p=2,n=8,angle=60){
let(e=p/3.1415/2*tan(angle))
linear_extrude(p*n,twist=-360*n)
    difference(){
    translate([e,0])
        circle(r=r);
       circle(r=r2);
    }
}
