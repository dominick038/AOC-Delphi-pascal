program Day4;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  Main in 'Main.pas',
  System.Diagnostics;

begin
  var InputFile := TStringList.Create;
  try
    var Stopwatch := TStopwatch.StartNew;
    InputFile.LoadFromFile('./input.txt');

    TAOCSolution.Solution
                .Solve(InputFile);

    WriteLn(Format('%f ms elapsed', [Stopwatch.Elapsed.TotalMilliseconds]));
  finally
    InputFile.Free;
  end;
  ReadLn;
end.
