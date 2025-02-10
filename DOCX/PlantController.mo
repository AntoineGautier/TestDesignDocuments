within TestDesignDocuments.DOCX;
block PlantController
  "Two-pipe air-to-water heat pump plant"
  parameter TestDesignDocuments.Types.Application typ=TestDesignDocuments.Types.Application.HeatingAndCooling
    "Application type";
  CDL.Enable enaCoo(
    final typ=TestDesignDocuments.Types.Application.CoolingOnly)
    if typ <> TestDesignDocuments.Types.Application.HeatingOnly
    "Cooling plant enable"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  CDL.Enable enaHea(
    final typ=TestDesignDocuments.Types.Application.HeatingOnly)
    if typ <> TestDesignDocuments.Types.Application.CoolingOnly
    "Heating plant enable"
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  annotation (
    Icon(
      graphics={
        Rectangle(
          extent={{-80,60},{0,-60}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{20,0},{20,0},{20,40},{100,40}},
          color={0,0,0},
          thickness=0.5,
          visible=typ<>TestDesignDocuments.Types.Application.HeatingOnly),
        Line(
          points={{20,0},{20,-40},{100,-40}},
          color={0,0,0},
          thickness=0.5,
          visible=typ<>TestDesignDocuments.Types.Application.CoolingOnly),
        Bitmap(
          extent={{-20,-20},{20,20}},
          origin={60,54},
          rotation=0,
          visible=typ<>TestDesignDocuments.Types.Application.HeatingOnly,
          fileName=
            "modelica://TestDesignDocuments/Resources/Images/Valves/TwoWayTwoPosition.svg"),
        Bitmap(
          extent={{-20,-20},{20,20}},
          origin={60,-26},
          rotation=0,
          visible=typ<>TestDesignDocuments.Types.Application.CoolingOnly,
          fileName=
            "modelica://TestDesignDocuments/Resources/Images/Valves/TwoWayTwoPosition.svg"),
        Line(
          points={{0,0},{20,0}},
          color={0,0,0},
          thickness=0.5)}));
end PlantController;
