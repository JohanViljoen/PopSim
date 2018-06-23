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

unit Pophis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Popdefs, Series, TeEngine, StdCtrls, ExtCtrls, TeeProcs, Chart,
  rxPlacemnt;

type
  THisblad = class(TForm)
    Chart2: TChart;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Bargraph1: TBarSeries;
    FormStorage1: TFormStorage;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox5: TCheckBox;
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Hisblad: THisblad;

implementation

{$R *.dfm}

procedure THisblad.CheckBox3Click(Sender: TObject);
begin
  if Hisblad.checkbox3.Checked then hisblad.Chart2.LeftAxis.Logarithmic:=True else hisblad.Chart2.LeftAxis.Logarithmic:=False;
  CheckBox4Click(self);
end;

procedure THisblad.CheckBox4Click(Sender: TObject);
begin
 if hisblad.checkbox4.checked then normaliseergrafiek:=True else normaliseergrafiek:=False;

  grootstemutasienommer:=draer;
  Hisblad.Chart2.LeftAxis.AutomaticMaximum:=True;
  Hisblad.Chart2.LeftAxis.AutomaticMinimum:=False;
  Hisblad.Chart2.LeftAxis.Maximum:=10;
  Hisblad.Chart2.LeftAxis.Title.Angle:=0;

  case normaliseergrafiek of
   False :begin
            if hisblad.checkbox3.Checked then Hisblad.Chart2.LeftAxis.Minimum:=0.5 else Hisblad.Chart2.LeftAxis.Minimum:=0;
            Hisblad.Chart2.LeftAxis.Title.Caption:='#';
          end;
   True  :begin
            if Hisblad.checkbox3.Checked then Hisblad.Chart2.LeftAxis.Minimum:=0.001 else Hisblad.Chart2.LeftAxis.Minimum:=0.1;
            Hisblad.Chart2.LeftAxis.Title.Caption:='%';
          end;
  end;


end;

procedure THisblad.FormCreate(Sender: TObject);
begin
  //CheckBox3Click(self);
end;

procedure THisblad.FormResize(Sender: TObject);
begin
  chart2.Width:=ClientWidth;
  chart2.Height:=ClientHeight;
end;

procedure THisblad.CheckBox2Click(Sender: TObject);
begin
  if checkbox2.Checked=False then checkbox5.Checked:=True;
end;

procedure THisblad.CheckBox5Click(Sender: TObject);
begin
  if checkbox5.Checked=False then checkbox2.Checked:=True;
end;

end.
