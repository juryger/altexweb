unit Sum_Propis_3;

interface

Uses Sysutils, Forms;

const
tril = 1000000000000.00;
bil  =    1000000000.00;
mill =       1000000.00;
thou =          1000.00;

Tri     = 'три ';
Chetire = 'четыре ';
Pyat    = 'п€ть ';
Shest   = 'шесть ';
Sem     = 'семь ';
Vosem   = 'восемь ';
Devyat  = 'дев€ть ';

MyStr: array[0..9] of PChar = ('0', '1', '2', '3', '4',
                               '5', '6', '7', '8', '9');

EdinM: array[0..9] of PChar = ('', 'один ', 'два ', Tri, Chetire, Pyat,
                               Shest, Sem, Vosem, Devyat);
EdinH: array[0..9] of PChar = ('', 'одна ', 'две ', Tri, Chetire, Pyat,
                               Shest, Sem, Vosem, Devyat);
EdinS: array[0..9] of PChar = ('', 'одно ', 'два ', Tri, Chetire, Pyat,
                               Shest, Sem, Vosem, Devyat);
Decs: array[0..9] of PChar = ('дес€ть ', 'одиннадцать ', 'двенадцать ',
                              'тринадцать ', 'четырнадцать ', 'п€тнадцать ',
                              'шестнадцать ', 'семнадцать ', 'восемнадцать ',
                              'дев€тнадцать ');
San: array[0..9] of PChar = ('', '', 'двадцать ', 'тридцать ', 'сорок ',
                             'п€тьдес€т ', 'шестьдес€т ', 'семьдес€т ',
                             'восемьдес€т ', 'дев€носто ');
Mil: array[0..9] of PChar = ('', 'сто ', 'двести ', 'триста ', 'четыреста ',
                             'п€тьсот ', 'шестьсот ', 'семьсот ', 'восемьсот ',
                             'дев€тьсот ');

type
  CurType = array[0..255] of Char;

type
  TSp3 = class(TForm)
  public
      function  GetRealSumma(ASumma: double; isnum: boolean): String;
  end;

var
   Sp3: TSp3;

implementation

function TSp3.GetRealSumma(ASumma: double; isnum: boolean): String;
var R,U,Fr: extended;
    XX,X,Y,Z,T,K: longint;
    ABuffer: CurType;
    d: array[0..200] of Char;
    fch: String;
    label s_exit;

  function GetCount(ACount: longint; Sex: byte): PChar;
  var X1,Y1,Z1: byte;
  begin
     X1 := ACount div 100;
     Y1 := (ACount mod 100) div 10;
     Z1 := (ACount mod 100) mod 10;
     StrCopy(d, Mil[X1]);
     if (Y1 * 10 + Z1) in [10..19] then StrCat(d, Decs[Y1 * 10 + Z1 - 10]) else
     begin
       StrCat(d, San[Y1]);
       Case Sex of
         1: StrCat(d, EdinM[Z1]);
         2: StrCat(d, EdinH[Z1]);
         3: StrCat(d, EdinS[Z1]);
       end;
     end;
     GetCount := @d;
  end;

begin
  ABuffer[0] := #0;
  U := ASumma;
  if (U >= 1000 * tril) or (U < 0) then
  begin
    StrCopy(ABuffer, '0.00');
    //GetRealSumma := @ABuffer;
    Result := ABuffer;
    Exit;
  end;
  Fr := Frac(U);
  if Fr > 0.994 then
  begin
    Fr := 0.000;
    U := U + 1;
  end;
  R := U - Fr;
  K := Round(100.00 * Fr);
  XX := Trunc(R / tril);
  R := R - tril * Int(R / tril);
  X := Trunc(R / bil);
  R := R - bil * Int(R / bil);
  Y := Trunc(R / mill);
  R := R - mill * Int(R / mill);
  Z := Trunc(R / thou);
  R := R - thou * Int(R / thou);
  T := Trunc(R);
  ABuffer[0] := #0;
  if XX > 0 then
  begin
    StrCat(ABuffer, GetCount(XX, 1));
    if (XX mod 100) in [10..19] then StrCat(ABuffer, 'триллионов ') else
    Case (XX mod 100) mod 10 of
      1: StrCat(ABuffer, 'триллион ');
      2..4: StrCat(ABuffer, 'триллиона ');
      else StrCat(ABuffer, 'триллионов ');
    end;
  end;
  if X > 0 then
  begin
    StrCat(ABuffer, GetCount(X, 1));
    if (X mod 100) in [10..19] then StrCat(ABuffer, 'миллиардов ') else
    Case (X mod 100) mod 10 of
      1: StrCat(ABuffer, 'миллиард ');
      2..4: StrCat(ABuffer, 'миллиарда ');
      else StrCat(ABuffer, 'миллиардов ');
    end;
  end;
  if Y > 0 then
  begin
    StrCat(ABuffer, GetCount(Y, 1));
    if (Y mod 100) in [10..19] then StrCat(ABuffer, 'миллионов ') else
    Case (Y mod 100) mod 10 of
      1: StrCat(ABuffer, 'миллион ');
      2..4: StrCat(ABuffer, 'миллиона ');
      else StrCat(ABuffer, 'миллионов ');
    end;
  end;
  if Z > 0 then
  begin
    StrCat(ABuffer, GetCount(Z, 2));
    if (Z mod 100) in [10..19] then StrCat(ABuffer, 'тыс€ч ') else
    Case (Z mod 100) mod 10 of
      1: StrCat(ABuffer, 'тыс€ча ');
      2..4: StrCat(ABuffer, 'тыс€чи ');
      else StrCat(ABuffer, 'тыс€ч ');
    end;
  end;
  if T > 0 then
  begin
    StrCat(ABuffer, GetCount(T, 1));
    //******************************
    if (isnum=true) then goto s_exit;
    //******************************
    if (T mod 100) in [10..19] then
    begin
      StrCat(ABuffer, 'рублей');
      StrCat(ABuffer, ' ');
    end
      else
    Case (T mod 100) mod 10 of
      1: begin
           StrCat(ABuffer, 'рубль');
           StrCat(ABuffer, ' ');
         end;
      2..4: begin
              StrCat(ABuffer, 'рубл€');
              StrCat(ABuffer, ' ');
            end;
      else begin
             StrCat(ABuffer, 'рублей');
             StrCat(ABuffer, ' ');
           end;
    end;
  end
    else
  if U >= 1 then
  begin
    StrCat(ABuffer, 'рублей');
    StrCat(ABuffer, ' ');
  end;
  StrCopy(d, MyStr[K div 10]);
  StrCat(d, MyStr[K mod 10]);
  StrCat(ABuffer, d);
  StrCat(ABuffer, ' ');
  if K in [10..19] then
  begin
    StrCat(ABuffer, 'копеек')
  end
    else
  Case (K mod 100) mod 10 of
    1: StrCat(ABuffer, 'копейка');
    2..4: StrCat(ABuffer, 'копейки')
    else StrCat(ABuffer, 'копеек')
  end;
s_exit:
  if ABuffer[Pred(StrLen(ABuffer))] = #32 then ABuffer[Pred(StrLen(ABuffer))] := #0;
  fch := ABuffer;
  Delete(fch,1,1);
  fch := AnsiUpperCase(ABuffer[0]) + fch;
  Result := fch;
  //GetRealSumma := @ABuffer;
end;


end.
