# Example Files for Creating Design Documents

This repository contains example files for creating design documents based on Modelica classes.

## Text Version of the Sequence of Operation

Two options are available to create the text version of the sequence of operation:

-
-

```mo
Enable enaCoo(
  final typ=TestDesignDocuments.Types.Application.CoolingOnly)
  if typ <> TestDesignDocuments.Types.Application.HeatingOnly
  "Cooling plant enable"
  annotation (Placement(transformation(extent={{-10,40},{10,60}})),
  __cdl(Documentation(section="1.1.1")));
```


## Control Schematic

The control schematic can be represented by

```mo

```
