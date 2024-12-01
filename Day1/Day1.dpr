program Day1;

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
    InputFile.LoadFromFile('./input.txt');

    var Stopwatch := TStopwatch.StartNew;

    TAOCSolution.Solution
                .Solve(InputFile);

    WriteLn(Format('elapsed %f ms', [Stopwatch.Elapsed.TotalMilliseconds]));
  finally
    InputFile.Free;
  end;
  ReadLn;
end.
