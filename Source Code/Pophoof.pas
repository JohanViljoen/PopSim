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
{$A+,B-,C+,D+,E-,F-,G+,H+,I-,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00040000}
{$MAXSTACKSIZE $01000000}
{$IMAGEBASE $04000000}
{$APPTYPE GUI}

{$INCLUDE compdefs.pas}

unit Pophoof;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, TeeProcs, TeEngine, Chart, Series,
  PBNumEdit, PBSuperSpin, Popdefs, Popvertoon,
  rxPlacemnt, PBSpinEdit, JvExControls, JvChart, JvAppInst, Menus;

type
  TForm1 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
{$IFDEF SHOWSTABTRIGGER}
    Series4: TLineSeries;
    Series5: TLineSeries;
{$ENDIF}
   
    Button4: TButton;
    Timer1: TTimer;
    FormStorage1: TFormStorage;
    GroupBox1: TGroupBox;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    PBSuperSpin3: TPBSuperSpin;
    ScrollBar2: TScrollBar;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    Button1: TButton;
    PBSuperSpin1: TPBSuperSpin;
    Label4: TLabel;
    Label7: TLabel;
    PBSuperSpin2: TPBSuperSpin;
    Label8: TLabel;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox5: TCheckBox;
    Button5: TButton;
    SaveDialog1: TSaveDialog;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label13: TLabel;
    Button6: TButton;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Label6: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label3: TLabel;
    Label15: TLabel;
    PBSuperSpin4: TPBSuperSpin;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    Label22: TLabel;
    Button7: TButton;
    Button8: TButton;
    OpenDialog1: TOpenDialog;
    CheckBox11: TCheckBox;
    JvAppInstances1: TJvAppInstances;
    ScrollBar5: TScrollBar;
    Label18: TLabel;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure pasdrempelsaan;
    procedure PBSuperSpin1Change(Sender: TObject);
    procedure PBSuperSpin4Change(Sender: TObject);
    procedure PBSuperSpin2Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PBSuperSpin3Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ScrollBar2Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure CheckBox5Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure maakcdf(v:real);
    procedure CheckBox7Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure ScrollBar5Change(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure CheckBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;
  criticalSection: TRTLCriticalSection;


implementation

uses Pophis, PopMC;


{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);   //Initialise
var
  a,b,i: integer;
  b2stat,b3stat,loop:Boolean;

begin
  initbesig:=True;

  if vertoon then Vertoonblad.Show;

  b2stat:=Button2.Enabled;
  b3stat:=Button3.Enabled;
  loop:=besig;
//  if besig then begin form1.Button3Click(self);repeat until besig=False;end;
  button2.Enabled:=False;
  button3.Enabled:=False; //Do not allow running/stopping when initialising

  for b:=0 to langgemiddeld-1 do stabiliteitsensor[b]:=langgemiddeld*2; //Initialise the stability sensor with values that will first need to be pushed out of the pipeline before it can trigger.

  for a:=0 to maksbreedte-1 do
  for b:=0 to makshoogte-1 do
  begin
    popskik^[a,b].status:=skoon;
    popskik^[a,b].g[1]:=skoon;
    popskik^[a,b].g[2]:=skoon;
{$IFDEF GESLAGTE}if random(2)=1 then popskik^[a,b].male:=True else popskik^[a,b].male:=False;{$ENDIF}
  end;
  tydskik^:=popskik^;

  draerteller:=0;
  wildteller:=0;


  for b:=0 to hoogte -1 do
  begin
//    if ((b mod 200)=0) then application.processmessages; //To make the program more responsive when doing large populations
    if ((vertoon) and (b<screen.Height-20)) then
      prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[b]
        else prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[0];
    for a:=0 to breedte-1 do
    begin
      with popskik^[a,b] do
      begin
        if random(1000000)/10000<beginpersentasie then
        begin
          inc(draerteller);
          if CheckBox2.Checked then g[1]:=draer+random(10) else
            g[1]:=draer;
          status:=g[1];
//          g[2]:=draer;
//          status:=beide;
        end else
        begin
          status:=skoon;
          g[1]:=skoon;
          inc(wildteller);
        end;

//        if ((vertoon) and (a<2*screen.width)) then prentlyn[a]:=kleureRGB[status];
        //Pas oorlewingsvoordeel toe
        if ((status<draer) and (random(drempelskaal)>drempels[status])) then status:=dood;

        if ((vertoon) and (a<2*screen.width)) then prentlyn[a]:=kleureRGB[status];
      end;
    end;
  end;
//  tydskik^:=popskik^;

  if loop or besig then begin
                 button2.Enabled:=b2stat;
                 button3.Enabled:=b3stat;

//                 Button3Click(self);repeat until besig=True;
                 tydskik^:=popskik^;

                 initbesig:=False;
        	 exit;
  		end;

  if vertoon then vertoonblad.Image1.Invalidate;
  draergemiddeld:=100*draerteller/(breedte*hoogte);
  wildgemiddeld:=100*wildteller/(breedte*hoogte);
  siekgemiddeld:=0;

  Series1.Clear;
  series2.Clear;
  series3.Clear;
{$IFDEF SHOWSTABTRIGGER}
  series4.Clear;
  series5.Clear;
{$ENDIF}

  grafiekpunte:=1;
  grafiekpuntevertoon:=0;

//  grafiekskik[grafiekpunte].draer:=100*draerteller/(breedte*hoogte);
  grafiekskik[grafiekpunte].hetero:=draergemiddeld;
  grafiekskik[grafiekpunte].homo:=0;
  grafiekskik[grafiekpunte].wild:=wildgemiddeld;

  if checkbox5.checked then
  begin
    Hisblad.Bargraph1.Clear;
    i:=draer;Hisblad.Bargraph1.AddXY(i,draerteller,'M'+inttostr(i-draer+1),kleure[i]);
  end;


  form1.PBSuperSpin1Change(self);
  form1.PBSuperSpin2Change(self);
  generasieteller:=0;
  besig:=False;
  generasieteller:=0;
  label6.Caption:='Generations : 0';
  if vertoon then
  begin
    ScrollBar3Change(self);
    ScrollBar4Change(self);
  end;
  grootstemutasienommer:=draer;

//  if loop then Button3Click(self);
  initbesig:=False;
  button2.Enabled:=b2stat;
  button3.Enabled:=b3stat;


end;

procedure maakgemeenskaplys;
var i,j,teller:integer;
begin
  teller:=0;
  gemeenskapskik[teller+1].x:=0;
  gemeenskapskik[teller+1].y:=0;
  inc(teller);

  for i:=1 to trunc(sqrt(maksgemeenskap)/2) do
  begin
    Application.ProcessMessages;
    for j:=-i to i-1 do
    begin
      gemeenskapskik[teller+1].x:=j;
      gemeenskapskik[teller+1].y:=-i;
      if teller<maksgemeenskap then inc(teller);

      gemeenskapskik[teller+1].x:=i;
      gemeenskapskik[teller+1].y:=j;
      if teller<maksgemeenskap then inc(teller);

      gemeenskapskik[teller+1].x:=-j;
      gemeenskapskik[teller+1].y:=i;
      if teller<maksgemeenskap then inc(teller);

      gemeenskapskik[teller+1].x:=-i;
      gemeenskapskik[teller+1].y:=-j;
      if teller<maksgemeenskap then inc(teller);
    end;
  end;
//  form1.scrollbar2.max:=teller;
  form1.scrollbar2.max:=trunc(20*ln(teller));
end;


procedure TForm1.maakcdf(v:real);
var
  i,j,punte,aantal:integer;
  sigma,variansie,a,aa:real;
  ekspskik:array[-makscdfbereik..makscdfbereik] of real;
  cdfbereik:integer;

begin
{$IFDEF OUERS}
for i:=0 to maksouerhis do ouerhis[i]:=0;
{$ENDIF}
 if v<=0 then v:=1;

//v:=makscdfstappe;
  for i:=1 to makscdfstappe do cdf2[i]:=0;
//  for i:=1 to maksgemeenskap do begin gemeenskapskik[i].x:=0;gemeenskapskik[i].y:=0;end;

  sigma:=sqrt(v/Pi)/2;    {Die radius van 'n sirkel met oppervlak v is 2-sigma; dit sluit 95% van die individue in}
  label14.Caption:='sigma :'+floattostrf(sigma,ffFixed,5,3);


  if checkbox7.checked=False then
  begin  //Plat verspreiding
    PBSuperSpin3.Decimals:=0;
    maakgemeenskaplys; //Maak seker die lys is reg
    for i:=1 to trunc(v) do cdf2[i]:=i;
    cdfstappe:=trunc(v);
  end

  else
  begin //Gaussverspreiding
    PBSuperspin3.Decimals:=3;
    variansie:=sigma*sigma;
    a:=1/(2*Pi*variansie);

//    cdfbereik:=makscdfbereik;
    case trunc(v) of   //Hierdie waardes is geldig vir makscdfstappe <= 600K; Dit spaar heelwat tyd om net die nodige area te bereken
    0..10:cdfbereik:=5;
    11..100:cdfbereik:=15;
    101..1000:cdfbereik:=36;
    1001..10000:cdfbereik:=95;
    10001..100000:cdfbereik:=225;
    else
      cdfbereik:=makscdfbereik;
    end;


    aa:=a*makscdfstappe;
    repeat
      application.ProcessMessages;
      //Bereken eers die waarde van die Gauss-eksponent om tyd te spaar
      for i:=-cdfbereik to cdfbereik do ekspskik[i]:=((i*i)/(2*variansie));
      cdfstappe:=0;
      for i:=-cdfbereik to cdfbereik do
      begin
        application.processmessages;

        for j:=-cdfbereik to cdfbereik do
        begin
          Gauss2D[i,j]:=round(aa*exp(-(ekspskik[i]+ekspskik[j])));
          cdfstappe:=cdfstappe+Gauss2D[i,j];
        end;
      end;
      if cdfstappe>makscdfstappe then
        aa:=aa*0.97    //Skaleer die waarskynlikhede af met 3% op 'n keer as afrondingsfoute maak dat die totaal groter as makscdfstappe is
          else
        aa:=aa*1.02;   //Skaleer die waarskynlikhede op met 2% op 'n keer as afrondingsfoute maak dat die totaal kleiner as 0.95*makscdfstappe is
      application.ProcessMessages;
    until ((cdfstappe<=makscdfstappe) and (cdfstappe>0.95*makscdfstappe));       //Maak seker die totale aantal opsies is kleiner as die grootte van cdf2

    cdfstappe:=0;
    punte:=0;
    for i:=-cdfbereik to cdfbereik do
    begin
      application.ProcessMessages;

      for j:=-cdfbereik to cdfbereik do
      begin
//        application.ProcessMessages;

        if Gauss2D[i,j]>0 then
        begin
          inc(punte);  //Sit die punt op die lys
          gemeenskapskik[punte].x:=i;
          gemeenskapskik[punte].y:=j;
          for aantal:=1 to Gauss2D[i,j] do
          begin
            inc(cdfstappe);  //Gee hom soveel kanse as wat hy moet kry
            cdf2[cdfstappe]:=punte;
          end;
        end;
      end;
    end;
  end;
{$IFDEF KLANKE}
   beep;
{$ENDIF}
//  series1.Clear;for i:=1 to cdfstappe do series1.AddXY(i,cdf2[i]);
end;



procedure TForm1.FormCreate(Sender: TObject);
var i,a,b:integer;
    systemInfo: SYSTEM_INFO;
    SysAFMask:Cardinal;
begin
//  InitializeCriticalSection(criticalSection);
  form1.Caption:=psversion;

  Randomize;
  maakgemeenskaplys;
  his[dood].naam:='Dead';
  his[beide].naam:='Hom';
  his[skoon].naam:='Wild';
  for i:=draer to maksstatus do begin his[i].naam:='M'+inttostr(i-draer+1);his[i].nommer:=i;end;
  for i:=dood to maksstatus do his2[i]:=his[i];


  hoogte:=beghoogte;
  breedte:=begbreedte;
//  form1.ScrollBar1.Position:=500;
  ScrollBar1Change(self);

  scrollbar3.max:=maksbreedte;
  scrollbar4.Max:=makshoogte;
//  scrollbar2.Max:=breedte div 2;
//  gemeenskapsgrootte:=trunc(PBSUperspin3.Value);
  if gemeenskapsgrootte<1 then gemeenskapsgrootte:=300;
  scrollbar2.Position:=round(20*ln(gemeenskapsgrootte));
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
{$IFDEF SHOWSTABTRIGGER}
  Series4.Clear;
  Series5.Clear;
{$ENDIF}
  grafiekpuntevertoon:=0;
  grafiekpunte:=0;

//  form1.Left:=20;
//  form1.Top:=20;
  PBSuperspin3.MaxValue:=maksgemeenskap;
  Label11.Caption:='Population : '+inttostr(breedte*hoogte);
  CheckBox3Click(self);
  CheckBox4Click(self);
  label12.caption:='';

  for a:=0 to maksbreedte-1 do
  for b:=0 to makshoogte-1 do
  begin
    popskik^[a,b].status:=skoon;
    popskik^[a,b].g[1]:=skoon;
    popskik^[a,b].g[2]:=skoon;
    tydskik^[a,b].status:=skoon;
    tydskik^[a,b].g[1]:=skoon;
    tydskik^[a,b].g[2]:=skoon;
  end;

{$IFDEF OUERS}
Checkbox11.visible:=True;
{$ELSE}
Checkbox11.Visible:=False;
{$ENDIF}

{$IFDEF HIDEMULTIPLETYPES}
Form1.CheckBox2.Visible:=False;
Form1.CheckBox5.Visible:=False;
{$ENDIF}

//  SetPriorityClass(GetCurrentProcess(),BELOW_NORMAL_PRIORITY_CLASS);   //IDLE_PRIORITY_CLASS, BELOW_NORMAL_PRIORITY_CLASS, NORMAL_PRIORITY_CLASS, ABOVE_NORMAL_PRIORITY_CLASS, HIGH_PRIORITY_CLASS, REALTIME_PRIORITY_CLASS

i:=JvAppInstances1.AppInstances.SessionInstanceCount;
GetSystemInfo(systemInfo);
a:=systemInfo.dwNumberOfProcessors;
form1.Caption:=form1.Caption+'  -  '+inttostr(i);
SysAFMAsk := $00000001 shl((i-1) mod a) ; // Set this process to run on CPU 1 only
{ Set the Process Affinity Mask }
SetProcessAffinityMask( GetCurrentProcess, SysAFMAsk);

b:=trunc(ln(SysAFMask)/ln(2));
form1.Caption:=form1.Caption+' : CPU '+inttostr(b)+'/'+inttostr(a);

  form1.ScrollBar5Change(self);
//  if PBSuperSpin3.value<1 then PBSuperspin3.value:=150;

//Determine which graphs should be displayed
  CheckBox8Click(self);
  CheckBox9Click(self);
  CheckBox10Click(self);

end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var s:string;

begin
  beginpersentasie:= scrollbar1.position/100;
  s:=FloatToStrF(beginpersentasie,ffFixed,5,2);
  form1.Label1.Caption:=s+'%';

end;




procedure TForm1.Button2Click(Sender: TObject);
var
  a,b,x1,y1,x2,y2,dx,dy,dx2,dy2,i,j,st:integer;
  ouer1,ouer2:indrekord;
  vorige:word;
  pogingteller:integer;
  dp,vorigedp:real;
//  geslagverskil:Boolean;
  t:TRGBQuad;
  pp:Pointer;
  lewendebevolking:real;
  stabielteller:integer;
  nulteller:integer;
  sstat:Boolean;

{$IFDEF OUERS}
  leer:textfile;
  leernaam,d:string;
{$ENDIF}

begin
  application.ProcessMessages;
  vorige:=0;dp:=0;
  if isbesig=False then
  begin
    sstat:=Button2.enabled;Button2.Enabled:=False;
    isbesig:=True;
    draerteller:=0;
    for i:=0 to maksstatus do begin his[i].aantal:=0;his2[i].aantal:=0;end;

//Ruil tydskik en popskik om
    pp:=tydskik;
    tydskik:=popskik;
    popskik:=pp;

{$IFDEF OUERS}
    //Maak ouerstatistieke bymekaar
if checkbox11.checked then
begin
    for b:=0 to hoogte-1 do
  for a:=0 to breedte-1 do ouerstat[a,b]:=0;
end;
{$ENDIF}


    for b:=0 to hoogte-1 do
    begin
      if ((b mod 200) = 0) then application.ProcessMessages;   //To make the program more responsive, especially when doing large populations which can take several seconds per generation
      if initbesig then repeat until initbesig=False;
      if ((vertoon) and (b<screen.Height-20)) then prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[b] else prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[0];
      for a:=0 to breedte-1 do
      begin

        if vertoon then vorige:=tydskik^[a,b].status;
        pogingteller:=0;
        repeat    //Kies ouer 1
          i:=cdf2[random(cdfstappe)+1];
          x1:=a+gemeenskapskik[i].x; while x1>=breedte do x1:=x1-breedte; while x1<0 do x1:=x1+breedte;
          y1:=b+gemeenskapskik[i].y; while y1>=hoogte do y1:=y1-hoogte; while y1<0 do y1:=y1+hoogte;

          inc(pogingteller);
        until ((tydskik^[x1,y1].status>dood) or (pogingteller>makspogings));

        repeat   //Kies ouer 2
          inc(pogingteller);
{$IFDEF ENKELOUER}
            j:=cdf2[random(cdfstappe)+1];
{$ELSE}
          repeat
            j:=cdf2[random(cdfstappe)+1];
          until j<>i;
{$ENDIF}  //ENKELOUER

          x2:=a+gemeenskapskik[j].x; while x2>=breedte do x2:=x2-breedte; while x2<0 do x2:=x2+breedte;
          y2:=b+gemeenskapskik[j].y; while y2>=hoogte do y2:=y2-hoogte; while y2<0 do y2:=y2+hoogte;

{$IFDEF GESLAGTE}
        until (((tydskik^[x2,y2].male<>tydskik^[x1,y1].male) and (tydskik^[x2,y2].status>dood)) or (pogingteller>makspogings));
{$ELSE}
        until ((tydskik^[x2,y2].status>dood) or (pogingteller>makspogings));
{$ENDIF}  //GESLAGTE

        ouer1:=tydskik^[x1,y1];
        ouer2:=tydskik^[x2,y2];

{$IFDEF OUERS}
//Ouerstatistieke
if checkbox11.checked then
begin     //Hierdie twee was ouers
  inc(ouerstat[x1,y1]);
  inc(ouerstat[x2,y2]);
end;
{$ENDIF}


        with popskik^[a,b] do
        begin
{$IFDEF GESLAGTE}if random(2)=1 then male:=True else male:=False;{$ENDIF}
          if pogingteller>makspogings then begin status:=skoon;g[1]:=skoon;g[2]:=skoon end else
          begin
            case random(4) of
            0:begin g[1]:=ouer1.g[1];g[2]:=ouer2.g[1];end;
            1:begin g[1]:=ouer1.g[1];g[2]:=ouer2.g[2];end;
            2:begin g[1]:=ouer1.g[2];g[2]:=ouer2.g[1];end;
            3:begin g[1]:=ouer1.g[2];g[2]:=ouer2.g[2];end;
            end;
            if ((g[1]<draer) and (g[2]<draer))
              then status := skoon
                else begin
                  	if ((g[1]>=draer) and (g[2]>=draer))
                    		then begin status := beide;inc(his2[g[1]].aantal);inc(his2[g[2]].aantal);end
                    	else begin if g[1]>=draer then status:=g[1] else status:=g[2];end;
                      end;
            if ((denovo>0) and (random(denovoskaal)<denovo)) then begin status:=beskikbaremutasie;g[1]:=beskikbaremutasie;g[2]:=skoon;end;
            if ((vertoon) and (status<>vorige) and (a<2*screen.Width)) then prentlyn[a]:=kleureRGB[status];
          end;
          inc(his[status].aantal);

          //Pas oorlewingsvoordeel toe - slaan party individue dood in voorbereiding op die volgende generasie
          //Ons spaar tyd deur dit nou reeds in dieselfde lus te doen
          if (random(drempelskaal)>drempels[status]) then status:=dood;
        end;
      end; //breedte
    end;  //hoogte

{$IFDEF OUERS}
if checkbox11.checked then
begin
  for b:=0 to hoogte-1 do
    for a:=0 to breedte-1 do inc(ouerhis[ouerstat[a,b]]);
  b:=0;for a:=0 to maksouerhis do if ouerhis[a]>0 then b:=a; //Kry grootste inskrywing
  d:=GetCurrentDir;
  inc(ouerleerteller);
  leernaam:=d+'\'+'ouers'+inttostr(ouerleerteller)+'_'+inttostr(gemeenskapsgrootte)+'.txt';
  assignfile(leer,leernaam);
  rewrite(leer);
  d:='Width:'+inttostr(breedte)+', Height:'+inttostr(hoogte)+', Pop:'+inttostr(breedte*hoogte)+', Com:'+inttostr(gemeenskapsgrootte);
  writeln(leer,d);
  d:='HetAdv:'+floattostrf(HeterozygoticAdvantage,fffixed,8,5)+' HomAdv:'+floattostrf(HomozygoticAdvantage,fffixed,8,5);
  writeln(leer,d);
  d:='Wild:'+floattostrf(grafiekskik[grafiekpunte].wild,fffixed,8,3)+'% Het:'+floattostrf(grafiekskik[grafiekpunte].hetero,fffixed,8,3)+'% Hom:'+floattostrf(grafiekskik[grafiekpunte].homo,fffixed,8,3)+'%';
  writeln(leer,d);
  //for a:=0 to b do writeln(leer,a,',',ouerhis[a]);
  for a:=0 to b do writeln(leer,ouerhis[a]);
  closefile(leer);
  for a:=0 to b do ouerhis[a]:=0;  //Maak nul vir volgende generasie
end;
{$ENDIF}


    if vertoon then Vertoonblad.Image1.Invalidate;
    inc(generasieteller);
    draerteller:=his[draer].aantal;if form1.CheckBox2.checked then for i:=draer+1 to maksstatus do draerteller:=draerteller+his[i].aantal;
    siekteller:=his[beide].aantal;
    wildteller:=his[skoon].aantal;

    inc(grafiekpunte);
    lewendebevolking:=1/((breedte*hoogte)-his[dood].aantal);
    grafiekskik[grafiekpunte].hetero:=100*draerteller*lewendebevolking;

{$IFDEF SHOWSTABTRIGGER}
//    if MCForm.Checkbox7.Checked=False then
{$ENDIF}
    begin
      grafiekskik[grafiekpunte].homo:=100*siekteller*lewendebevolking;
      grafiekskik[grafiekpunte].wild:=100*wildteller*lewendebevolking;
    end;

//    grafiekskik[grafiekpunte].hetero:=100*draerteller/(breedte*hoogte-his[dood].aantal);
//    grafiekskik[grafiekpunte].homo:=100*his[beide].aantal/(breedte*hoogte-his[dood].aantal);
//    grafiekskik[grafiekpunte].wild:=100*his[skoon].aantal/(breedte*hoogte-his[dood].aantal);

//    dp:=100*draerteller/(breedte*hoogte-his[dood].aantal);
    vorigedp:=dp;
    dp:=grafiekskik[grafiekpunte].hetero;
    vorigedraergemiddeld:=draergemiddeld;
    draergemiddeld:=(draergemiddeld*(langgemiddeld-1)+dp)/langgemiddeld;



//Toets of die draergemiddeld stabiel is
    if ((MCBesig1=True) and (doEquilibrium=True)) then
    begin
      if vorigedp=dp then
        stabiliteitsensor[generasieteller mod langgemiddeld]:=0
        else
        begin
          if draergemiddeld<dp then stabiliteitsensor[generasieteller mod langgemiddeld]:=1
           else stabiliteitsensor[generasieteller mod langgemiddeld]:=-1;
        end;
      if generasieteller>1 then //langgemiddeld then  //Laat hom minstens langgemiddeld generasies loop
      begin
        stabielteller:=0;
        nulteller:=0;
        st:=1;
        repeat
          if ( (stabiliteitsensor[st-1]*stabiliteitsensor[st])=-1)// or ( (stabiliteitsensor[st-1]=0) and (stabiliteitsensor[st]=0) ) )
            then inc(stabielteller) else
          if (stabiliteitsensor[st]=0) then inc(nulteller);
          inc(st);
        until st>=langgemiddeld-1;
        if ((stabielteller>=stabieldrempel) or (nulteller>=nuldrempel)) then stabiel:=True else stabiel:=False;


//***************
{$IFDEF SHOWSTABTRIGGER}
      if MCForm.Checkbox7.Checked then  //Display the moving average and trigger levels using the wild & homo graph lines
      begin
        grafiekskik[grafiekpunte].movingavg:=draergemiddeld;
        grafiekskik[grafiekpunte].trig:=grafiekskik[grafiekpunte].movingavg*stabielteller/stabieldrempel;
//        if stabiel then chart1.BackColor:=clCream else chart1.BackColor:=clWhite;
      end;
{$ENDIF}
//****************

      end else stabiel:=False;
    end;



//    siekgemiddeld:=(siekgemiddeld*(langgemiddeld-1)+100*his[beide].aantal/(breedte*hoogte-his[dood].aantal))/langgemiddeld;
//    wildgemiddeld:=(wildgemiddeld*(langgemiddeld-1)+100*his[skoon].aantal/(breedte*hoogte-his[dood].aantal))/langgemiddeld;

    siekgemiddeld:=(siekgemiddeld*(langgemiddeld-1)+grafiekskik[grafiekpunte].homo)/langgemiddeld;
    wildgemiddeld:=(wildgemiddeld*(langgemiddeld-1)+grafiekskik[grafiekpunte].wild)/langgemiddeld;


    beskikbaremutasie:=0;

      for i:=draer to maksstatus do
      begin
        if (his[i].aantal>0) then
        begin
          if i>grootstemutasienommer then grootstemutasienommer:=i;
        end
        else
        begin
          if beskikbaremutasie=0 then beskikbaremutasie:=i;
          if beskikbaremutasie>=maksstatus then beskikbaremutasie:=maksstatus;
        end;
      end;
    if ((CheckBox2.Checked=False) or (beskikbaremutasie=0)) then beskikbaremutasie:=draer;

    isbesig:=False;
    Button2.enabled:=sstat;

  end;


end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  generasieteller:=0;
  if PBSuperspin3.Value<1 then PBSUperspin3.value:=100;
  if vertoon then vertoonblad.show;
  vorigegt:=generasieteller;
  tydvorige:=Gettickcount;
  Button3.Enabled:=False;


  if besig=False then
  begin
//    Button3.Enabled:=False;
    form1.PBSuperSpin1Change(self);  //Maak seker die hetero-voordeel is opgedateer
    form1.PBSuperSpin4Change(self);  //Maak ook seker die homo-voordeel is opgedateer
    PBSuperSpin3Change(self);

    pasdrempelsaan;


//    form1.Series1.clear;form1.Series2.clear;form1.Series3.clear;
    grafiekpunte:=0;
    grafiekpuntevertoon:=0;
    Button3.Caption:='Stop';
    Button2.Enabled:=False;
//    Button1.Enabled:=False;
    Button6.Enabled:=False;
    Button3.Enabled:=True;

  end else
  begin
    Form1.GroupBox1.Enabled:=False;
    Form1.GroupBox2.Enabled:=False;

    Button3.enabled:=False;
    Button3.caption:='Run';
//    Button2.Enabled:=True;
    Button1.Enabled:=True;
//    Button6.Enabled:=True;
    sktyd:=0;
    spoed:=0;
  end;

  besig:=not(besig);

  while ((besig=True) and (initbesig=False)) do
  begin
    form1.Button2Click(self);
  end;
//  if besig=False then Button2.enabled:=True;
//  Button3.Enabled:=True;

end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var a,b,br:integer;
begin
  vertoon:=form1.CheckBox1.Checked;
  if vertoon then
  begin
//    breedte:=form1.ScrollBar3.Position;
//    hoogte:=form1.ScrollBar4.Position;
    vertoonblad.clientwidth:=breedte;
    vertoonblad.ClientHeight:=hoogte;
    vertoonblad.show;
    vertoonblad.UpdateDisplay;
{
    for b:=0 to hoogte-1 do
    begin
      if b<screen.Height-20 then prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[b] else prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[0];
      br:=breedte-1;if br>2*screen.width then br:=2*screen.width;
      for a:=0 to br do
        prentlyn[a]:=kleureRGB[popskik^[a,b].status];
    end;
}
  end;
  vertoonblad.Image1.Invalidate;
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
  breedte:=scrollbar3.Position;
  if checkbox1.checked then vertoonblad.ClientWidth:=breedte;
  label9.Caption:='Width : '+inttostr(breedte);
  Label11.Caption:='Population : '+inttostr(breedte*hoogte);
  sktyd:=0;

end;

procedure TForm1.ScrollBar4Change(Sender: TObject);
begin
  hoogte:=ScrollBar4.Position;
  if checkbox1.checked then vertoonblad.ClientHeight:=hoogte;
  label10.caption:='Height : '+inttostr(hoogte);
  Label11.Caption:='Population : '+inttostr(breedte*hoogte);
  sktyd:=0;

end;

procedure TForm1.pasdrempelsaan;
var i:integer;
    het,hom,wild,max:real;

begin
(*
  dood = 0;
  beide = 1;
  skoon = 2;
  draer = 3;
*)
  het:=HeterozygoticAdvantage;max:=het;
  hom:=HomozygoticAdvantage;if hom>max then max:=hom;
  wild:=1;if wild>max then max:=wild;

  het:=drempelskaal*het/max;
  hom:=drempelskaal*hom/max;
  wild:=drempelskaal*wild/max;
  drempels[0]:=0;
  drempels[1]:=hom;
  drempels[2]:=wild;
  for i:=draer to maksstatus do drempels[i]:=het;
end;

procedure TForm1.PBSuperSpin1Change(Sender: TObject);
var
  vt:real;
begin
    vt:=StrToFloat(PBSuperSpin1.Text);
    HeterozygoticAdvantage:=1+vt/100;
    label4.Caption:=floattostrf(HeterozygoticAdvantage,ffFixed,5,4);
    pasdrempelsaan;
    sktyd:=0;
//    generasieteller:=0;
end;

procedure TForm1.PBSuperSpin4Change(Sender: TObject);
var
  vt:real;
begin
    vt:=StrToFloat(PBSuperSpin4.Text);
    HomozygoticAdvantage:=1+vt/100;
    label16.Caption:=floattostrf(HomozygoticAdvantage,ffFixed,5,4);
    pasdrempelsaan;
    sktyd:=0;
end;



procedure TForm1.PBSuperSpin2Change(Sender: TObject);
begin
  denovo:=PBSuperSpin2.Value*denovoskaal/1E6;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  form1.Chart1.Width:=form1.ClientWidth-form1.Chart1.Left;
//  Hisblad.Chart2.Width:=form1.ClientWidth;
  form1.Chart1.Height:=form1.ClientHeight-form1.chart1.Top;
end;


procedure TForm1.Button4Click(Sender: TObject);
begin
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
{$IFDEF SHOWSTABTRIGGER}
  Series4.Clear;
  Series5.Clear;
{$ENDIF}
  grafiekpunte:=0;grafiekpuntevertoon:=0;
end;

procedure vertoonhistogram;
var i:integer;
begin
    Hisblad.Bargraph1.Clear;
    if hisblad.checkbox5.Checked then
    begin
      hissort:=his;//Net die heterosigote
      if hisblad.CheckBox2.checked then
      begin
        for i:=0 to grootstemutasienommer do hissort[i].aantal:=hissort[i].aantal+his2[i].aantal;
      end;
    end else begin hissort:=his2;end; //Net die homosigote

  //Sorteer histogram
    if Hisblad.CheckBox1.checked then  //Sorteer
    repeat
      hisskoon:=True;
      for i:=draer to grootstemutasienommer-1 do if hissort[i+1].aantal>hissort[i].aantal then begin tydhisrek:=hissort[i];hissort[i]:=hissort[i+1];hissort[i+1]:=tydhisrek;hisskoon:=False;end;
    until hisskoon;
    i:=draer;
    while (i<=grootstemutasienommer) do
    begin
      if ((normaliseergrafiek=True) and(draerteller>0)) then Hisblad.Bargraph1.AddXY(i,100*hissort[i].aantal/draerteller,hissort[i].naam,kleure[hissort[i].nommer])
         else Hisblad.Bargraph1.AddXY(i,hissort[i].aantal,hissort[i].naam,kleure[hissort[i].nommer]);
      inc(i);
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i:integer;
    ttg:real;
    h,m,s:integer;
    eta:string;
begin

  if ((Form1.HorzScrollBar.IsScrollBarVisible) or (Form1.VertScrollBar.IsScrollBarVisible)) then
  begin
    form1.AutoSize:=True;
    form1.ScrollBy(1,1);
    form1.Repaint;
    form1.AutoSize:=False;
  end;


  inc(tydteller);
  application.ProcessMessages;



  //  form1.Label5.caption:='Carrier Prevalence : '+floattostrF(draergemiddeld,ffFixed,6,4)+'%';
  form1.Label5.caption:=floattostrF(draergemiddeld,ffFixed,6,4)+'%';
  form1.Label20.caption:=floattostrF(siekgemiddeld,ffFixed,6,4)+'%';
  form1.Label22.caption:='Wild :'+floattostrF(wildgemiddeld,ffFixed,6,4)+'%';

  form1.label6.Caption:='Generations : '+inttostr(generasieteller);
  if tydteller=2 then
  begin
    checkbox1click(self);
  end;

  if series1.Count>grafiekskoonmaakdrempel then
  begin
    Button5Click(self);  //Skryf eers na skyf
    Button4Click(self);  //Maak grafieke skoon as dinge te groot raak
  end;

  if form1.CheckBox6.Checked then  //Vertoon grafieke
  begin
    if grafiekpuntevertoon<grafiekpunte then
    for i:=grafiekpuntevertoon+1 to grafiekpunte do
    begin
      Series1.AddXY(series1.count+1,grafiekskik[i].hetero);
      Series2.AddXY(series2.count+1,grafiekskik[i].homo);
      Series3.AddXY(series3.count+1,grafiekskik[i].wild);
{$IFDEF SHOWSTABTRIGGER}
      Series4.AddXY(series4.count+1,grafiekskik[i].movingavg);
      Series5.AddXY(series5.count+1,grafiekskik[i].trig);
{$ENDIF}
    end;
    grafiekpuntevertoon:=grafiekpunte;
  end;
  if (grafiekpunte>(maksgrafiekpunte-10000)) then grafiekpunte:=maksgrafiekpunte-10000;


  if checkbox5.checked then  //Vertoon histogram
  vertoonhistogram;

  if ((besig) or (MCBesig1)) then
  begin
    tydnou:=gettickcount;
    if ((tydnou>tydvorige) and (generasieteller<>vorigegt)) then
    begin
      if sktyd<sk then inc(sktyd);

      spoed:=( spoed*(sktyd-1) +  1000*(generasieteller-vorigegt)/(tydnou-tydvorige) ) /sktyd;
      tydvorige:=tydnou;
      vorigegt:=generasieteller;
    end;

    if ((spoed>0.2) or (spoed<1E-4)) then
      label12.Caption:=floattostrF(spoed,ffFixed,6,2)+' gen/s'
    else
      label12.Caption:=floattostrF(1/spoed,ffFixed,6,2)+' s/gen';


    if MCBesig1 then
    begin
//      MCspoed:=(MCspoed*(sktyd-1) + (1000/Timer1.interval)*(MCTeller-vorigeMCt))/(sktyd);
      if MCTeller<=0 then MCspoed:=0 else
      if ((MCTeller<>vorigeMCT) and (tydteller>MCBegin)) then
      begin
        MCspoed:=(1000/timer1.Interval)*MCTeller/(tydteller-MCbegin);
        vorigeMCt:=MCTeller;
        deltatyd:=gettickcount;
      end;

      if MCSpoed>0 then
      begin
        eta:='ETA : ';
        ttg:=((MCRuns-MCTeller)/MCSpoed)-(gettickcount-deltatyd)/1000;
        h:=trunc(ttg/3600); ttg:=ttg-h*3600; if h>0 then eta:=eta+inttostr(h)+'h';
        m:=trunc(ttg/60);s:=trunc(ttg-m*60);if ((h>0) or (m>0)) then eta:=eta+inttostr(m)+'m';
        eta:=eta+inttostr(s)+'s';
      end else eta:='';



      if ((MCSpoed>0.2) or (MCSpoed<1E-6)) then
        MCForm.label13.Caption:=floattostrF(MCspoed,ffFixed,6,2)+' runs/s'+'   '+eta
      else
        MCForm.label13.Caption:=floattostrF(1/MCspoed,ffFixed,6,2)+' s/run'+'   '+eta;

    end;

    if checkbox5.checked then vertoonhistogram;
(*
    begin
      Hisblad.Bargraph1.Clear;
    //Sorteer histogram
      hissort:=his;
      if Hisblad.CheckBox1.checked then
      repeat
        hisskoon:=True;
        for i:=draer to grootstemutasienommer-1 do if hissort[i+1].aantal>hissort[i].aantal then begin tydhisrek:=hissort[i];hissort[i]:=hissort[i+1];hissort[i+1]:=tydhisrek;hisskoon:=False;end;
      until hisskoon;
      i:=draer;
      while (i<=grootstemutasienommer) do
      begin
        if ((normaliseergrafiek=True) and(draerteller>0)) then Hisblad.Bargraph1.AddXY(i,100*hissort[i].aantal/draerteller,hissort[i].naam,kleure[hissort[i].nommer])
           else Hisblad.Bargraph1.AddXY(i,hissort[i].aantal,hissort[i].naam,kleure[hissort[i].nommer]);
        inc(i);
      end;
    end;
*)

(*
    if form1.CheckBox6.Checked then
    //    if ((form1.CheckBox6.checked = True) or (MCBesig=True) and (MCGrafieke=True)) then
//    if not((MCBesig=True) and (MCGrafieke=False)) then
    begin
      if grafiekpuntevertoon<grafiekpunte then
      for i:=grafiekpuntevertoon+1 to grafiekpunte do
      begin
        Series1.AddXY(series1.count+1,grafiekskik[i].hetero);
        Series2.AddXY(series2.count+1,grafiekskik[i].homo);
        Series3.AddXY(series3.count+1,grafiekskik[i].wild);
      end;
      grafiekpuntevertoon:=grafiekpunte;
    end;
*)

    if (grafiekpunte>(maksgrafiekpunte-10000)) then grafiekpunte:=maksgrafiekpunte-10000;
    application.ProcessMessages;
  end else  //besig=False
  begin
    if ((isbesig=False) and (MCForm.Visible=False)) then
    begin
      button2.Enabled:=True;
      button3.enabled:=True;
      button6.enabled:=True;
      form1.GroupBox1.Enabled:=True;
      form1.GroupBox2.Enabled:=True;

    end;
  end;

end;

procedure TForm1.PBSuperSpin3Change(Sender: TObject);
begin
//  gemeenskapsgrootte:=trunc(PBSUperspin3.Value);
  gemeenskapsgrootte:=(PBSUperspin3.Value);

  if gemeenskapsgrootte<1 then gemeenskapsgrootte:=1;
  if gemeenskapsgrootte>0 then scrollbar2.Position:=round(20*ln(gemeenskapsgrootte)) else scrollbar2.Position:=round(20*ln(1));
  maakcdf(gemeenskapsgrootte);
  sktyd:=0;
//  PBSuperSpin3.Value:=gemeenskapsgrootte;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
var a,b:integer;
begin
  if checkbox2.Checked=False then
  begin
    for a:=0 to breedte-1 do
    for b:=0 to hoogte-1 do if popskik^[a,b].status>draer then begin popskik^[a,b].status:=draer;if popskik^[a,b].g[1]>draer then popskik^[a,b].g[1]:=draer;if popskik^[a,b].g[2]>draer then popskik^[a,b].g[2]:=draer; end;
  end;
end;

procedure TForm1.ScrollBar2Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  gemeenskapsgrootte:=round(exp(scrollbar2.position/20));
  PBSuperspin3.Value:=gemeenskapsgrootte;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  if CheckBox5.Checked then Hisblad.Show else Hisblad.Visible:=False;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  uitleernaam:string;
  leer:textfile;
  i:integer;
  s,s1,s2,d:string;
  b:integer;
begin

  s:=Datetostr(Date)+' - '+TimeToStr(Time);s2:='-';for i:=1 to length(s) do if not(s[i] in ['/',':',' ']) then s2:=s2+s[i];
  d:=GetCurrentDir;
  uitleernaam:=d+'\'+'Sim'+floattostr(HeterozygoticAdvantage)+s2+'.dat';
  assignfile(leer,uitleernaam);
  rewrite(leer);
  s:='Com '+floattostr(gemeenskapsgrootte) +' HetAdv '+FloatToStr(HeterozygoticAdvantage)+' HomAdv '+FloatToStr(HomozygoticAdvantage)+' Pop '+IntToStr(breedte)+'x'+inttostr(hoogte)+' denovo '+floattostr(denovo);
  writeln(leer,s);

  for i:=0 to form1.Series1.Count-1 do
  begin
    s1:=inttostr(i+1)+' '+floattostr(form1.series1.XValues[i])+'  '+floattostr(form1.series1.YValues[i])+' '+floattostr(form1.series2.YValues[i])+'  '+floattostr(form1.series3.YValues[i]);
    writeln(leer,s1);
  end;
  closefile(leer);
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.checked then form1.Chart1.LeftAxis.Logarithmic:=True else form1.Chart1.LeftAxis.Logarithmic:=False;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.checked then form1.Chart1.BottomAxis.Logarithmic:=True else form1.Chart1.BottomAxis.Logarithmic:=False;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  form1.GroupBox1.Enabled:=False;
  form1.GroupBox2.Enabled:=False;
  form1.Button2.Enabled:=False;
  form1.Button3.Enabled:=False;
  form1.Button6.Enabled:=False;

  MCForm.show;
  MCForm.PBSuperSpin2Change(self);
//  form1.Enabled:=false;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if besig then Button3Click(self);
//  repeat until isbesig=False;
//  repeat until besig=False;
//  a:=gettickcount;
//  repeat until (gettickcount-a)>2000/(spoed+1);
//  Dispose(tydskik);
//  Dispose(popskik);
end;


procedure TForm1.CheckBox7Click(Sender: TObject);
begin
  PBSuperSpin3Change(self);
  if checkbox7.Checked then label14.Visible:=True else label14.Visible:=False;
end;

procedure TForm1.Label9Click(Sender: TObject);
begin
  scrollbar4.Position:=scrollbar3.position;
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
begin
  Series1.LinePen.Visible:=Checkbox8.Checked;
  series1.Active:=Checkbox8.Checked;
end;

procedure TForm1.CheckBox9Click(Sender: TObject);
begin
  series2.LinePen.Visible:=checkbox9.Checked;
  series2.active:=checkbox9.Checked;
end;

procedure TForm1.CheckBox10Click(Sender: TObject);
begin
  series3.LinePen.Visible:=CheckBox10.Checked;
  series3.Active:=CheckBox10.Checked;
end;

procedure TForm1.CheckBox12Click(Sender: TObject);
begin
{$IFDEF SHOWSTABTRIGGER}
  series4.LinePen.Visible:=CheckBox12.Checked;
  series4.Active:=CheckBox12.Checked;
{$ENDIF}
end;

procedure TForm1.CheckBox13Click(Sender: TObject);
begin
{$IFDEF SHOWSTABTRIGGER}
  series5.LinePen.Visible:=CheckBox13.Checked;
  series5.Active:=CheckBox13.Checked;
{$ENDIF}
end;



procedure skryfopset(leernaam:string);
var uitleer:text;
begin
  assignfile(uitleer,leernaam);
  rewrite(uitleer);



  closefile(uitleer);
end;

procedure TForm1.Button7Click(Sender: TObject);
var leernaam:string;
begin
  if OpenDialog1.Execute then
  begin
    leernaam:=Opendialog1.FileName;
    skryfopset(leernaam);
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
//var leernaam:string;
begin
  if opendialog1.Execute then
  begin
//    leernaam:=Opendialog1.FileName;

  end;
end;

procedure TForm1.CheckBox11Click(Sender: TObject);
{$IFDEF OUERS}
var i,a,b:integer;
{$ENDIF}

begin
{$IFDEF OUERS}
  for i:=0 to maksouerhis do ouerhis[i]:=0;
  for b:=0 to hoogte-1 do
  for a:=0 to breedte-1 do ouerstat[a,b]:=0;
{$ENDIF}
end;

procedure TForm1.ScrollBar5Change(Sender: TObject);
begin
//  SetPriorityClass(GetCurrentProcess(),BELOW_NORMAL_PRIORITY_CLASS);   //IDLE_PRIORITY_CLASS, BELOW_NORMAL_PRIORITY_CLASS, NORMAL_PRIORITY_CLASS, ABOVE_NORMAL_PRIORITY_CLASS, HIGH_PRIORITY_CLASS, REALTIME_PRIORITY_CLASS
  case Scrollbar5.Position of
//  1:begin SetPriorityClass(GetCurrentProcess(),IDLE_PRIORITY_CLASS); form1.label18.caption:='Priority : Idle'; end;
  1:begin SetPriorityClass(GetCurrentProcess(),64); form1.label18.caption:='Priority : Idle'; end;
  2:begin SetPriorityClass(GetCurrentProcess(),16384); form1.label18.caption:='Priority : Below Normal'; end;
//  2:begin SetPriorityClass(GetCurrentProcess(),NORMAL_PRIORITY_CLASS); form1.label18.caption:='Priority : Normal'; end;
  3:begin SetPriorityClass(GetCurrentProcess(),32); form1.label18.caption:='Priority : Normal'; end;
  4:begin SetPriorityClass(GetCurrentProcess(),32768); form1.label18.caption:='Priority : Above Normal'; end;
//  3:begin SetPriorityClass(GetCurrentProcess(),HIGH_PRIORITY_CLASS); form1.label18.caption:='Priority : High'; end;
  5:begin SetPriorityClass(GetCurrentProcess(),128); form1.label18.caption:='Priority : High'; end;
//  4:begin SetPriorityClass(GetCurrentProcess(),REALTIME_PRIORITY_CLASS); form1.label18.caption:='Priority : Realtime'; end;
  6:begin SetPriorityClass(GetCurrentProcess(),256); form1.label18.caption:='Priority : Realtime'; end;
  end;
end;




procedure TForm1.CheckBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i:integer;
begin
  if ((ssAlt in shift) and (key=67)) then  //Alt-C
  begin
    if kleure[skoon]=clBlack then
    begin  //Alternative colour scheme
//      checkbox1.Caption:=inttostr(key);
      kleure[skoon]:=clWhite;   	//0
      kleure[dood]:=clWhite;    	//1
      kleure[beide]:=clRed;	   	//2
      kleure[draer]:=clBlack;    	//3
    end else
    begin  //Standard colour scheme
//      checkbox1.Caption:='Display';
      kleure[skoon]:=clBlack;   	//0
      kleure[dood]:=clBlack;    	//1
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
    vertoonblad.UpdateDisplay;
  end;
end;




end.
