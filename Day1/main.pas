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
    LeftArr: TArray<Integer>;
    RightArr: TArray<Integer>;
    FrequencyMap: TDictionary<Integer, Integer>;

    function CompareVal(const L, R: Integer): Integer;
  public
    {$REGION 'Initialization'}
    class function  Solution: IAOCSolution;
    {$ENDREGION}

    procedure Solve(const Lines: TStringList);
  end;

implementation

uses
  System.StrUtils, 
  System.SysUtils;

{ TAOCSolution }

function TAOCSolution.CompareVal(const L, R: Integer): Integer;
begin
  if L > R then
    Result := L - R
  else if L < R then
    Result := R - L
  else 
    Result := 0;
end;

procedure TAOCSolution.Solve(const Lines: TStringList);
const
  SpaceChar: Char = ' ';
begin
  FrequencyMap := TDictionary<Integer, Integer>.Create;

  var Line: string;
  for Line in Lines do
  begin
    var Strings := Line.Split(SpaceChar);

    var LeftInt := StrToInt(Strings[0]);
    var RightInt := StrToInt(Strings[3]);

    LeftArr := LeftArr + [LeftInt];
    RightArr := RightArr + [RightInt];
  end;

  TArray.Sort<Integer>(LeftArr);
  TArray.Sort<Integer>(RightArr);

  var Total := 0;
  for var I := 0 to Length(LeftArr) - 1 do
  begin
    var RightVal := RightArr[I];
    Total := Total + CompareVal(LeftArr[I], RightArr[I]);

    if FrequencyMap.ContainsKey(RightVal) then
      FrequencyMap[RightVal] := FrequencyMap[RightVal] + 1
    else
      FrequencyMap.Add(RightVal, 1);
  end;

  var TotalSimiliarityScore := 0;
  for var I := 0 to Length(LeftArr) - 1 do
  begin
    var LeftVal := LeftArr[I];
    if FrequencyMap.ContainsKey(LeftVal) then
      TotalSimiliarityScore := TotalSimiliarityScore + FrequencyMap[LeftVal] * LeftVal;
  end;

  WriteLn('Result 1:');
  WriteLn(Total);
  WriteLn;

  WriteLn('Result 2:');
  WriteLn(TotalSimiliarityScore);
  WriteLn;
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
