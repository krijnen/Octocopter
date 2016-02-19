%%%Data Engine%%%
TorqueMax=7700;                 %[Nm]
ThrustMax=23000;                %[N]
AoAMax=18;                      %[deg]
AoAEffective=12;                %[deg]
RPMMax=6400;                    %[RPM]
RPMEffective=6400;              %[RPM]
TorqueCoefficientUP=0.119615;   %[Nm/rpm]
TorqueCoefficientDOWN=-0.05821; %[Nm/rpm]
TorqueConstantUP=570;           %[Nm]
TorqueConstantDOWN=881;         %[Nm]

%%%Data Transmission%%%
TransmissionRatio=12;

%%%Data Blade%%%
DiameterBlade=8;                %[m]
ThicknessBlade=0.04;            %[m]
ChordBlade=0.2;                 %[m]
DensityBlade=2700;              %[kg/m^3]
MassBlade=35;

%%%Data Framework%%%
RadiusTube=0.1;                 %[m]
DensityTube=2700;               %[kg/m^3]
RotorMargin=0.2;                %[m]
InnerDimensions=DiameterBlade+RotorMargin;  %[m]
OuterRod=InnerDimensions/sqrt(2);           %[m]
RodLength=2*OuterRod+InnerDimensions;       %[m]
RodMass=1505;

%%%Configuration Framework%%%
HorizontalBar1=[0 +InnerDimensions/2 0];    %[m]
HorizontalBar2=[0 -InnerDimensions/2 0];    %[m]
VerticalBar1=[-InnerDimensions/2 0 0];      %[m]
VerticalBar2=[+InnerDimensions/2 0 0];      %[m]

%%%Data Container%%%
ContainerLength=6.06;       %[m]
ContainerWidth=2.44;        %[m]
ContainerHeight=2.59;       %[m]

%%%Data Cables%%%
ContainerUnderFrame=-2;      %[m]

CableLengthXSHORT=0.5*(InnerDimensions-ContainerWidth);                 %[m]
CableLengthYSHORT=0.5*(RodLength-ContainerLength);                      %[m]
CableLengthTopSHORT=sqrt(CableLengthXSHORT^2+CableLengthYSHORT^2);      %[m]
CableLengthSHORT=sqrt(CableLengthTopSHORT^2+ContainerUnderFrame^2);     %[m]

CableLengthXLONG=0.5*(RodLength-ContainerWidth);                        %[m]
CableLengthYLONG=0.5*(InnerDimensions-ContainerLength);                 %[m]
CableLengthTopLONG=sqrt(CableLengthXLONG^2+CableLengthYLONG^2);         %[m]
CableLengthLONG=sqrt(CableLengthTopLONG^2+ContainerUnderFrame^2);       %[m]    

%%%Data Attachment Container (wrt container reference frame at centre)%%%
AttachContainerFrontLeft=[-ContainerWidth/2 ContainerLength/2 ContainerHeight/2];      %[m]
AttachContainerFrontRight=[ContainerWidth/2 ContainerLength/2 ContainerHeight/2];      %[m]
AttachContainerBackLeft=[-ContainerWidth/2 -ContainerLength/2 ContainerHeight/2];      %[m]
AttachContainerBackRight=[ContainerWidth/2 -ContainerLength/2 ContainerHeight/2];      %[m]

AngleFrontLeftOverZ=atand(CableLengthXSHORT/CableLengthYSHORT);
AngleFrontLeftOverX=atand(CableLengthTopSHORT/ContainerUnderFrame);
TranslationFrontLeft=[CableLengthXSHORT/2 CableLengthYSHORT/2 ContainerUnderFrame/2];

%%%Configuration Engines%%%
PositionEngine1=[-InnerDimensions/2 ((+InnerDimensions/2)+OuterRod) 0]; %[m]
PositionEngine2=[+InnerDimensions/2 ((+InnerDimensions/2)+OuterRod) 0]; %[m]
PositionEngine3=[((InnerDimensions/2)+OuterRod) +InnerDimensions/2 0];  %[m]
PositionEngine4=[((InnerDimensions/2)+OuterRod) -InnerDimensions/2 0];  %[m]
PositionEngine5=[+InnerDimensions/2 ((-InnerDimensions/2)-OuterRod) 0]; %[m]
PositionEngine6=[-InnerDimensions/2 ((-InnerDimensions/2)-OuterRod) 0]; %[m]
PositionEngine7=[((-InnerDimensions/2)-OuterRod) -InnerDimensions/2 0]; %[m]
PositionEngine8=[((-InnerDimensions/2)-OuterRod) +InnerDimensions/2 0]; %[m]
k_engine_rotorlocation = 1000;

load PitchSettingDataReal
