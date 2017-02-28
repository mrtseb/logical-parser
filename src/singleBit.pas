unit singleBit;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls,graphics;

type
  TsingleBit = class(TgraphicControl)
  private
    FDiametre:integer;
    FEnabled:boolean;
    FValue:boolean;
    FCaption:string;
    FPen: TPen; { un champ pour l’objet crayon }
    FBrush: TBrush; { un champ pour l’objet pinceau }
    procedure SetBrush(Value: TBrush);
    procedure SetCaption(txt: string);
    procedure SetPen(Value: TPen);
    procedure Setdiametre(Value: integer);
    procedure SetValue(Value: boolean);
    { Déclarations privées }
  protected
    { Déclarations protégées }
    procedure Paint; override;
    procedure Click; override;
  public
    { Déclarations publiques }
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   procedure StyleChanged(Sender: TObject);
  published
    { Déclarations publiées }
    property Caption:string read Fcaption write setCaption;
    property Value:boolean read Fvalue write setValue default false;
    property Diametre:integer read Fdiametre write Setdiametre default 10;
    property Height default 10;
    property Width default 10;
    property Enabled read FEnabled write FEnabled default false;
    property DragCursor; { propriétés associées au glisser-lâcher }
    property DragMode;
    property OnDragDrop; { événements associés au glisser-lâcher }
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown; { événements souris }
    property OnMouseMove;
    property OnMouseUp;
    property Brush: TBrush read FBrush write SetBrush;
    property Pen: TPen read FPen write SetPen;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Bits', [TsingleBit]);
end;

constructor TsingleBit.create(AOwner:Tcomponent);
begin
inherited Create(AOwner); { toujours appeler le constructeur reçu en héritage ! }
width:=10;
height:=10;
FPen := TPen.Create; { construit le crayon }
FPen.OnChange := StyleChanged; { associe la méthode à l’événement OnChange }
FBrush := TBrush.Create; { construit le pinceau }
Fbrush.Style:=bsclear;
FBrush.OnChange := StyleChanged; { associe la méthode à l’événement OnChange }
Fvalue:=value;
Fdiametre:=width;
invalidate;
end;

procedure TsingleBiT.SetCaption(txt: string);
begin
FCaption:=txt;
end;

procedure Tsinglebit.click;
begin
if not Fenabled then exit;
inherited Click;
Fvalue:=not Fvalue;
invalidate;
end;

procedure Tsinglebit.Paint;
var i:integer;
p:^boolean;
begin
with Canvas do
begin
Pen := FPen; { copie le crayon du composant }
Brush := FBrush; { copie le pinceau du composant }
Brush.style:=bssolid;
if Fvalue then Brush.color:=clRed else Brush.color:=clblack;
ellipse(0,0,Fdiametre,Fdiametre);
Brush.Style:=bsclear;
canvas.TextOut(Fdiametre+2,0,self.FCaption);
end;


end;

procedure TsingleBit.StyleChanged(Sender: TObject);
begin
Invalidate; { efface puis redessine le composant }
end;

procedure Tsinglebit.SetBrush(Value: TBrush);
begin
FBrush.Assign(Value); { remplace le pinceau existant par le paramètre }
end;


procedure Tsinglebit.SetDiametre(Value:integer);
begin
Fdiametre:=Value;
Width:=Fdiametre+20*length(self.name);
Height:=Fdiametre;
invalidate;
end;

procedure Tsinglebit.SetValue(Value:boolean);
begin
Fvalue:=Value;
invalidate;
end;

procedure Tsinglebit.SetPen(Value: TPen);
begin
FPen.Assign(Value); { remplace le crayon existant par le paramètre }
end;

destructor Tsinglebit.Destroy;
begin
FPen.Free; { détruit l’objet crayon }
FBrush.Free; { détruit l’objet pinceau }
inherited Destroy; { toujours appeler le destructeur reçu en héritage }
end;



end.
