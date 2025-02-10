within TestDesignDocuments.DOCX;
block Enable
  "Plant enable"
  parameter TestDesignDocuments.Types.Application typ
    "Application type";
  parameter Real TOutLck(
    final min=100,
    final unit="K",
    displayUnit="degC")=if typ == TestDesignDocuments.Types.Application.HeatingOnly
    then 18 + 273.15 else 15 + 273.15
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
end Enable;
