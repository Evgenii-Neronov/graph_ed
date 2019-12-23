{Из прошлого...}
unit printscr;

interface

type
 M4=array[1..4] of integer;
 M3p=array[1..3] of pointer;

 procedure newM3p(x1,y1,x2,y2:integer;var poin3:M3p);
 procedure freeM3p(x1,y1,x2,y2:integer;var poin3:M3p);
 procedure Print(x1,y1,x2,y2,x,y:integer;poin3:M3p);
 procedure Screen(x1,y1,x2,y2:integer;var poin3:M3p);

implementation
uses graph;

procedure raspred(x1,y1,x2,y2:integer;var pr1,pr2,pr3:M4);
 begin
  pr1[1]:=x1; pr1[2]:=y1;
  pr1[3]:=x2;
  pr1[4]:=((y2-y1) div 3)+y1;

  pr2[1]:=x1; pr2[2]:=pr1[4];
  pr2[3]:=x2;
  pr2[4]:=y2-pr1[4]+y1;

  pr3[1]:=x1; pr3[2]:=pr2[4];
  pr3[3]:=x2;
  pr3[4]:=y2;
 end;

procedure newM3p(x1,y1,x2,y2:integer;var poin3:M3p);
 var s1,s2,s3:integer;
     pr1,pr2,pr3:M4;
 begin
  raspred(x1,y1,x2,y2,pr1,pr2,pr3);

  s1:=imagesize(pr1[1],pr1[2],pr1[3],pr1[4]);
  s2:=imagesize(pr2[1],pr2[2],pr2[3],pr2[4]);
  s3:=imagesize(pr3[1],pr3[2],pr3[3],pr3[4]);

  getmem(poin3[1],s1);
  getmem(poin3[2],s2);
  getmem(poin3[3],s3);


 end;
procedure freeM3p(x1,y1,x2,y2:integer;var poin3:M3p);
 var s1,s2,s3:integer;
     pr1,pr2,pr3:M4;
 begin
  raspred(x1,y1,x2,y2,pr1,pr2,pr3);

  s1:=imagesize(pr1[1],pr1[2],pr1[3],pr1[4]);
  s2:=imagesize(pr2[1],pr2[2],pr2[3],pr2[4]);
  s3:=imagesize(pr3[1],pr3[2],pr3[3],pr3[4]);

  freemem(poin3[1],s1);
  freemem(poin3[2],s2);
  freemem(poin3[3],s3);
 end;
procedure Screen(x1,y1,x2,y2:integer;var poin3:M3p);
 var
  pr1,pr2,pr3:M4;
 begin
  raspred(x1,y1,x2,y2,pr1,pr2,pr3);
  getimage(pr1[1],pr1[2],pr1[3],pr1[4],poin3[1]^);
  getimage(pr2[1],pr2[2],pr2[3],pr2[4],poin3[2]^);
  getimage(pr3[1],pr3[2],pr3[3],pr3[4],poin3[3]^);
 end;
procedure Print(x1,y1,x2,y2,x,y:integer;poin3:M3p);
 var pr1,pr2,pr3:M4;
 begin

  raspred(x1,y1,x2,y2,pr1,pr2,pr3);

  putimage(pr1[1]+x,pr1[2]+y,poin3[1]^,0);
  putimage(pr2[1]+x,pr2[2]+y,poin3[2]^,0);
  putimage(pr3[1]+x,pr3[2]+y,poin3[3]^,0);

 end;
end.