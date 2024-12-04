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

{ TAOCSolution }



procedure TAOCSolution.Solve(const Lines: TStringList);
const
  Directions: TArray<TArray<Integer>> = [
    [0, 1],
    [1, 0],
    [1, 1],
    [0, -1],
    [-1, 0],
    [-1, -1],
    [-1, 1],
    [1, -1]
  ];

  function Dfs(const X, Y: Integer; const Index: Integer; const CurrentDirection: TArray<Integer> = nil): Boolean;
  begin
    Result := False;

    if CurrentDirection <> nil then
      Exit(
        Dfs(X + CurrentDirection[0], Y + CurrentDirection[1], Index + 1, CurrentDirection)
      );

    for var Direction in Directions do
      if Dfs(X, Y, Index + 1, Direction) then
        Exit(True);
  end;
  
begin
  var Count := 0;

  for var Y := 0 to Lines.Count - 1 do
    for var X := Low(Lines[Y]) to High(Lines[Y]) do
      if Dfs(X, Y, 0) then
        inc(Count);
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
