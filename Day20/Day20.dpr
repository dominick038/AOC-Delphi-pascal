program Day20;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  Main in 'Main.pas';

begin
  var InputFile := TStringList.Create;
  try
    InputFile.LoadFromFile('./input.txt');

    TAOCSolution.Solution
                .Solve(InputFile);
  finally
    InputFile.Free;
  end;
  ReadLn;
end.
