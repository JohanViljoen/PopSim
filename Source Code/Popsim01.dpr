(*
    Popsim - a simulation tool to explore the establishment and proliferation of monogenic variations in a diploid population
    Copyright (C) 2018  JW Viljoen

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*)
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
