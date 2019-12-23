{Модуль - <MyWind>}                                  { Неронов Е.Ю  08.05.03 }
Unit MyWind;
InterFace
Uses Crt,Graph,Neronov,Mouse,Risov,PrintScr;

Type
 TButton = Object {Класс <TButton>}
  Private
   x1,y1,x2,y2:Integer;
   xStrin,yStrin:Integer;
   ok:Boolean;
   strin:String;
   Procedure Draw(bool:Boolean); Virtual;
  Public
   Constructor INIT(x1_,y1_,x2_,y2_:Integer;strin_:String);
   Destructor Done;
   Procedure Move(x1_,y1_:Integer);
   Procedure MoveRel(relX,relY:Integer);
   Function GetX1:Integer;
   Function GetY1:Integer;
   Function GetX2:Integer;
   Function GetY2:Integer;
   Function GetStrin:String;
   Function DA:Boolean;
 End;

 TReader = Object(TButton) {Класс TReader(Button)}
  Private
   outStrin:String;
   CharSize:Byte;
   Procedure Draw(bool:Boolean); Virtual;
  Public
   Constructor INIT(x1_,y1_,x2_:Integer;strin_:String;ChSize_:Integer);
   Function DA:String;
   Function Stroka:String;
 End;

 TButtonsList = ^TButRec; { Тип для списка кнопок(TButton) }
 TButRec = Record
   key  : String;
   but  : TButton;
   next : TButtonsList;
 End;

 TReadersList = ^TWinRec; { Тип для списка диалоговых окон (TReader) }
 TWinRec = Record
   key  : String;
   read : TReader;
   next : TReadersList;
 End;

 TButtons = Object {Класс - TButtons}
  Private
   buttons:TButtonsList;
  Public
   Constructor INIT;
   Destructor Done;
   Function  DA:String;
   Procedure Creat(x1,y1,x2,y2:Integer;strin:String;key:String);
   Procedure Del(key:String);
   Procedure MoveRel(kX,kY:Integer);
 End;

 TReaders = Object {Класс - TReaders}
  Private
   buttons:TReadersList;
  Public
   Constructor INIT;
   Destructor Done;
   Function  DA(key:String):String;
   Procedure AllDA;
   Procedure Creat(x1,y1,x2:Integer;strin:String;charSize:Byte;key:String);
   Procedure Del(key:String);
   Procedure MoveRel(kX,kY:Integer);
   Function  Stroka(key:String):String;
 End;

 TWindow = Object(TReader) { Класс TWindow(Reader)}
  Private
   image:M3P;
   active:Boolean;
   Procedure Draw(bool:Boolean); Virtual;
   Procedure Move(x1_,y1_:Integer);
   Procedure MoveRel(relX,relY:Integer);
  Public
   buts:TButtons;
   reads:TReaders;
   Constructor INIT(x2_,y2_:Integer;strin_:String);
   Destructor Done;
   Function DA(key:String):String;
 End;



Implementation

{Методы для класса <TButton>}

 Constructor TButton.INIT(x1_,y1_,x2_,y2_:Integer;strin_:String);
  Begin
   x1:=x1_; y1:=y1_;
   x2:=x2_; y2:=y2_;
   strin:=strin_;
   SetTextStyle(0,0,0);
   If strin='x' then xStrin:=(x1+(x2-x1) div 2) - TextWidth(strin) div 3
   else xStrin:=(x1+(x2-x1) div 2) - TextWidth(strin) div 2;
   yStrin:=((y1+(y2-y1) div 2) - (TextHeight(strin) div 3)*2)+1;
   ok:=TRUE;
  End;{TButton.INIT(x1_,y1_,x2_,y2_:Integer;strin_:String);}

 Destructor TButton.Done; Begin End;{TButton.Done;}

 Procedure TButton.Draw(bool:Boolean);
  Begin
   SetTextStyle(0,0,0);
   SetLineStyle(0,0,0);
   MsOff;
   SetFillStyle(1,7);
   bar(x1,y1,x2,y2);
   If ok then
    Begin
     SetColor(15);
     Line(x1,y1,x1,y2);
     Line(x1,y1,x2,y1);
     SetColor(0);
     Line(x2,y1,x2,y2);
     Line(x1,y2,x2,y2);
    End
   Else
   Begin
     SetColor(15);
     Line(x2,y1,x2,y2);
     Line(x1,y2,x2,y2);
     SetColor(0);
     Line(x1,y1,x1,y2);
     Line(x1,y1,x2,y1);
    End;
   OuttextXY(xStrin-Ord(ok),yStrin-Ord(ok),Strin);
   Ok:=bool;
   MsOn;
  End;{Procedure TButton.Draw(bool:Boolean);}

 Procedure TButton.Move(x1_,y1_:Integer);
  Begin
   SetTextStyle(0,0,0);
   x2:=x1_+(x2-x1);
   x1:=x1_;
   y2:=y1_+(y2-y1);
   y1:=y1_;
   If strin='x' then xStrin:=(x1+(x2-x1) div 2) - TextWidth(strin) div 3
   else xStrin:=(x1+(x2-x1) div 2) - TextWidth(strin) div 2;
   yStrin:=((y1+(y2-y1) div 2) - (TextHeight(strin) div 3)*2)+1;
   Ok:=TRUE;
   Draw(TRUE);
  End;{TButton.Move;}

 Procedure TButton.MoveRel(relX,relY:Integer);
  Begin
   Move(x1+relX,y1+relY);
  End;{TButton.MoveRel(relX,relY:Integer);}

 Function TButton.GetX1:Integer;   Begin GetX1:=x1;       End;
 Function TButton.GetY1:Integer;   Begin GetY1:=y1;       End;
 Function TButton.GetX2:Integer;   Begin GetX2:=x2;       End;
 Function TButton.GetY2:Integer;   Begin GetY2:=y2;       End;
 Function TButton.GetStrin:String; Begin GetStrin:=strin; End;

 Function TButton.DA:Boolean;
  Begin
   If Cloce=1 then
    If LimitN(MsX,x1,x2) and LimitN(MsY,y1,y2) then
     Begin
      Draw(TRUE);
      Repeat
      Until (Cloce<>1);
     End
    Else
   Else
    If ok then Draw(FALSE);
   DA:=ok and (LimitN(MsX,x1,x2) and LimitN(MsY,y1,y2));
  End;{TButton.DA:Boolean;}


{Методы для класса TReader(Button)}

 Constructor TReader.INIT(x1_,y1_,x2_:Integer;strin_:String;ChSize_:Integer);
  Begin
   outStrin:=strin_;
   strin:='';
   x1:=x1_; y1:=y1_;
   SetTextStyle(2,0,ChSize_);
   yStrin:=TextHeight('W')+TextHeight('W') div 6;
   x2:=x1+x2_; y2:=y1_+TextHeight('W')+TextHeight('W') div 6;
   CharSize:=ChSize_;
   Draw(FALSE);
  End;{TReader.INIT(x1_,y1_,x2_:Integer;strin_:String;ChSize_:Integer);}

 Procedure TReader.Draw(bool:Boolean);
  Begin
   SetLineStyle(0,0,0);
   SetTextStyle(2,0,CharSize);
   MsOff;
   SetColor(0);
   OutTextXY(x1-TextWidth(outStrin)-3,(y1-TextHeight('W') div 4)+2,outStrin);
   SetFillStyle(1,15);
   Bar(x1,y1,x2,y2);
   SetColor(15);
   Line(x2,y1,x2,y2);
   Line(x1,y2,x2,y2);
   SetColor(0);
   Line(x1,y1,x1,y2);
   Line(x1,y1,x2,y1);
   If bool then OutTextXY(x1+3,(y1-TextHeight('W') div 4)+2,strin);
   MsOn;
  End;{TReader.Draw(bool:Boolean);}

 Function TReader.DA:String;
  Begin
   DA:='';
   If LimitN(MsX,x1,x2) and LimitN(MsY,y1,y2) and (Cloce=1) then
    Begin
     Draw(FALSE);
     SetColor(8);
     MsOff;
     SetTextStyle(2,0,CharSize);
     Strin:=GrRead(x1+3,y1+2,x2);
     MsOn;
     Draw(TRUE);
     DA:=strin;
    End;
  End;{TReader.DA:String;}

 Function Treader.Stroka:String;
  Begin
   Stroka:=strin;
  End;{Treader.Stroka:String;}


{ Mетды для класса TButtons }
 Constructor TButtons.INIT; Begin End;{TButtons.INIT;}
 Destructor TButtons.Done;
  Var now,back:TButtonsList;
  Begin
   now:=buttons;
   While now<>nil do
    Begin
     back:=now;
     now:=now^.next;
     dispose(back);
    End;
   buttons:=NIL;
  End;{TButtons.Done;}

 Function  TButtons.DA:String;
  Var now:TButtonsList;
  Begin
   DA:='';
   now:=buttons;
   While now<>nil do
    Begin
     If now^.but.DA then DA:=now^.key;
     now:=now^.next;
    End;
  End;{TButtons.DA:String;}

 Procedure TButtons.Creat(x1,y1,x2,y2:Integer;strin:String;key:String);
  Var now:TButtonsList;
  Begin
   New(now);
   now^.but.INIT(x1,y1,x2,y2,strin);
   now^.key:=key;
   now^.next:=buttons;
   buttons:=now;
  End;

 Procedure TButtons.Del(key:String);
  Var now,back:TButtonsList;
  Begin
   now:=buttons;
   back:=now;
   While now<>nil do
    Begin
     If now^.key=key then
      Begin
       If now=buttons then buttons:=buttons^.next;
       back^.next:=now^.next;
       now^.but.DONE;
       Dispose(now);
       Break; { !!!!!!!!!!!!!!!!!!!!!!!!! }
      End;
     back:=now;
     now:=now^.next;
    End;
  End;{TButtons.Del(key:String);}

 Procedure TButtons.MoveRel(kX,kY:Integer);
  Var now:TButtonsList;
  Begin
   now:=buttons;
   While now<>nil do
    Begin
     now^.but.MoveRel(kX,kY);
     now:=now^.next;
    End;
  End;{TButtons.MoveRel(kX,kY:Integer);}

{ Mетды для класса TReaders }
 Constructor TReaders.INIT; Begin End;{TReaders.INIT;}
 Destructor TReaders.Done;{TReaders.Done;}
  Var now,back:TReadersList;
  Begin
   now:=buttons;
   While now<>nil do
    Begin
     back:=now;
     now:=now^.next;
     dispose(back);
    End;
   buttons:=NIL;
  End;

 Function  TReaders.DA(key:String):String;
  Var now:TReadersList;
  Begin
   DA:='';
   now:=buttons;
   While now<>nil do
    Begin
     If now^.key=key then DA:=now^.read.DA;
     now:=now^.next;
    End;
  End;{TReaders.DA(key:String):String;}

 Procedure TReaders.Creat(x1,y1,x2:Integer;strin:String;charSize:Byte;key:String);
  Var now:TReadersList;
  Begin
   New(now);
   now^.read.INIT(x1,y1,x2,strin,charSize);
   now^.key:=key;
   now^.next:=buttons;
   buttons:=now;
  End;{TReaders.Creat(x1,y1,x2:Integer;strin:String;charSize:Byte;key:String);}

 Procedure TReaders.Del(key:String);
  Var now,back:TReadersList;
  Begin
   now:=buttons;
   back:=now;
   While now<>nil do
    Begin
     If now^.key=key then
      Begin
       If now=buttons then buttons:=buttons^.next;
       back^.next:=now^.next;
       now^.read.DONE;
       Dispose(now);
       Break; { !!!!!!!!!!!!!!!!!!!!!!!!! }
      End;
     back:=now;
     now:=now^.next;
    End;
  End;{TReaders.Del(key:String);}

 Procedure TReaders.MoveRel(kX,kY:Integer);
  Var now:TReadersList;
  Begin
   now:=buttons;
   While now<>nil do
    Begin
     now^.read.MoveRel(kX,kY);
     now:=now^.next;
    End;
  End;{TReaders.MoveRel(kX,kY:Integer);}

 Procedure TReaders.AllDA;
  Var now:TReadersList;
  Begin
   now:=buttons;
   While now<>nil do
    Begin
     now^.read.DA;
     now:=now^.next;
    End;
  End;{TReaders.AllDA(Var strin,key:String);}

 Function  TReaders.Stroka(key:String):String;
  Var now:TReadersList;
  Begin
   now:=buttons;
   While now<>nil do
    Begin
     If key=now^.key then Stroka:=now^.read.Stroka;
     now:=now^.next;
    End;
  End;{TReaders.Stroka(key:String):String;}

{Методы для класса TWindow}
 Constructor TWindow.INIT(x2_,y2_:Integer;strin_:String);
  Begin
   x1:=0; x2:=x2_;
   y1:=0; y2:=y2_;
   strin:=strin_;
   SetTextStyle(0,0,1);
   xStrin:=x1+(((x2-x1)-TextWidth(strin)) div 2);
   yStrin:=y1+4;
   NewM3P(x1,y1,x2,y2,image);
   Screen(x1,y1,x2,y2,image);
   Draw(TRUE);
   reads.INIT;
   buts.INIT;
   buts.Creat(x2-14,y1+2,x2-2,y1+14,'x','exit');
   active:=TRUE;
  End;{TWindow.INIT(x1_,y1_,x2_,y2_:Integer;strin_:String);}

 Destructor TWindow.Done;
  Begin
   buts.DONE;
   reads.DONE;
   MsOff;
   Print(x1,y1,x2,y2,0,0,image);
   FreeM3P(x1,y1,x2,y2,image);
   MsOn;
   active:=FALSE;
  End;{TWindow.Done;}

 Procedure TWindow.Draw(bool:Boolean);
  Begin
   SetTextStyle(0,0,1);
   SetLineStyle(0,0,0);
   SetFillStyle(1,7);
   Bar(x1,y1,x2,y2);
   If bool then SetFillStyle(1,9)
   Else SetFillStyle(1,1);
   Bar(x1,y1,x2,y1+15);
   SetColor(15);
   OutTextXY(xStrin,yStrin,strin);
   SetColor(15);
   Line(x1,y1,x1,y2);
   Line(x1,y1,x2,y1);
   SetColor(0);
   Line(x2,y1,x2,y2);
   Line(x1,y2,x2,y2);
  End;{TWindow.Draw(bool:Boolean);}

 Procedure TWindow.Move(x1_,y1_:Integer);
  Var kX,kY:Integer;
  Begin
   If (x1_<>x1) or (y1_<>y1) then
    Begin
     MsOff;
     Print(x1,y1,x2,y2,0,0,image);
     kX:=x1_-x1;         kY:=y1_-y1 ;
     x2:=x1_+(x2-x1);    y2:=y1_+(y2-y1);
     x1:=x1_;            y1:=y1_;
     xStrin:=x1+(((x2-x1)-TextWidth(strin)) div 2);
     yStrin:=y1+4;
     Screen(x1,y1,x2,y2,image);
     Draw(TRUE);
     buts.MoveRel(kX,kY);
     reads.MoveRel(kX,kY);
     MsOn;
    End;
  End;{TWindow.Move(x1_,y1_:Integer);}

 Procedure TWindow.MoveRel(relX,relY:Integer);
  Begin
   Move(x1+relX,y1+relY);
  End;{TWindow.MoveRel(relX,relY:Integer);}

 Function TWindow.DA(key:String):String;
  Var x,y,kX,kY:Integer;
      key1,strin1:String;
  Begin
   If active then
    Begin
     If (Cloce=1) and LimitN(MsX,x1,x2-20) and LimitN(MsY,y1,y1+15) then
      Begin
       SetWriteMode(1);
       SetLineStyle(3,0,0);
       SetColor(8);
       kX:=x1-MsX;
       kY:=y1-MsY;
       MsWin(-kX,-kY,GetMaxX-(x2-MsX),GetMaxY-(y2-MsY));
       Repeat
        x:=MsX; y:=MsY;
        MsOff; Rectangle(x+kX,y+kY,x+kX+(x2-x1),y+kY+(y2-y1)); MsOn;
        Repeat Until (MsX<>x) or (MsY<>y) or (Cloce<>1);
        MsOff; Rectangle(x+kX,y+kY,x+kX+(x2-x1),y+kY+(y2-y1)); MsOn;
       Until Cloce<>1;
       MsWin(0,0,GetMaxX,GetMaxY);
       SetWriteMode(0);
       Move(x+kX,y+kY);
      End;
      reads.allDA;
      If key='' then strin1:=buts.DA
      else strin1:=reads.Stroka(key);
      DA:=strin1;
      If strin1='exit' then DONE;
    End;
  End;{TWindow.DA(Key:String);}



End.