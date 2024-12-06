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
    FGrammarRules: TDictionary<Integer, TArray<Integer>>;

    function  ValidateInput(const InputArray: TArray<Integer>; const InputArrayCount: Integer): Boolean;
  public
    {$REGION 'Initialization'}
    class function  Solution: IAOCSolution;
    {$ENDREGION}

    procedure Solve(const Lines: TStringList);
  end;

implementation

uses
  System.SysUtils;

{ TAOCSolution }

procedure TAOCSolution.Solve(const Lines: TStringList);
begin
  // This copy setup is just for me to see what happens to performance compared to .Split and then parsing from that...
  FGrammarRules := TDictionary<Integer, TArray<Integer>>.Create;
  for var I := 0 to 1175 do
  begin
    var Index := StrToInt(Copy(Lines[I], 1, 2));
    if FGrammarRules.ContainsKey(Index) then
      FGrammarRules[Index] := FGrammarRules[Index] + [StrToInt(Copy(Lines[I], 4, 2))]
    else
      FGrammarRules.Add(Index, [StrToInt(Copy(Lines[I], 4, 2))]);
  end;

  var MiddleNumSum := 0;
  
  // This copy setup is just for me to see what happens to performance compared to .Split and then parsing from that...
  for var I := 1177 to Lines.Count - 1 do
  begin
    var InputArray: TArray<Integer>;
    var AmountToCopy := Length(Lines[I]) div 3 + 1;

    SetLength(InputArray, AmountToCopy);

    for var J := 0 to AmountToCopy - 1 do
      InputArray[J] := StrToInt(Copy(Lines[I], J * 3 + 1, 2));
 
    if ValidateInput(InputArray, AmountToCopy - 1) then
      MiddleNumSum := MiddleNumSum + InputArray[Integer(AmountToCopy div 2)];
  end;

  WriteLn(MiddleNumSum);
end;

function TAOCSolution.ValidateInput(const InputArray: TArray<Integer>; const InputArrayCount: Integer): Boolean;
var
  LookupArray: array[1..99] of Integer;
begin
  Result := True;
  FillChar(LookupArray, System.SizeOf(LookupArray), 0);

  for var I := 0 to InputArrayCount do
    LookupArray[InputArray[I]] := I;

  var GrammarRuleArray: TArray<Integer>;
  for var I := 0 to InputArrayCount do
  begin  
    var InputValue := InputArray[I];
    if FGrammarRules.TryGetValue(InputValue, GrammarRuleArray) then
    begin
      for var Rule in GrammarRuleArray do
      begin
        var InputIndex := LookupArray[InputValue];
        if LookupArray[Rule] <> 0 then  
          Result := Result and (LookupArray[Rule] > InputIndex)
      end;
    end;
  end;
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
