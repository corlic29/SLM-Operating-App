function slm2(mapa)
NET.addAssembly('D:\OneDrive - Politechnika Wroclawska\Laboratorium\Aplikacja_SLM\sdMatlabTools1.dll');
bmp1=NET.convertArray(mapa,'System.Single');
slm1=sdMatlabTools1.Slm;
slm1.SetF(bmp1,255);
%slm1.ShowSlm();
end