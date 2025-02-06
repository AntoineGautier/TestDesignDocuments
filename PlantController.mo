within TestPackageDesign;
block PlantController
  "Two-pipe air-to-water heat pump plant"
  parameter Boolean have_chw=true
    "Set to true if the plant provides CHW";
  parameter Boolean have_hhw=true
    "Set to true if the plant provides HHW";
  Enable enaCoo(
    final have_chw=true,
    final have_hhw=false)
    if have_chw
    "Cooling plant enable"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})),
    __cdl(Documentation(section="1.1.1")));
  Enable enaHea(
    final have_chw=false,
    final have_hhw=true)
    if have_hhw
    "Heating plant enable"
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})),
    __cdl(Documentation(section="1.2.1")));
  Section plant
    "Two-pipe air-to-water heat pump plant"
    annotation (Placement(transformation(extent={{-100,-100},{100,100}})),
    __cdl(Documentation(section="1")));
  Section coolingPlant
    "Cooling plant"
    annotation (Placement(transformation(extent={{-40,20},{40,80}})),
    __cdl(Documentation(section="1.1")));
  Section heatingPlant
    "Heating plant"
    annotation (Placement(transformation(extent={{-40,-80},{40,-20}})),
    __cdl(Documentation(section="1.2")));
  annotation (
    Documentation(
      info="<html></html>"));
end PlantController;
