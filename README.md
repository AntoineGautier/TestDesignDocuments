# Example Files for Creating Design Documents

This repository contains example files for creating design documents based on Modelica classes.
We focus here on
- the sequence of operation (text document),
- the control schematic (drawing).

## Text Version of the Sequence of Operation

Two options are available to create the text version of the sequence of operation:

- Docx-based workflow
  - Currently used in https://ctrl-flow.lbl.gov/
  - A "master" Word document covers all system configurations, and annotations are used
  to toggle the visibility of the text for a specific configuration.
  - An additional file is needed to map the Modelica parameters to the annotations used in the
  master document.
- CDL-based workflow
  - Currently implemented as a proof-of-concept in https://github.com/lbl-srg/modelica-json/blob/master/lib/cdlDoc.js
  - All the text is stored in the Modelica classes, and Modelica annotations `__cdl(...)` are used
  to toggle the visibility of the text and organize the sections of the document.

These two options are compared in the following sections based on a minimum working example.

Advanced features and limitations are discussed in https://docs.google.com/document/d/1yPmEJ87rWasWUXBcGyOjwsIBk6aje-6-fa0e5_b3yIo/edit?tab=t.0#heading=h.apk7h766rj4q.

### Comparison of the Two Workflows

A simple controller with only the plant enable logic is implemented as an example to compare the two workflows.
The plant controller can be configured for heating only, cooling only, or both heating and cooling.
The enable logic is implemented in the `Enable` block, which covers both heating and cooling applications.

The package [CDL](CDL) contains the Modelica classes for the CDL-based workflow,
and the package [DOCX](DOCX) contains the Modelica classes for the Docx-based workflow.
The diff between the two package directories gives a rough overview of the differences between the two workflows.

Let's look at the instance of the enable block for cooling applications in [DOCX/PlantController.mo](DOCX/PlantController.mo).

```mo
Enable enaCoo(
  final typ=TestDesignDocuments.Types.Application.CoolingOnly)
  if typ <> TestDesignDocuments.Types.Application.HeatingOnly
  "Cooling plant enable"
  annotation (Placement(transformation(extent={{-10,40},{10,60}})));
```

- The binding equation `final typ=TestDesignDocuments.Types.Application.CoolingOnly` enables configuring the polarity of the control logic in the `Enable` block, that differs between heating and cooling applications.
- The conditional clause `if typ <> TestDesignDocuments.Types.Application.HeatingOnly` ensures the cooling enable component is only included when the controller is not configured for heating-only applications.
- These constructs are common to both workflows.

Let's see how each workflow handles the documentation of the enable logic.

#### CDL-Based Workflow

The sequence of operation for the enable logic is inluded in HTML format in the `__cdl(...)` annotation in the `Enable` block:
see https://github.com/AntoineGautier/TestDesignDocuments/blob/master/CDL/Enable.mo#L27-L76

⚠️ The complete sequence of operation is not included in one place, but rather distributed across the Modelica classes.

The entire section "Cooling plant enable" is included in the documentation based on the conditional clause
`if typ <> TestDesignDocuments.Types.Application.HeatingOnly`.

In addition, within the `Enable` block, HTML `<template>` elements are used to toggle the visibility of the text for different configurations.
This allows having the enable logic implemented in a single class that can be used for both heating and cooling applications
by adjusting the value of the `typ` parameter.

```html
<template data-cdl-visible='typ==TestDesignDocuments.Types.Application.HeatingOnly'>
<li>
Outdoor air temperature &lt; outdoor air lockout
temperature <code>TOutLck</code>, and
</li>
</template>
```

The documentation sections are organized with annotations: `__cdl(Documentation(section="1.2.1")))`.
- If these annotations are not used, the sections are organized based on the instantiation order.
- Is these annotations are used, the provided numbering may be sparse — only the heading level and the order of the annotations matter.

The documentation is then created using modelica-json, which generates a single HTML file for the whole control logic,
see [Resources/CDL/sequence.html](Resources/CDL/sequence.html).

```sh
node ./modelica-json/app.js -f TestDesignDocuments/CDL/PlantController.mo -o doc
```

Note that
- the parameter values (such as the outdoor air lockout temperature) are retrieved from the Modelica classes,
- the parameter units are converted based on the Modelica attributes `unit` and `displayUnit`.

#### Docx-Based Workflow

Contrary to the CDL-based workflow, the supplementary documentation data is stored in two separate files:

1. [Resources/DOCX/sequence.docx](Resources/DOCX/sequence.docx) contains the documentation of the whole control logic, and for all system configurations.
It uses straightforward annotations marked with the "Toggle" style. The following operators are supported in these annotations: `['AND', 'OR', 'YES', 'NO', 'EQUALS', 'NOT_EQUALS', 'ANY', 'DELETE']`.
Note that unit conversions are handled individually for each occurrence based on the `UNIT` annotations.

2. [Resources/DOCX/mappings.csv](Resources/DOCX/mappings.csv) defines the relationships between Modelica parameters and the annotations used in the sequence documentation.

The documentation is then generated using the server scripts of ctrl-flow: https://github.com/lbl-srg/ctrl-flow-dev/tree/main/server/scripts/sequence-doc/src.

```py
from generate_doc import generate_doc

# The 'selections' dictionary would typically be populated by ctrl-flow's frontend based on user input.
selections = {
    "TestPackageDesign.PlantController.typ": ['TestPackageDesign.Types.Application.HeatingAndCooling'],
    "Buildings.Templates.Data.AllSystems.sysUni": ["Buildings.Templates.Types.Units.IP"],
    "DEL_INFO_BOX": ['true'],
}
document = generate_doc(selections=selections, version="Test")
document.save("sequence.docx")
```

## Control Schematic

### Current Implementation

Minimum support for control schematics is currently provided by [Modelica graphical primitives](https://specification.modelica.org/maint/3.6/annotations.html#graphical-primitives)
that are included in the icon and diagram layers of the Modelica classes: see for example
https://github.com/AntoineGautier/TestDesignDocuments/blob/master/DOCX/PlantController.mo#L17-L50.

Key aspects of this implementation:

- There is no distinction between the two documentation workflows for the control schematic.
- The `visible` attribute allows toggling the visibility of the graphical primitives based on the value of the `typ` parameter.
- The `Bitmap` primitive is used to include external images in the control schematic. (Even when using vectorized images, these are converted by Modelica tools into raster images.)
- ⚠️ The system schematic is distributed across multiple Modelica classes rather than being implemented as a single, centralized diagram.
- Neiher ctrl-flow, nor modelica-json can currently interpret the graphical primitives, only third-party tools like Dymola can display and export them.

### Alternative Approach

Similarly to the Docx-based workflow for the sequence documentation,
the control schematic could be externalized in a single "master" file, and the visibility of the components could be toggled based
on object attributes, mapped to the Modelica parameters.

### To Be Further Specified

- Direct graphical feedback at UI runtime or simple export capability
- Output format: SVG, DXF, other
- In case of an external "master" file: Input format SVG, DXF, other — taking into account the ability to store extended entity data
