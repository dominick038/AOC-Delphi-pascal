unit Main;

interface

uses
  System.Classes, 
  System.Generics.Collections;

type
  {$REGION 'Initialization'}
  IAOCSolution = interface
    ['{8FF3F1BC-A525-48C8-B79D-CC84759FBFB2}']
    procedure Solve(const Lines: TStringList);
  end;
  {$ENDREGION}

  TAOCSolution = class(TInterfacedObject, IAOCSolution)
  strict private
    function  ExtractMul(const InputTxt: string): TList<TPair<Integer, Integer>>;
  public
    {$REGION 'Initialization'}
    class function  Solution: IAOCSolution;
    {$ENDREGION}

    procedure Solve(const Lines: TStringList);
  end;

implementation

uses
  System.RegularExpressions, 
  System.SysUtils;

{ TAOCSolution }

function TAOCSolution.ExtractMul(const InputTxt: string): TList<TPair<Integer, Integer>>;
const
  RegexPattern = 'mul\(\d*,\d*\)|don''t\(\)|do\(\)';
begin
  Result := TList<TPair<Integer, Integer>>.Create;
  var RegEx := TRegEx.Create(RegexPattern);

  var Match := RegEx.Match(InputTxt);
  var Count := 0;
  while Match.Success do
  begin
    var MatchVal := Match.Value;
    if Pos('don''t', MatchVal) > 0 then
    begin
      Result.Add(TPair<Integer, Integer>.Create(0, 0));
      Match := Match.NextMatch;
      Continue;
    end
    else if Pos('do', MatchVal) > 0 then
    begin
      Result.Add(TPair<Integer, Integer>.Create(-1, -1));
      Match := Match.NextMatch;
      Continue;
    end;
  
    var Values := MatchVal.Split(['mul(', ',', ')']);

    Result.Add(TPair<Integer, Integer>.Create(StrToInt(Values[1]), StrToInt(Values[2])));

    Match := Match.NextMatch;
  end;
end;

procedure TAOCSolution.Solve(const Lines: TStringList);
begin
  var MultiplicationPairs := ExtractMul(Lines.Text);
  var Total := 0;
  var TotalWithDos := 0;
  var IsEnabled := True;
  for var Pair in MultiplicationPairs do
  begin
    if (Pair.Key = -1) and (Pair.Value = -1) then
    begin
      IsEnabled := True;
      Continue;
    end
    else if (Pair.Key = 0) and (Pair.Value = 0) then
    begin
      IsEnabled := False;
      Continue;
    end;
      
      
    if IsEnabled then
      TotalWithDos := TotalWithDos + (Pair.Key * Pair.Value);
       
    Total := Total + (Pair.Key * Pair.Value);
  end;

  WriteLn('Part 1:');
  WriteLn(Total);
  WriteLn;

  WriteLn('Part 2:');
  WriteLn(TotalWithDos);
  
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
