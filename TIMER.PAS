{ Модуль - 'Timer' }                               { Неронов Е.Ю.  04.05.03 }
Unit Timer;
InterFace
Uses Dos;

 Procedure DelayNer(sec100:Word);{Задержка исп. программы на указ. кол-во м.сек.}
 Function GetHour:Word;{ Функция возвращает кол-во часов на данный момент }
 Function GetMinute:Word;{ Функция возвращает кол-во минут на данный момент}
 Function GetSecond:Word;{Функция возвращает кол-во секунд на данный момент}
 Function GetSec100:Word;{Функция возвращает кол-во м.секунд на данный момент}

Implementation

 Procedure DelayNer(sec100:Word);
  Var
   msec,nMsec:word;
  Begin
   msec:=0; nMsec:=0;
   repeat
    if msec<>GetSec100 then
     begin
      msec:=GetSec100;
      nMsec:=nMsec+1;
     end;
   until(Sec100=NMsec);
  End;{   Delay   }

 Function GetHour:Word;
  Var
   hour,minute,second,sec100:word;
  Begin
   GetTime(hour,minute,second,sec100);
   GetHour:=Hour;
  End;  { GetHour:Word }

 Function GetMinute:Word;
  Var
   hour,minute,second,sec100:word;
  Begin
   GetTime(hour,minute,second,sec100);
   GetMinute:=minute;
  End;  { GetMinute:Word }

 Function GetSecond:Word;
  Var
   hour,minute,second,sec100:word;
  Begin
   GetTime(hour,minute,second,sec100);
   GetSecond:=Second;
  End;  { GetSecond:Word }

 Function GetSec100:Word;
  Var
   hour,minute,second,sec100:word;
  Begin
   GetTime(hour,minute,second,sec100);
   GetSec100:=sec100;
  End;  { GetSec100:Word }

End.