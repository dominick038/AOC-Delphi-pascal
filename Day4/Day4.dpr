program Day4;

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

    try
      TAOCSolution.Solution
                  .Solve(InputFile);
    except
      on E: Exception do
        WriteLn(E.Message);
    end;

  finally
    InputFile.Free;
  end;
  ReadLn;
end.
