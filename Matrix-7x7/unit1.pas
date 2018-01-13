unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    iloscpar: TButton;
    Label3: TLabel;
    Label4: TLabel;
    maxSumaKodu: TButton;
    Zapis: TButton;
    Odczyt: TButton;
    Label2: TLabel;
    literyicyfry: TButton;
    slowoPrzekatna: TButton;
    sumaLiczb: TButton;
    Label1: TLabel;
    Losuj: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure iloscparClick(Sender: TObject);
    procedure maxSumaKoduClick(Sender: TObject);
    procedure literyicyfryClick(Sender: TObject);
    procedure OdczytClick(Sender: TObject);
    procedure slowoPrzekatnaClick(Sender: TObject);
    procedure sumaLiczbClick(Sender: TObject);
    procedure LosujOnClick(Sender: TObject);
    procedure ZapisClick(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
type tablica = array[1..7,1..7] of char;

var
  macierz : tablica;
  macierzPar : tablica;
  i, j, suma, litery, cyfry, maxim, kolumna, para, k, l  : integer;
   u, again : char;
   plikMacierz : file of char ;
   s: string;
   flag: boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.LosujOnClick(Sender: TObject);
begin
  Randomize;
  for i:= 1 to 7  do                                  {Inicjalizacja macierzy, uzycie przycisku LOSUJ}
        for j:= 1 to 7 do
        begin
       while true do
          begin
           u:=chr(ord ('0')+Random(74));
            if (u>='0') and (u<='9') or (u>='A') and (u<='Z')or (u>='a') and (u<='z')  then
          begin
          macierz[i,j]:=u  ;
          break;
          end;
          end;
        end;
begin
  Memo1.Lines.Clear;                                  {Wyswietlanie w panelu TMemo}
  Memo2.Lines.Clear;
  for i:=1 to 7 do
   begin
    s:=' ';
      for j:=1 to 7 do
          s:=s + macierz[i,j]+ ' ';
          Memo1.Lines.Add(s);
   end;
end;
end;

procedure TForm1.ZapisClick(Sender: TObject);
begin
AssignFile(plikMacierz,'plikMacierz.bin');
Rewrite(plikMacierz);
for i:=1 to 7 do                                          {Zapis Macierzy}
   begin
      for j:=1 to 7 do
         write(plikMacierz,macierz[i,j]);

   end;
CloseFile(plikMacierz) ;
end;

procedure TForm1.sumaLiczbClick(Sender: TObject);         {Suma liczb}
begin
s:=' ';
suma := 0;
Memo2.Lines.Clear;
Memo2.Lines.Add('Liczby w macierzy to:');
 for i:=1 to 7 do
   begin
      for j:=1 to 7 do
      if (macierz[i,j]>='0') and (macierz[i,j]<='9') then
      begin
      s:= s + macierz[i,j]+' ';
      suma:= suma + ord(macierz[i,j])-48;
      end;
   end;
 Memo2.Lines.Add(s);
 Memo2.Lines.Add('Ich suma:');
 Memo2.Lines.Add(InttoStr(suma));
end;

procedure TForm1.slowoPrzekatnaClick(Sender: TObject);
begin
s:=' ';
Memo2.Lines.Clear;
Memo2.Lines.Add('Slowo na glownej przekatnej:');
begin                                                         {Slowo na przekatnej}
 for i:=1 to 7 do
   begin
    if (macierz[i,i]>='A') and (macierz[i,i]<='Z') or (macierz[i,i]>='a') and (macierz[i,i]<='z') then
    s:=s + (macierz[i,i]) ;
   end;
 Memo2.Lines.Add(s);
end;
end;

procedure TForm1.literyicyfryClick(Sender: TObject);
begin
Memo2.Lines.Clear;
                                                         {Ilosc liter i cyfr}
 litery := 0;
 cyfry := 0;
 for i:=1 to 7 do
   begin
      for j:=1 to 7 do
      if (macierz[i,j]>='A') and (macierz[i,j]<='Z') or (macierz[i,j]>='a') and (macierz[i,j]<='z') then
      begin
      litery := litery + 1;
      end
      else  cyfry := cyfry + 1;
   end;
 Memo2.Lines.Add('Ilosc cyfr:');
 Memo2.Lines.Add(InttoStr(cyfry));
 Memo2.Lines.Add('Ilosc liter:');
 Memo2.Lines.Add(InttoStr(litery));



end;

procedure TForm1.maxSumaKoduClick(Sender: TObject);                 {Max. suma kodu ASCII}
begin
Memo2.Lines.Clear;
maxim:=0;
for i:=1 to 7 do
    begin
    suma:=0;
      for j:=1 to 7 do
      begin
         suma := suma + ord(macierz[j,i]);
         if(j=7) and (maxim<suma)   then
         begin
         maxim:=suma;
         kolumna := i;
         end;
      end;
   end;
Memo2.Lines.Add('Najwieksza suma kodow ASCII w kolumnie:');
Memo2.Lines.Add(InttoStr(kolumna));
Memo2.Lines.Add('Wynosi:');
Memo2.Lines.Add(InttoStr(maxim));




end;

procedure TForm1.iloscparClick(Sender: TObject);
begin
   begin;
for i:=1 to 7 do
    begin
      for j:=1 to 7 do
         macierzPar[i,j]:=macierz[i,j];
    end;
end;
para:=0;
s:=' ';
Memo2.Lines.Clear;
Memo2.Lines.Add('W macierzy wystepuja nastepujace pary liter: ');
for i:=1 to 7 do
    begin

    for j:=1 to 7 do
      begin


      if (macierzPar[i,j]>='A') and (macierzPar[i,j]<='Z') or (macierzPar[i,j]>='a') and (macierzPar[i,j]<='z') then
         begin
             flag:=false;
              for k:=1 to 7 do
              begin
                      if(flag=true) then break;

                        for l:=1 to 7 do
                        begin;



                            if ((macierzPar[i,j]>='A') and (macierzPar[i,j]<='Z')) and ((ord(macierzPar[k,l])=ord(macierz[i,j])+32)) then
                            begin;
                            para:=para+1;
                            s:=' '+macierzPar[i,j]+' '+macierzPar[k,l]+' Para nr.: '+ InttoStr(para) ;
                            Memo2.Lines.Add(s);

                            flag:=true;
                            macierzPar[k,l]:='0';
                            end;
                            s:=' ';
                            if(flag=true) then break;

                        end;
              end;
      end;
   end;
end;

Memo2.Lines.Add('Ilosc par wynosi');
Memo2.Lines.Add(InttoStr(para));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;


procedure TForm1.OdczytClick(Sender: TObject);
begin

AssignFile(plikMacierz,'plikMacierz.bin');                                {Odczyt z pliku }
Reset(plikMacierz);
while not EoF(plikMacierz) do
begin;
for i:=1 to 7 do
    begin
      for j:=1 to 7 do
         read(plikMacierz,macierz[i,j]);
    end;
end;
 CloseFile(plikMacierz) ;
 begin
  Memo1.Lines.Clear;                                  {Wyswietlanie w panelu TMemo}
  for i:=1 to 7 do
   begin
    s:=' ';
      for j:=1 to 7 do
          s:=s + macierz[i,j]+ ' ';
          Memo1.Lines.Add(s);
   end;
end;
end;




end.

