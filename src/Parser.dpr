program Parser;

uses
  Forms,
  parser1 in 'parser1.pas' {Form1},
  parser_maths in 'parser_maths.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
