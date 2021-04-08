close all
clear all

pkg load symbolic

syms R1
syms R2
syms R3
syms R4
syms R5
syms R6
syms R7
syms Kb
syms Kd
syms Vs
syms f

values = dlmread('data.txt');
R1 = values(2,4);
R2 = values(3,3);
R3 = values(4,3);
R4 = values(5,3);
R5 = values(6,3);
R6 = values(7,3);
R7 = values(8,3);	
Vs = values(9,3);
C = values(10,3);
Kb = values(11,3);
Kd = values(12,3);
 
f=1000

R1=R1*1000
R2=R2*1000
R3=R3*1000
R4=R4*1000
R5=R5*1000
R6=R6*1000
R7=R7*1000

Kb=Kb*0.001
Kd=Kd*1000

C=C*0.000001

G1=1/R1
G2=1/R2
G3=1/R3
G4=1/R4
G5=1/R5
G6=1/R6
G7=1/R7

% ------------------------ 1 ------------------------%

Linha_1_1=[1,0,0,0,0,0,0,0];
Linha_2_1=[-G1,G1+G2+G3,-G2,-G3,0,0,0,0]; 
Linha_3_1=[0,-G2-Kb,G2,Kb,0,0,0,0];          
Linha_4_1=[0,Kb,0,-G5-Kb,G5,0,0,0];          
Linha_5_1=[0,0,0,0,0,G6+G7,-G7,0];
Linha_6_1=[0,0,0,1,0,Kd*G6,-1,0];            
Linha_7_1=[0,-G3,0,G3+G4+G5,-G5,0,0,-1];
Linha_8_1=[0,0,0,0,0,-G7,G7,1]

A_1=[Linha_1_1;Linha_2_1;Linha_3_1;Linha_4_1;Linha_5_1;Linha_6_1;Linha_7_1;Linha_8_1];

B_1=[Vs;0;0;0;0;0;0;0];

x_1=A_1\B_1

V1_1=x_1(1)
V2_1=x_1(2)
V3_1=x_1(3)
V5_1=x_1(4)
V6_1=x_1(5)
V7_1=x_1(6)
V8_1=x_1(7)

I1_1=(V1_1-V2_1)*G1
I2_1=(V2_1-V3_1)*G2
I3_1=(V5_1-V2_1)*G3
I4_1=V5_1*G4
I5_1=(V6_1-V5_1)*G5
I6_1=-V7_1*G6
I7_1=(V7_1-V8_1)*G7

Vb_1=V2_1-V5_1
Ib_1=Kb*Vb_1
Id_1=I6_1
Vd_1=Kb*Id_1
Vc_1=0


f1=fopen("f1_tab.tex","w")

fprintf(f1,"$V1$ & %e \\\\ \\hline \n",V1_1);
fprintf(f1,"$V2$ & %e \\\\ \\hline \n",V2_1);
fprintf(f1,"$V3$ & %e \\\\ \\hline \n",V3_1);
fprintf(f1,"$V5$ & %e \\\\ \\hline \n",V5_1);
fprintf(f1,"$V6$ & %e \\\\ \\hline \n",V6_1);
fprintf(f1,"$V7$ & %e \\\\ \\hline \n",V7_1);
fprintf(f1,"$V8$ & %e \\\\ \\hline \n",V8_1);
fprintf(f1,"$I1$ & %e \\\\ \\hline \n",I1_1);
fprintf(f1,"$I2$ & %e \\\\ \\hline \n",I2_1);
fprintf(f1,"$I3$ & %e \\\\ \\hline \n",I3_1);
fprintf(f1,"$I4$ & %e \\\\ \\hline \n",I4_1);
fprintf(f1,"$I5$ & %e \\\\ \\hline \n",I5_1);
fprintf(f1,"$I6$ & %e \\\\ \\hline \n",I6_1);
fprintf(f1,"$I7$ & %e \\\\ \\hline \n",I7_1);
fprintf(f1,"$Vb$ & %e \\\\ \\hline \n",Vb_1);
fprintf(f1,"$Vc$ & %e \\\\ \\hline \n",Vc_1);
fprintf(f1,"$Vd$ & %e \\\\ \\hline \n",Vd_1);
fprintf(f1,"$Ib$ & %e \\\\ \\hline \n",Ib_1);
fprintf(f1,"$Id$ & %e \\\\ \\hline \n",Id_1);

fclose(f1)



% ------------------------ 2 ------------------------%


Vx=V6_1-V8_1


Linha_1_2=[1,0,0,0,0,0,0,0,0,0,0]
Linha_2_2=[-G1,G1+G2+G3,-G2,-G3,0,0,0,0,0,0,0]
Linha_3_2=[0,-G2,G2,0,0,0,0,0,0,-1,0]
Linha_4_2=[G1+G4,-G1,0,-G4,0,0,0,0,0,0,1]
Linha_5_2=[0,0,0,0,0,G7,-G7,0,0,0,-1]
Linha_6_2=[0,0,0,1,0,0,-1,0,-1,0,0]
Linha_7_2=[G6,0,0,0,0,-G6,0,0,0,0,-1]
Linha_8_2=[0,1,0,-1,0,0,0,-1,0,0,0]
Linha_9_2=[0,0,0,0,1,0,-1,0,0,0,0]
Linha_10_2=[0,0,0,0,0,0,0,-Kb,0,1,0]
Linha_11_2=[0,0,0,0,0,0,0,0,1,0,-Kd]


A_2=[Linha_1_2;Linha_2_2;Linha_3_2;Linha_4_2;Linha_5_2;Linha_6_2;Linha_7_2;Linha_8_2;Linha_9_2;Linha_10_2;Linha_11_2];

B_2=[0;0;0;0;0;0;0;0;Vx;0;0];

x_2=A_2\B_2

V1_2=x_2(1)
V2_2=x_2(2)
V3_2=x_2(3)
V5_2=x_2(4)
V6_2=x_2(5)
V7_2=x_2(6)
V8_2=x_2(7)
Vb_2=x_2(8)
Vd_2=x_2(9)
Ib_2=x_2(10)
Id_2=x_2(11)

I1_2=(V1_2-V2_2)*G1
I2_2=(V2_2-V3_2)*G2
I3_2=(V5_2-V2_2)*G3
I4_2=V5_2*G4
I5_2=(V6_2-V5_2)*G5
I6_2=-V7_2*G6
I7_2=(V7_2-V8_2)*G7

Ix=(V6_2-V5_2)*G5+Id_2

Req=Vx/Ix
tc=Req*C

f2=fopen("f2_tab.tex","w")

fprintf(f2,"$Vx$ & %e \\\\ \\hline \n",Vx);
fprintf(f2,"$Ix$ & %e \\\\ \\hline \n",Ix);
fprintf(f2,"$Req$ & %e \\\\ \\hline \n",Req);
fprintf(f2,"$Time Constant$ & %e \\\\ \\hline \n",tc);
fprintf(f2,"$V1$ & %e \\\\ \\hline \n",V1_2);
fprintf(f2,"$V2$ & %e \\\\ \\hline \n",V2_2);
fprintf(f2,"$V3$ & %e \\\\ \\hline \n",V3_2);
fprintf(f2,"$V5$ & %e \\\\ \\hline \n",V5_2);
fprintf(f2,"$V6$ & %e \\\\ \\hline \n",V6_2);
fprintf(f2,"$V7$ & %e \\\\ \\hline \n",V7_2);
fprintf(f2,"$V8$ & %e \\\\ \\hline \n",V8_2);
fprintf(f2,"$I1$ & %e \\\\ \\hline \n",I1_2);
fprintf(f2,"$I2$ & %e \\\\ \\hline \n",I2_2);
fprintf(f2,"$I3$ & %e \\\\ \\hline \n",I3_2);
fprintf(f2,"$I4$ & %e \\\\ \\hline \n",I4_2);
fprintf(f2,"$I5$ & %e \\\\ \\hline \n",I5_2);
fprintf(f2,"$I6$ & %e \\\\ \\hline \n",I6_2);
fprintf(f2,"$I7$ & %e \\\\ \\hline \n",I7_2);
fprintf(f2,"$Vb$ & %e \\\\ \\hline \n",Vb_2);
fprintf(f2,"$Vd$ & %e \\\\ \\hline \n",Vd_2);
fprintf(f2,"$Ib$ & %e \\\\ \\hline \n",Ib_2);
fprintf(f2,"$Id$ & %e \\\\ \\hline \n",Id_2);


fclose(f2)


% ------------------------ 3 ------------------------%
% V6n em funcao de t

syms t
syms v6_n(t)

t=0:1e-06:20e-03;

v6_n=(V8_2+Vx)*exp(-(t/tc))


ns = figure ();
plot (t*1000, v6_n);
xlabel ("t[ms]");
ylabel ("v_{6n} [V]");
print (ns, "natural_solution.eps", "-color");
close(ns)


% ------------------------ 4 ------------------------%

w=2*pi*f
yc=j*w*C
zc=1/yc

Linha_1_4=[1,0,0,0,0,0,0,0,0,0,0]
Linha_2_4=[-G1,G1+G2+G3,-G2,-G3,0,0,0,0,0,0,0]
Linha_3_4=[0,-G2-Kb,G2,Kb,0,0,0,0,0,0,0] 
Linha_4_4=[0,Kb,0,-Kb-G5,G5+yc,0,-yc,0,0,0,0]
Linha_5_4=[0,0,0,0,0,G6+G7,-G7,0,0,0,0]
Linha_6_4=[G1,-G1,0,-G4,0,-G6,0,0,0,0,0]
Linha_7_4=[0,0,0,1,0,Kd*G6,-1,0,0,0,0]



A_4=[Linha_1_4;Linha_2_4;Linha_3_4;Linha_4_4;Linha_5_4;Linha_6_4;Linha_7_4]

B_4=[1;0;0;0;0;0;0]

x_4=A_4\B_4

V1_4=x_4(1)
V2_4=x_4(2)
V3_4=x_4(3)
V5_4=x_4(4)
V6_4=x_4(5)
V7_4=x_4(6)
V8_4=x_4(7)


V1_r=real(V1_4)
V1_i=imag(V1_4)
V1_a=sqrt((V1_r*V1_r)+(V1_i*V1_i))
V1_ph=atan(V1_i/V1_r)

V2_r=real(V2_4)
V2_i=imag(V2_4)
V2_a=sqrt((V2_r*V2_r)+(V2_i*V2_i))
V2_ph=atan(V2_i/V2_r)

V3_r=real(V3_4)
V3_i=imag(V3_4)
V3_a=sqrt((V3_r*V3_r)+(V3_i*V3_i))
V3_ph=atan(V3_i/V3_r)

V5_r=real(V5_4)
V5_i=imag(V5_4)
V5_a=sqrt((V5_r*V5_r)+(V5_i*V5_i))
V5_ph=atan(V5_i/V5_r)

V6_r=real(V6_4)
V6_i=imag(V6_4)
V6_a=sqrt((V6_r*V6_r)+(V6_i*V6_i))
V6_ph=atan(V6_i/V6_r)

V7_r=real(V7_4)
V7_i=imag(V7_4)
V7_a=sqrt((V7_r*V7_r)+(V7_i*V7_i))
V7_ph=atan(V7_i/V7_r)

V8_r=real(V8_4)
V8_i=imag(V8_4)
V8_a=sqrt((V8_r*V8_r)+(V8_i*V8_i))
V8_ph=atan(V8_i/V8_r)

save("-ascii","../doc/f4.tex", "V1_a", "V2_a", "V3_A", "V5_A", "V6_a", "V7_a", "V8_a", "V1_ph", "V2_ph", "V3_ph", "V5_ph", "V6_ph", "V7_ph", "V8_ph","V6_r");


% ------------------------ 5 ------------------------%

t=-5e-3:1e-6:20e-3;

Vs_t(t>=0) = sin(w*t(t>=0));
Vs_t(t<0) = Vs;

V6_t(t>=0)= Vx*exp(-t(t>=0)/tc) + V6_4*sin(w*t(t>=0)) ;
V6_t(t<0) = V6_1;	
 
tsol = figure();
plot(t, V6_t, t, Vs_t);
xlabel ("t[ms]");
ylabel ("V");
legend("V6","Vs");
#title ("Total solution of v_6(t) and v_s(t)");
print (tsol, "tsol.eps", "-color");
close(tsol);
  
  
% ------------------------ 6 ------------------------%

f =-1:0.1:6; %Hz
w = 2*pi*power(10,f);
	
Vs_ph= 1*power(e,-j*pi/2);
yc=j.*w.*C
zc=1. ./yc;

Linha_1_6 =[Kb+1./R2,-1./R2,-Kb,0]
Linha_2_6=[1./R3-Kb,0,Kb-1./R3-1./R4,-1./R6]
Linha_3_6=[Kb-1./R1-1./R3,0,1./R3-Kb,0]
Linha_4_6=[0,0,1.,Kd/R6-R7/R6-1.];

A_6=[Linha_1_6;Linha_2_6;Linha_3_6;Linha_4_6]    
  
B_6 = [0;0;-Vs_ph/R1;0];
	
x_6=A_6\B_6   % v2, v3, v5, v7
	 
V8_6=R7*(1./R1+1./R6)*x_6(4) + 0*zc;
V6_6=(((1./R5)+Kb)*x_6(3)-Kb*x_6(1)+ (V8_6 ./ zc)) ./ ((1./R5) + (1. ./ zc));
Vc_6=V6_6-V8_6;
Vs_6=power(e,j*pi/2)+0*w;

V6_ph=(180/pi)*(angle(V6_6))

for aux=1:length(V6_ph)
  if(V6_ph(aux)<=-90)
    V6_ph(aux)=V6_ph(aux)+180
  elseif(V6_ph(aux)>=90)
    V6_ph(aux)=V6_ph(aux)-180
  endif
endfor
	
mg=figure ();
plot(f, 20*log10(abs(Vc_6)), "b");
hold on;
plot (f, 20*log10(abs(V6_6)), "r");
hold on;
plot (f, 20*log10(abs(Vs_6)), "g");	
legend ("v_c","v_6","v_s");
xlabel ("log_{10}(f) [Hz]");
ylabel ("Magnitude v^~_c(f), v^~_6(f), v^~_s(f) [dB]");
print (mg, "magnitude.eps", "-depsc");
	

ph=figure ();
plot (f, V6_ph, "r");
hold on;
plot (f, (180/pi)*(angle(Vc_6) + pi), "b");
hold on;
plot (f, (180/pi)*angle(Vs_6), "g");
	
legend ("v_c","v_6","v_s");
xlabel ("log_{10}(f) [Hz]");
ylabel ("Phase v_c(f), v_6(f), v_s(f) [degrees]");
print (ph, "phase.eps", "-depsc");

%----------------------------------------------------------------%
%Ngspice%

filename = 't2_1.txt'
file =fopen(filename,'w');
fprintf(file,"R1 2 1 %.11e\nR2 3 2 %.11e\nR3 2 5 %.11e\nR4 5 0 %.11e\nR5 6 5 %.11e\nR6 N001 7 %.11e\nR7 8 7 %.11e\nV1 1 0 %.11e\nV2 0 N001 0\nG§Ib 6 3 2 5 %.11e\nH1 5 8 V2 %.11e\n",R1,R2,R3,R4,R5,R6,R7,Vs,Kb,Kd);
fflush(filename);
fclose(filename);

filename = 't2_2.txt'
file =fopen(filename,'w');
fprintf(file,"R1 2 1 %.11e\nR2 3 2 %.11e\nR3 2 5 %.11e\nR4 5 0 %.11e\nR5 6 5 %.11e\nR6 N001 7 %.11e\nR7 8 7 %.11e\nV1 1 0 0\nV2 0 N001 0\nG§Ib 6 3 2 5 %.11e\nH1 5 8 V2 %.11e\nV3 6 8 %.11e",R1,R2,R3,R4,R5,R6,R7,Kb,Kd,Vx);
fflush(filename);
fclose(filename);

filename = 't2_3.txt'
file =fopen(filename,'w');
fprintf(file,"R1 2 1 %.11e\nR2 3 2 %.11e\nR3 2 5 %.11e\nR4 5 0 %.11e\nR5 6 5 %.11e\nR6 N001 7 %.11e\nR7 8 7 %.11e\nV1 1 0 0\nV2 0 N001 0\nG§Ib 6 3 2 5 %.11e\nH1 5 8 V2 %.11e\nC1 6 8 %.11e\n\n.ic V(6)=%.11e\n.ic V(8)=0",R1,R2,R3,R4,R5,R6,R7,Kb,Kd,C,Vx);
fflush(filename);
fclose(filename);

filename = 't2_4.txt'
file =fopen(filename,'w');
fprintf(file,"R1 2 1 %.11e\nR2 3 2 %.11e\nR3 2 5 %.11e\nR4 5 0 %.11e\nR5 6 5 %.11e\nR6 N001 7 %.11e\nR7 8 7 %.11e\nV1 1 0 SIN(0 1 1000)\nV2 0 N001 0\nG§Ib 6 3 2 5 %.11e\nH1 5 8 V2 %.11e\nC1 6 8 %.11e\n\n.ic V(6)=%.11e\n.ic V(8)=0",R1,R2,R3,R4,R5,R6,R7,Kb,Kd,C,Vx);
fflush(filename);
fclose(filename);

filename = 't2_5.txt'
file =fopen(filename,'w');
fprintf(file,"R1 2 1 %.11e\nR2 3 2 %.11e\nR3 2 5 %.11e\nR4 5 0 %.11e\nR5 6 5 %.11e\nR6 N001 7 %.11e\nR7 8 7 %.11e\nV1 1 0 AC 1\nV2 0 N001 0\nG§Ib 6 3 2 5 %.11e\nH1 5 8 V2 %.11e\nC1 6 8 %.11e\n\n.ic V(6)=%.11e\n.ic V(8)=0\n.ac oct 0.020 0.1 1000000",R1,R2,R3,R4,R5,R6,R7,Kb,Kd,C,Vx);
fflush(filename);
fclose(filename);
