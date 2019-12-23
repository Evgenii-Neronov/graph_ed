unit clicebar;
interface
type
 Tmas=array[1..190] of byte;

  function knopka:string;

  procedure NewKnop(x_1,y_1,x_2,y_2:integer;FAC1,FPC1,TAC1,TPC1:byte;strin1:string{;Mas:Tmas});

  procedure delknop(strin:string);

  procedure activet(strin:string;b:boolean);

  procedure NewKnop2(x_1,y_1,x_2,y_2,FAC1,FPC1:integer;strin1:string);


type
 Tknopki=^Tclicebar;
 Tclicebar = record
   x1,y1,x2,y2:integer;
   strin:string;
   act_pas:boolean;
   FPC:byte;
   FAC:byte;
   TPC:byte;
   TAC:byte;
   next:Tknopki;
   active:boolean;
   izob:boolean;
 end;

var
 knop:Tknopki;

implementation

uses graph,neronov,mouse;

function knopka:string;
 var
 p:Tknopki;
 begin
  setlinestyle(0,0,1);
  knopka:='';
  p:=knop;
    while (p<>nil) do
     begin
      if p^.active then
      if ((limitN(MsX,p^.x1,p^.x2) and limitN(MsY,p^.y1,p^.y2))=false) and (p^.act_pas) then
       begin
        Msoff;
        if p^.izob then
         begin
          setcolor(P^.FPC);
          rectangle(p^.x1-2,p^.y1-2,p^.x2+2,p^.y2+2);
          rectangle(p^.x1-1,p^.y1-1,p^.x2+1,p^.y2+1);
          end
        else
         begin
          setfillstyle(1,p^.FPC);
          setcolor(p^.TPC);
          bar(p^.x1,p^.y1,p^.x2,p^.y2);
          outtextXY(p^.x1+2,p^.y1+2,p^.strin);
         end;
         p^.act_pas:=false;
         MsOn;
       end
      else
      if (limitN(MsX,p^.x1,p^.x2) and limitN(MsY,p^.y1,p^.y2)) and (p^.act_pas=false) then
       begin
        Msoff;
        if p^.izob then
         begin
          setcolor(P^.FAC);
          rectangle(p^.x1-1,p^.y1-1,p^.x2+1,p^.y2+1);
          rectangle(p^.x1-2,p^.y1-2,p^.x2+2,p^.y2+2);
         end
        else
         begin
          setfillstyle(1,p^.FAC);
          setcolor(p^.TAC);
          bar(p^.x1,p^.y1,p^.x2,p^.y2);
          outtextXY(p^.x1+2,p^.y1+2,p^.strin);
         end;
       p^.act_pas:=true;
       MsOn;
       end;
     if (cloce=1) and (limitN(MsX,p^.x1,p^.x2) and limitN(MsY,p^.y1,p^.y2)) then knopka:=p^.strin;
     p:=p^.next;
   end;
  end;
procedure NewKnop(x_1,y_1,x_2,y_2:integer;FAC1,FPC1,TAC1,TPC1:byte;strin1:string{;Mas:Tmas});
 var
  p:Tknopki;
 begin
  new(p);
  with p^ do
   begin
    act_pas:=true;
    x1:=x_1;
    x2:=x_2;
    y1:=y_1;
    y2:=y_2;
    FAC:=FAC1;
    FPC:=FPC1;
    TAC:=TAC1;
    TPC:=TPC1;
    strin:=strin1;
    active:=true;
   end;
   p^.next:=knop;
  knop:=p;
  p:=nil;
 end;
procedure delknop(strin:string);
 var now,back:Tknopki;
 begin
  now:=knop;
  repeat
   if strin=now^.strin then
    begin
     back^.next:=now^.next;
     dispose(now);
     exit;
    end;
   back:=now;
   now:=now^.next;
  until now=nil;

 end;
procedure activet(strin:string;b:boolean);
 var now:Tknopki;
 begin
 now:=knop;
  while now<>nil do
   begin
    if now^.strin=strin then now^.active:=b;
    now:=now^.next;
   end;
 end;

procedure NewKnop2(x_1,y_1,x_2,y_2,FAC1,FPC1:integer;strin1:string);
 var
  p:Tknopki;
  f:file;
  mas:tmas;
 begin
  new(p);
  with p^ do
   begin
    act_pas:=true;
    x1:=x_1;
    y1:=y_1;
    x2:=x_2;
    y2:=y_2;
    FAC:=FAC1;
    FPC:=FPC1;
    strin:=strin1;
    active:=true;
    izob:=true;
    assign(f,p^.strin);
    reset(f,1);
    blockread(f,mas,190);
    close(f);
    putimage(p^.x1,p^.y1,mas,0);
    setcolor(2);
   end;
  p^.next:=knop;
  knop:=p;
  p:=nil;
 end;

end.