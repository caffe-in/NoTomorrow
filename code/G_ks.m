function [ G ] = G_ks( E ,E_M,G_M,W_MIN,W_MAX,water_coff)
%���������������ʺͿ�ʪ�Ⱥ�ʪ�ȵĹ�ϵ
%   G_M ��ʪ��M������µ�G
    %offset = G_max-water_coff(2)*E_MAX/E_M*G_M
    offset=0
    if E<W_MIN
        G=water_coff(1)*E/E_M*G_M+offset
    
    elseif W_MIN<E && E<W_MAX
        G=water_coff(2)*E/E_M*G_M+offset
    else
        G=water_coff(3)*E/E_M*G_M+offset
    end

end

