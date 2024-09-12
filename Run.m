%Agregado: 
%FOLDER='D:\Plenoptics\LabVIEW\Contenedor\DriverXPS\IMG15noisy\GAUSSIAN\a0.1 b0.7 GAUSSIAN';
%FOLDER2='D:\Plenoptics\LabVIEW\Contenedor\DriverXPS\IMG15noisy\CEDIP\a0.1 b0.7 CEDIP';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 close all; clc;
%A = Load4D4('mitad8x8', 240, 240, 8, 8, 1, 1, 0);
%A = Load4D4('cuarto4x4', 240, 240, 16, 16, 1, 1, 0);
%
A = Load4D4('C:\Users\joaqu\OneDrive\Desktop\UdeC\Postgrado\Memoria\PNP\data\plantas1460SR_RGB', 640, 512, 10, 10, 1, 1, 0);

%320 256 xeva
%640 480 gobi
 A_size = size(A);     
for i = 0:1:250
    lamnda  = +0.001 * i;
    I = real(FourierSlice4D3(A, lamnda  , A_size(2), A_size(1), 5));
    Imax = max(max(I)); Imin = min(min(I)); Idif = Imax - Imin; II = uint8(((I - Imin)./(Idif)) * 255);
    
    answer = strcat({'IMG8x8_'},{num2str(i)},{'.png'});
    assignin('base','imfile',answer{1});
    imwrite(II,imfile,'png'); 
    disp(i); 
end