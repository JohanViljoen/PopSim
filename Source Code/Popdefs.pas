unit Popdefs;
{$INCLUDE compdefs.pas}

interface
uses
  Graphics;

const
  psversion='PopSim 1.53  2018-01-09 ';
  maksbreedte = 10000;
  makshoogte = 10000;

  begbreedte = 800;
  beghoogte = 625;
  dood = 0;
  beide = 1;
  skoon = 2;
  draer = 3;

  makspogings = 50;  //Probeer soveel keer om 'n ouer te kies, en gee dan op

  langgemiddeld = 40;
  stabieldrempel = 11;
  nuldrempel = langgemiddeld*0.75;
//  langgemiddeld = 1;

  maksgemeenskap = 984610;  // 1E6
  sk = 50;        //IIR-konstante vir die spoedmeter (gen/s)
  maksstatus = 250;
//    maksstatus = 65535;
  grafiekskoonmaakdrempel = 100000;  //Maak grafieke skoon as daar te veel punte is
  maksgrafiekpunte = 3010000;
  denovoskaal  = 1000000000;
  drempelskaal = 2000000000;

  makscdfstappe = 60000;
  makscdfbereik = 500;
  eps = 1E-12;
{$IFDEF OUERS}
  maksouerhis = 1000;
{$ENDIF}

type
  indrekord = record
//                status:byte;
{$IFDEF GESLAGTE}
		male:Boolean;
{$ENDIF}
                status:word;
                g:array[1..2] of word;
              end;
  adresrekord = record
  		  x,y:integer;
                end;
  TRGBQuad = packed record
               B, G, R, A: Byte;
             end;
  hisrek = record
             nommer:integer;
             naam:string;
             aantal:longint;
           end;
  hisskik = array[0..maksstatus] of hisrek;

  pRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = ARRAY[Word] OF TRGBQuad;
  skikrek = array[0..maksbreedte-1,0..makshoogte-1] of indrekord;
  grafiekrekord = record
                    hetero,
                    homo,
                    wild:real;
                  end;



//  kleurlys = (clwhite, clblack, clred, clblue, clAqua, clFuchsia, clLime, clTeal, clYellow, clOlive, clPurple, clNavy, clMaroon);


var
  i,j:integer;
  kleure:array[0..maksstatus] of integer;
  drempels:array[0..maksstatus] of real;

  HeterozygoticAdvantage:real;
  HomozygoticAdvantage:real;



  kleureRGB:array[0..maksstatus] of TRGBQuad;

  popskik,tydskik:^skikrek;

  beginpersentasie:real;

  his,his2:hisskik;
  generasieteller:integer;
  draerteller:int64;
  siekteller:int64;
  wildteller:int64;
  initbesig:Boolean=False;
  besig:Boolean=False;
  isbesig:Boolean=False;
  vertoon:Boolean=True;
  hoogte,breedte:integer;
  draergemiddeld,vorigedraergemiddeld:real;
  siekgemiddeld:real;
  wildgemiddeld:real;

  denovo:real;

  gemeenskapskik: array[1..maksgemeenskap+1] of adresrekord;
  gemeenskapsgrootte:real;
  tydteller:integer=0;
  spoed,MCSpoed:real;
  deltatyd:longword;

  vorigegt:integer;
  vorigeMCt:integer;

  beskikbaremutasie:word=draer;
  grootstemutasienommer:word=draer;
  normaliseergrafiek:Boolean;
  prentlyn:pRGBQuadArray;

  MCbesig1:Boolean;
  MCTeller:integer;
  MCRuns:integer;
  MCbegin:integer;
  aanvangstyd,eindtyd:Longword;


  tydnou,tydvorige:LongWord;
  sktyd:integer;

  hissort:hisskik;
  hisskoon:Boolean;
  tydhisrek:hisrek;

  grafiekskik:array[1..maksgrafiekpunte] of grafiekrekord;
  grafiekpunte:integer=0;
  grafiekpuntevertoon:integer=0;
//  gauss:array[0..cdfstappe] of real;
  cdf2:array[1..makscdfstappe] of integer;
  cdfstappe:integer;
  Gauss2D:array[-makscdfbereik..makscdfbereik,-makscdfbereik..makscdfbereik] of integer;

{$IFDEF OUERS}
  ouerstat:array[0..maksbreedte-1,0..makshoogte-1] of cardinal;
  ouerhis:array[0..maksouerhis] of cardinal;
  ouerleerteller:integer;
{$ENDIF}

  stabiliteitsensor:array[0..langgemiddeld-1] of integer;
  stabiel:Boolean;


implementation

begin
{$IFDEF OUERS}
for i:=0 to maksouerhis do ouerhis[i]:=0;
ouerleerteller:=0;
{$ENDIF}

  for i:=0 to maksstatus do drempels[i]:=0;


//  kleure[skoon]:=clWhite;   	//0
  kleure[skoon]:=clBlack;   	//0
  kleure[dood]:=clMaroon;    	//1
  kleure[beide]:=clWhite;   	//2
  kleure[draer]:=clLime;    	//3
  kleure[draer+1]:=clAqua;  	//4
  kleure[draer+2]:=clFuchsia;
  kleure[draer+3]:=clRed;
  kleure[draer+4]:=clTeal;
  kleure[draer+5]:=clYellow;
  kleure[draer+6]:=clOlive;
  kleure[draer+7]:=clBlue;
  kleure[draer+8]:=TColor($808080);
  kleure[draer+9]:=clPurple;
  kleure[draer+10]:=TColor($004299);
  kleure[draer+11]:=TColor($006600);

//  for i:=Draer+12 to maksstatus do kleure[i]:=kleure[i-12];
  for i:=Draer+12 to maksstatus do  //Maak willekeurige kleure
  begin
    kleure[i]:=TColor((random(256) shl 16) + (random(256) shl 8) + random(256));
  end;

  for i:=0 to maksstatus do
  begin
    kleureRGB[i].R := kleure[i] and $ff;
    kleureRGB[i].G := (kleure[i] and $ff00) shr 8;
    kleureRGB[i].B := (kleure[i] and $ff0000) shr 16;
    kleureRGB[i].A:=0;
  end;

  new(popskik);
  new(tydskik);
  for i:=0 to maksbreedte-1 do
  for j:=0 to makshoogte-1 do
  begin
    popskik^[i,j].status:=skoon;
    popskik^[i,j].g[1]:=skoon;
    popskik^[i,j].g[2]:=skoon;
  end;

end.
