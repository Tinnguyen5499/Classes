close all;
clear all
clc

%% Input Material From Excel Sheet
materialData=readtable("materialData.xlsx");
materialNames=string(materialData.AISINo_);
materialNames_holder=materialNames;
materialNames(~ismissing(materialNames_holder))=strcat(materialNames_holder(~ismissing(materialNames_holder)),' HR');
materialNames(ismissing(materialNames_holder))=strcat(materialNames_holder(find(ismissing(materialNames_holder))-1),' CD');

yieldStrength=materialData.YieldStrength_MPa_kpsi_;
tensileStrength=materialData.TensileStrength_MPa_kpsi_;

%% Processing Data
for n=1:length(yieldStrength)

    yieldStrength_MPa{n}=yieldStrength{n}(1:find(isspace(yieldStrength{1}))-1);
    yieldStrength_ksi{n}=yieldStrength{n}(find(isspace(yieldStrength{n}))+2:end-1);

    tensileStrength_MPa{n}=tensileStrength{n}(1:find(isspace(tensileStrength{1}))-1);
    tensileStrength_ksi{n}=tensileStrength{n}(find(isspace(tensileStrength{n}))+2:end-1);
    
   
end 

    yieldStrength_MPa=str2double(yieldStrength_MPa);
    yieldStrength_ksi=str2double(yieldStrength_ksi);

    tensileStrength_MPa=str2double(tensileStrength_MPa);
    tensileStrength_ksi=str2double(tensileStrength_ksi);

% Loading (in ksi)

%% UI design

% Create UIFigure and hide until all components are created
app.UIFigure = uifigure('Visible', 'off');
app.UIFigure.Position = [100 100 434 602];
app.UIFigure.Name = 'Shaft Design';


% Create RoughSketchofShaftCheckBox
app.RoughSketchofShaftCheckBox = uicheckbox(app.UIFigure);
app.RoughSketchofShaftCheckBox.Text = 'Rough Sketch of Shaft';
app.RoughSketchofShaftCheckBox.Position = [282 62 143 23];
app.RoughSketchofShaftCheckBox.Value = true;

% Create MeanMomentMmEditField
app.MeanMomentMmEditField = uieditfield(app.UIFigure, 'numeric');
app.MeanMomentMmEditField.HorizontalAlignment = 'center';
app.MeanMomentMmEditField.Position = [108 491 157 22];

% Create MeanMomentMmEditFieldLabel
app.MeanMomentMmEditFieldLabel = uilabel(app.UIFigure);
app.MeanMomentMmEditFieldLabel.HorizontalAlignment = 'center';
app.MeanMomentMmEditFieldLabel.Position = [17 483 83 30];
app.MeanMomentMmEditFieldLabel.Text = {'Mean'; 'Moment (Mm)'};

% Create UnitsSwitchLabel
app.UnitsSwitchLabel = uilabel(app.UIFigure);
app.UnitsSwitchLabel.HorizontalAlignment = 'center';
app.UnitsSwitchLabel.Position = [172 534 33 22];
app.UnitsSwitchLabel.Text = 'Units';

% Create UnitsSwitch
app.UnitsSwitch = uiswitch(app.UIFigure, 'slider');
app.UnitsSwitch.Items = {'MPa', 'KSI'};
app.UnitsSwitch.Position = [167 557 45 20];
app.UnitsSwitch.Value = 'KSI';

% Create AlternatingMomentMaEditFieldLabel
app.AlternatingMomentMaEditFieldLabel = uilabel(app.UIFigure);
app.AlternatingMomentMaEditFieldLabel.HorizontalAlignment = 'center';
app.AlternatingMomentMaEditFieldLabel.Position = [17 444 78 30];
app.AlternatingMomentMaEditFieldLabel.Text = {'Alternating'; 'Moment (Ma)'};

% Create AlternatingMomentMaEditField
app.AlternatingMomentMaEditField = uieditfield(app.UIFigure, 'numeric');
app.AlternatingMomentMaEditField.HorizontalAlignment = 'center';
app.AlternatingMomentMaEditField.Position = [108 452 157 22];

% Create MeanTorsionTmEditFieldLabel
app.MeanTorsionTmEditFieldLabel = uilabel(app.UIFigure);
app.MeanTorsionTmEditFieldLabel.HorizontalAlignment = 'center';
app.MeanTorsionTmEditFieldLabel.Position = [23 405 70 30];
app.MeanTorsionTmEditFieldLabel.Text = {'Mean'; 'Torsion (Tm)'};

% Create MeanTorsionTmEditField
app.MeanTorsionTmEditField = uieditfield(app.UIFigure, 'numeric');
app.MeanTorsionTmEditField.HorizontalAlignment = 'center';
app.MeanTorsionTmEditField.Position = [108 413 156 22];

% Create AlternatingTorsionTmEditFieldLabel
app.AlternatingTorsionTmEditFieldLabel = uilabel(app.UIFigure);
app.AlternatingTorsionTmEditFieldLabel.HorizontalAlignment = 'center';
app.AlternatingTorsionTmEditFieldLabel.Position = [23 368 70 30];
app.AlternatingTorsionTmEditFieldLabel.Text = {'Alternating'; 'Torsion (Tm)'};

% Create AlternatingTorsionTmEditField
app.AlternatingTorsionTmEditField = uieditfield(app.UIFigure, 'numeric');
app.AlternatingTorsionTmEditField.HorizontalAlignment = 'center';
app.AlternatingTorsionTmEditField.Position = [108 376 156 22];

% Create MaterialSelectionListBoxLabel
app.MaterialSelectionListBoxLabel = uilabel(app.UIFigure);
app.MaterialSelectionListBoxLabel.HorizontalAlignment = 'right';
app.MaterialSelectionListBoxLabel.FontWeight = 'bold';
app.MaterialSelectionListBoxLabel.Position = [295 531 109 22];
app.MaterialSelectionListBoxLabel.Text = 'Material Selection';

% Create MaterialSelectionListBox
app.MaterialSelectionListBox = uilistbox(app.UIFigure,"Items",materialNames);
app.MaterialSelectionListBox.Position = [297 103 114 429];

% Create SafetyFactorLabel
app.SafetyFactorLabel = uilabel(app.UIFigure);
app.SafetyFactorLabel.HorizontalAlignment = 'center';
app.SafetyFactorLabel.Position = [32 331 52 30];
app.SafetyFactorLabel.Text = {'Safety '; 'Factor'};

% Create SafetyFactorEditField
app.SafetyFactorEditField = uieditfield(app.UIFigure, 'numeric');
app.SafetyFactorEditField.HorizontalAlignment = 'center';
app.SafetyFactorEditField.Position = [108 335 157 22];
app.SafetyFactorEditField.Value=1;

% Create OptionalInputLabel
app.OptionalInputLabel = uilabel(app.UIFigure);
app.OptionalInputLabel.FontWeight = 'bold';
app.OptionalInputLabel.Position = [15 175 168 25];
app.OptionalInputLabel.Text = 'Optional Input';

% Create RequiredInputLabel_2
app.RequiredInputLabel_2 = uilabel(app.UIFigure);
app.RequiredInputLabel_2.FontWeight = 'bold';
app.RequiredInputLabel_2.Position = [17 528 168 25];
app.RequiredInputLabel_2.Text = 'Required Input';

% Create ShouldFilletLabel
app.ShouldFilletLabel = uilabel(app.UIFigure);
app.ShouldFilletLabel.HorizontalAlignment = 'center';
app.ShouldFilletLabel.Position = [3 242 105 40];
app.ShouldFilletLabel.Text = {'Diameter'; 'Changes (D/d)'};

% Create DiameterChangesDdDropDown
app.DiameterChangesDdDropDown = uidropdown(app.UIFigure);
app.DiameterChangesDdDropDown.Items = {'2', '1.20', '1.10'};
app.DiameterChangesDdDropDown.Position = [107 250 157 22];
app.DiameterChangesDdDropDown.Value = '2';

% Create ConvergenceLimitLabel
app.ConvergenceLimitLabel = uilabel(app.UIFigure);
app.ConvergenceLimitLabel.HorizontalAlignment = 'center';
app.ConvergenceLimitLabel.Position = [17 95 78 30];
app.ConvergenceLimitLabel.Text = {'Convergence'; 'Limit (%)'};

% Create ConvergenceLimitEditField
app.ConvergenceLimitEditField = uieditfield(app.UIFigure, 'numeric');
app.ConvergenceLimitEditField.Limits = [-70 1000];
app.ConvergenceLimitEditField.HorizontalAlignment = 'center';
app.ConvergenceLimitEditField.Position = [108 103 156 22];
app.ConvergenceLimitEditField.Value = 1;

% Create SurfaceFinishDropDownLabel
app.SurfaceFinishDropDownLabel = uilabel(app.UIFigure);
app.SurfaceFinishDropDownLabel.HorizontalAlignment = 'center';
app.SurfaceFinishDropDownLabel.Position = [28 283 57 40];
app.SurfaceFinishDropDownLabel.Text = {'Surface'; 'Finish'};

% Create SurfaceFinishDropDown
app.SurfaceFinishDropDown = uidropdown(app.UIFigure);
app.SurfaceFinishDropDown.Items = {'Ground', 'Machined or CD', 'Hot-rolled', 'As-forged'};
app.SurfaceFinishDropDown.Position = [108 291 157 22];
app.SurfaceFinishDropDown.Value = 'Ground';

% Create ShoulderFilletDropDown_2Label
app.ShoulderFilletDropDown_2Label = uilabel(app.UIFigure);
app.ShoulderFilletDropDown_2Label.HorizontalAlignment = 'center';
app.ShoulderFilletDropDown_2Label.Position = [28 199 57 40];
app.ShoulderFilletDropDown_2Label.Text = {'Shoulder'; 'Fillet'};

% Create ShoulderFilletDropDown_2
app.ShoulderFilletDropDown_2 = uidropdown(app.UIFigure);
app.ShoulderFilletDropDown_2.Items = {'Sharp (r/d=0.02)', 'Well rounded (r/d=0.1)'};
app.ShoulderFilletDropDown_2.Position = [108 207 157 22];
app.ShoulderFilletDropDown_2.Value = 'Well rounded (r/d=0.1)';

% Create ReliabilityDropDownLabel
app.ReliabilityDropDownLabel = uilabel(app.UIFigure);
app.ReliabilityDropDownLabel.HorizontalAlignment = 'center';
app.ReliabilityDropDownLabel.Position = [28 135 57 40];
app.ReliabilityDropDownLabel.Text = 'Reliability';

% Create ReliabilityDropDown
app.ReliabilityDropDown = uidropdown(app.UIFigure);
app.ReliabilityDropDown.Items = {'50%', '90%', '95%', '99%', '99.9%', '99.99%', '99.999%', '99.9999%'};
app.ReliabilityDropDown.Position = [108 143 157 22];
app.ReliabilityDropDown.Value = '99.9%';

% Create TemperatureFLabel
app.TemperatureFLabel = uilabel(app.UIFigure);
app.TemperatureFLabel.HorizontalAlignment = 'center';
app.TemperatureFLabel.Position = [10 58 93 30];
app.TemperatureFLabel.Text = 'Temperature (*F)';

% Create TemperatureFEditField
app.TemperatureFEditField = uieditfield(app.UIFigure, 'numeric');
app.TemperatureFEditField.HorizontalAlignment = 'center';
app.TemperatureFEditField.Position = [108 62 156 22];
app.TemperatureFEditField.Value = 70;

% Create ConvergenceGraphCheckBox
app.ConvergenceGraphCheckBox = uicheckbox(app.UIFigure);
app.ConvergenceGraphCheckBox.Text = 'Convergence Graph';
app.ConvergenceGraphCheckBox.Position = [282 37 130 22];


% Show the figure after all components are created

app.UIFigure.Visible = 'on';

% Create RunButton
app.RunButton = uibutton(app.UIFigure);
app.RunButton.Text = 'Run';
app.RunButton.Position = [136 16 100 23];
app.RunButton.ButtonPushedFcn='uiresume(app.UIFigure)';

% The program will pause and let user input until the Run button is pressed
uiwait(app.UIFigure)


%% Obtained Values that user input into the UI

unit=app.UnitsSwitch.Value;

Mm=app.MeanMomentMmEditField.Value;

Ma=app.AlternatingMomentMaEditField.Value;

Tm=app.MeanTorsionTmEditField.Value;

Ta=app.AlternatingTorsionTmEditField.Value;

n=app.SafetyFactorEditField.Value;

selectedMaterial=find(materialNames==app.MaterialSelectionListBox.Value);

roughSketch=app.RoughSketchofShaftCheckBox.Value;
convergenceGraph=app.ConvergenceGraphCheckBox.Value;

shoulderFillet=app.ShoulderFilletDropDown_2.Value;

surfaceFinish=app.SurfaceFinishDropDown.Value;

diameterChanges=app.DiameterChangesDdDropDown.Value;

reliability_list=string(app.ReliabilityDropDown.Items);
reliability=app.ReliabilityDropDown.Value;

convergenceLimit=app.ConvergenceLimitEditField.Value;

temperature=app.TemperatureFEditField.Value;

close(app.UIFigure)

          
%% Setup/Initial Guesses

% Obtain Sy and Sut and surface finish values based on the unit that the user had chosen
if unit=="MPa"

Sy= yieldStrength_MPa(selectedMaterial);
Sut= tensileStrength_MPa(selectedMaterial);

switch surfaceFinish
    case 'Ground'
        a=1.58; b=-0.085;
    case 'Machined or CD'
        a=4.51; b=-0.265;
    case 'Hot-rolled'
        a=57.7; b=-0.718;
    otherwise
        a=272.; b=-0.995;
end


    if Sut<=1400
        Se_prime=0.5*Sut;
    else 
        Se_prime= 700;
    end 
 

else


switch surfaceFinish
    case 'Ground'
        a=1.34; b=-0.085;
    case 'Machined or CD'
        a=2.70; b=-0.265;
    case 'Hot-rolled'
        a=14.4; b=-0.718;
    otherwise
        a=39.9; b=-0.995;
end


Sy= yieldStrength_ksi(selectedMaterial);
Sut= tensileStrength_ksi(selectedMaterial);
     if Sut<=200
        Se_prime=0.5*Sut;
    else 
        Se_prime= 100;
    end 

end 
   

%calculate ka


ka=a*Sut^(-b);


%Guess kb
kb= 0.85;

%Constant kc
kc=1;

%Calcualte kd
kd=0.975 + 0.432*10^(-3)*temperature-0.115*10^(-5)*temperature^2+0.104*10^(-8)*temperature^3-0.595*10^(-12)*temperature^4 ;

%choosing ke
ke_list=[1.000 0.897 0.868 0.814 00.753 0.72 0.659 0.620];

ke=ke_list(reliability_list==reliability);

%choosing kf
kf=1;

%Calculating Se
Se= Se_prime *ka *kb *kc *kd *ke;

% Guess Stress Concentration

if shoulderFillet=="Sharp (r/d=0.02)";

Kf= 2.7;
Kfs= 2.2;
shoulderFilletRatio=0.02;

else
Kf=1/7;
Kfs=1.5;
shoulderFilletRatio=0.1;

end 

switch diameterChanges
    case '2'
        At=0.90879; bt=-0.28598;
        Ats=0.86331; bts=-0.23865;
    case '1.20'
        At=0.97098; bt=-0.21796;
        Ats=0.83425; bts=-0.21649;
    case '1.10'
        At=0.95120; bt=-0.23757;
        Ats=0.90337; bts=-0.12692;
end

%First itteration
Convergence=100;
n=1;
d= ( (16*n/pi) * ( (2*(Kf*Ma)/Se) + ( (3*(Kfs*Tm)^2)^(1/2) /Sut) ) ) ^ (1/3);

%% Calculation Loop

while Convergence>=convergenceLimit/100

d_previous=d;

r=shoulderFilletRatio*d;

%calculate updated Kf and Kfs based on new calculated d
Kt=At*(shoulderFilletRatio)^bt;
Kts=Ats*(shoulderFilletRatio)^bts;

neuber=0.246-3.08*10^(-3)*Sut+1.51*10^(-5)*Sut^2-2.67*10^(-8)*Sut^3;
neuber_shear=0.190-2.51*10^(-3)*Sut+1.35*10^(-5)*Sut^2-2.67*10^(-8)*Sut^3;

q=1/(1+(neuber/sqrt(r)));
q_shear=1/(1+(neuber_shear/sqrt(r)));

Kf=1+q*(Kt-1);
Kfs=1+q_shear*(Kts-1);

d=( (16*n/pi) * ( (2*(Kf*Ma)/Se) + ( (3*(Kfs*Tm)^2)^(1/2) /Sut) ) ) ^ (1/3);

%checking convergence
Convergence=abs(d-d_previous)/d_previous;
d_test(n)=d;
convergence_test(n)=Convergence;
n=n+1;

end

%% Display

D=d*str2num(diameterChanges);

% sketching the shaft if user wanted
if roughSketch==1
r=d/2;
R=D/2;
h=2*R;

[X1,Y1,Z1]=cylinder(R);
Z1=Z1*h;
surf(X1,Y1,Z1)

hold on

[X2,Y2,Z2]=cylinder(r);
Z2=Z2*h;
surf(X2,Y2,Z2+h)

daspect([1 1 1])

title('Rough Sketch of Shaft')

xlabel('inches')
ylabel('inches')
zlabel('inches')

end 

% Graph convergence Graph if user wanted
if convergenceGraph==1
figure(2)
plot(d_test)
title('Diamameter after each itteration')
xlabel('itteration')

figure(3)
plot(convergence_test)
title('Convergence after each interration')
xlabel('itteration')
else
end

% Output Result with message box
msgbox(sprintf('Operation Completed.\nYour diameter is d=%g inches', d))