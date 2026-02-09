%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%   Author: Nicolò Basso                                        %
%   Email: nicolo.basso@aurorarocketry.eu                       %
%   MSA Department, Aurora Rocketry, University of Bologna      %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% elapsed_time	86.2194	1×1	double 8 cores
% PC fisso 35
% With preallocation 33.93

clear; clc;

loadedFile = load("Cases\BOREALIS.mat");


tic

x = 0.01:0.01:0.6;

parfor i = 1:length(x)
    y(i) = eval(loadedFile.datcom_case, x(i));
end

elapsed_time = toc;

disp(toc)

% loadedFile.datcom_case.nose_type = 'OGIVE';
% loadedFile.datcom_case.power = []



% y1 = cell2mat(arrayfun(@(m) eval(loadedFile.datcom_case, m), x, 'UniformOutput', false));
% 
% loadedFile.datcom_case.nose_type = 'POWER';
% loadedFile.datcom_case.power = 0.4;
% 
% y2 = zeros(size(x));
% y2 = cell2mat(arrayfun(@(m) eval(loadedFile.datcom_case, m), x, 'UniformOutput', false));
% 
% loadedFile.datcom_case.power = 0.5;
% 
% y3 = zeros(size(x));
% y3 = cell2mat(arrayfun(@(m) eval(loadedFile.datcom_case, m), x, 'UniformOutput', false));
% 
% loadedFile.datcom_case.power = 0.6;
% 
% y4 = zeros(size(x));
% y4 = cell2mat(arrayfun(@(m) eval(loadedFile.datcom_case, m), x, 'UniformOutput', false));
% 
% loadedFile.datcom_case.power = 0.7;
% 
% y5 = zeros(size(x));
% y5 = cell2mat(arrayfun(@(m) eval(loadedFile.datcom_case, m), x, 'UniformOutput', false));
% 
% loadedFile.datcom_case.power = 0.8;
% 
% y6 = zeros(size(x));
% y6 = cell2mat(arrayfun(@(m) eval(loadedFile.datcom_case, m), x, 'UniformOutput', false));
% 
% 
% figure
% plot(x, y1)
% hold on
% plot(x, y2)
% plot(x, y3)
% plot(x, y4)
% plot(x, y5)
% plot(x, y6)
% legend('OGIVE', 'POWER 0.4', 'POWER 0.5', 'POWER 0.6', 'POWER 0.7', 'POWER 0.8')


function cd = eval(datcom_case, x)
    datcom_case.mach = x;

    writeOnDat(datcom_case);

    system("cd DATCOM && datcom.exe");

    % output = datcomimport('DATCOM/for006.dat');

    % cd = output{1}.cd;
    cd = x;
    % cd = fastimportCD('DATCOM/for006.dat');
end

% writeOnDat(loadedFile.datcom_case);
% 
% system("cd DATCOM && datcom.exe");
% 
% export = datcomimport('DATCOM/for006.dat');
% 
% data = export{1};
% 
% h1 = figure;
% figtitle = {'Lift Curve' ''};
% for k=1:2
%     subplot(2,1,k)
%     plot(data.alpha,permute(data.cl(:,k,:),[1 3 2]))
%     grid
%     ylabel(['Lift Coefficient (Mach =' num2str(data.mach(k)) ')'])
%     title(figtitle{k});
% end
% xlabel('Angle of Attack (deg)')
% 
% h2 = figure; 
% figtitle = {'Drag Polar' ''};
% for k=1:2
%     subplot(2,1,k)
%     plot(permute(data.cd(:,k,:),[1 3 2]),permute(data.cl(:,k,:),[1 3 2]))
%     grid
%     ylabel(['Lift Coefficient (Mach =' num2str(data.mach(k)) ')'])
%     title(figtitle{k})
% end
% xlabel('Drag Coefficient')
% 
% h3 = figure;
% figtitle = {'Pitching Moment' ''};
% for k=1:2
%     subplot(2,1,k)
%     plot(permute(data.cm(:,k,:),[1 3 2]),permute(data.cl(:,k,:),[1 3 2]))
%     grid
%     ylabel(['Lift Coefficient (Mach =' num2str(data.mach(k)) ')'])
%     title(figtitle{k})
% end
% xlabel('Pitching Moment Coefficient')
