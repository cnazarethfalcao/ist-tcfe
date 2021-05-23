%gain stage
C1 =450e-06
RB1 =23000 
RB2 =2000
RC1 =3500
RE1 =100
Rout=200
C2 =550e-06
Cout=200e-6

vi = 0.01;
VT=25e-3;
BFN=178.7;
VAFN=69.7;
VBEON=0.7;
VCC=12;
RS=100;

RB=1/(1/RB1+1/RB2);
VEQ=RB2/(RB1+RB2)*VCC;
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1);
IC1=BFN*IB1;
IE1=(1+BFN)*IB1;
VE1=RE1*IE1;
VO1=VCC-RC1*IC1;
VCE=VO1-VE1;

f=fopen("data_gain.tex","w")
fprintf(f,"$V_{T}$ & %e \\\\ \\hline \n",VT);
fprintf(f,"$Vcc$ & %e \\\\ \\hline \n",VCC);
fprintf(f,"$Beta$ & %e \\\\ \\hline \n",BFN);
fprintf(f,"$V_{A}$ & %e \\\\ \\hline \n",VAFN);
fprintf(f,"$R_{E}$ & %e \\\\ \\hline \n",RE1);
fprintf(f,"$R_{C}$ & %e \\\\ \\hline \n",RC1);
fprintf(f,"$R_{bias1}$ & %e \\\\ \\hline \n",RB1);
fprintf(f,"$R_{bias2}$ & %e \\\\ \\hline \n",RB2);
fprintf(f,"$C$ & %e \\\\ \\hline \n",C1);
fprintf(f,"$V_{BEON}$ & %e \\\\ \\hline \n",VBEON);
fprintf(f,"$R_{S}$ & %e \\\\ \\hline \n",RS);
fclose(f)

i = complex(0,1);
f = logspace(1,8, 100);
w = 2*pi*f;

gm1 = IC1/VT;
rpi1 = BFN/gm1;
ro1 = VAFN/IC1;
Zc1 = 1./(i*w*C1);
Zc2 = 1./(i*w*C2);

I=ones(length(w),4);
voE=zeros(1,length(w));
AV1=zeros(1,length(w));

for k=1:length(w)
A = [0, -RB, 0, 0, RS+RB;
    -RE1, -Zc2(k), 0, RE1 + Zc2(k), 0; 
    RE1 + ro1 + RC1, 0, -ro1, -RE1, 0;
    0, gm1*rpi1, 1, 0, 0;
    0, RB+Zc1(k)+rpi1+Zc2(k), 0, -Zc2(k), -RB];

N = [vi; 0; 0; 0; 0];
res = A\N;

voE(k) = abs(RC1 * res(1));
AV1(k) = voE(k)/vi;
endfor

ZI1 = 1/(1/RB + 1/rpi1);
ZO1 = 1/(1/ro1 + 1/RC1);


AV1F=abs(max(AV1))

f=fopen("results_gain.tex","w")
fprintf(f,"$Input impedance$ & %e \\\\ \\hline \n",ZI1);
fprintf(f,"$Output impedance$ & %e \\\\ \\hline \n",ZO1);
fprintf(f,"$Gain$ & %e \\\\ \\hline \n",AV1F);
fclose(f)

%ouput stage
BFP = 227.3
VAFP = 37.2
RE2 =200
VEBON = 0.7
VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2

f=fopen("data_output.tex","w")
fprintf(f,"$Beta$ & %e \\\\ \\hline \n",BFP);
fprintf(f,"$V_{A}$ & %e \\\\ \\hline \n",VAFP);
fprintf(f,"$R_{E}$ & %e \\\\ \\hline \n",RE2);
fprintf(f,"$V_{BE ON}$ & %e \\\\ \\hline \n",VBEON);
fprintf(f,"$V_{in}$ & %e \\\\ \\hline \n",VI2);
fclose(f)

gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

ro2 = 1/go2;
rpi2 = 1/gpi2;

I2=zeros(length(w),3);
vo2=zeros(1,length(w));
AV2 = zeros(1,length(w));

for k=1:length(w)
A2 = [rpi2+RE2, -RE2, 0;
    gm2*rpi2, 0, 1; 
    -RE2, RE2+ro2, -ro2];

N2 = [voE(k); 0; 0];
res = A2\N2;

vo2(k) = abs((res(1)-res(2))*RE2);
AV2(k) = vo2(k)/voE(k);
endfor

ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2);
ZO2 = 1/(gm2+gpi2+go2+ge2);

AV2F=abs(max(AV2))

f=fopen("results_output.tex","w")
fprintf(f,"$Input impedance$ & %e \\\\ \\hline \n",ZI2);
fprintf(f,"$Output impedance$ & %e \\\\ \\hline \n",ZO2);
fprintf(f,"$Gain$ & %e \\\\ \\hline \n",AV2F);
fclose(f)

%total
AV = AV1.*AV2
gB = 1/(1/gpi2+ZO1)
ZI=ZI1
ZO = 1/(gm2*(rpi2/(rpi2+ZO1))+(1/(rpi2+ZO1))+go2+ge2)
AVF=abs(max(AV))
AVdb = 20*log10(AV);
maximo = max(AVdb);



hp = figure ();
plot (log10(w/(2*pi)), 20*log10(AV), "g");
legend("v_{o}(f)/v_{i}(f)");
xlabel ("Frequency [Hz]");
ylabel ("Gain");
print (hp, "freqgain", "-depsc");


k = 1;

while  0.05 < ((maximo - AVdb(k))/maximo)
    k = k + 1;
endwhile

lcf = (w(k))/(2*pi);
ucf = 1.434592e6;

cost=1229.1
gain=AVF
bwd=ucf-lcf
merit=(gain*bwd)/(cost*lcf)

f=fopen("results_total.tex","w")
fprintf(f,"$Input impedance$ & %e \\\\ \\hline \n",ZI);
fprintf(f,"$Output impedance$ & %e \\\\ \\hline \n",ZO);
fprintf(f,"$Gain$ & %e \\\\ \\hline \n",gain);
fprintf(f,"$Lower Cut-off Frequency$ & %e \\\\ \\hline \n",lcf);
fprintf(f,"$Bandwidth$ & %e \\\\ \\hline \n",bwd);
fprintf(f,"$Cost$ & %e \\\\ \\hline \n",cost);
fprintf(f,"$Merit$ & %e \\\\ \\hline \n",merit);
fclose(f)

