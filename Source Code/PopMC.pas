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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PBSuperSpin8Change(Sender: TObject);
    procedure PBSuperSpin2Change(Sender: TObject);
    procedure PBSuperSpin13Change(Sender: TObject);
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
                   gemgrootte:integer;
                   begpersentasie:real;
                   vertoon,grafieke,histog:Boolean;
                   horlosieinterval:integer;
                 end;

var
  MCForm: TMCForm;
  statrek:statusrekord;
  comsteps,hetadvsteps,homadvsteps:integer;
  hetstatus:Boolean=False;
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
  HeterozygoticAdvantage:=statrek.heta;Form1.PBSuperSpin1.Text:=floattostrF(100*(statrek.heta-1),fffixed,6,5);
  HomozygoticAdvantage:=statrek.homa;Form1.PBSuperSpin4.Text:=floattostrF(100*(statrek.homa-1),fffixed,6,5);
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
  if ((RadioButton1.Checked=False) and (RadioButton2.checked=False)) then RadioButton1.Checked:=True;
  MCForm.RadioButton1Click(self);
  MCForm.CheckBox3Click(self);

end;

procedure TMCForm.FormShow(Sender: TObject);
begin
  krystatus;
  label13.Caption:='';
  PBSuperSpin7Change(self);

  PBSuperSpin11Change(self);
  MCFOrm.CheckBox2Click(self);



end;

procedure TMCForm.PBSuperSpin8Change(Sender: TObject);
var
  w:real;
begin
  if tydteller<2 then exit;
  comsteps:=0;
  w:=PBSuperSpin8.value;
//  if w>PBSuperSpin9.value then PBSuperSpin9.Value:=w;
  repeat
    w:=w+PBSuperSpin10.Value;
    inc(comsteps);
  until ((w>PBSuperSpin9.Value+eps) or (PBSuperSpin10.Value<=0));
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
    repeat
      w:=w/(1+PBSuperspin4.Value);
      inc(hetadvsteps);
    until ((abs(w)<abs(PBSuperSpin2.value)) or (PBSuperspin2.Value=0) or (PBSuperspin4.Value=0) or ((PBSuperspin2.Value/PBSuperspin3.value)<=0));
  end else
  begin  //Linie�r
    w:=PBSuperspin2.value;
    repeat
      w:=w+PBSuperspin4.Value;
      inc(hetadvsteps);
    until ((w>PBSuperSpin3.value+eps) or (PBSuperspin4.Value<=0));
  end;
  label10.Caption:='Steps : '+inttostr(hetadvsteps);
  PBSuperSpin5Change(self);

end;

procedure TMCForm.PBSuperSpin13Change(Sender: TObject);
var
  w:real;
begin

  if tydteller<2 then exit;
  homadvsteps:=0;
  w:=PBSuperspin13.value;
  repeat
    w:=w+PBSuperspin15.Value;
    inc(homadvsteps);
  until ((w>PBSuperSpin14.value+eps) or (PBSuperspin15.Value<=0));
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

procedure TMCForm.Button1Click(Sender: TObject);
var age:integer;
    i,a,b:integer;
    hetadv,homadv:real;
    s,s2:string;
    maxcolony:integer;
    uitleer:textfile;
    hetinis:Boolean;

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
  Button1.Caption:='Run';beep;

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
    aanvangstyd:=GetTickCount;
    s:=Datetostr(Date)+' - '+TimeToStr(Time);s2:='';for i:=1 to length(s) do if not(s[i] in ['/',':',' ']) then s2:=s2+s[i];
    assignfile(uitleer,'MC'+s2+'.txt');
    rewrite(uitleer);
    MCBesig1:=True; Button1.Caption:='Stop';
    memo1.Lines.clear;
    memo1.Lines.add(form1.Caption);writeln(uitleer,form1.Caption);
    memo1.lines.add(s);writeln(uitleer,s);
    vorigeMCT:=0;
    if RadioButton1.Checked then s:='Mutation Establishment' else s:='Equilibrium Prevalence';
    memo1.lines.add(s);writeln(uitleer,s);

    s:='Runs:'+floattostrf(PBSuperspin5.value,fffixed,8,0);
     if RadioButton1.Checked then
       s:=s+'  Threshold:'+floattostrf(PBSuperspin1.value,fffixed,5,0)
       else s:=s+'  Initial prevalence:'+floattostrf(PBSuperspin12.value,fffixed,8,3);
     s:=s+'  Maxgens:'+floattostrf(PBSuperspin6.value,fffixed,5,0)
     +'  Community:'+floattostrf(PBSuperspin8.value,fffixed,6,0)+'/'+floattostrf(PBSuperspin9.value,fffixed,6,0)+'/'+floattostrf(PBSuperspin10.value,fffixed,6,0)
     +'  HetAdv:'+floattostrf(PBSuperspin2.value,fffixed,8,5)+'/'+floattostrf(PBSuperspin3.value,fffixed,8,5)+'/'+floattostrf(PBSuperspin4.value,fffixed,8,5);
     if checkbox3.checked=False then
     s:=s+'  HomAdv:'+floattostrf(PBSuperspin13.value,fffixed,8,5)+'/'+floattostrf(PBSuperspin14.value,fffixed,8,5)+'/'+floattostrf(PBSuperspin15.value,fffixed,8,5)
     else s:=s+'  HomAdv: = HetAdv';
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

  gemeenskapsgrootte:=trunc(PBSuperSpin8.Value);
//    if form1.checkbox7.Checked then
    form1.maakcdf(gemeenskapsgrootte);
  repeat  //Doen eers die gemeenskapsgrootte-lus
    if MCBesig1=False then begin maakleerordeliktoe;exit;end;
    if checkbox4.Checked then hetadv:=PBSuperSpin3.Value else hetadv:=PBSuperSpin2.Value;
    HeterozygoticAdvantage:=1+hetadv/100;
//    ddrempel:=drempelskaal/HeterozygoticAdvantage;
//    drempels[skoon]:=ddrempel;
//    Form1.pasdrempelsaan;
//    drempels[skoon]:=drempelskaal/HeterozygoticAdvantage;
    repeat  //Doen nou die hetero-lus
      if MCBesig1=False then begin maakleerordeliktoe;exit;end;

      if checkbox3.Checked=False then homadv:=PBSuperSpin13.Value else homadv:=hetadv;

      HomozygoticAdvantage:=1+homadv/100;
      form1.pasdrempelsaan;

      repeat  //Doen die homosigotiese lus
        for i:=1 to trunc(PBSuperspin5.Value) do   //Doen dan PBSuperspin5.Value iterasies per punt
        begin
          if MCBesig1=False then begin maakleerordeliktoe;exit;end;
          s:='';

          if ((Radiobutton1.Checked=True) or (hetinis=False) or (checkbox5.Checked=False) or ((draerteller=0) and (siekteller=0))) then
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
//          draerteller:=1;

          //Inisieer
          if RadioButton1.Checked then
          begin //Plaas een mutasie in die middel
            popskik^[breedte div 2,hoogte div 2].status:=draer;
            popskik^[breedte div 2,hoogte div 2].g[1]:=draer;
            popskik^[breedte div 2,hoogte div 2].g[2]:=skoon;
            draerteller:=1;siekteller:=0;
          end else //Inisieer met beginvoorkoms
          begin
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
//            if MCBesig1=False then begin maakleerordeliktoe;exit;end;
//Step one generation
              form1.Button2Click(self);
//            if (((generasieteller-1) mod grafiekskoonmaakdrempel)>=grafiekskoonmaakdrempel-4) then begin form1.series1.clear;Form1.series2.Clear;end;
            inc(age);
            if draerteller>maxcolony then maxcolony:=draerteller;
          until (((draerteller=0) and (siekteller=0)) or ((radiobutton1.Checked=True) and (draerteller>=PBSuperSpin1.value)) {or ((radiobutton2.Checked=True) and (stabiel=True))} or (age>=PBSuperSpin6.Value) or (MCBesig1=False));

{$IFDEF OUERS}
form1.checkbox11.checked:=True;
form1.Button2Click(self);
form1.checkbox11.checked:=False;
{$ENDIF}

          inc(MCteller);
          PBSuperSpin5Change(self);

          s:=floattostrf(MCteller,fffixed,8,0)
               +', Com: '+floattostrf(gemeenskapsgrootte,fffixed,4,0)
               +', HetAdv: '+floattostrf(hetadv,fffixed,6,5)
               +', HomAdv: '+floattostrf(homadv,fffixed,6,5)
               +', Age: '+floattostrf(age,fffixed,6,0);
               if radiobutton1.Checked then
               s:=s+', Max: '+floattostrf(maxcolony,fffixed,4,0) else
               s:=s+', Hetprev: '+floattostrf(100*draerteller/(breedte*hoogte),fffixed,6,5)
                   +', Homprev: '+floattostrf(100*siekteller/(breedte*hoogte),fffixed,6,5);
          memo1.lines.add(s);
          writeln(uitleer,s);flush(uitleer);
        end;  //PBSuperspin5.Value iterasies per punt

        if checkbox3.Checked=False then
          homadv:=homadv+PBSuperSpin15.Value
            else
              homadv:=hetadv;
        HomozygoticAdvantage:=1+homadv/100;
        form1.pasdrempelsaan;
      until ((checkbox3.checked=True) or (homadv>PBSuperspin14.Value+eps) or (PBSuperspin15.Value<=0) or (MCBesig1=False));  //homosigotiese-lus

      if checkbox4.checked then hetadv:=hetadv/(1+PBSuperspin4.Value) else hetadv:=hetadv+PBSuperSpin4.Value;
      HeterozygoticAdvantage:=1+hetadv/100;
//      ddrempel:=drempelskaal/HeterozygoticAdvantage;
//      drempels[skoon]:=ddrempel;
      Form1.pasdrempelsaan;
//      drempels[skoon]:=drempelskaal/HeterozygoticAdvantage;

    until ( ( (checkbox4.checked=False) and ((hetadv>PBSuperspin3.Value+eps) or (PBSuperspin4.Value<=0) or (MCBesig1=False)))
              or
            ((checkbox4.checked=True) and ((abs(hetadv)<abs(PBSuperSpin2.value)) or (PBSuperspin2.Value=0) or (PBSuperspin4.Value=0) or ((PBSuperspin2.Value/PBSuperspin3.value)<=0)))
           );  //hetero-lus

    gemeenskapsgrootte:=gemeenskapsgrootte+trunc(PBSuperSpin10.Value);{if form1.checkbox7.Checked then} Form1.maakcdf(gemeenskapsgrootte);
  until ((gemeenskapsgrootte>PBSuperSpin9.Value+eps) or (PBSuperSpin10.Value<=0) or (MCBesig1=False));  //gemeenskapsgrootte-lus

  if MCBesig1=True then
  begin
    MCBesig1:=False;
    maakleerordeliktoe;
  end;
end;

procedure TMCForm.PBSuperSpin5Change(Sender: TObject);
begin
  if MCBesig1=False then
    label12.Caption:='Total Runs : '+inttostr(comsteps*hetadvsteps*homadvsteps*trunc(PBSuperSpin5.value))
    else
    begin
      MCRuns:=comsteps*hetadvsteps*homadvsteps*trunc(PBSuperSpin5.value);
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
  Groupbox4.Visible:=RadioButton2.checked;
  PBSuperSpin1.Visible:=Radiobutton1.Checked;
  Label2.Visible:=RadioButton1.Checked;
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
end;

end.