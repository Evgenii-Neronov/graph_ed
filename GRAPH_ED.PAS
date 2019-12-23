program risov;
uses crt,graph,neronov,printscr,mouse,clicebar,MyWind;

type
  Tizob=record
   mas:array[1..190] of byte;
   xy:array[1..2] of integer;
  end;

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
  Public
    Procedure Draw(bool:Boolean); Virtual;
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

{Методы для класса <TButton>}

 Constructor TButton.INIT(x1_,y1_,x2_,y2_:Integer;strin_:String);
  Begin
   x1:=x1_; y1:=y1_;
   x2:=x2_; y2:=y2_;
   strin:=strin_;
   SetTextStyle(0,0,0);
   If strin='x' then xStrin:=(x1+(x2-x1) div 2) - TextWidth(strin) div 3
   else xStrin:=((x1+(x2-x1) div 2) - TextWidth(strin) div 2)+2;
   yStrin:=((y1+(y2-y1) div 2) - (TextHeight(strin) div 3)*2)+1;
   ok:=TRUE;
  End;{TButton.INIT(x1_,y1_,x2_,y2_:Integer;strin_:String);}

 Destructor TButton.Done; Begin End;{TButton.Done;}

 Procedure TButton.Draw(bool:Boolean);
  Begin
   SetTextStyle(0,0,0);
   SetLineStyle(0,0,0);
   MsOff;
   SetFillStyle(1,8);
   bar(x1,y1,x2,y2);
   If ok then
    Begin
     SetColor(0);
     Line(x1,y1,x1,y2);
     Line(x1,y1,x2,y1);
     SetColor(11);
     Line(x2,y1,x2,y2);
     Line(x1,y2,x2,y2);
    End
   Else
   Begin
     SetColor(0);
     Line(x2,y1,x2,y2);
     Line(x1,y2,x2,y2);
     SetColor(11);
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
   SetColor(11);
   OutTextXY(x1-TextWidth(outStrin)-3,(y1-TextHeight('W') div 4)+2,outStrin);
   SetFillStyle(1,0);
   Bar(x1,y1,x2,y2);
   SetColor(0);
   Line(x2,y1,x2,y2);
   Line(x1,y2,x2,y2);
   SetColor(11);
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
 Constructor TButtons.INIT; Begin Buttons:=NIL; End;{TButtons.INIT;}
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
 Constructor TReaders.INIT; Begin Buttons:=NIL; ;End;{TReaders.INIT;}
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
   SetFillStyle(1,8);
   Bar(x1,y1,x2,y2);
   If bool then SetFillStyle(1,9)
   Else SetFillStyle(1,1);
   Bar(x1,y1,x2,y1+15);
   SetColor(0);
   OutTextXY(xStrin,yStrin,strin);
   SetColor(0);
   Line(x1,y1,x1,y2);
   Line(x1,y1,x2,y1);
   SetColor(11);
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
    End;
  End;{TWindow.DA(Key:String);}



const
  MinX:integer =40;
  MinY:integer = 0;
  MaxX:integer = 639;
  MaxY:integer = 479;
var
  color,colorfill,filltip,tipline,tolline,CharSize,tipText:byte;
  instr:string;
  path,FileName:string;
  reinstr:boolean;
  rea:TReader;
  but:TButton;

Procedure SaveImage(name:String);
const
 SizeConst = 55000;
Type
 TMasImage=array[0..SizeConst] of Byte;
Var
 Mas:TmasImage;
 f:File;
 Begin
  MsOff;
  Assign(f,name);
  ReWrite(f,1);
  GetImage(41,0,639,180,Mas);
  BlockWrite(f,mas,SizeConst);
  GetImage(41,180,639,320,mas);
  BlockWrite(f,mas,SizeConst);
  GetImage(41,320,639,479,mas);
  BlockWrite(f,mas,SizeConst);
  Close(f);
  MsOn;
 End;

Procedure OpenImage(name:String);
const
 SizeConst = 55000;
Type
 TMasImage=array[0..SizeConst] of Byte;
Var
 Mas:TmasImage;
 f:File;
Begin
 Assign(f,name);
 {$i-}
 Reset(f,1);
 {$i+}
 If IOResult<>0 then Exit; {!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
 MsOff;
 BlockRead(f,mas,SizeConst);
 PutImage(41,0,Mas,0);
 BlockRead(f,mas,SizeConst);
 PutImage(41,180,Mas,0);
 BlockRead(f,mas,SizeConst);
 PutImage(41,320,Mas,0);
 Close(f);
 MsOn;
End;

procedure face;
 var i,j:integer;
 begin
  graphmode('d:\pascal\bgi');
  rea.INIT(5,455,20,'',5);
  but.INIT(2,3,38,17,'меню');
  setbkcolor(15);
  setpalette(15,cyan);
  setpalette(3,black);
  setpalette(11,darkgray);
  setpalette(8,lightgray);
  setpalette(7,lightcyan);
  setfillstyle(1,8);
  bar(0,0,40,480);
  path:='';
  NewKnop2(2,200,18,215,10,8,path+'karand');
  NewKnop2(22,200,38,215,10,8,path+'aaa');
  NewKnop2(2,220,18,235,10,8,path+'line');
  NewKnop2(22,220,38,235,10,8,path+'rectang');
  NewKnop2(2,240,18,255,10,8,path+'bar');
  NewKnop2(22,240,38,255,10,8,path+'randbar');
  NewKnop2(2,260,18,275,10,8,path+'okrug');
  NewKnop2(22,260,38,275,10,8,path+'krug');
  NewKnop2(2,280,18,295,10,8,path+'lines');
  NewKnop2(22,280,38,295,10,8,path+'lincolor');
  NewKnop2(2,300,18,315,10,8,path+'pshsh');
  NewKnop2(22,300,38,315,10,8,path+'pshcolor');
  NewKnop2(2,320,18,335,10,8,path+'fill');
{  NewKnop2(22,320,38,335,10,8,path+'aaa');}
  for i:=1 to 8 do
   for j:=0 to 1 do
   begin
    setfillstyle(1,(i+j*8));
    bar(4+j*17,7+i*17,15+j*17,17+i*17);
    setcolor(11);
    rectangle(2+j*17,5+i*17,17+j*17,19+i*17);
    rectangle(1+j*17,4+i*17,18+j*17,20+i*17);
   end;
  but.DA;
 end;

function grani(x,y:integer):boolean;
 begin
  grani:=false;
  if limitN(X,MinX,MaxX) and limitN(Y,MinY,MaxX) then grani:=true;
 end;{grani}

procedure pen;
 var x,y:integer;
 begin
  x:=MsX;y:=MsY;
  if (cloce=1) and grani(x,y) then
   begin
    MsWin(MinX,MinY,MaxX,MaxY);
    MoveTo(x,y);
    repeat
     x:=MsX;y:=MsY;
     MsOff;lineto(x,y);MsOn;
     repeat
     until (x<>MsX) or (y<>MsY);
    until  (cloce<>1);
    MsWin(0,0,GetMaxX,GetMaxY);
   end;
 end;{pen}
procedure figur(const figur:byte);
 type
  Tproc= procedure(m,n,x,y:integer);
 var
  x,y,m,n,xn,yn:integer;
  b:boolean;
  proc:Tproc;
 procedure rand(n,m,x,y:integer);
  var i,j:integer;
  begin
   randomize;
   for i:=1 to abs(x-n)*2 do
     begin
      setcolor(random(15)+1);
      line(n,m+random(abs(y-m)),x,y-random(abs(y-m)));
      line(n+random(abs(x-n)),m,x-random(abs(x-n)),y);
     end;
  end;
 begin
  case figur of
   1:proc:=line;
   2:proc:=rectangle;
   3:proc:=rectangle;
   4:proc:=rectangle;
  end;
  b:=false;
  setwritemode(1);
  if color=16 then setcolor(8);
  n:=MsX;
  m:=MsY;
  If (grani(MsX,MsY)) then
  while (cloce=1) do
   begin
    MsWin(MinX,MinY,MaxX,MaxY);
    b:=true;
    x:=MsX;
    y:=MsY;
    MsOff; proc(n,m,x,y); MsOn;
    repeat
    until ((x<>MsX) or (y<>MsY)) or (cloce<>1);
    MsOff; proc(n,m,x,y); MsOn;
    MsWin(0,0,GetMaxX,GetMaxY);
   end;
  setwritemode(0);
  if figur<>1 then
   begin
    xn:=x;yn:=y;
    if xn<n then begin x:=n; n:=xn; end;
    if yn<m then begin y:=m; m:=yn; end;
   end;
  setcolor(color);
  if b and grani(MsX,MsY) then
   begin
    MsOff; proc(n,m,x,y); MsOn;
    if figur=3 then
     begin
      MsOff; bar(n,m,x,y); MsOn;
     end;
    if figur=4 then
     begin
      MsOff; rand(n,m,x,y); MsOn;
     end;
   end;
 end;{figur}

procedure okrug(zapoln:boolean);
 var
  n,m,x,y,r:integer;
  b:boolean;
 procedure metki;
  var
   k:integer;
  begin
   k:=((r div 4) * 3);
   setwritemode(1);
   line(n-r,m,n+r,m);
   line(n,m-r,n,m+r);
   line(n+k+4,m+k-4,n+k-4,m+k+4);
   line(n-k-4,m-k+4,n-k+4,m-k-4);
   line(n-k+4,m+k+4,n-k-4,m+k-4);
   line(n+k+4,m-k+4,n+k-4,m-k-4);
   setwritemode(2);
  end;
 begin
  b:=false;
  n:=MsX;
  m:=MsY;
  while (cloce=1) and (grani(MsX,MsY)) do
   begin
    b:=true;
    x:=MsX;
    y:=MsY;
    r:=abs(MsY-m);
    MsOff; metki; MsOn;
    repeat
    until ((x<>MsX) or (y<>MsY)) or (cloce<>1);
    MsOff;metki; MsOn;
   end;
  if (b = true) then
   begin
    MsOff;
    SetViewPort(MinX,MinY,MaxX,MaxY,TRUE);
    if zapoln then pieSlice(n-MinX,m-MinY,0,360,r)
    else circle(n-MinX,m-MinY,r);
    SetViewPort(0,0,GetMaxX,GetMaxY,TRUE);
    MsOn;
   end;

 end;{figur}

procedure fill;
 var x,y:integer;
 begin
  x:=MsX; y:=MsY;
  if (cloce=1) and grani(x,y) then
   begin
    SetViewPort(Minx,MinY,MaxX,MaxY,true);
    MsOff;
    floodfill(x-MinX,y-MinY,color);
    MsOn;
    SetViewPort(0,0,GetMaxX,GetMaxY,true);
   end;
 end;

procedure linei(colors:boolean);
 var cvet,x,y,n,m,x1,y1:integer;
 begin
  n:=MsX;x:=MsX;x1:=x;
  m:=MsY;y:=MsY;y1:=y;
  If (grani(n,m) and grani(x,y)) then
  while (cloce=1) do
   begin
    MsWin(MinX,MinY,MaxX,MaxY);
    MsOff;
    line(x,y,x1,y1);
    MsOn;
    cvet:=cvet+1;
    if cvet>15 then cvet:=1;
    if colors then setcolor(cvet);
    MsOff;
    line(n,m,x,y);
    x1:=x;y1:=y;
    MsOn;
    repeat
    until (x<>MsX) or (y<>MsY);
    x:=MsX;
    y:=MsY;
    MsWin(0,0,GetMaxX,GetMaxY);
   end;
 end;

procedure Pshsh(colors:boolean);
 var
 x,y,xrand,yrand,i,cvet:integer;
 begin
  x:=MsX;y:=MsY;
  if (cloce=1) and grani(x,y) then
   begin
   MsWin(MinX+20,MinY+10,GetMaxX,GetMaxY);
    randomize;
    repeat
     for i:=1 to 20 do
      begin
       delay(1);
       if (x<>MsX) or (y<>MsY) then break;
       if cloce<>1 then break;
      end;
     xrand:=random(20)-10;
     yrand:=random(20)-10;
     if colors then cvet:=random(15)+1
     else cvet:=color;
     MsOff; putpixel(x+xrand-yrand,y+yrand+xrand,cvet); MsOn;
     x:=MsX;y:=MsY;
    until (cloce<>1);
    MsWin(0,0,GetMaxX,GetMaxY);
   end;
 end;{pen}

procedure palitra;
 var
  i,j:integer;
 begin
 setlinestyle(0,0,1);
 if (cloce=1) and (limitN(MsX,1,35) and limitN(MsY,21,156)) then
  for i:=1 to 8 do
   for j:=0 to 1 do
     begin
      MsOff;
      setcolor(11);
        rectangle(2+j*17,5+i*17,17+j*17,19+i*17);
        rectangle(1+j*17,4+i*17,18+j*17,20+i*17);
      MsOn;
      if limitN(MsX,2+j*17,18+j*17) and limitN(MsY,5+i*17,20+i*17) then
       begin
        MsOff;
        setcolor(10);
        rectangle(2+j*17,5+i*17,17+j*17,19+i*17);
        rectangle(1+j*17,4+i*17,18+j*17,20+i*17);
        color:=(i+j*8);
        setfillstyle(1,color);
        bar(1,160,38,194);
        MsOn;
       end
     end;
 end;

procedure aaa;
 begin
  if (cloce=1) and (Grani(MsX,MsY)) then
   begin
    MsOff;
    GRread(MsX,MsY,MaxX);
    MsOn;
   end;
 end;

procedure linetip;
 var i:integer;
     lin:LineSettingsType;
 procedure _linetip;
  var i:integer;
  begin
   setfillstyle(1,8);
   bar(0,343,40,475);
   for i:=0 to 3 do
    begin
     setcolor(10);
     if tipline=i then rectangle(5,(360+i*20)-4,35,(360+i*20)+4);
     setlinestyle(i,0,1);
     setcolor(1);
     line(5,360+i*20,35,360+i*20);
    end;
   for i:=2 to 3 do
    begin
     setlinestyle(tipline,0,i);
     setcolor(1);
     line(5,410+i*19,35,410+i*19);
     setcolor(10);
     if tolline=i then rectangle(5,(410+i*19)-5,35,(410+i*19)+5);
    end;
   setlinestyle(tipline,0,1);
  end;
 begin
 if reinstr then _linetip;
  if ((cloce=1) and limitN(MsX,5,35)) and limitN(MsY,360,424) then
    for i:=0 to 3 do
     begin
      MsOff;
      if i=0 then _linetip;
      setcolor(10);
      if limitN(MsX,5,35) and limitN(MsY,(360+i*20)-9,(360+i*20)+9) then
       begin
        rectangle(5,(360+i*20)-4,35,(360+i*20)+4);
        tipline:=i;
       end;
      MsOn;
     end;
  if ((cloce=1) and limitN(MsX,5,35)) and limitN(MsY,440,475) then
  for i:=2 to 3 do
    begin
     MsOff;
     if i=2 then _linetip;
     setlinestyle(tipline,0,i);
     setcolor(10);
     if limitN(MsX,5,35) and limitN(MsY,(410+i*19)-9,(410+i*19)+9) then
      begin
       rectangle(5,(410+i*19)-5,35,(410+i*19)+5);
       tolline:=i;
      end;
     MsOn;
    end;
 end;

procedure tipfill;
 const x1=2; y1=350;
 var i,j:integer;
     strin:string;
 begin
 if (limitN(MsX,x1,x1+35) and limitN(MsY,y1,y1+115)) or reinstr then
 for j:=0 to 1 do
 for i:=0 to 5 do
   begin
    if reinstr then
      begin
       setfillstyle(1,8);
       if (i=0) and (j=0) then bar(x1-5,y1-12,x1+38,y1+130);
       setfillstyle(i+j*6,1);
       bar(x1+20*j,y1+i*20,x1+15+20*j,y1+15+i*20);
      end;
    if (cloce=1) then
    if (limitN(MsX,x1+20*j,x1+15+20*j) and limitN(MsY,y1+i*20,y1+15+i*20))
    or ((filltip=(i+j*6)) and reinstr) then
     begin
      MsOff;
      setcolor(10);
      rectangle(x1+20*j-2,y1+i*20-2,x1+15+20*j+2,y1+15+i*20+2);
      rectangle(x1+20*j-1,y1+i*20-1,x1+15+20*j+1,y1+15+i*20+1);
      MsOn;
      filltip:=i+j*6;
     end
    else
      begin
      MsOff;
      setcolor(8);
      rectangle(x1+20*j-2,y1+i*20-2,x1+15+20*j+2,y1+15+i*20+2);
      rectangle(x1+20*j-1,y1+i*20-1,x1+15+20*j+1,y1+15+i*20+1);
      MsOn;
      end;
    MsOn;
   end;
 end;

procedure AAAtip;
 const X0=5; Y0=345;
 var
  x,y,i:integer;
  ChSize:integer;
  InfoText:TextSettingsType;
  Function strinN(strin:String):Integer;
  Begin
   If Length(strin)=1  then strinN:=(ord(strin[1])-48)
   else strinN:=((ord(strin[1])-48)*10)+((ord(strin[2])-48))
  End;
  procedure drow;
   var i:integer;
   begin
    MsOff;
    setfillstyle(1,8);
    bar(0,345,40,475);
    setcolor(11);
    rectangle(2,343,38,475);
    for i:=0 to 4 do
     begin
      setcolor(11);
      y:=y0+i*18;
      if i=0 then ChSize:=2
      else if i=2 then ChSize:=8
      else ChSize:=1;
      settextstyle(i,0,ChSize);
      OutTextXY(x0,y+i*2,'aa');
      setcolor(8);
      rectangle(x0-2,(y0+i*23)-i,x0+32,(y0+(i+1)*22)-i);
     end;
    setcolor(10);
    for i:=0 to 4 do if tipText=i then
    rectangle(x0-2,(y0+i*23)-i,x0+32,(y0+(i+1)*22)-i);
    rea.DRAW(TRUE);
    MsOn;
   end;
 begin
  rea.DA;
  If rea.Stroka <> '' then
   Begin
    CharSize:=StrinN(rea.Stroka);
    SetTextStyle(TipLine,0,TolLine)
    End;
  GetTextSettings(InfoText);
  if reinstr then drow;
  for i:=0 to 4 do
   begin
    if (cloce=1) and limitN(MsX,x0-2,x0+32) and limitN(MsY,(y0+i*23)-i,(y0+(i+1)*22)-i)
    then
     begin
      SetTextStyle(i,0,2);
      GetTextSettings(InfoText);
      tipText:=i;
      drow;
      SetTextStyle(TipLine,0,CharSize);
     end;
   end;

 end;



procedure instrument;
 var
  instr1:string;
 begin
  reinstr:=false;
  instr1:=knopka;
  if instr1<>'' then
    begin
     activet(instr,true);
     instr:=instr1;
     activet(instr,false);
     reinstr:=true;
    end;
  SetColor(Color);
  SetTextStyle(TipText,0,CharSize);
  SetLineStyle(tipLine,0,tolLine);
  if instr=path+'karand' then pen else
  if instr=path+'line' then figur(1) else
  if instr=path+'rectang' then figur(2) else
  if instr=path+'bar' then figur(3) else
  if instr=path+'randbar' then figur(4) else
  if instr=path+'okrug' then okrug(false) else
  if instr=path+'krug' then okrug(true) else
  if instr=path+'lines' then linei(false) else
  if instr=path+'lincolor' then linei(true) else
  if instr=path+'pshsh' then pshsh(false) else
  if instr=path+'pshcolor' then pshsh(true) else
  if instr=path+'fill' then fill else
  if instr=path+'aaa' then aaa;
  if (instr<>path+'bar') and (instr<>path+'krug') and (instr<>path+'fill')
  and (instr<>path+'aaa') then linetip else
  if(instr<>path+'aaa') then tipfill else AAAtip;
  setfillstyle(filltip,color);
  setlinestyle(tipline,0,tolline);
 end;


Function menu:Integer;
 Var
  win:TWindow;
  strin:String;
 Begin
  MsOff;
  menu:=0;
  win.INIT(160,250,'Menu');
  win.buts.creat(10,25,150,55,'создать','1');
  win.buts.creat(10,70,150,100,'открыть','2');
  win.buts.creat(10,115,150,145,'сохранить','3');
  win.buts.creat(10,160,150,190,'сохранить как?','4');
  win.buts.creat(10,205,150,235,'ВЫХОД','5');
  win.Move(230,100);
  MsOn;
 Repeat
  strin:=win.DA('');
 Until strin<>'';
  menu:=Ord(strin[1])-48;
  If strin='exit' then menu:=0;
  Win.Done;
 End;

Procedure Save;
 Var
  win:TWindow;
  strin:String;
 Begin
  MsOff;
  win.INIT(500,45,'Под каким именем вы хототе сохранить файл:             ');
  win.reads.Creat(10,25,400,'',5,'1');
  win.buts.Creat(420,22,496,41,'Сохранить','2');
  MsOn;
  Repeat
   strin:=win.DA('');
   FileName:=win.reads.Stroka('1');
  Until strin<>'';
  win.Done;
  If FileName<>'' then SaveImage(FileName);

 End;

Function Open:String;
 Var
  win:TWindow;
  strin:String;
 Begin
  MsOff;
  win.INIT(500,45,'Введите имя файла, который следует открыть:             ');
  win.reads.Creat(10,25,400,'',5,'1');
  win.buts.Creat(420,22,496,41,'Открыть','2');
  MsOn;
  Repeat
   strin:=win.DA('');
   FileName:=win.reads.Stroka('1');
  Until strin<>'';
  win.Done;
  If FileName<>'' then OpenImage(FileName);

 End;

Procedure Hallo;
 Var
  disk,strin:String;
 Begin
  GetDir(0,strin);
  OpenImage('hallo');
 End;


Var
 win:TWindow;
 strin:String;
 men:Integer;
begin
 color:=1;
 filltip:=1;
 face;
 Hallo;
 setcolor(2);
 instr:='';
 tolline:=2;
 tipfill;
 settextstyle(1,0,10);
 win.INIT(240,90,'Добро пожаловать!');
 win.buts.creat(20,30,220,70,'Приступить к работе','go');
 win.Move(170,150);
 MsOn;
 Repeat
  strin:=win.DA('');
 Until (strin='go') or (strin='exit');
 Win.Done;
 initmouse;
 repeat
  If but.DA then
   Begin
    men:=menu;
    Case men of
     1:Begin
        MsOff;
        SetFillStyle(1,0);
        Bar(40,0,GetMaxX,GetMaxY);
        FileName:='';
        MsOn;
      End;
     2:Open;
     3:If men=3 then If FileName<>'' then SaveImage(FileName)
       else Save;
     4:Save;
     5:Exit;   {!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
    End;
   End;
  palitra;
  instrument;
 until FALSE;
end.