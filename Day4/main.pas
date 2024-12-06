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
    MaxX, MaxY: integer;
    FLines: TStringList;
    
    function  Dfs(const X, Y: Integer; const CurrentDirection: TArray<Integer>; const Index: Integer = 1; const SearchWord: string = 'XMAS'): Boolean;
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

function TAOCSolution.Dfs(const X, Y: Integer; const CurrentDirection: TArray<Integer>; const Index: Integer; const SearchWord: string): Boolean;
begin
  Result := False;

  var XOutOfBounds := (X < 1) or (X > MaxX);
  var YOutOfBounds := (Y < 0) or (Y > MaxY);

  if XOutOfBounds or YOutOfBounds or (Index > Length(SearchWord)) or (SearchWord[Index] <> FLines[Y][X]) then
    Exit;

  if (Index = Length(SearchWord)) and (SearchWord[Index] = FLines[Y][X]) then
    Exit(True);

  Exit(
    Dfs(X + CurrentDirection[0], Y + CurrentDirection[1], CurrentDirection, Index + 1)
  );
    
end;

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

begin
  MaxY := Lines.Count - 1;
  MaxX := Length(Lines[0]);
  FLines := Lines;

  var Count := 0;
  for var Y := 0 to Lines.Count - 1 do
    for var X := Low(Lines[Y]) to High(Lines[Y]) do
      for var Direction in Directions do
        if Dfs(X, Y, Direction) then
          Inc(Count);

  WriteLn(Count);
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
