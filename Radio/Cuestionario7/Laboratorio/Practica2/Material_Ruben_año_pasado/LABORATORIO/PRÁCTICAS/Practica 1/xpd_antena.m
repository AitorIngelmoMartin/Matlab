function [] = xpd_antena(antena_objeto, frec, azimut)

[directividad_V,~,~]=pattern(antena_objeto,frec,azimut,0,'Polarization','V');
[directividad_H,~,~]=pattern(antena_objeto,frec,azimut,0,'Polarization','H');
figure()

    plot(azimut,directividad_V,'b','LineWidth',2)
    hold on
    plot(azimut,directividad_H,'r','LineWidth',2)
    legend('PV','PH')
    g2=gca;
    g2.XLim=[-180 180];
    g1=gcf;
    g1.Name='Estudio XPD Acimut';
    g1.NumberTitle='off';
    grid on
  

end

