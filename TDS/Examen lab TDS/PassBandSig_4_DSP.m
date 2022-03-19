function signalPassBanding = PassBandSig_4_DSP(L,Omega_0,K)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

ak = randn*0.02;
n=(0:L-1);

    for k=1:K
        sigmaK = (1+(k/25))^-1;
        OmegaK = Omega_0*(1+ak*k);
        
        A1 = sigmaK*randn;
        A2 = sigmaK*randn;
        
        Phi1=rand*(2*pi-pi);
        Phi2=rand*(2*pi-pi);
        
        sumatorio = A1*cos(OmegaK*n+Phi1) + A2*cos(((Omega_0^2)/OmegaK)*n + Phi2);
        
    end
    signalPassBanding = cos(Omega_0*n)+sumatorio;

end

