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
    FReorderValue: Integer;
    
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
var
  I: Integer;
begin
  // This copy setup is just for me to see what happens to performance compared to .Split and then parsing from that...
  FGrammarRules := TDictionary<Integer, TArray<Integer>>.Create;
  var ContinueIndex := 0;
  for I := 0 to Lines.Count do
  begin
    if Lines[I] = '' then
    begin
      ContinueIndex := I + 1;
      Break;
    end;

    var Index := StrToInt(Copy(Lines[I], 1, 2));
    if FGrammarRules.ContainsKey(Index) then
      FGrammarRules[Index] := FGrammarRules[Index] + [StrToInt(Copy(Lines[I], 4, 2))]
    else
      FGrammarRules.Add(Index, [StrToInt(Copy(Lines[I], 4, 2))]);

  end;

  var MiddleNumSum := 0;
  FReorderValue := 0;
  
  // This copy setup is just for me to see what happens to performance compared to .Split and then parsing from that...
  for I := ContinueIndex to Lines.Count - 1 do
  begin
    var InputArray: TArray<Integer>;
    var AmountToCopy := Length(Lines[I]) div 3 + 1;

    SetLength(InputArray, AmountToCopy);

    for var J := 0 to AmountToCopy - 1 do
      InputArray[J] := StrToInt(Copy(Lines[I], J * 3 + 1, 2));
 
    if ValidateInput(InputArray, AmountToCopy - 1) then
      MiddleNumSum := MiddleNumSum + InputArray[AmountToCopy div 2];
  end;

  WriteLn(MiddleNumSum);
  WriteLn(FReorderValue);
end;

function TAOCSolution.ValidateInput(const InputArray: TArray<Integer>; const InputArrayCount: Integer): Boolean;
var
  LookupArray: array[10..99] of Integer;
  // For some reason the debugger freaks out if I set the vars inside the loops so we do this
  I: Integer;
  GrammarRuleArray: TArray<Integer>;
  Rule: Integer;
begin
  Result := True;
  FillChar(LookupArray, System.SizeOf(LookupArray), -1);

  for I := 0 to InputArrayCount do
    LookupArray[InputArray[I]] := I;

  for I := 0 to InputArrayCount do
  begin  
    var InputValue := InputArray[I];
    if FGrammarRules.TryGetValue(InputValue, GrammarRuleArray) then
    begin
      for Rule in GrammarRuleArray do
      begin
        var InputIndex := LookupArray[InputValue];
        if LookupArray[Rule] <> -1 then  
          Result := Result and (LookupArray[Rule] > InputIndex)
      end;
    end;
  end;

  // Pt 2 || This can probably be better but I am too lazy to optimize it rn...
  if not Result then
  begin
    I := 0;
    while (I <= InputArrayCount) do
    begin
      var InputValue := InputArray[I];
      if FGrammarRules.TryGetValue(InputValue, GrammarRuleArray) then
      begin
        for Rule in GrammarRuleArray do
        begin
          var InputIndex := LookupArray[InputValue];
          var RuleIndex := LookupArray[Rule];

          if (RuleIndex <> -1) and (RuleIndex < InputIndex) then
          begin
            // Move InputValue to RuleIndex
            // Step 1: Extract InputValue and shift elements to the right
            for var J := InputIndex downto RuleIndex + 1 do
              InputArray[J] := InputArray[J - 1];

            // Step 2: Place InputValue at RuleIndex
            InputArray[RuleIndex] := InputValue;

            // Step 3: Update LookupArray to reflect the changes
            for var K := 0 to InputArrayCount do
              LookupArray[InputArray[K]] := K;

            // Step 4: Restart validation from 0
            I := 0;
          end;
        end;
      end;
      Inc(I);
    end;

    FReorderValue := FReorderValue + InputArray[(InputArrayCount + 1) div 2];
  end;
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
