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
    function  IsSafe(const NumberA, NumberB: string; var ExpectedResultSign: Integer): Boolean;
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

function TAOCSolution.IsSafe(const NumberA, NumberB: string; var ExpectedResultSign: Integer): Boolean;
begin
  Result := True;
  var Diff: Integer := StrToInt(NumberA) - StrToInt(NumberB);

  var OutOfRange := (Diff < -3) or (Diff > 3);
  var CurrentResultSign := Sign(Diff);
  if OutOfRange or ((ExpectedResultSign <> -2) and (CurrentResultSign <> ExpectedResultSign)) then
    Exit(False);

  ExpectedResultSign := CurrentResultSign;
end;

procedure TAOCSolution.Solve(const Lines: TStringList);
const
  SpaceChar: Char = ' ';
begin
  var SafeCount: Integer := 0;
  var DampVal := 0;
  
  for var Line: string in Lines do
  begin
    var Numbers := Line.Split([SpaceChar]);
    var Safe := True;
    var SafeWithRemoved := True;
    var ResultSign := -2;
    var ResSignForThing := -2;
    
    for var I := Low(Numbers) to High(Numbers) - 1 do
    begin
      if not IsSafe(Numbers[I + 1], Numbers[I], ResultSign) then
        Safe := False
      else
      begin
        for var J := Low(Numbers) to High(Numbers) - 1 do
        begin
          var ArrCpy := Copy(Numbers, Low(Numbers), Length(Numbers));
          Delete(ArrCpy, J, 1);
          if not IsSafe(ArrCpy[J + 1], ArrCpy[J], ResSignForThing) then
            SafeWithRemoved := False
        end;
      end;
    end;

    if Safe then
      Inc(SafeCount);

    if SafeWithRemoved then
      Inc(DampVal)
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
