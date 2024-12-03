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
  RegexPattern = 'mul\(\d*,\d*\)';
begin
  Result := TList<TPair<Integer, Integer>>.Create;
  var RegEx := TRegEx.Create(RegexPattern);

  var Match := RegEx.Match(InputTxt);
  var Count := 0;
  while Match.Success do
  begin
    var Values := Match.Value.Split(['mul(', ',', ')']);
    
    Result.Add(TPair<Integer, Integer>.Create(StrToInt(Values[1]), StrToInt(Values[2])));

    Match := Match.NextMatch;
  end;
end;

procedure TAOCSolution.Solve(const Lines: TStringList);
begin
  var MultiplicationPairs := ExtractMul(Lines.Text);
  var Total := 0;
  for var Pair in MultiplicationPairs do
    Total := Total + (Pair.Key * Pair.Value);

  WriteLn(Total);
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
