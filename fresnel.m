function [ F ] = fresnel(k,w,f,l,pixel_size)
%Funkcja zwraca hologram soczewki fresnela

%[k w] - rozmiar hologramu
% f - ogniskowa [m]
% l - dlugosc fali

krok=pixel_size; %rozmiar pixela lcos w metrach
%Umieszczenie srodka mapy
x_obr=0; %wspolrzedne srodka przesuniecie o 19*10^(-6) to jeden pixel w lewo
y_obr=0;
obrx=k*krok;
obry=w*krok;
bokx=x_obr-obrx/2;
boky=y_obr-obry/2;

for m=1:k
   for n=1:w
      x=bokx+m*krok;
      y=boky+n*krok;
      r=sqrt(x.^2+y.^2);
F(n,m)=mod((1*pi*r^2)/(l*f),2*pi);
   end
end
end

