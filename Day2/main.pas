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
    function  IsSafe(const Numbers :TArray<string>): Boolean;
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

function TAOCSolution.IsSafe(const Numbers :TArray<string>): Boolean;
begin
  Result := True;
  var IntialSign := -2;

  for var I := Low(Numbers) to High(Numbers) - 1 do
  begin
    var Diff: Integer := StrToInt(Numbers[I + 1]) - StrToInt(Numbers[I]);

    var OutOfRange := (Diff < -3) or (Diff > 3);
    var CurrentResultSign := Sign(Diff);
    if OutOfRange or (CurrentResultSign = 0) or ((IntialSign <> -2) and (CurrentResultSign <> IntialSign)) then
      Exit(False);

    IntialSign := CurrentResultSign;
  end;
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
    var Safe := False;
    var SafeWithRemoved := False;

    if IsSafe(Numbers) then
      Safe := True
    else
    begin
      for var I := Low(Numbers) to Length(Numbers) do
      begin
        var NumbersCopy := Copy(Numbers, Low(Numbers), Length(Numbers));
        Delete(NumbersCopy, I, 1);
        if IsSafe(NumbersCopy) then
        begin
          SafeWithRemoved := True;
          Break;
        end;
      end;
    end;

    if Safe then
      Inc(SafeCount);

    if SafeWithRemoved or Safe then
      Inc(DampVal);
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
