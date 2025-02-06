within TestPackageDesign;
block Enable
  "Plant enable"
  parameter Boolean have_chw
    "Set to true if the plant provides CHW";
  parameter Boolean have_hhw
    "Set to true if the plant provides HHW";
  parameter Real TOutLck(
    final min=100,
    final unit="K",
    displayUnit="degC")=if have_hhw then 18 + 273.15 else 15 + 273.15
    "Outdoor air lockout temperature";
  parameter Integer nReqIgn(
    min=0)=0
    "Number of ignored requests";
  parameter Real dtRun(
    final min=0,
    final unit="s")=15 * 60
    "Minimum runtime of enable and disable states";
  parameter Real dtReq(
    final min=0,
    final unit="s")=3 * 60
    "Runtime with low number of request before disabling";
  annotation (
    __cdl(
      Documentation(
        include=true,
        section="1.1.1")),
    Documentation(
      info="<html>
<p>
The plant is enabled when it has been disabled for at least the duration <code>dtRun</code> and:
</p>
<ul>
<li>
Number of plant requests &gt; number of ignored requests <code>nReqIgn</code>, and
</li>
<template data-cdl-visible=have_chw>
<li>
Outdoor air temperature &gt; outdoor air lockout
temperature <code>TOutLck</code>, and
</template>
</li>
<template data-cdl-visible=have_hhw>
<li>
Outdoor air temperature &lt; outdoor air lockout
temperature <code>TOutLck</code>, and
</template>
</li>
<li>
The enable schedule is active.
</li>
</ul>
<p>
The plant is disabled when it has been enabled for at least the duration
<code>dtRun</code> and:
</p>
<ul>
<li>
Number of plant requests &le; number of ignored requests <code>nReqIgn</code>
for at least the duration <code>dtReq</code>, or
</li>
<template data-cdl-visible=have_chw>
<li>
Outdoor air temperature &lt; outdoor air lockout
temperature <code>TOutLck</code> minus hysteresis <code>dTOutLck</code>, or
</li>
</template>
<template data-cdl-visible=have_hhw>
<li>
Outdoor air temperature &gt; outdoor air lockout
temperature <code>TOutLck</code> plus hysteresis <code>dTOutLck</code>, or
</li>
</template>
<li>
The plant enable schedule is inactive.
</li>
</ul>
</html>"));
end Enable;
