unit parser_maths;



interface

uses classes,contnrs, tabassoc;

type
 Toper = record
    signe: char;
    priorite:integer;
    assoc: integer;
  end;

 Tparser = class(Tobject)

    RPN:string;
    variables: TableauAssociatif;
    constructor create;
    destructor destroy; override;
    function isOperator(token:char):boolean;
    function isAssociative(token:char; typ:integer):boolean;
    function cmpPrecedence(token1, token2:char):integer;
    function infixToRpn(inputTokens:string):string;
    function CalculateRPN:string;
    function getRPN:Tstringlist;
    procedure do_it(op: char; stack:Tstack);
 end;

const

 LEFT_ASSOC = 0;
 RIGHT_ASSOC = 1;

 opers : array[0..9] of TOper =
   (
     (signe : '%'; priorite : 5; assoc: LEFT_ASSOC),
     (signe : '+'; priorite : 1; assoc: LEFT_ASSOC ),
     (signe : '|'; priorite : 1; assoc: LEFT_ASSOC),
     (signe : '-'; priorite : 1; assoc: LEFT_ASSOC),
     (signe : '*'; priorite : 5; assoc: LEFT_ASSOC),
     (signe : '.'; priorite : 5; assoc: LEFT_ASSOC),
     (signe : '&'; priorite : 5; assoc: LEFT_ASSOC),
     (signe : '/'; priorite : 6; assoc: LEFT_ASSOC),
     (signe : '^'; priorite : 10; assoc: RIGHT_ASSOC),
     (signe : '='; priorite : 0; assoc: LEFT_ASSOC)
   ) ;

   procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings);


implementation
uses sysutils;

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings);
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.DelimitedText   := Str;
end;

function Tparser.getRPN: Tstringlist;
var i:integer;
    t:Tstringlist;

begin
getRpn:=Tstringlist.create;
t:=Tstringlist.create;
Split(':',self.RPN,t);
getRpn:=t;
end;

procedure Tparser.do_it(op: char; stack:Tstack);
var a,b:char;
    p:^char;
begin

if (op='/') then begin
   p:=stack.Pop;
   a:=p^;
   if a in ['S'..'Z'] then if variables.contientCle(a) then a:=variables[a][1] else a:='0';
   p^ := inttostr((strtoint(a)+1) mod 2)[1];
   stack.Push(p);
end;

if (op='=') then begin
   p:=stack.Pop;
   b:=p^;
   p:=stack.Pop;
   a:=p^;
   if variables.contientCle(a) then variables[a]:=b else variables.AjoutElement(a,b);
end;

if (op='&') or (op='.') or (op='*') then begin
   p:=stack.Pop;
   a:=p^;
   if a in ['S'..'Z'] then if variables.contientCle(a) then a:=variables[a][1] else a:='0';
   p:=stack.Pop;
   b:=p^;
   if b in ['S'..'Z'] then if variables.contientCle(b) then b:=variables[b][1] else b:='0';
   p^:=inttostr(integer((strtoint(a) + strtoint(b)) > 1))[1];
   stack.Push(p);
end;

if (op='+') or (op='|') then begin
   p:=stack.Pop;
   a:=p^;
   if a in ['S'..'Z'] then if variables.contientCle(a) then a:=variables[a][1] else a:='0';
   p:=stack.Pop;
   b:=p^;
   if b in ['S'..'Z'] then if variables.contientCle(b) then b:=variables[b][1] else b:='0';
   p^:=inttostr(integer((strtoint(a) + strtoint(b)) >= 1))[1];
   stack.Push(p);
end;

end;

function Tparser.CalculateRPN: string;
var Fstack:Tstack;
    t:Tstringlist;
    i:integer;
    p:^char;
    s:string;
begin
Fstack:=Tstack.create;
t:=Tstringlist.create;
Split(':',self.RPN,t);

for i:=0 to t.count-2 do begin
  if self.isOperator(t[i][1]) then do_it(t[i][1],Fstack)

  else
  begin

    new(p);
    
    if (t[i][1] in ['0'..'1']) then p^:=t[i][1] else
    if (t[i][1] in ['A'..'R']) then
       if variables.contientCle(t[i][1]) then p^:= variables[t[i][1]][1] else p^:= t[i][1];
    if (t[i][1] in ['S'..'Z']) then p^:= t[i][1];


    Fstack.Push(p);
  end;


end;

for i:=0 to Fstack.count-1 do begin
p:=Fstack.Pop;
s:=s+p^;
end;

calculateRpn:=s;
Fstack.Free;
t.Free;
end;


function Tparser.isOperator(token:char):boolean;
var i:integer;
begin
   isOperator:=false;
   for i:= 0 to length(opers)-1 do if (token=opers[i].signe) then isOperator:=true;

end;

function Tparser.isAssociative(token:char; typ:integer):boolean;
var i:integer;
begin
   isAssociative:=false;
   for i:= 0 to length(opers)-1 do if (token=opers[i].signe) then isAssociative:= (opers[i].assoc = typ);

end;

function Tparser.cmpPrecedence(token1, token2:char):integer;
var i,a,b:integer;

begin
  if not self.isOperator(token1) or not self.isOperator(token2) then begin cmpPrecedence:=-1; exit; end;
  for i:= 0 to length(opers)-1 do
      begin
      if opers[i].signe=token1 then a:= opers[i].priorite;
      if opers[i].signe=token2 then b:= opers[i].priorite;
      end;
  cmpPrecedence:=a-b;
end;


function Tparser.infixToRpn(inputTokens:string):string;
var i:integer;
    p:^char;
    outp:string;
    Fstack:Tstack;
begin

Fstack:=Tstack.create;
outp:='';
new(p);
for i:=1 to length(inputTokens) do
    begin

      if self.isOperator(inputTokens[i]) then

      begin

        while Fstack.count<>0 do begin
           p:=Fstack.Peek;
           if not self.isOperator(p^) then break;
           if self.isAssociative(inputTokens[i], LEFT_ASSOC) and (self.cmpPrecedence(inputTokens[i],p^) <=0)
           or self.isAssociative(inputTokens[i], RIGHT_ASSOC) and (self.cmpPrecedence(inputTokens[i], p^) <0) then
           begin
              p:=Fstack.Pop;
              if p^<>#0 then outp:=outp+p^+':';
           end;
           break;
        end;

        new(p);
        p^:=inputTokens[i];
        Fstack.Push(p);
      end

      else if (inputTokens[i]='(') then begin new(p); p^:= inputTokens[i]; Fstack.Push(p); end
      else if (inputTokens[i]=')') then
      repeat
          p:=Fstack.Pop;
          if p^<>'(' then if p^<>' ' then if p^<>#0 then outp:=outp+p^+':';
      until (Fstack.Count=0) or (p^ ='(')

      else if (inputTokens[i]<>#32) then outp:= outp+inputTokens[i]+':';


end;

while Fstack.count<>0 do begin
   p:=Fstack.Pop;
   outp:=outp+p^+':';

end;
self.RPN:=outp;
infixToRpn:=outp;
Fstack.free;
end;

constructor Tparser.create;
begin
  variables:=TableauAssociatif.Create;
end;

destructor Tparser.destroy;
begin
inherited;
variables.Free;
end;

end.
