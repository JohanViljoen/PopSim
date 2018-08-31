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
unit Popvertoon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, Popdefs, rxPlacemnt,
  Menus;

type
  TVertoonblad = class(TForm)
    FormStorage1: TFormStorage;
    Panel1: TPanel;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    AlternativeColourScheme1: TMenuItem;
    StandardColourScheme1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure UpdateDisplay;
    procedure FormResize(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AlternativeColourScheme1Click(Sender: TObject);
    procedure StandardColourScheme1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);


  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Vertoonblad: TVertoonblad;
  bm:integer;
  deletecarriers:Boolean=False;

implementation

uses Pophoof, PopMC;

{$R *.dfm}

procedure TVertoonblad.FormCreate(Sender: TObject);
var reghoek:Trect;
begin
  vertoonblad.clientwidth:=begbreedte;
  vertoonblad.ClientHeight:=beghoogte;
  vertoonblad.Image1.Picture.Bitmap.Width:=breedte;
  vertoonblad.Image1.Picture.Bitmap.Height:=hoogte;
//  vertoonblad.Top:=form1.top;
//  vertoonblad.Left:=form1.Left+form1.Width;

  with vertoonblad.image1.Picture.Bitmap.Canvas do begin
    reghoek.Left:=0;reghoek.Right:=maksbreedte-1;
    reghoek.Top:=0;reghoek.Bottom:=Height;
    Brush.Color := kleure[skoon];
    Brush.Style := bsSolid;
    FillRect(reghoek);
    Brush.Style := bsClear;

  end;
  Panel1.DoubleBuffered:=True;
//  vertoonblad.DoubleBuffered:=True;
  with Image1.Picture.Bitmap do
  begin
    PixelFormat := pf32bit;
    Width := Image1.Width;
    Height := Image1.Height;
  end;

end;


procedure TVertoonblad.UpdateDisplay;
var a,b,br:integer;
    status:word;
begin
    for b:=0 to hoogte-1 do
    begin
      if b<screen.Height-20 then prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[b] else prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[0];
      br:=breedte-1;if br>2*screen.width then br:=2*screen.width;
      for a:=0 to br do
        prentlyn[a]:=kleureRGB[popskik^[a,b].status];
    end;

end;


procedure TVertoonblad.FormResize(Sender: TObject);
begin

  if vertoonblad.clientwidth<2*Screen.Width then breedte:=vertoonblad.ClientWidth;
  if vertoonblad.ClientHeight<screen.Height then hoogte:=vertoonblad.ClientHeight;
  vertoonblad.Image1.Picture.Bitmap.Width:=breedte;
  vertoonblad.Image1.Picture.Bitmap.Height:=hoogte;
  form1.scrollbar3.position:=breedte;
  form1.scrollbar4.position:=hoogte;

end;

procedure TVertoonblad.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var i,j,waarde,rad,rad2:integer;
begin
//  application.processmessages;
  if ((ssLeft in Shift) {or (ssRight in Shift)}) and ((x>=0) and (x<breedte) and (y>=0) and (y<hoogte)) then
  begin
    begin
      if (deletecarriers=True) then begin waarde:=skoon; rad:=25;end else begin waarde:=bm;rad:=5;end;
      rad2:=rad*rad;
      begin
        for i:=-rad to rad do
        for j:=-rad to rad do if (((X+i)>=0) and ((X+i)<breedte) and ((Y+j)>=0) and ((Y+j)<hoogte) and ((i*i+j*j)<=rad2)) then
        begin
          popskik^[X+i,Y+j].status:=waarde;
          popskik^[X+i,Y+j].g[1]:=waarde;
          popskik^[X+i,Y+j].g[2]:=waarde;

//          if ((ssRight in Shift) and (ssLeft in Shift)) then begin popskik^[X+i,Y+j].g[2]:=waarde;popskik^[X+i,Y+j].status:=beide;end;
          prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[y+j];
          prentlyn[x+i]:=kleureRGB[popskik^[X+i,Y+j].status];
        end;
      end;
    end;
    Image1.Invalidate;
  end;
end;

procedure TVertoonblad.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  bm:=beskikbaremutasie;
  Image1MouseMove(self,Shift,X,Y);
end;

procedure TVertoonblad.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if vertoonblad.clientwidth<2*Screen.Width then breedte:=vertoonblad.ClientWidth;
  if vertoonblad.ClientHeight<screen.Height then hoogte:=vertoonblad.ClientHeight;
  vertoonblad.Image1.Picture.Bitmap.Width:=breedte;
  vertoonblad.Image1.Picture.Bitmap.Height:=hoogte;

  form1.scrollbar3.position:=breedte;
  form1.scrollbar4.position:=hoogte;
  UpdateDisplay;
//  Form1.CheckBox1Click(self);  //Force redraw
end;

procedure TVertoonblad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if MCForm.Visible then MCForm.checkbox2.checked:=False else form1.CheckBox1.checked:=False; 
end;

procedure TVertoonblad.AlternativeColourScheme1Click(Sender: TObject);
var i:integer;
begin
    begin  //Alternative colour scheme
      kleure[skoon]:=clWhite;   	//0
      kleure[dood]:=clMaroon;    	//1
      kleure[beide]:=clRed;	   	//2
      kleure[draer]:=clBlack;    	//3
    end;
    for i:=0 to maksstatus do
    begin
      kleureRGB[i].R := kleure[i] and $ff;
      kleureRGB[i].G := (kleure[i] and $ff00) shr 8;
      kleureRGB[i].B := (kleure[i] and $ff0000) shr 16;
      kleureRGB[i].A:=0;
    end;
    Vertoonblad.UpdateDisplay;
end;

procedure TVertoonblad.StandardColourScheme1Click(Sender: TObject);
var i:integer;
begin
    begin  //Standard colour scheme
//      checkbox1.Caption:='Display';
      kleure[skoon]:=clBlack;   	//0
      kleure[dood]:=clMaroon;    	//1
      kleure[beide]:=clWhite;   	//2
      kleure[draer]:=clLime;    	//3
    end;
    for i:=0 to maksstatus do
    begin
      kleureRGB[i].R := kleure[i] and $ff;
      kleureRGB[i].G := (kleure[i] and $ff00) shr 8;
      kleureRGB[i].B := (kleure[i] and $ff0000) shr 16;
      kleureRGB[i].A:=0;
    end;
    Vertoonblad.UpdateDisplay;
end;

procedure TVertoonblad.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssCtrl in Shift) or (ssShift in Shift)) then
    deletecarriers:=True;
end;

procedure TVertoonblad.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  deletecarriers:=False;
end;

end.
