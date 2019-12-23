unit neronov;

interface
 uses graph,crt;

 procedure GraphMode(paht:string);
 procedure Coorsor(x,y:integer);
 function GRread(const x0,y0,Xmax:integer):string;
 function limitN(n,min,max:integer):boolean;

implementation
 uses dos;

procedure GraphMode(paht:string);
 var
  grDrive,grMode:integer;
 begin
  grDrive:=0;grMode:=0;
  if paht<>'' then initgraph(grDrive,grMode,paht)
   else closegraph;
 end;
procedure coorsor(x,y:integer);
 var i:integer;
     b:boolean;
 begin
  repeat
   b:=false;
   SetWriteMode(1);
   line(x,y,x,y+TextHeight('Û'));
   for i:=1 to 500 do
    begin
     delay(1);
     if keypressed then b:=true;
     if b=true then break;
    end;
   line(x,y,x,y+TextHeight('Û'));
   for i:=1 to 500 do
    begin
     delay(1);
     if keypressed then b:=true;
     if b=true then break;;
    end;
   SetWriteMode(0);
  until b=true;
 end;

function GRread(const x0,y0,Xmax:integer):string;
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
 end;{  function GRread(x0,y:integer):string; }
function limitN(n,min,max:integer):boolean;
 var i:integer;
 begin
  limitN:=false;
  for i:=min to max do if n=i then limitN:=true;
 end;
END.


