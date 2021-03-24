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
syms Kc
syms Va
syms Id

syms Vb_m
syms Vb_n
syms Vc_m
syms Vc_n
syms Ib_m
syms Ib_n
syms Ic_m
syms Ic_n


R1 = 1.02302308346
R2 = 2.05847187301
R3 = 3.14448265892
R4 = 4.0890992189
R5 = 3.06982128569
R6 = 2.02872154531
R7 = 1.04069982417

Va = 5.1692937016

Id = 1.0485127294

Kb = 7.21708907826
Kc = 8.33817212086

R1=R1*1000
R2=R2*1000
R3=R3*1000
R4=R4*1000
R5=R5*1000
R6=R6*1000
R7=R7*1000

Id=Id*0.001

Kb=Kb*0.001
Kc=Kc*1000

G1=1/R1
G2=1/R2
G3=1/R3
G4=1/R4
G5=1/R5
G6=1/R6
G7=1/R7

%Metodo das malhas
A_m=[(R1+R3+R4),-R3,-R4,0;(Kb*R3),(1-(Kb*R3)),0,0;-R4,0,(R4+R6+R7-Kc),0;0,0,0,1]

B_m=[Va;0;0;-Id]

x_m=A_m\B_m


I_A=x_m(1)
I_B=x_m(2)
I_C=x_m(3)
I_D=x_m(4)

V0=0

V1_m=Va
V2_m=V1_m-(R1*I_A)
V3_m=V2_m-(I_B*R2)
V4_m=V2_m-(I_A-I_B)*R3
V5_m=V4_m-(I_D-I_B)*R5
V6_m=I_C*R6
V7_m=V6_m+(I_C*R7)

Vb_m=V2_m-V4_m
Ib_m=Kb*Vb_m
Vc_m=V4_m-V7_m
Ic_m=(V0-V6_m)*G6

I1_m=(V1_m-V2_m)*G1
I2_m=(V3_m-V2_m)*G2
I3_m=(V2_m-V4_m)*G3
I4_m=V4_m*G4
I5_m=(V4_m-V5_m)*G5
I6_m=-V6_m*G6
I7_m=(V6_m-V7_m)*G7



f_m=fopen("rm_tab.tex","w")

fprintf(f_m,"$I_A$ & %e \\\\ \\hline \n",I_A);
fprintf(f_m,"$I_B$ & %e \\\\ \\hline \n",I_B);
fprintf(f_m,"$I_C$ & %e \\\\ \\hline \n",I_C);
fprintf(f_m,"$I_D$ & %e \\\\ \\hline \n",I_D);
fprintf(f_m,"$V1$ & %e \\\\ \\hline \n",V1_m);
fprintf(f_m,"$V2$ & %e \\\\ \\hline \n",V2_m);
fprintf(f_m,"$V3$ & %e \\\\ \\hline \n",V3_m);
fprintf(f_m,"$V4$ & %e \\\\ \\hline \n",V4_m);
fprintf(f_m,"$V5$ & %e \\\\ \\hline \n",V5_m);
fprintf(f_m,"$V6$ & %e \\\\ \\hline \n",V6_m);
fprintf(f_m,"$V7$ & %e \\\\ \\hline \n",V7_m);
fprintf(f_m,"$I1$ & %e \\\\ \\hline \n",I1_m);
fprintf(f_m,"$I2$ & %e \\\\ \\hline \n",I2_m);
fprintf(f_m,"$I3$ & %e \\\\ \\hline \n",I3_m);
fprintf(f_m,"$I4$ & %e \\\\ \\hline \n",I4_m);
fprintf(f_m,"$I5$ & %e \\\\ \\hline \n",I5_m);
fprintf(f_m,"$I6$ & %e \\\\ \\hline \n",I6_m);
fprintf(f_m,"$I7$ & %e \\\\ \\hline \n",I7_m);
fprintf(f_m,"$Vb$ & %e \\\\ \\hline \n",Vb_m);
fprintf(f_m,"$Vc$ & %e \\\\ \\hline \n",Vc_m);
fprintf(f_m,"$Ib$ & %e \\\\ \\hline \n",Ib_m);
fprintf(f_m,"$Ic$ & %e \\\\ \\hline \n",Ic_m);

fclose(f_m)

%Metodo dos nos
Linha_1=[1,0,0,0,0,0,0];
Linha_2=[-G1,G1+G2+G3,-G2,-G3,0,0,0]; 
Linha_3=[0,-G2-Kb,G2,Kb,0,0,0];          
Linha_4=[0,Kb,0,-G5-Kb,G5,0,0];          
Linha_5=[0,0,0,0,0,G6+G7,-G7];            
Linha_6=[0,0,0,1,0,G6*Kc,-1];
Linha_7=[0,-G3,0,G3+G4+G5,-G5,-G7,G7];


A_n=[Linha_1;Linha_2;Linha_3;Linha_4;Linha_5;Linha_6;Linha_7];

B_n=[Va;0;0;Id;0;0;-Id];

x_n=A_n\B_n

V1_n=x_n(1)
V2_n=x_n(2)
V3_n=x_n(3)
V4_n=x_n(4)
V5_n=x_n(5)
V6_n=x_n(6)
V7_n=x_n(7)


Vb_n=V2_n-V4_n
Ib_n=Kb*Vb_n
Vc_n=V4_n-V7_n
Ic_n=(V0-V7_n)*G6

I1_n=(V1_n-V2_n)*G1
I2_n=(V3_n-V2_n)*G2
I3_n=(V2_n-V4_n)*G3
I4_n=V4_n*G4
I5_n=(V4_n-V5_n)*G5
I6_n=-V6_n*G6
I7_n=(V6_n-V7_n)*G7



f_n=fopen("rn_tab.tex","w")

fprintf(f_n,"$V1$ & %e \\\\ \\hline \n",V1_n);
fprintf(f_n,"$V2$ & %e \\\\ \\hline \n",V2_n);
fprintf(f_n,"$V3$ & %e \\\\ \\hline \n",V3_n);
fprintf(f_n,"$V4$ & %e \\\\ \\hline \n",V4_n);
fprintf(f_n,"$V5$ & %e \\\\ \\hline \n",V5_n);
fprintf(f_n,"$V6$ & %e \\\\ \\hline \n",V6_n);
fprintf(f_n,"$V7$ & %e \\\\ \\hline \n",V7_n);
fprintf(f_n,"$I1$ & %e \\\\ \\hline \n",I1_n);
fprintf(f_n,"$I2$ & %e \\\\ \\hline \n",I2_n);
fprintf(f_n,"$I3$ & %e \\\\ \\hline \n",I3_n);
fprintf(f_n,"$I4$ & %e \\\\ \\hline \n",I4_n);
fprintf(f_n,"$I5$ & %e \\\\ \\hline \n",I5_n);
fprintf(f_n,"$I6$ & %e \\\\ \\hline \n",I6_n);
fprintf(f_n,"$I7$ & %e \\\\ \\hline \n",I7_n);
fprintf(f_n,"$Vb$ & %e \\\\ \\hline \n",Vb_n);
fprintf(f_n,"$Vc$ & %e \\\\ \\hline \n",Vc_n);
fprintf(f_n,"$Ib$ & %e \\\\ \\hline \n",Ib_n);
fprintf(f_n,"$Ic$ & %e \\\\ \\hline \n",Ic_n);

fclose(f_n);

