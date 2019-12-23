{ Модуль - <Mouse> }                               { Неронов Е.Ю.  04.05.03 }
Unit Mouse;
InterFace
Uses Dos;

   Procedure MsOn;{Показать курсор}
   Procedure MsOff;{Спрятать курсор}
   Procedure InitMouse;{Сменить изображене курсора на <<прицел>> }
   Procedure MsSendXY(x,y:Integer);{ Указать координаты }
   Procedure MsReXY(var x_,y_:Integer);{  Относительное изменение координат  }
   Procedure MsWin(x1,y1,x2,y2:Integer);{  Указание границ передвижения мыши }
   Function cloce:Byte; { Номер кнопки, нажатой на мыши }
   Function MsX:Integer;{ возвращает значение Х, на которой находится мышь}
   Function MsY:Integer;{ возвращает значение Y, на которой находится мышь}

Implementation

Var
 x,y:Integer;
 r:Registers;

Procedure Mouse1(ax:Integer; Var x,y:Integer);
 Begin
  r.ax:=ax; r.cx:=x; r.dx:=y;
  intr($33,r);
  ax:=r.ax; x:=r.cx; y:=r.dx;
 End;{Mouse1}

Procedure MsOn;
 Begin
  Mouse1(1,x,y);
 End;{MsOn}

Procedure MsOff;
 Begin
  Mouse1(2,x,y);
 End;{MsOff}

Procedure MsSendXY(x,y:Integer);
 Begin
  Mouse1(4,x,y);
 End;{MsSendXY}

Procedure MsWin(x1,y1,x2,y2:Integer);
 Begin
  Mouse1(7,x1,x2);
  Mouse1(8,y1,y2);
 End;{MsWin}

Procedure InitMouse;
Const
  kyrsor:Array[1..64] of byte =
   (255,255,63,252,159,249,207,243,247,239,243,207,249,159,253,191,
   253,191,249,159,243,207,247,239,207,243,159,249,63,252,255,255,
   0,0,192,3,100,38,56,28,24,24,44,52,70,98,2,64,
   2,64,70,98,44,52,24,24,56,28,100,38,192,3,0,0);
  Begin
   r.ax:=9;
   r.bx:=9;
   r.cx:=9;
   r.es:=seg(kyrsor);
   r.dx:=ofs(kyrsor);
   Intr($33,r);
   Mouse1(4,x,y);
  End;{InitMouse}

Function MsX:Integer;
 Begin
  mouse1(3,x,y);
  MsX:=x;
 End;{MsX:Integer}

Function MsY:Integer;
 Begin
  mouse1(3,x,y);
  MsY:=y;
 End;{MsY:Integer}

Function cloce:Byte;
 Begin
  r.ax:=3;
  Intr($33,r);
  cloce:=r.bx;
 End;{Cloce:Byte}

Procedure MsReXY(var x_,y_:Integer);
 Var x1,y1:integer;
 Begin
  x1:=r.cx;
  y1:=r.dx;
  mouse1(3,x,y);
  x_:=x-x1;
  y_:=y-y1;
 End;{MsReXY}
End.
