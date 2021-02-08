function [ G_tp ] = G_tp( temp,G_M_at_tp,tp_at_max_GM,tp_max,tp_min,temp_coff,offset)
%UNTITLED 此处显示有关此函数的摘要
%   生长率和温度的关系
     if temp<tp_at_max_GM
        G_tp=temp_coff(1)*(temp-tp_at_max_GM)^2+G_M_at_tp+offset;
     else
        G_tp=temp_coff(2)*(temp-tp_at_max_GM)^2+G_M_at_tp+offset;
     end
end

