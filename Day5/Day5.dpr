program Day5;

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

    WriteLn(Format('elapsed %f ms', [Stopwatch.Elapsed.TotalMilliseconds]));
  finally
    InputFile.Free;
  end;
  ReadLn;
end.
