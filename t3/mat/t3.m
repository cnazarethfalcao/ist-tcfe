close all
clear all

pkg load symbolic

%-----------Dados---------%

A_p=230
f=50
w=2*pi*f
T=1/f

%-----------Transformador---------%
n=sqrt(20)

A=A_p/n


%-----------Envelope---------%

Re=80e3
Ce=85e-6

t=linspace(0,(10/50),1000)

v_s=A*cos(w*t)
v_o_r=zeros(1,length(t))
v_o=zeros(1,length(t))

t_off=(1/w)*atan(1/(w*Re*Ce))

for i=1:length(t)
  v_o_r(i)=abs(v_s(i));
endfor

for i=1:length(t)
  v_o_exp(i)=(A*abs(cos(w*t_off)))*exp(-(t(i)-t_off)/(Re*Ce))
  if t(i)<=t_off
    v_o(i)=v_o_r(i)
  elseif v_o_exp(i)>v_o_r(i)
    v_o(i)=v_o_exp(i)
  else
    t_off=t_off+(T/2)
    v_o(i)=v_o_r(i)
  endif
endfor

avg=mean(v_o)
ripple=max(v_o)-min(v_o)


hf = figure ();
plot (t, v_o, "g");
legend("v_{envelope}")
xlabel("t[ms]")
ylabel("V")
print(hf,"envelope.eps","-depsc")


%-----------Voltage Regulator---------%

Is=1e-14
Vt=0.025
eta=1

nd=18
Rvr=28.1e3

V_out=12 %ir buscar ao ngspice%

i=Is*(exp(12/(nd*eta*Vt))-1)
Rd=eta*(Vt/(i+Is))

for i=1:length(t)
  dvo(i)=((nd*Rd)/(Rvr+(nd*Rd)))*(v_o(i)-avg)
  v_out(i)=dvo(i)+V_out
endfor

ripple=max(v_out)-min(v_out)

avg_f=mean(v_out)
d=abs(avg_f-12)

%-----------cost and merit---------%

c=((Re+Rvr)/1000)+(Ce*1000000)+(0.1*(nd+4))
m=1/(c*(ripple+d+(1e-6)))


%-----------tables and graphics---------%

f=fopen("data.tex","w")
fprintf(f,"$n(transformer)$ & %e \\\\ \\hline \n",n);
fprintf(f,"$R_{envelope}$ & %e \\\\ \\hline \n",Re);
fprintf(f,"$C_{envelope}$ & %e \\\\ \\hline \n",Ce);
fprintf(f,"$n_{diodes}$ & %e \\\\ \\hline \n",nd);
fprintf(f,"$R_{vr}$ & %e \\\\ \\hline \n",Rvr);
fclose(f)

f=fopen("results.tex","w")
fprintf(f,"$average$ & %e \\\\ \\hline \n",avg_f);
fprintf(f,"$deviation$ & %e \\\\ \\hline \n",d);
fprintf(f,"$ripple$ & %e \\\\ \\hline \n",ripple);
fprintf(f,"$cost$ & %e \\\\ \\hline \n",c);
fprintf(f,"$merit$ & %e \\\\ \\hline \n",m);
fclose(f)


hf1 = figure (2)
plot (t, v_out, "b")
legend("v_{out}")
xlabel("t[ms]")
ylabel("V")
print(hf1,"vo.eps","-depsc")

hf2 = figure (3)
plot (t,v_out-12, "r")
legend("v_{out}-12")
xlabel("t[ms]")
ylabel("V")
print(hf2,"dev.eps","-depsc")
