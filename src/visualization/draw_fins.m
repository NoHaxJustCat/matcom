clear 
clc

span = [0, 2];
x_le = [42, 44];
chord = [4, 2];
lmaxupper = [0.025, 0.05];

X = [x_le(1), x_le(1) + chord(1), x_le(2) + chord(2), x_le(1) + chord(2) x_le(1); x_le(1), x_le(1) + chord(1), x_le(2) + chord(2), x_le(1) + chord(2) x_le(1)];
Z = [0, 0, span(2) + span(1), span(2) + span(1) 0; 0, 0, span(2) + span(1), span(2) + span(1) 0];
Y = [lmaxupper(1)*chord(1), lmaxupper(1)*chord(1), lmaxupper(2)*chord(2), lmaxupper(2)*chord(2) lmaxupper(1)*chord(1); -lmaxupper(1)*chord(1), -lmaxupper(1)*chord(1), -lmaxupper(2)*chord(2), -lmaxupper(2)*chord(2),  -lmaxupper(1)*chord(1)];

figure;
surf(X, Y, Z);

hold on

X1 = [x_le(1), x_le(1) + chord(1); x_le(2), x_le(2) + chord(2)];
Z1 = [0, 0; span(2)+span(1), span(2)+span(1)];
Y1 = [lmaxupper(1)*chord(1), lmaxupper(1)*chord(1); lmaxupper(1)*chord(1), lmaxupper(1)*chord(1)];

X2 = [x_le(1), x_le(1) + chord(1); x_le(2), x_le(2) + chord(2)];
Z2 = [0, 0; span(2)+span(1), span(2)+span(1)];
Y2 = [-lmaxupper(1)*chord(1), -lmaxupper(1)*chord(1); -lmaxupper(1)*chord(1), -lmaxupper(1)*chord(1)];

surf(X1, Y1, Z1);
surf(X2, Y2, Z2);