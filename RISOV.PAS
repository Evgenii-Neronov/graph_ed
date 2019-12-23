{ Программа - <Risov> }                              { Неронов Е.Ю  08.05.03 }
Unit Risov;
Interface
Uses Crt,Graph,Neronov,Mouse;
 Var nowColur,nowFill,styleLine,tolLine:Integer;


 Function GRread(Const x0,y0,Xmax:Integer):String;

 Procedure Coorsor(x,y:Integer);
 Procedure Karand(colur,x1,y1,x2,y2:Integer);
 Procedure Lin(colur,x1,y1,x2,y2:Integer);
 Procedure Rect(colur,x1,y1,x2,y2:Integer);
 Procedure Baric(colur,fill,x1,y1,x2,y2:Integer);
 Procedure Circl(colur,x1,y1,x2,y2:Integer);
 Procedure FillCircl(colur,fill,x1,y1,x2,y2:Integer);
 Procedure Ellips(colur,x1,y1,x2,y2:Integer);
 Procedure Pshsh(colur,x1,y1,x2,y2:Integer);
 Procedure ColurPsh(colur,x1,y1,x2,y2:Integer);
 Procedure Linei(colur,x1,y1,x2,y2:Integer);
 Procedure ColorLinei(colur,x1,y1,x2,y2:Integer);
 Procedure Fills(colur,fill,x1,y1,x2,y2:Integer);

Type
 TKarand = Object    {Класс "TKarand"}
  Private
   colur:Integer;
   x1,y1,x2,y2:Integer;
   Function RisBool(x,y:Integer):Boolean; Virtual;
   Procedure Win(bool:Boolean); Virtual;
   Procedure Ris; Virtual;
  Public
   Constructor INIT(colur1,x1_,y1_,x2_,y2_:Integer);
   Destructor Done;
   Function  GetColur:Integer;
   Procedure SetColur(colur1:Integer);
   Procedure SetWin(x1_,y1_,x2_,y2_:Integer);
   Procedure DA;
 End;

 TLine = Object(TKarand) {Класс "TLine" }
  Private
   StyleL:LineSettingsType;
   Procedure Ris; Virtual;
   Procedure Figur(n,m,x,y:Integer;bool:Boolean); Virtual;
  Public
   Procedure SetLS(LS,Pattern,Thickness:Integer);
 End;

 TRectangle = Object(TLine) { Класс "TRectangle(TLine)" }
  Private
   Procedure Figur(n,m,x,y:Integer;bool:Boolean); Virtual;
 End;

 TBar = Object(TRectangle) { Класс "TBar(TRectangle)"}
  Private
   StyleF:FillSettingsType;
   Procedure Ris; Virtual;
   Procedure Figur2(n,m,x,y:Integer); Virtual;
  Public
   Procedure SetFS(Pattern,Color:Integer);
 End;

 TCircle = Object(TBar){ Класс TCircle(TBar) }
  Private
   Procedure Figur(n,m,x,y:Integer;bool:Boolean); Virtual;
   Procedure Figur2(n,m,x,y:Integer); Virtual;
 End;

 TCircleFill = Object(TCircle){ Класс TCircleFill }
  Private
   Procedure Figur2(n,m,x,y:Integer); Virtual;
 End;

 TEllipse = Object(TBar){ Класс TEllipse(TCircleFill) }
  Private
   Procedure Figur(n,m,x,y:Integer;bool:Boolean); Virtual;
   Procedure Figur2(n,m,x,y:Integer); Virtual;
 End;

 TRandPix = Object(TKarand) {Класс TRandPix(TKarand)}
  Private
   Colors:Boolean;
   Procedure Ris; Virtual;
  Public
   Procedure SetColors(Colors1:Boolean);
 End;


Implementation

 Procedure Karand(colur,x1,y1,x2,y2:Integer);
  Var
   kar:TKarand;
  Begin
   kar.INIT(colur,x1,y1,x2,y2);
   kar.DA;
   kar.Done;
  End;{Karand(colur,x1,y1,x2,y2:Integer);}

 Procedure Lin(colur,x1,y1,x2,y2:Integer);
  Var
   lin:TLine;
  Begin
   lin.INIT(colur,x1,y1,x2,y2);
   lin.DA;
   lin.Done;
  End;{Lin(colur,x1,y1,x2,y2:Integer);}

 Procedure Rect(colur,x1,y1,x2,y2:Integer);
  Var
   rec:TRectangle;
  Begin
   rec.INIT(colur,x1,y1,x2,y2);
   rec.DA;
   rec.Done;
  End;{Rect(colur,x1,y1,x2,y2:Integer);}
 Procedure Baric(colur,fill,x1,y1,x2,y2:Integer);
  Var
   bar:TBar;
  Begin
   bar.INIT(GetColor,x1,y1,x2,y2);
   bar.SetFS(colur,fill);
   bar.DA;
   bar.Done;
  End;

 Procedure Circl(colur,x1,y1,x2,y2:Integer);
  Var
   cir:TCircle;
  Begin
   cir.INIT(colur,x1,y1,x2,y2);
   cir.DA;
   cir.Done;
  End;{Circl(colur,x1,y1,x2,y2:Integer);}

 Procedure FillCircl(colur,fill,x1,y1,x2,y2:Integer);
  Var
   fillcir:TCircleFill;
  Begin
   fillCir.INIT(colur,x1,y1,x2,y2);
   fillCir.SetFS(colur,fill);
   fillCir.DA;
   fillCir.Done;
  End;{FillCircl(colur,fill,x1,y1,x2,y2:Integer);}

 Procedure Ellips(colur,x1,y1,x2,y2:Integer);
  Var
   ell:TEllipse;
  Begin
   ell.INIT(colur,x1,y1,x2,y2);
   ell.DA;
   ell.Done;
  End;{Ellips(colur,x1,y1,x2,y2:Integer);}

 Procedure Pshsh(colur,x1,y1,x2,y2:Integer);
  Var
   psh:TRandPix;
  Begin
   psh.INIT(colur,x1,y1,x2,y2);
   psh.SetColors(FALSE);
   psh.DA;
   psh.Done;
  End;{Pshsh(colur,x1,y1,x2,y2:Integer);}

 Procedure ColurPsh(colur,x1,y1,x2,y2:Integer);
  Var
   colurPsh:TRandPix;
  Begin
   colurPsh.INIT(colur,x1,y1,x2,y2);
   colurPsh.SetColors(TRUE);
   colurPsh.DA;
   colurPsh.Done;
  End;{ColurPsh(colur,x1,y1,x2,y2:Integer);}

 Procedure Linei(colur,x1,y1,x2,y2:Integer);
 Var cvet,x,y,n,m,n1,m1:integer;
 Begin
  n:=MsX;x:=MsX;n1:=x;
  m:=MsY;y:=MsY;m1:=y;
  While (cloce=1) and LimitN(x,x1,x2) and LimitN(y,y1,y2) do
   Begin
    MsWin(x1,y1,x2,y2);
    MsOff;
    line(x,y,n1,m1);
    MsOn;
    cvet:=cvet+1;
    If cvet>15 then cvet:=1;
    MsOff;
    line(n,m,x,y);
    n1:=x;m1:=y;
    MsOn;
    Repeat
    Until (x<>MsX) or (y<>MsY);
    x:=MsX;
    y:=MsY;
    MsWin(0,0,GetMaxX,GetMaxY);
   End;
  End;{Linei(colur,x1,y1,x2,y2:Integer);}

 Procedure ColorLinei(colur,x1,y1,x2,y2:Integer);
 Var cvet,x,y,n,m,n1,m1:integer;
 Begin
  n:=MsX;x:=MsX;n1:=x;
  m:=MsY;y:=MsY;m1:=y;
  While (cloce=1) and LimitN(x,x1,x2) and LimitN(y,y1,y2)  do
   Begin
    MsWin(x1,y1,x2,y2);
    MsOff;
    line(x,y,n1,m1);
    MsOn;
    cvet:=cvet+1;
    If cvet>15 then cvet:=1;
    setcolor(cvet);
    MsOff;
    line(n,m,x,y);
    n1:=x;m1:=y;
    MsOn;
    Repeat
    Until (x<>MsX) or (y<>MsY);
    x:=MsX;
    y:=MsY;
    MsWin(0,0,GetMaxX,GetMaxY);
   End;
   End;{ColorLinei(colur,x1,y1,x2,y2:Integer);}

 Procedure Fills(colur,fill,x1,y1,x2,y2:Integer);
  Var x,y:integer;
  Begin
   x:=MsX; y:=MsY;
   If (cloce=1) and LimitN(x,x1,x2) and LimitN(y,y1,y2) then
    Begin
     SetViewPort(x1,y1,x2,y2,TRUE);
     MsOff;
     SetFillStyle(fill,colur);
     FloodFill(x-x1,y-y1,colur);
     MsOn;
     SetViewPort(0,0,GetMaxX,GetMaxY,TRUE);
    End;

   End;{Fills(colur,fill,x1,y1,x2,y2:Integer);}




{ Методы для класса TKarand }
 Constructor TKarand.INIT(colur1,x1_,y1_,x2_,y2_:Integer);
  Begin
   colur:=colur1;
   x1:=x1_; x2:=x2_;
   y1:=y1_; y2:=y2_;
  End;{TKarand.INIT(colur1,x1_,y1_,x2_,y2_:Integer);}

 Destructor TKarand.Done;
  Begin
  End;
 Function  TKarand.RisBool(x,y:Integer):Boolean;
  Begin
   RisBool:=LimitN(x,x1,x2) and LimitN(y,y1,y2) and (Cloce=1);
  End;{TKarand.RisBool(x,y:Integer):Boolean;}

 Function  TKarand.GetColur:Integer;
  Begin
   GetColur:=colur;
  End;{TKarand.GetColur:Integer;}

 Procedure TKarand.Win(bool:Boolean);
  Begin
   If bool then MsWin(x1,y1,x2,y2)
   else MsWin(0,0,GetMaxX,GetMaxY);
  End;{TKarand.Win(bool:Boolean);}

 Procedure TKarand.Ris;
  Var x,y:Integer;
  Begin
   Repeat
    x:=MsX; y:=MsY;
    MsOff; LineTo(x,y); MsOn;
    Repeat Until (MsX<>x) or (MsY<>y) or (Cloce<>1);
   Until Cloce<>1;
  End;{TKarand.Ris;}

 Procedure TKarand.SetColur(Colur1:Integer);
  Begin
   colur:=colur1;
  End;{TKarand.SetColur(Colur1:Integer);}


 Procedure TKarand.SetWin;
  Begin
   x1:=x1_;y1:=y1_;
   x2:=x2_;y2:=y2_;
  End;{TKarand.SetWin;}

 Procedure TKarand.DA;
  Begin
   If RisBool(MsX,MsY) then
    Begin
     Win(TRUE);
     SetColor(Colur);
     MoveTo(MsX,MsY);
     Ris;
     Win(FALSE);
    End;{TKarand.DA;}
  End;

{ Методы для Класса TLine(TKarand) }
 Procedure TLine.Ris;
  Var
   n,m,x,y:Integer;
  Begin
   n:=MsX; m:=MsY;
   SetWriteMode(1);
   Repeat
    x:=MsX; y:=MsY;
    MsOff; Figur(n,m,x,y,TRUE); MsOn;
    Repeat Until (Cloce<>1) or (MsX<>x) or (MsY<>y);
    MsOff; Figur(n,m,x,y,TRUE); MsOn;
   Until (Cloce<>1);
   SetWriteMode(0);
   MsOff; Figur(n,m,x,y,FALSE); MsOn;
  End;{TLine.Ris;}

 Procedure TLine.Figur(n,m,x,y:Integer;bool:Boolean);
  Begin
   SetLineStyle(StyleL.LineStyle,StyleL.Pattern,StyleL.Thickness);
   If bool then SetWriteMode(1);
   Line(n,m,x,y);
   If bool then SetWriteMode(0);
  End;{TLine.Figur(n,m,x,y:Integer;bool:Boolean);;}

 Procedure TLine.SetLS(LS,Pattern,Thickness:Integer);
  Begin
   StyleL.LineStyle:=LS;
   StyleL.Pattern:=Pattern;
   StyleL.Thickness:=Thickness;
  End;{TLine.SetLS(LineStyle1:Integer);}


{ Методы для Класса TRectangle(TLine) }
 Procedure TRectangle.Figur(n,m,x,y:Integer;bool:Boolean);
  Begin
   SetLineStyle(StyleL.LineStyle,StyleL.Pattern,StyleL.Thickness);
   If bool then SetWriteMode(1);
   Rectangle(n,m,x,y);
   If bool then SetWriteMode(0);
  End;{TRectangle.Figur(n,m,x,y:Integer;bool:Boolean);}


{Методы для класса "TBar(TRectangle)"}
 Procedure TBar.Figur2(n,m,x,y:Integer);
  Begin
   SetFillStyle(StyleF.Pattern,StyleF.Color);
   Bar(n,m,x,y);
  End;{Figur2}

 Procedure TBar.SetFS(Pattern,Color:Integer);
  Begin
   StyleF.Pattern:=Pattern;
   StyleF.Color:=Color;
  End;{TBar.SetFS(Pattern,Color);}

 Procedure TBar.Ris;
  Var
   n,m,x,y:Integer;
  Begin
   n:=MsX; m:=MsY;
   SetWriteMode(1);
   Repeat
    x:=MsX; y:=MsY;
    MsOff; Figur(n,m,x,y,TRUE); MsOn;
    Repeat Until (Cloce<>1) or (MsX<>x) or (MsY<>y);
    MsOff; Figur(n,m,x,y,TRUE); MsOn;
   Until (Cloce<>1);
   SetWriteMode(0);
   MsOff; Figur2(n,m,x,y); MsOn;
  End;{TLine.Ris;}


{ Методы для класса TCircle(TBar) }
 Procedure TCircle.Figur(n,m,x,y:Integer;bool:Boolean);
  Var k:Integer;
  Begin
   If bool then SetWriteMode(1);
    Line(n+(n-x),m,x,m);
    Line(n,m-(n-x),n,m+(n-x));
    k:=(((n-x) div 4) * 3);
    line(n+k+4,m+k-4,n+k-4,m+k+4);
    line(n-k-4,m-k+4,n-k+4,m-k-4);
    line(n-k+4,m+k+4,n-k-4,m+k-4);
    line(n+k+4,m-k+4,n+k-4,m-k-4);
   If bool then SetWriteMode(0);
  End;{TCircle.Figur(n,m,x,y:Integer;bool:Boolean);}

 Procedure TCircle.Figur2(n,m,x,y:Integer);
  Var radX:Integer;
  Begin
   If x>n then radX:=x-n
   Else radX:=n-x;
   SetViewPort(x1,y1,x2,y2,TRUE);
   Circle(n-x1,m-y1,radX);
   SetViewPort(0,0,GetMaxX,GetMaxY,TRUE);
  End;{TCircle.Figur2(n,m,x,y:Integer);}


{ Методы для класса TCircleFill }
 Procedure TCircleFill.Figur2(n,m,x,y:Integer);
  Var radX:Integer;
  Begin
   SetFillStyle(StyleF.pattern,StyleF.Color);
   SetColor(StyleF.Color);
   If x>n then radX:=x-n
   Else radX:=n-x;
   SetViewPort(x1,y1,x2,y2,TRUE);
   PieSlice(n-x1,m-y1,0,360,radX);
   SetColor(StyleF.Color);
   Line(n-x1,m-y1,n-x1+radX,m-y1);
   SetViewPort(0,0,GetMaxX,GetMaxY,TRUE);
  End;{TCircle.Figur2(n,m,x,y:Integer);}


{ Методы для класса TEllipse(TCircleFill) }
 Procedure TEllipse.Figur(n,m,x,y:Integer;bool:Boolean);
  Var k:Integer;
  Begin
   If bool then SetWriteMode(1);
    Line(n+(n-x),m,x,m);
    Line(n,m-(m-y),n,m+(m-y));
   If bool then SetWriteMode(0);
  End;{TCircle.Figur(n,m,x,y:Integer;bool:Boolean);}

 Procedure TEllipse.Figur2(n,m,x,y:Integer);
  Var radX,radY:Integer;
  Begin
   SetColor(colur);
   If x>n then radX:=x-n
   Else radX:=n-x;
   If y>m then radY:=y-m
   Else radY:=m-y;
   SetViewPort(x1,y1,x2,y2,TRUE);
   Ellipse(n-x1,m-y1,0,360,radX,radY);
   SetViewPort(0,0,GetMaxX,GetMaxY,TRUE);
  End;{TCircle.Figur2(n,m,x,y:Integer);}

 Procedure TRandPix.Ris;
  Var xRand,yRand,cvet,i,x,y:Integer;
  Begin
   x:=MsX;y:=MsY;
   For i:=1 to 10 do
    Begin
     Delay(1);
     If (x<>MsX) or (y<>MsY) then Break;
     If Cloce<>1 then Exit;
    end;
   xRand:=Random(30)-15;
   yRand:=Random(30)-15;
   If colors then cvet:=Random(15)+1
   Else cvet:=colur;
   MsOff;
   If LimitN(x+xRand,x1,x2) and LimitN(y+yRand,y1,y2)
   then PutPixel(x+xRand,y+yRand,cvet);
   MsOn;
  End;{TRandPix.Ris;}

 Procedure TRandPix.SetColors(colors1:boolean);
  Begin
   colors:=colors1;
  End;{TRandPix.SetColors(colors1:boolean);}


procedure Coorsor(x,y:Integer);
 var i:integer;
     b:boolean;
 begin
  repeat
   b:=false;
   SetWriteMode(1);
   line(x,y,x,y+TextHeight('█'));
   for i:=1 to 500 do
    begin
     delay(1);
     if keypressed then b:=true;
     if b=true then break;
    end;
   line(x,y,x,y+TextHeight('█'));
   for i:=1 to 500 do
    begin
     delay(1);
     if keypressed then b:=true;
     if b=true then break;;
    end;
   SetWriteMode(0);
  until b=true;
 end;{procedure Coorsor(x,y:Integer);}

Function GRread(Const x0,y0,Xmax:Integer):String;
 type
  Tlist=^Trec;
  Trec=record
    ch:char;
    p:pointer;
    next:Tlist;
  end;
 var
  x,y,s:integer;
  list,now:tlist;
  key:char;
  strin:string;
  TextInfo:TextSettingsType;
  bool:boolean;
 begin
  x:=x0;
  list:=nil;
  repeat
   coorsor(x,y0);
   key:=readkey;
   bool:=((ord(key)>31) and (x<GetMaxX-TextWidth(key)) and
         (x<(XMax-TextWidth(key))));
   if bool then
    begin
     new(now);
     now^.ch:=key;
     s:=imagesize(x,y0,x+TextWidth(now^.ch),y0+TextHeight(now^.ch));
     getmem(now^.p,s);
     getimage(x,y0,x+TextWidth(now^.ch),y0+TextHeight(now^.ch),now^.p^);
     now^.next:=list;
     list:=now;
     GetTextSettings(TextInfo);
     if TextInfo.font>0 then y:=y0-TextHeight(now^.ch) div 4
     else y:=y0;
     outtextXY(x,y,now^.ch);
     x:=x+TextWidth(now^.ch);
    end
   else
    if (key=#8) and (list<>nil) then
     begin
      s:=imagesize(x,y0,x+TextWidth(list^.ch),y0+TextHeight(list^.ch));
      x:=x-TextWidth(list^.ch);
      putimage(x,y0,list^.p^,0);
      now:=list;
      list:=list^.next;
      freemem(now^.p,s);
      dispose(now);
     end
    else
     if key=#13 then
      begin
       strin:='';
       while list<>nil do
        begin
         strin:=list^.ch+strin;
         list:=list^.next;
        end;
      end;
  until key=#13;
  GRread:=strin;
 end;{  Function GRread(x0,y:Integer):String; }




End.
