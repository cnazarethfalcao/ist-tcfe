C1=220e-9
R1=1000

C2=110e-9
R2=1e3

R3=100e3
R4=1e3
R5=100e3

Vcc=10


wl=1/R1/C1
wh=1/R2/C2
wo=(sqrt(wl*wh))
fo=wo/2/pi
ucf=wh/2/pi
lcf=wl/2/pi



Tcf=(R1*C1*j*wo/(1+(R1*C1*j*wo)))*(1+(R3+R5)/R4)*(1/(1+(R2*C2*j*wo)))
Tcf_db=20*log10(abs(Tcf))

f=fopen("tr1.tex","w")
fprintf(f,"$Lower Cut-off Frequency [Hz]$ & %e \\\\ \\hline \n",lcf);
fprintf(f,"$Upper Cut-off Frequency [Hz]$ & %e \\\\ \\hline \n",ucf);
fprintf(f,"$Central Frequency [Hz]$ & %e \\\\ \\hline \n",fo);
fprintf(f,"$Gain [dB]$ & %e \\\\ \\hline \n",Tcf_db);
fclose(f)



zin=abs(R1+(1/(j*wo*C1)))
zout=abs(1/((1/R2)+(j*wo*C2)))

f=fopen("tr2.tex","w")
fprintf(f,"$Input impedance$ & %e \\\\ \\hline \n",zin)
fprintf(f,"$Output impedance$ & %e \\\\ \\hline \n",zout)
fclose(f)



freq=logspace(1,8,100)
w=2*pi*freq
s=j*w
Tdb = ones(1,length(s))
for k = 1:length(s)
	T(k) = ((R1*C1*s(k))./(1+R1*C1*s(k))).*(1+(R3+R5)/R4).*(1/(1+R2*C2*s(k)))
	Tdb(k) = 20*log10(abs(T(k)))
end
	
%%%%%%%%%%%%%%%

ph=figure();
plot(log10(freq),(180*arg(T)/pi),"b")
title("Phase - Frequency Response")
xlabel("Frequency [Hz]")
ylabel("Phase [Deg]")
print(ph, "phase.eps", "-depsc")

gf=figure ();
plot(log10(freq),Tdb,"g")
title("Gain - Frequency Response")
xlabel ("Frequency [Hz]")
ylabel ("Gain")
legend("v_o(f)/v_i(f)")
print (gf, "gain.eps", "-depsc")
  
  
	
gaindev_db=abs(40-Tcf_db)
gaindev=10^(gaindev_db/20)

cfdev=abs(1000-fo)

cost=13626.44-100-0.11

merit=1/(cost*(gaindev+cfdev+10e-6))

f=fopen("tr3.tex","w")
fprintf(f,"$Gain Deviation [V]$ & %e \\\\ \\hline \n",gaindev);
fprintf(f,"$Central Frequency Deviation [Hz]$ & %e \\\\ \\hline \n",cfdev);
fprintf(f,"$Cost$ & %e \\\\ \\hline \n",cost);
fprintf(f,"$Merit$ & %e \\\\ \\hline \n",merit);
fclose(f)
  
