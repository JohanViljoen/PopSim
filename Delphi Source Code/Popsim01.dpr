// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program Popsim01;

uses
  Forms,
  Pophoof in 'Pophoof.pas' {Form1},
  Popvertoon in 'Popvertoon.pas' {Vertoonblad},
  Popdefs in 'Popdefs.pas',
  Pophis in 'Pophis.pas' {Hisblad},
  PopMC in 'PopMC.pas' {MCForm}
// , FasterThread in 'FasterThread.pas'
;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TVertoonblad, Vertoonblad);
  Application.CreateForm(THisblad, Hisblad);
  Application.CreateForm(TMCForm, MCForm);
  Application.Run;
end.
