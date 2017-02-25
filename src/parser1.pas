unit parser1;



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, parser_maths, ExtCtrls, singleBit, Buttons, Menus;

type

  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    ListBox1: TListBox;
    Edit2: TEdit;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    ListBox2: TListBox;
    Memo1: TMemo;
    procedure ButtonClick(Sender: TObject);
    procedure up;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
  private
    { D√©clarations priv√©es }
  public
    { D√©clarations publiques }
  end;



var
  Form1: TForm1;
  oper:Toper;
  parser:Tparser;
implementation

{$R *.dfm}
procedure Tform1.up;
var k:integer;
begin
for k:=0 to listbox2.Items.Count-1 do begin
    edit1.Text:=listbox2.Items[k];
    self.SpeedButton1Click(self);
  end;
end;

procedure TForm1.ButtonClick(Sender: TObject);
var s:string;
    i:integer;
    p:Tsinglebit;
begin


 for i:=0 to self.Panel1.ControlCount-1 do parser.variables.AjoutElement((self.Panel1.Controls[i] as Tcheckbox).Caption,inttostr(integer((self.Panel1.Controls[i] as Tcheckbox).checked)));






end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var ck:Tcheckbox;
    sb:Tsinglebit;
    i:integer;
    j:integer;
    ajoute:boolean;
    s:string;

begin

if trim(edit1.Text) <>'' then if listbox2.items.IndexOf(edit1.Text) =-1 then listbox2.items.Add(uppercase(edit1.text));
if trim(edit1.Text) <>'' then memo1.Lines.Add(edit1.text);

begin
  s:=uppercase(edit1.Text);
  //s:=memo1.Lines[k-1];
  for i:=0 to 17 do begin
     ajoute:=true;
     if pos(chr(65+i),s)>0 then begin
        for j:= 0 to panel1.ControlCount-1 do if (panel1.Controls[j]as Tcheckbox).Name = 'chk'+chr(65+i) then ajoute:=false;
        if ajoute then
        begin
          ck:=Tcheckbox.Create(self.Panel1);
          ck.parent:=self.Panel1;
          ck.caption:=chr(65+i);
          ck.Name:='chk'+chr(65+i);
          ck.left:=5;
          ck.top:=5+30*(j);
          ck.Width:=30;
          ck.onclick:=ButtonClick;
          ck.ShowHint:=true;
          ck.Hint:='Capteurs binaires de A ‡ R';
        end;
     end;
  end;

  for i:=0 to 8 do  begin
    ajoute:=true;
    if pos(chr(82+i),s)>0 then begin
      for j:= 0 to panel2.ControlCount-1 do if (panel2.Controls[j] as Tsinglebit).Name = 'bit'+chr(82+i) then ajoute:=false;
      if ajoute then begin
        sb:=Tsinglebit.create(self.Panel2);
        sb.parent:=self.Panel2;
        sb.caption:=chr(82+i);
        sb.Name:='bit'+chr(82+i);
        sb.Diametre:=15;
        sb.left:=5;
        sb.top:=5+30*panel2.ControlCount;
        sb.Width:=30;
        sb.ShowHint:=true;
        sb.Hint:='Actionneurs binaires de S ‡ Z';
      end;
    end;
  end;


self.Timer1.Enabled:=true;
self.ButtonClick(self);
end;




end;



procedure TForm1.FormCreate(Sender: TObject);
begin
parser:=Tparser.create;
//self.up;
//self.SpeedButton1Click(self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
parser.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var j,i:integer;
    s:string;
begin

for j:= 0 to self.memo1.lines.Count-1 do
begin

s:=trim(memo1.lines[j]);
s:=stringreplace(s,' ','',[rfReplaceAll]);
self.Edit2.Text:=parser.infixToRpn(s);
parser.calculateRpn;
//self.Memo2.Lines:=parser.getRPN;
self.ListBox1.items:=parser.variables.listeCles;

for i:=0 to panel2.Controlcount-1 do
begin
s:=(panel2.Controls[i] as Tsinglebit).caption+' = 1';
(panel2.Controls[i] as Tsinglebit).Value:=listbox1.items.indexof(s) > -1;
end;
end;

self.ButtonClick(self);

end;

procedure TForm1.Button1Click(Sender: TObject);
var k:integer;
begin
  //self.up;
  timer1.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
timer1.Enabled:=false;
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
self.Timer1.Enabled:=false;
end;

procedure TForm1.Memo1Click(Sender: TObject);
begin
self.timer1.Enabled:=false;
end;

procedure TForm1.ListBox2Click(Sender: TObject);
begin
memo1.clear;
self.Timer1.Enabled:=false;
edit1.Text := listbox2.Items[listbox2.itemindex];
self.SpeedButton1Click(self);
self.Timer1.Enabled:=true;
end;

end.
