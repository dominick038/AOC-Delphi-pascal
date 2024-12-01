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
    LeftArr: array[0..999] of Integer;
    RightArr: array[0..999] of Integer;
    FrequencyMap: TDictionary<Integer, Integer>;
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

procedure TAOCSolution.Solve(const Lines: TStringList);
const
  SpaceChar: Char = ' ';
begin
  FrequencyMap := TDictionary<Integer, Integer>.Create;

  for var I := 0 to Lines.Count - 1 do
  begin
    var Strings := Lines[I].Split(SpaceChar);

    var LeftInt := StrToInt(Strings[0]);
    var RightInt := StrToInt(Strings[3]);

    LeftArr[I] := LeftInt;
    RightArr[I] := RightInt;

    if FrequencyMap.ContainsKey(RightInt) then
      FrequencyMap[RightInt] := FrequencyMap[RightInt] + 1
    else
      FrequencyMap.Add(RightInt, 1);
  end;

  TArray.Sort<Integer>(LeftArr);
  TArray.Sort<Integer>(RightArr);

  var Total := 0;
  var TotalSimiliarityScore := 0;
  for var I := 0 to Length(LeftArr) - 1 do
  begin
    var LeftVal := LeftArr[I];
    Total := Total + Abs(LeftArr[I] - RightArr[I]);

    var FrequencyValue: Integer;
    if FrequencyMap.TryGetValue(LeftVal, FrequencyValue) then
      TotalSimiliarityScore := TotalSimiliarityScore + LeftVal * FrequencyValue;
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
