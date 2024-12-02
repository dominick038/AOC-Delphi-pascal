unit Main;

interface

uses
  System.Classes;

type
  {$REGION 'Initialization'}
  IAOCSolution = interface
    ['{8FF3F1BC-A525-48C8-B79D-CC84759FBFB2}']
    procedure Solve(const Lines: TStringList);
  end;
  {$ENDREGION}

  TAOCSolution = class(TInterfacedObject, IAOCSolution)
  strict private

  public
    {$REGION 'Initialization'}
    class function  Solution: IAOCSolution;
    {$ENDREGION}

    procedure Solve(const Lines: TStringList);
  end;

implementation

uses
  System.StrUtils,
  System.SysUtils, 
  System.Math;

{ TAOCSolution }

procedure TAOCSolution.Solve(const Lines: TStringList);
const
  SpaceChar: Char = ' ';
begin
  var SafeCount: Integer := 0;
  var DampVal := 0;
  
  for var Line: string in Lines do
  begin
    var Numbers := Line.Split([SpaceChar]);
    var IsSafe := True;
    var ResultSign := -2; 
    
    for var I := Low(Numbers) to High(Numbers) - 1 do
    begin
      var Diff: Integer := StrToInt(Numbers[I + 1]) - StrToInt(Numbers[I]);

      var OutOfRange := (Diff < -3) or (Diff > 3);
      var CurrSign := Sign(Diff);
      if OutOfRange or ((ResultSign <> -2) and (CurrSign <> ResultSign)) then
      begin
        IsSafe := False;
        Break;
      end;

      ResultSign := CurrSign;
    end;

    if IsSafe then
      Inc(SafeCount);
    
  end;

  WriteLn(SafeCount);
  Writeln(DampVal);
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
