unit Popvertoon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, Popdefs, rxPlacemnt;

type
  TVertoonblad = class(TForm)
    FormStorage1: TFormStorage;
    Panel1: TPanel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Vertoonblad: TVertoonblad;
  bm:integer;

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
  if ((ssLeft in Shift) or (ssRight in Shift)) and ((x>=0) and (x<breedte) and (y>=0) and (y<hoogte)) then
  begin
    begin
      if (ssRight in Shift) then begin waarde:=skoon; rad:=25;end else begin waarde:=bm;rad:=5;end;
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

end;

procedure TVertoonblad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if MCForm.Visible then MCForm.checkbox2.checked:=False else form1.CheckBox1.checked:=False; 
end;

end.
