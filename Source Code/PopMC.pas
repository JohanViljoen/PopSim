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
unit PopMC;
{$INCLUDE compdefs.pas}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Popdefs, StdCtrls, PBNumEdit, PBSuperSpin, rxPlacemnt,
  ExtCtrls, RXClock;

type
  TMCForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PBSuperSpin2: TPBSuperSpin;
    Button1: TButton;
    Memo1: TMemo;
    FormStorage1: TFormStorage;
    Label6: TLabel;
    Label10: TLabel;
    PBSuperSpin3: TPBSuperSpin;
    PBSuperSpin4: TPBSuperSpin;
    PBSuperSpin8: TPBSuperSpin;
    PBSuperSpin9: TPBSuperSpin;
    PBSuperSpin10: TPBSuperSpin;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox5: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    PBSuperSpin7: TPBSuperSpin;
    Label15: TLabel;
    PBSuperSpin11: TPBSuperSpin;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    GroupBox4: TGroupBox;
    Label16: TLabel;
    PBSuperSpin12: TPBSuperSpin;
    GroupBox6: TGroupBox;
    Label1: TLabel;
    PBSuperSpin5: TPBSuperSpin;
    Label2: TLabel;
    PBSuperSpin1: TPBSuperSpin;
    Label11: TLabel;
    PBSuperSpin6: TPBSuperSpin;
    GroupBox7: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    PBSuperSpin13: TPBSuperSpin;
    PBSuperSpin14: TPBSuperSpin;
    PBSuperSpin15: TPBSuperSpin;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    RadioButton3: TRadioButton;
    Button2: TButton;
    Label21: TLabel;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    Label22: TLabel;
    CheckBox9: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PBSuperSpin8Change(Sender: TObject);
    procedure PBSuperSpin2Change(Sender: TObject);
    procedure PBSuperSpin13Change(Sender: TObject);
    procedure PBSuperSpin15Change(Sender: TObject);

    procedure Button1Click(Sender: TObject);
    procedure PBSuperSpin5Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure PBSuperSpin7Change(Sender: TObject);
    procedure PBSuperSpin11Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure PBSuperSpin12Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure PBSuperSpin4Change(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure skryftemplate;
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }

  public
    { Public declarations }

  end;

  statusrekord = record
                   heta:real;
                   homa:real;
                   dn:real;
                   b,h:integer;
                   gemgrootte:real;
                   begpersentasie:real;
                   vertoon,grafieke,histog:Boolean;
                   horlosieinterval:integer;
                 end;
  eenlyn = record
              Com:real;
              HetAdv:real;
              HomAdv:real;
            end;

var
  MCForm: TMCForm;
  statrek:statusrekord;
  comsteps,hetadvsteps,homadvsteps:integer;
  hetstatus:Boolean=False;
  doEstablishment,doEquilibrium:Boolean;
  templatefilename,fulltemplatefilename:string;
  MCtyd:integer;
  MCwerklys:array[1..maxtemplate] of eenlyn;
  templateteller,werkpos:integer;

  

//  MCTeller:integer;


implementation

uses Pophoof, Popvertoon;

{$R *.dfm}



procedure krystatus;
begin
  if hetstatus then exit;
  statrek.heta:=HeterozygoticAdvantage;
  statrek.homa:=HomozygoticAdvantage;
  statrek.dn:=denovo;
  statrek.b:=form1.scrollbar3.position;breedte:=trunc(MCForm.PBSuperSpin7.value);
  statrek.h:=form1.ScrollBar4.Position;hoogte:=trunc(MCForm.PBSuperSpin11.value);
  statrek.gemgrootte:=gemeenskapsgrootte;
  statrek.begpersentasie:=beginpersentasie;
  statrek.vertoon:=vertoon;
  statrek.grafieke:=form1.CheckBox6.checked;form1.CheckBox6.checked:=MCForm.checkbox1.checked;
  statrek.histog:=Form1.CheckBox5.checked;
  statrek.horlosieinterval:=form1.Timer1.Interval;
  hetstatus:=True;


end;

procedure herstelstatus;
begin
  if hetstatus=False then exit;
  HeterozygoticAdvantage:=statrek.heta;Form1.PBSuperSpin1.Text:=floattostrF(100*(statrek.heta-1),fffixed,8,7);
  HomozygoticAdvantage:=statrek.homa;Form1.PBSuperSpin4.Text:=floattostrF(100*(statrek.homa-1),fffixed,8,7);
  denovo:=statrek.dn;Form1.PBSuperSpin2.Text:=floattostrf(denovo*1E6/denovoskaal,fffixed,6,5);
  breedte:=statrek.b;form1.ScrollBar3.Position:=breedte;form1.ScrollBar3Change(Form1);
  hoogte:=statrek.h;form1.ScrollBar4.Position:=hoogte;Form1.ScrollBar4Change(Form1);
  gemeenskapsgrootte:=statrek.gemgrootte;Form1.PBSuperSpin3.Value:=gemeenskapsgrootte;Form1.PBSuperSpin3Change(Form1) ;
  beginpersentasie:=statrek.begpersentasie;form1.ScrollBar1.Position:=trunc(100*beginpersentasie);
  vertoon:=statrek.vertoon;form1.CheckBox1.checked:=vertoon;
  form1.CheckBox6.Checked:=statrek.grafieke;
  Form1.CheckBox5.checked:=statrek.histog;
  form1.Timer1.Interval:=statrek.horlosieinterval;
  hetstatus:=False;

//  form1.Button1Click(MCForm);
end;



procedure TMCForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MCbesig1 then Button1Click(self);

  if form1.series1.Count>grafiekskoonmaakdrempel then begin form1.series1.clear;Form1.series2.Clear;end;

  form1.GroupBox1.Enabled:=True;
  form1.GroupBox2.Enabled:=True;
  form1.Button2.Enabled:=True;
  form1.Button3.Enabled:=True;
  form1.Button6.Enabled:=True;
  herstelstatus;

end;

procedure TMCForm.FormCreate(Sender: TObject);
begin
  PBSuperspin7.MaxValue:=maksbreedte;
  PBSuperspin11.MaxValue:=makshoogte;

  MCBesig1:=False;

  hetstatus:=False;
  MCForm.FormStyle:=fsStayOnTop;
  PBSuperspin2Change(self);
  PBSuperSpin8Change(self);
  PBSuperSpin13Change(self);

  PBSuperSpin7Change(self);
  PBSuperSpin11Change(self);
  MCFOrm.CheckBox2Click(self);
  if ((doEstablishment=False) and (doEquilibrium=False) and (RadioButton3.checked=False)) then RadioButton1.Checked:=True;
  MCForm.RadioButton1Click(self);
  MCForm.CheckBox3Click(self);
  if MCform.HorzScrollBar.IsScrollBarVisible or MCForm.VertScrollBar.IsScrollBarVisible then
  begin
    MCform.AutoSize:=True;
    MCform.ScrollBy(1,1);
    MCform.Repaint;
    MCform.AutoSize:=False;
  end;

end;

procedure TMCForm.FormShow(Sender: TObject);
begin
  if form1.CheckBox7.Checked then
  begin
    PBSuperspin8.MinValue:=1;
    PBSuperspin8.Decimals:=3;
    PBSuperspin9.MinValue:=1;
    PBSuperspin9.Decimals:=3;
    PBSuperspin10.Decimals:=3;

  end else
  begin
    PBSuperSpin8.MinValue:=2;if PBSuperspin8.Value<2 then PBSuperspin8.Value:=2;
    PBSuperspin8.Decimals:=0;
    PBSuperspin9.MinValue:=2;
    PBSuperspin9.Decimals:=0;
    PBSuperspin10.Decimals:=0;
  end;

  krystatus;
  label13.Caption:='';
  PBSuperSpin7Change(self);

  PBSuperSpin11Change(self);
  MCFOrm.CheckBox2Click(self);
  MCtyd:=0;
  MCForm.Timer1.enabled:=True;



end;

procedure TMCForm.PBSuperSpin8Change(Sender: TObject);
var
  w:real;
begin
  if tydteller<2 then exit;
  comsteps:=0;
  if checkbox6.Checked then
  begin  //Logaritmies
    w:=PBSuperSpin9.value;
    if ((PBSuperSpin9.Value>0) and (PBSuperspin10.value>0)) then
    repeat
      w:=(w*((PBSuperspin9.Value-PBSuperspin10.Value)/(PBSuperspin9.Value)));
      if not(form1.checkbox7.Checked) then w:=trunc(w);  //Plat verspreiding

      inc(comsteps);
    until ((w<=0) or (abs(w)<abs(PBSuperSpin8.value)) or (PBSuperspin8.Value<=0) or (PBSuperspin10.Value<=0) or ((PBSuperspin8.Value/PBSuperspin9.value)<=0));

  end else
  begin
    w:=PBSuperSpin8.value;
//  if w>PBSuperSpin9.value then PBSuperSpin9.Value:=w;
    repeat
      w:=w+PBSuperSpin10.Value;
      inc(comsteps);
    until ((w>PBSuperSpin9.Value+eps) or (PBSuperSpin10.Value<=0));
  end;
  if comsteps<1 then comsteps:=1;
  label6.Caption:='Steps : '+inttostr(comsteps);
  PBSuperSpin5Change(self);
end;

procedure TMCForm.PBSuperSpin2Change(Sender: TObject);
var
  w:real;
begin
  if tydteller<2 then exit;
  hetadvsteps:=0;

  if checkbox4.Checked then
  begin  //Logaritmies
    w:=PBSuperspin3.value;
    if ((PBSuperspin3.Value<>0) and (PBSuperspin4.value<>0) and (abs(PBSuperspin3.value)>abs(PBSuperspin2.value)) and (PBSuperspin2.value<>0) and (abs(PBSuperspin3.value)>abs(PBSuperspin4.value))) then
    repeat
        w:=(w*abs(((abs(PBSuperspin3.Value)-abs(PBSuperspin4.Value))/abs(PBSuperspin3.Value))));
//     w:=w/(1+PBSuperspin4.Value);
      inc(hetadvsteps);
    until ((abs(w)<abs(PBSuperSpin2.value)) or (PBSuperspin2.Value=0) or (PBSuperspin4.Value=0) or ((PBSuperspin2.Value/(PBSuperspin3.value))<=0));

  end else
  begin  //Linieêr
    w:=PBSuperspin2.value;
    repeat
      w:=w+PBSuperspin4.Value;
      inc(hetadvsteps);
    until ((w>PBSuperSpin3.value+eps) or (PBSuperspin4.Value<=0));
  end;
  if hetadvsteps<1 then hetadvsteps:=1;

  label10.Caption:='Steps : '+inttostr(hetadvsteps);
  PBSuperSpin5Change(self);

end;

procedure TMCForm.PBSuperSpin13Change(Sender: TObject);
var
  w:real;
begin

  if tydteller<2 then exit;
  homadvsteps:=0;
  if CheckBox8.Checked then
  begin //Logaritmies
    w:=PBSuperspin14.value;
    if ((PBSuperspin14.Value<>0) and (PBSuperspin15.value<>0) and (abs(PBSuperspin14.value)>abs(PBSuperspin13.value)) and (PBSuperspin13.value<>0) and (abs(PBSuperspin14.value)>abs(PBSuperspin15.value))) then
    repeat
        w:=(w*abs((abs(PBSuperspin14.Value)-abs(PBSuperspin15.Value))/abs(PBSuperspin14.Value)));
//     w:=w/(1+PBSuperspin4.Value);
      inc(homadvsteps);
    until ((abs(w)<abs(PBSuperSpin13.value)) or (PBSuperspin13.Value=0) or (PBSuperspin15.Value=0) or ((PBSuperspin13.Value/(PBSuperspin14.value))<=0));
  end else
  begin  //Linieêr
    w:=PBSuperspin13.value;
    repeat
      w:=w+PBSuperspin15.Value;
      inc(homadvsteps);
    until ((w>PBSuperSpin14.value+eps) or (PBSuperspin15.Value<=0));
  end;
  if homadvsteps<1 then homadvsteps:=1;

  label20.Caption:='Steps : '+inttostr(homadvsteps);
  if MCForm.checkbox3.Checked then homadvsteps:=1;
  PBSuperSpin5Change(self);

end;

function IsOpen(const txt:TextFile):Boolean;
const
  fmTextOpenRead = 55217;
  fmTextOpenWrite = 55218;
begin
  Result := (TTextRec(txt).Mode = fmTextOpenRead) or (TTextRec(txt).Mode = fmTextOpenWrite)
end;

procedure maakwerklys;
var comlys,hetlys,homlys:array[1..maksMCdim] of real;
    comteller,hetteller,homteller:integer;
    tyd:real;
    i,j,k:integer;
    w:real;
    lr:eenlyn;
begin   //Compile a list of all the parameter combinations to use during Monte Carlo testing

//Community
  comteller:=1;
  if MCForm.checkbox6.Checked then
  begin  //Logaritmies
    w:=MCForm.PBSuperSpin9.value;comlys[comteller]:=w;
    if ((MCForm.PBSuperSpin9.Value>0) and (MCForm.PBSuperspin10.value>0)) then
    repeat
      w:=(w*((MCForm.PBSuperspin9.Value-MCForm.PBSuperspin10.Value)/(MCForm.PBSuperspin9.Value)));
      if not(form1.checkbox7.Checked) then w:=trunc(w);  //Plat verspreiding
      inc(comteller);comlys[comteller]:=w;
    until ((w<=0) or (abs(w)<abs(MCForm.PBSuperSpin8.value)) or (MCForm.PBSuperspin8.Value<=0) or (MCForm.PBSuperspin10.Value<=0) or ((MCForm.PBSuperspin8.Value/MCForm.PBSuperspin9.value)<=0));
  end else
  begin
    w:=MCForm.PBSuperSpin8.value;comlys[comteller]:=w;
    repeat
      w:=w+MCForm.PBSuperSpin10.Value;
      inc(comteller);comlys[comteller]:=w;
    until ((w>MCForm.PBSuperSpin9.Value+eps) or (MCForm.PBSuperSpin10.Value<=0));
  end;
  if comteller>1 then dec(comteller);

{*
  //Scramble the list in an attempt to make the time estimates more accurate
  if comteller>1 then
    for j:=1 to comteller do begin k:=random(comteller)+1;tyd:=comlys[j];comlys[j]:=comlys[k];comlys[k]:=tyd;end;
*}


//Heterozygous Advantage
  hetteller:=1;
  if MCForm.checkbox4.Checked then
  begin  //Logaritmies
    w:=MCForm.PBSuperspin3.value;hetlys[hetteller]:=w;
    if ((MCForm.PBSuperspin3.Value<>0) and (MCForm.PBSuperspin4.value<>0) and (abs(MCForm.PBSuperspin3.value)>abs(MCForm.PBSuperspin2.value)) and (MCForm.PBSuperspin2.value<>0) and (abs(MCForm.PBSuperspin3.value)>abs(MCForm.PBSuperspin4.value))) then
    repeat
      w:=(w*abs(((abs(MCForm.PBSuperspin3.Value)-abs(MCForm.PBSuperspin4.Value))/abs(MCForm.PBSuperspin3.Value))));
      inc(hetteller);hetlys[hetteller]:=w;
    until ((abs(w)<abs(MCForm.PBSuperSpin2.value)) or (MCForm.PBSuperspin2.Value=0) or (MCForm.PBSuperspin4.Value=0) or ((MCForm.PBSuperspin2.Value/(MCForm.PBSuperspin3.value))<=0));
  end else
  begin  //Linieêr
    w:=MCForm.PBSuperspin2.value;hetlys[hetteller]:=w;
    repeat
      w:=w+MCForm.PBSuperspin4.Value;
      inc(hetteller);hetlys[hetteller]:=w;
    until ((w>MCForm.PBSuperSpin3.value+eps) or (MCForm.PBSuperspin4.Value<=0));
  end;
  if hetteller>1 then dec(hetteller);

//Homozygous Advantage
  homteller:=1;
  if MCForm.CheckBox8.Checked then
  begin //Logaritmies
    w:=MCForm.PBSuperspin14.value;homlys[homteller]:=w;
    if ((MCForm.PBSuperspin14.Value<>0) and (MCForm.PBSuperspin15.value<>0) and (abs(MCForm.PBSuperspin14.value)>abs(MCForm.PBSuperspin13.value)) and (MCForm.PBSuperspin13.value<>0) and (abs(MCForm.PBSuperspin14.value)>abs(MCForm.PBSuperspin15.value))) then
    repeat
      w:=(w*abs((abs(MCForm.PBSuperspin14.Value)-abs(MCForm.PBSuperspin15.Value))/abs(MCForm.PBSuperspin14.Value)));
      inc(homteller);homlys[homteller]:=w;
    until ((abs(w)<abs(MCForm.PBSuperSpin13.value)) or (MCForm.PBSuperspin13.Value=0) or (MCForm.PBSuperspin15.Value=0) or ((MCForm.PBSuperspin13.Value/(MCForm.PBSuperspin14.value))<=0));
  end else
  begin  //Linieêr
    w:=MCForm.PBSuperspin13.value;homlys[homteller]:=w;
    repeat
      w:=w+MCForm.PBSuperspin15.Value;
      inc(homteller);homlys[homteller]:=w;
    until ((w>MCForm.PBSuperSpin14.value+eps) or (MCForm.PBSuperspin15.Value<=0));
  end;
  if MCForm.checkbox3.Checked then homteller:=1;
  if homteller>1 then dec(homteller);


  //Now combine these three
  templateteller:=0;
  for i:=1 to comteller do
  begin
    for j:=1 to hetteller do
    begin
      for k:=1 to homteller do
      begin
        inc(templateteller);
        MCwerklys[templateteller].Com:=comlys[i];
        MCwerklys[templateteller].HetAdv:=hetlys[j];
        if MCForm.CheckBox3.checked then MCwerklys[templateteller].HomAdv:=MCwerklys[templateteller].HetAdv else MCwerklys[templateteller].HomAdv:=homlys[k];
      end;
    end;
  end;

{*
//Scramble the entire list
  if templateteller>1 then
    for j:=1 to templateteller do begin k:=random(templateteller)+1;lr:=MCwerklys[j];MCwerklys[j]:=MCwerklys[k];MCwerklys[k]:=lr;end;
*}

end;


procedure TMCForm.Button1Click(Sender: TObject);
var age:integer;
    i,j,k,a,b:integer;
    hetadv,homadv,vorigehetadv,vorigehomadv,vorigegemeenskapsgrootte:real;
    s,s2:string;
    maxcolony:integer;
    uitleer:textfile;
    hetinis:Boolean;
    commin,commax,comstep,hetmin,hetmax,hetstep,hommin,hommax,homstep:real;
    lr:eenlyn;


procedure maakleerordeliktoe;
var s:string;
    tt:real;
    h,m,ss:integer;
begin
  if IsOpen(uitleer) then flush(uitleer);
  eindtyd:=Gettickcount;
  tt:=(eindtyd-aanvangstyd)/1000;
//  repeat until isbesig=False;
  if IsOpen(uitleer) then begin writeln(uitleer,'***');memo1.lines.add('***');end;
  if IsOpen(uitleer) then flush(uitleer);
  s:=Datetostr(Date)+' - '+TimeToStr(Time)+' - Total Time : '+inttostr(trunc(tt))+'s';
  if IsOpen(uitleer) then begin memo1.lines.add(s);writeln(uitleer,s);end;

  h:=trunc(tt/3600);tt:=tt-h*3600;
  m:=trunc(tt/60);tt:=tt-m*60;
  ss:=trunc(tt);
  MCForm.label13.Caption:='Time : '+inttostr(h)+'h'+inttostr(m)+'m'+inttostr(ss)+'s';
  if IsOpen(uitleer) then begin flush(uitleer);closefile(uitleer);end;
  Button1.Caption:='Run';
{$IFDEF KLANKE}
   beep;
{$ENDIF}

end;


begin
  hetinis:=False;
  beginpersentasie:=PBSuperSpin12.Value;
  MCbegin:=tydteller;

  breedte:=trunc(PBSuperSpin7.value);
  hoogte:=trunc(PBSuperSpin11.value);
  Form1.ScrollBar3.position:=breedte;
  Form1.ScrollBar4.position:=hoogte;
  Form1.ScrollBar3Change(MCForm);
  Form1.ScrollBar4Change(MCForm);
  Form1.CheckBox5.Checked:=False; //Geen histogramme
//  Hisblad.visible:=False;

  denovo:=0;
  form1.Timer1.Interval:=500;  //Dateer minder gereeld op om tyd te spaar

  PBSuperSpin2Change(self);   //Dateer hetadv op
  PBSuperSpin8Change(self);   //Dateer com op
  PBSuperSpin13Change(self);  //Dateer homadv op
  CheckBox3Click(self);

  CheckBox2Click(self);
  if MCBesig1=False then
  begin
    commin:=PBSuperspin8.value;commax:=PBSuperspin9.value;comstep:=PBSuperspin10.value;
    hetmin:=PBSuperspin2.value;hetmax:=PBSuperspin3.Value;hetstep:=PBSuperspin4.value;
    hommin:=PBSuperspin13.value;hommax:=PBSuperspin14.value;homstep:=PBSuperspin15.value;

    if Radiobutton3.Checked=False then maakwerklys;
    skryftemplate;

//Scramble the entire list
    if ((checkbox9.checked=True) and (templateteller>1)) then
      for j:=1 to templateteller do begin k:=random(templateteller)+1;lr:=MCwerklys[j];MCwerklys[j]:=MCwerklys[k];MCwerklys[k]:=lr;end;



    if templateteller<1 then exit;  //Nothing to do

    aanvangstyd:=GetTickCount;
    s:=Datetostr(Date)+' - '+TimeToStr(Time);s2:='';for i:=1 to length(s) do if not(s[i] in ['/',':',' ']) then s2:=s2+s[i];
    assignfile(uitleer,'MC'+s2+'.txt');
    rewrite(uitleer);
    MCBesig1:=True; Button1.Caption:='Stop';
    memo1.Lines.clear;
    memo1.Lines.add(form1.Caption);writeln(uitleer,form1.Caption);
    memo1.lines.add(s);writeln(uitleer,s);
    vorigeMCT:=0;
    if doEstablishment then s:='Mutation Establishment';
    if doEquilibrium then s:='Equilibrium Prevalence';
    memo1.lines.add(s);writeln(uitleer,s);

    s:='Runs:'+floattostrf(PBSuperspin5.value,fffixed,8,0);
     if doEstablishment then
       s:=s+'  Threshold:'+floattostrf(PBSuperspin1.value,fffixed,5,0)
       else s:=s+'  Initial prevalence:'+floattostrf(PBSuperspin12.value,fffixed,8,3);
     s:=s+'  Maxgens:'+floattostrf(PBSuperspin6.value,fffixed,5,0)
     +'  Community:'+floattostrf(commin,fffixed,6,0)+'/'+floattostrf(commax,fffixed,6,0)+'/'+floattostrf(comstep,fffixed,6,0)
     +'  HetAdv:'+floattostrf(hetmin,fffixed,8,5)+'/'+floattostrf(hetmax,fffixed,8,5)+'/'+floattostrf(hetstep,fffixed,8,5);
     if checkbox3.checked=False then
     begin
       s:=s+'  HomAdv:'+floattostrf(hommin,fffixed,8,5)+'/'+floattostrf(hommax,fffixed,8,5)+'/'+floattostrf(homstep,fffixed,8,5)
     end else s:=s+'  HomAdv: = HetAdv';
    memo1.lines.add(s);
    writeln(uitleer,s);
    s:='Pop:'+floattostrf(breedte,fffixed,8,0)+'*'+floattostrf(hoogte,fffixed,8,0)+'='+floattostrf(breedte*hoogte,fffixed,8,0);
    memo1.lines.add(s);
    writeln(uitleer,s);
    flush(uitleer);


  end else
  begin
    maakleerordeliktoe;
    MCBesig1:=False;
    exit;
 end;

  MCteller:=0;
  inc(generasieteller);
  begin
    //Vertoon nulde punt
    inc(grafiekpunte);
    grafiekskik[grafiekpunte].hetero:=100*draerteller/(breedte*hoogte);
    grafiekskik[grafiekpunte].homo:=0;
  end;

//Measure speed of maakcdf
//  a:=GetTickCount;for i:=1 to 1000 do form1.maakcdf(i*10);b:=GettickCount;Radiobutton3.Caption:=floattostr((b-a)/1000)+'ms/it';

  vorigegemeenskapsgrootte:=MCwerklys[1].com;form1.maakcdf(vorigegemeenskapsgrootte);


  hetadv:=MCwerklys[1].hetadv;HeterozygoticAdvantage:=1+hetadv/100;vorigehetadv:=hetadv;
  homadv:=MCwerklys[1].homadv;HomozygoticAdvantage:=1+homadv/100;vorigehomadv:=homadv;
  form1.pasdrempelsaan;

  for i:=1 to templateteller do
  begin
    if MCBesig1=False then begin maakleerordeliktoe;exit;end;
    gemeenskapsgrootte:=MCwerklys[i].Com; if gemeenskapsgrootte<>vorigegemeenskapsgrootte then form1.maakcdf(gemeenskapsgrootte);
    vorigegemeenskapsgrootte:=gemeenskapsgrootte;
    hetadv:=MCwerklys[i].HetAdv;HeterozygoticAdvantage:=1+hetadv/100;
    homadv:=MCwerklys[i].HomAdv;HomozygoticAdvantage:=1+homadv/100;
    if ((hetadv<>vorigehetadv) or (homadv<>vorigehomadv)) then form1.pasdrempelsaan;
    vorigehetadv:=hetadv;vorigehomadv:=homadv;

    for j:=1 to trunc(PBSuperspin5.Value) do   //Do PBSuperspin5.Value runs per point
    begin
      if MCBesig1=False then begin maakleerordeliktoe;exit;end;
      s:='';
      if ((doEstablishment=True) or (hetinis=False) or (checkbox5.Checked=False) or ((draerteller=0) and (siekteller=0))) then
      //Clear all
      for b:=0 to hoogte-1 do
      begin
        if vertoon then prentlyn:=vertoonblad.image1.Picture.Bitmap.ScanLine[b];
        for a:=0 to breedte-1 do
        begin
          popskik^[a,b].status:=skoon;
          popskik^[a,b].g[1]:=skoon;
          popskik^[a,b].g[2]:=skoon;
          if vertoon then prentlyn[a]:=kleureRGB[popskik^[a,b].status];
          //Pas oorlewingsvoordeel toe
          if (random(drempelskaal)>drempels[popskik^[a,b].status]) then popskik^[a,b].status:=dood;
          draerteller:=0;siekteller:=0;
        end;
      end;
      //Inisieer
      if doEstablishment then
      begin //Plaas een mutasie in die middel
        popskik^[breedte div 2,hoogte div 2].status:=draer;
        popskik^[breedte div 2,hoogte div 2].g[1]:=draer;
        popskik^[breedte div 2,hoogte div 2].g[2]:=skoon;
        draerteller:=1;siekteller:=0;
      end else //Inisieer met beginvoorkoms
      begin
        for b:=0 to langgemiddeld-1 do stabiliteitsensor[b]:=-langgemiddeld*2; //Initialise the stability sensor with values that will first need to be pushed out of the pipeline before it can trigger.
        stabiel:=False;
        if ((hetinis=False) or (CheckBox5.checked=False) or ((draerteller=0) and (siekteller=0))) then
        for b:=0 to hoogte -1 do
        begin
          for a:=0 to breedte-1 do
          begin
            if random(1000000)/10000<beginpersentasie then
            begin
              popskik^[a,b].status:=draer;
              popskik^[a,b].g[1]:=draer;
              popskik^[a,b].g[2]:=skoon;
              inc(draerteller);
            end else
            begin
              popskik^[a,b].status:=skoon;
              popskik^[a,b].g[1]:=skoon;
              popskik^[a,b].g[2]:=skoon;
            end;
            //Pas oorlewingsvoordeel toe
            if (random(drempelskaal)>drempels[popskik^[a,b].status]) then popskik^[a,b].status:=dood;
          end;
        end;
        hetinis:=True;
      end;

      form1.PBSuperspin3.Value:=gemeenskapsgrootte;
      form1.PBSuperspin1.Value:=hetadv;
      form1.PBSuperspin4.Value:=homadv;
      age:=0;maxcolony:=1;
//          generasieteller:=0;
      inc(generasieteller);

      begin //Vertoon eerste punt ook
          inc(grafiekpunte);
          grafiekskik[grafiekpunte].hetero:=100*draerteller/(breedte*hoogte);
          grafiekskik[grafiekpunte].homo:=0;
      end;


      repeat
        repeat until isbesig=False;
          if MCBesig1=False then begin maakleerordeliktoe;exit;end;
//Step one generation
          form1.Button2Click(self);
//            if (((generasieteller-1) mod grafiekskoonmaakdrempel)>=grafiekskoonmaakdrempel-4) then begin form1.series1.clear;Form1.series2.Clear;end;
          inc(age);
          if (draerteller+siekteller)>maxcolony then maxcolony:=(draerteller+siekteller);
      until (((draerteller=0) and (siekteller=0)) or ((doEstablishment=True) and ((draerteller+siekteller)>=PBSuperSpin1.value)) or ((doEquilibrium=True) and (stabiel=True)) or (age>=PBSuperSpin6.Value) or (MCBesig1=False));

{$IFDEF OUERS}
form1.checkbox11.checked:=True;
form1.Button2Click(self);
form1.checkbox11.checked:=False;
{$ENDIF}

      inc(MCteller);
      PBSuperSpin5Change(self);

      s:=floattostrf(MCteller,fffixed,8,0)
               +', Com: '+floattostrf(gemeenskapsgrootte,fffixed,8,5)
               +', HetAdv: '+floattostrf(hetadv,fffixed,8,7)
               +', HomAdv: '+floattostrf(homadv,fffixed,8,7)
               +', Age: '+floattostrf(age,fffixed,6,0);
               if doEstablishment then
               s:=s+', Max: '+floattostrf(maxcolony,fffixed,4,0);// else
               s:=s+', Hetprev: '+floattostrf(100*draerteller/(breedte*hoogte),fffixed,8,6)
                   +', Homprev: '+floattostrf(100*siekteller/(breedte*hoogte),fffixed,8,6);
      memo1.lines.add(s);
      writeln(uitleer,s);flush(uitleer);
    end; //Runs per point
  end;

  if MCBesig1=True then
  begin
    MCBesig1:=False;
    maakleerordeliktoe;
  end;
end;

procedure TMCForm.PBSuperSpin5Change(Sender: TObject);
begin
  if MCForm.Visible = false then exit;
  MCRuns:=trunc(PBSuperSpin5.value)*templateteller;
  if MCForm.Radiobutton3.Checked = False then
    MCRuns:=comsteps*hetadvsteps*homadvsteps*trunc(PBSuperSpin5.value);

  if MCBesig1=False then
    label12.Caption:='Total Runs : '+inttostr(MCRuns)
    else
    begin
      label12.Caption:='Total Runs : '+inttostr(MCteller)+'/'+inttostr(MCRuns);
    end;
end;

procedure TMCForm.CheckBox1Click(Sender: TObject);
begin
  form1.CheckBox6.Checked:=MCForm.CheckBox1.checked;
end;

procedure TMCForm.CheckBox2Click(Sender: TObject);
begin
  Form1.CheckBox1.Checked:=MCForm.CheckBox2.checked;
  PBSuperSpin7Change(self);
  PBSuperSpin11Change(self);
end;

procedure TMCForm.PBSuperSpin7Change(Sender: TObject);
begin
  breedte:=trunc(PBSuperspin7.value);
  vertoonblad.clientwidth:=breedte;
  vertoonblad.ClientHeight:=hoogte;

end;

procedure TMCForm.PBSuperSpin11Change(Sender: TObject);
begin
  hoogte:=trunc(PBSuperspin11.value);
  vertoonblad.clientwidth:=breedte;
  vertoonblad.ClientHeight:=hoogte;

end;

procedure TMCForm.FormDestroy(Sender: TObject);
begin
  herstelstatus;
end;

procedure TMCForm.RadioButton1Click(Sender: TObject);
begin
  if MCBesig1=True then MCForm.Button1Click(self);  //Stop hom as hy loop
  if not(Radiobutton3.checked) then
  begin
    doEstablishment:=Radiobutton1.checked;
    doEquilibrium:=Radiobutton2.Checked;
  end else
  begin
    MCTyd:=1;
    MCForm.Timer1.Enabled:=True;
  end;

  Groupbox4.Visible:=RadioButton2.checked;
  Button2.Visible:=RadioButton3.checked;
  Label21.Visible:=RadioButton3.Checked;
  Groupbox2.Visible:=not(Radiobutton3.Checked);
  Groupbox3.Visible:=not(Radiobutton3.Checked);
  Groupbox7.Visible:=not(Radiobutton3.Checked);
  MCForm.PBSuperSpin1.Enabled:=not(Radiobutton3.Checked);
  MCForm.PBSuperSpin6.Enabled:=not(Radiobutton3.Checked);
  MCForm.PBSuperSpin7.Enabled:=not(Radiobutton3.Checked);
  MCForm.PBSuperSpin11.Enabled:=not(Radiobutton3.Checked);


{$IFDEF SHOWSTABTRIGGER}
//  Checkbox7.visible:=doEquilibrium;  //Show Stability Trigger
{$ENDIF}

  PBSuperSpin1.Visible:=doEstablishment;      //Threshold
  Label2.Visible:=doEstablishment;
  MCForm.PBSuperspin1.Enabled:=not(Radiobutton3.Checked);
  MCForm.PBSuperSpin5Change(self);


end;

procedure TMCForm.RadioButton2Click(Sender: TObject);
begin
  RadioButton1Click(self);
end;


procedure TMCForm.PBSuperSpin12Change(Sender: TObject);
begin
  beginpersentasie:=PBSuperSpin12.Value;
end;

procedure TMCForm.FormResize(Sender: TObject);
begin
  if MCForm.clientWidth<GroupBox1.Width then MCForm.clientwidth:=Groupbox1.Width;
  if MCForm.clientHeight<Groupbox5.Top+groupbox5.Height+40 then MCForm.clientHeight:=Groupbox5.Top+groupbox5.Height+40;
end;

procedure TMCForm.CheckBox3Click(Sender: TObject);
begin
  MCForm.PBSuperSpin13.Enabled:=not(CheckBox3.Checked);
  MCForm.PBSuperSpin14.Enabled:=not(CheckBox3.Checked);
  MCForm.PBSuperSpin15.Enabled:=not(CheckBox3.Checked);
  MCForm.Label17.Enabled:=not(CheckBox3.Checked);
  MCForm.Label18.Enabled:=not(CheckBox3.Checked);
  MCForm.Label19.Enabled:=not(CheckBox3.Checked);
  MCForm.Label20.Enabled:=not(CheckBox3.Checked);
  MCForm.PBSuperSpin13Change(self);
end;

procedure TMCForm.CheckBox4Click(Sender: TObject);
begin
  PBSuperSpin2Change(self);
  CheckBox8Click(self);
end;

procedure TMCForm.CheckBox6Click(Sender: TObject);
begin
  PBSuperSpin8Change(self);
end;

procedure TMCForm.PBSuperSpin4Change(Sender: TObject);
begin
  PBSuperSpin2Change(self);
end;

procedure TMCForm.PBSuperSpin15Change(Sender: TObject);
begin
  PBSuperSpin13Change(self);
end;


procedure TMCForm.CheckBox8Click(Sender: TObject);
begin
  PBSuperSpin13Change(self);
end;



procedure skepitem(var w:eenlyn);
var a:integer;
begin
  inc(templateteller);
  begin
    MCwerklys[templateteller].Com:=w.Com;
    MCwerklys[templateteller].HetAdv:=w.HetAdv;
    MCwerklys[templateteller].HomAdv:=w.HomAdv;
  end;
end;

procedure inkrementeer(var w:eenlyn);
var c:integer;
begin
  if templateteller=0 then begin skepitem(w);werkpos:=1; end
    else
  begin
//    if ((abs(w.Com/(histogram[werkpos].Com+eps)-1)>drempel) or (abs(w.HetAdv/(histogram[werkpos].HetAdv+eps)-1)>drempel) or (abs(w.HomAdv/(histogram[werkpos].HomAdv+eps)-1)>drempel)) then
    if ((w.Com<>MCwerklys[werkpos].Com) or (w.HetAdv<>MCwerklys[werkpos].HetAdv) or (w.HomAdv<>MCwerklys[werkpos].HomAdv)) then

    begin //Soek nuwe lyn
      werkpos:=0;
      repeat inc(werkpos);
        until (  (werkpos>templateteller) or
               ( (w.Com=MCwerklys[werkpos].Com)
            and  (w.Hetadv=MCwerklys[werkpos].Hetadv)
            and  (w.Homadv=MCwerklys[werkpos].HomAdv)
               ) );
      if werkpos>templateteller then skepitem(w);
    end;
  end;
end;

procedure TMCForm.skryftemplate;
var uitleer:textfile;
    s,s2:string;
    i:integer;
    commin,commax,comstep,hetmin,hetmax,hetstep,hommin,hommax,homstep:real;

begin
    commin:=MCForm.PBSuperspin8.value;commax:=MCForm.PBSuperspin9.value;comstep:=MCForm.PBSuperspin10.value;
    hetmin:=MCForm.PBSuperspin2.value;hetmax:=MCForm.PBSuperspin3.Value;hetstep:=MCForm.PBSuperspin4.value;
    hommin:=MCForm.PBSuperspin13.value;hommax:=MCForm.PBSuperspin14.value;homstep:=MCForm.PBSuperspin15.value;

    s:=Datetostr(Date)+' - '+TimeToStr(Time);s2:='';for i:=1 to length(s) do if not(s[i] in ['/',':',' ']) then s2:=s2+s[i];
    assignfile(uitleer,'Template'+s2+'.txt');
    rewrite(uitleer);
    MCBesig1:=True; Button1.Caption:='Stop';
    writeln(uitleer,form1.Caption);
    writeln(uitleer,s);
    if radiobutton1.Checked then s:='Mutation Establishment';
    if radiobutton2.Checked then s:='Equilibrium Prevalence';
    writeln(uitleer,s);

    s:='Runs:'+floattostrf(PBSuperspin5.value,fffixed,8,0);
     if doEstablishment then
       s:=s+'  Threshold:'+floattostrf(PBSuperspin1.value,fffixed,5,0)
       else s:=s+'  Initial prevalence:'+floattostrf(PBSuperspin12.value,fffixed,8,3);
     s:=s+'  Maxgens:'+floattostrf(PBSuperspin6.value,fffixed,5,0)
     +'  Community:'+floattostrf(commin,fffixed,6,0)+'/'+floattostrf(commax,fffixed,6,0)+'/'+floattostrf(comstep,fffixed,6,0)
     +'  HetAdv:'+floattostrf(hetmin,fffixed,8,5)+'/'+floattostrf(hetmax,fffixed,8,5)+'/'+floattostrf(hetstep,fffixed,8,5);
     if checkbox3.checked=False then
     begin
       s:=s+'  HomAdv:'+floattostrf(hommin,fffixed,8,5)+'/'+floattostrf(hommax,fffixed,8,5)+'/'+floattostrf(homstep,fffixed,8,5)
     end else s:=s+'  HomAdv: = HetAdv';
    writeln(uitleer,s);
    s:='Pop:'+floattostrf(breedte,fffixed,8,0)+'*'+floattostrf(hoogte,fffixed,8,0)+'='+floattostrf(breedte*hoogte,fffixed,8,0);
    writeln(uitleer,s);

    for i:=1 to templateteller do
    begin
      s:=floattostrf(i,fffixed,8,0)
               +', Com: '+floattostrf(MCwerklys[i].Com,fffixed,6,3)
               +', HetAdv: '+floattostrf(MCwerklys[i].hetadv,fffixed,6,5)
               +', HomAdv: '+floattostrf(MCwerklys[i].homadv,fffixed,6,5)
               +', ';
      writeln(uitleer,s);
    end;
    writeln(uitleer,'***');
    closefile(uitleer);
end;


procedure leestemplate(leernaam:string);
var
  d,n,e:string;
  sukses:Boolean;
  leer:textfile;
  lynteller,p,q,t:integer;
  lyn:string;
  a:real;
  lynitem,kleinste,grootste:eenlyn;
  comstep,hetstep,homstep:real;


begin
  if fileexists(leernaam) then
  begin
    lynteller:=0;


    templateteller:=0;werkpos:=0;
    assignfile(leer,leernaam);
    reset(leer);
    while not eof(leer) do
    begin
      readln(leer,lyn);
      inc(lynteller);
      if lynteller<6 then  //Read header info
      begin
        p:=pos('Mutation Establishment',lyn);
        if p>0 then begin doEstablishment:=True;doEquilibrium:=False;end;
        p:=pos('Equilibrium Prevalence',lyn);
        if p>0 then begin doEstablishment:=False;doEquilibrium:=True;end;
        p:=pos('Runs:',lyn);
        if p>0 then
        begin
          lyn:=copy(lyn,p+5,length(lyn));q:=pos(' ',lyn);t:=strtoint(copy(lyn,1,q-1));if t>0 then MCForm.PBSuperSpin5.value:=t;
          if doEstablishment then
          begin
            p:=pos('Threshold:',lyn);lyn:=copy(lyn,p+10,length(lyn));
            q:=pos(' ',lyn);t:=strtoint(copy(lyn,1,q-1));if t>0 then MCForm.PBSuperSpin1.value:=t;
          end else
          begin
            p:=pos('Initial prevalence:',lyn);lyn:=copy(lyn,p+19,length(lyn));
            q:=pos(' ',lyn);a:=strtofloat(copy(lyn,1,q-1));MCForm.PBSuperspin12.Value:=a;
          end;
          p:=pos('Maxgens:',lyn);lyn:=copy(lyn,p+8,length(lyn));
          q:=pos(' ',lyn);p:=strtoint(copy(lyn,1,q-1)); if p>0 then MCForm.PBSuperspin6.value:=p;

          p:=pos('Community:',lyn);lyn:=copy(lyn,p+10,length(lyn));
          p:=pos('/',lyn);a:=strtofloat(copy(lyn,1,p-1)); MCForm.PBSuperspin8.value:=a;lyn:=copy(lyn,p+1,length(lyn));
          p:=pos('/',lyn);a:=strtofloat(copy(lyn,1,p-1)); MCForm.PBSuperspin9.value:=a;lyn:=copy(lyn,p+1,length(lyn));
          q:=pos(' ',lyn);a:=strtofloat(copy(lyn,1,q-1)); MCForm.PBSuperspin10.value:=a;

          p:=pos('HetAdv:',lyn);lyn:=copy(lyn,p+7,length(lyn));
          p:=pos('/',lyn);a:=strtofloat(copy(lyn,1,q-1)); MCForm.PBSuperspin2.value:=a;lyn:=copy(lyn,p+1,length(lyn));
          p:=pos('/',lyn);a:=strtofloat(copy(lyn,1,q-1)); MCForm.PBSuperspin3.value:=a;lyn:=copy(lyn,p+1,length(lyn));
          q:=pos(' ',lyn);a:=strtofloat(copy(lyn,1,q-1)); MCForm.PBSuperspin4.value:=a;

          p:=pos('HomAdv:',lyn);lyn:=copy(lyn,p+7,length(lyn));
          p:=pos('/',lyn);a:=strtofloat(copy(lyn,1,q-1)); MCForm.PBSuperspin13.value:=a;lyn:=copy(lyn,p+1,length(lyn));
          p:=pos('/',lyn);a:=strtofloat(copy(lyn,1,q-1)); MCForm.PBSuperspin14.value:=a;lyn:=copy(lyn,p+1,length(lyn));
          q:=length(lyn)+1;a:=strtofloat(copy(lyn,1,q-1)); MCForm.PBSuperspin15.value:=a;


        end;
        p:=pos('Pop:',lyn);
        if p>0 then
        begin
          lyn:=copy(lyn,p+4,length(lyn));q:=pos('*',lyn);
          t:=strtoint(copy(lyn,1,q-1));
          if t>0 then MCForm.PBSuperspin7.value:=t;
          lyn:=copy(lyn,q+1,length(lyn));q:=pos('=',lyn);
          t:=strtoint(copy(lyn,1,q-1));
          if t>0 then MCForm.PBSuperspin11.value:=t;
        end;
      end;   //Header info
      p:=pos('Com:',lyn);
      if p>0 then  //Body info
      begin
        lyn:=copy(lyn,p+5,length(lyn));
        p:=pos('HetAdv: ',lyn);
        if p>0 then begin
          e:=copy(lyn,1,p-2);
          e:=Trim(e);
          if e[length(e)]=',' then e:=copy(e,1,length(e)-1);
          lynitem.Com:=strtofloat(e);
        end;

        lyn:=copy(lyn,p+8,length(lyn));
        p:=pos('HomAdv: ',lyn);
        if p>0 then begin
          e:=copy(lyn,1,p-2);
          if e[length(e)]=',' then e:=copy(e,1,length(e)-1);
          lynitem.HetAdv:=strtofloat(e);
        end;

        lyn:=copy(lyn,p+8,length(lyn));
        p:=pos(', ',lyn);
        if p>0 then begin
          e:=copy(lyn,1,p-1);
          if e[length(e)]=',' then e:=copy(e,1,length(e)-1);
          lynitem.HomAdv:=strtofloat(e);
        end;
        inkrementeer(lynitem);
      end;


    end;
    closefile(leer);
    sukses:=True;
  end else sukses:=False;

  if sukses then
  begin
    n:=extractfilename(leernaam);
    MCForm.label21.Caption:=n;
    MCForm.Radiobutton1click(nil);


//Find biggest and smallest Com, hetadv & homadv
{
    kleinste:=lynitem;grootste:=lynitem;
    for t:=1 to templateteller do
    begin
      if MCwerklys[t].Com<kleinste.Com then kleinste.Com:=MCwerklys[t].Com;
      if MCwerklys[t].Com>grootste.Com then grootste.Com:=MCwerklys[t].Com;
      if MCwerklys[t].hetadv<kleinste.hetadv then kleinste.hetadv:=MCwerklys[t].hetadv;
      if MCwerklys[t].hetadv>grootste.hetadv then grootste.hetadv:=MCwerklys[t].hetadv;
      if MCwerklys[t].homadv<kleinste.homadv then kleinste.homadv:=MCwerklys[t].homadv;
      if MCwerklys[t].homadv>grootste.homadv then grootste.homadv:=MCwerklys[t].homadv;
    end;
    MCForm.PBSuperSpin8.Value:=kleinste.Com;
    MCForm.PBSuperSpin9.Value:=grootste.Com;
    MCForm.PBSuperSpin2.Value:=kleinste.hetadv;
    MCForm.PBSuperSpin3.Value:=grootste.hetadv;
    MCForm.PBSuperSpin13.Value:=kleinste.homadv;
    MCForm.PBSuperSpin14.Value:=grootste.homadv;
}

//    MCForm.label12.caption:='Total Runs :'+inttostr(templateteller);
  end else
  begin
    templateteller:=0;
  end;
  MCForm.PBSuperSpin5Change(nil);

end;


procedure TMCForm.Button2Click(Sender: TObject);
begin
  if MCForm.OpenDialog1.Execute then
  begin
    fulltemplatefilename:=opendialog1.FileName;
    MCForm.label22.Caption:=fulltemplatefilename;
    leestemplate(fulltemplatefilename);
  end;
end;

procedure TMCForm.Timer1Timer(Sender: TObject);
begin
  if MCForm.Radiobutton3.Checked then
  begin
    inc(MCtyd);
    if MCtyd>=2 then
    begin
      fulltemplatefilename:=MCForm.label22.caption;
      leestemplate(fulltemplatefilename);
      MCForm.Timer1.Enabled:=False;
    end;
  end;  
end;

procedure TMCForm.CheckBox7Click(Sender: TObject);
begin
{$IFDEF SHOWSTABTRIGGER}
{  form1.Series4.LinePen.Visible:=CheckBox7.Checked;
  form1.Series5.LinePen.Visible:=CheckBox7.Checked;
  form1.Series4.Active:=CheckBox7.Checked;
  form1.Series5.Active:=CheckBox7.Checked;
  form1.Series4.Active:=True;
  form1.Series5.Active:=True;
}
  Form1.checkbox12.Visible:=CheckBox7.Checked;
  Form1.checkbox13.Visible:=CheckBox7.Checked;
{$ENDIF}

end;

procedure TMCForm.CheckBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssCtrl in shift) and (ssShift in shift)) then
  begin
    Checkbox7.Checked:=not(checkbox7.Checked);
    CheckBox7Click(self);
  end;
end;

end.
