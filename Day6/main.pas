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

  TSimpleVec = record
    X, Y: Integer;
    constructor Create(const X, Y: Integer);
  end;

  TDirectionEnum = (UP, RIGHT, DOWN, LEFT);

  TAOCSolution = class(TInterfacedObject, IAOCSolution)
  strict private
  public
    {$REGION 'Initialization'}
    class function  Solution: IAOCSolution;
    {$ENDREGION}

    procedure Solve(const Lines: TStringList);
  end;

implementation

uses
  System.SysUtils;

{ TSimpleVec }

constructor TSimpleVec.Create(const X, Y: Integer);
begin
  self.X := X;
  self.Y := Y;
end;

{ TAOCSolution }

procedure TAOCSolution.Solve(const Lines: TStringList);

var
  MaxX, MaxY: Integer;

const
  Directions: TArray<TArray<Integer>> = [
    [ 0, -1],
    [ 1,  0],
    [ 0,  1],
    [-1,  0]
  ];

  function FindStartingVec: TSimpleVec;
  begin
    for var LineY := 0 to Lines.Count do
    begin
      var PositionOfSelf := Pos('^', Lines[LineY]);
      if PositionOfSelf > 0 then
        Exit(TSimpleVec.Create(PositionOfSelf, LineY));
    end;

    raise Exception.Create('Position not found in input');
  end;

  function CountPath(const CurrentCount: Integer; CurrentPosition: TSimpleVec; CurrentDirection: TDirectionEnum): Integer;
  begin
    Result := CurrentCount;

    var NewX := CurrentPosition.X + Directions[Ord(CurrentDirection)][0];
    var NewY := CurrentPosition.Y + Directions[Ord(CurrentDirection)][1];
    
    var IsXOutOfBounds := (NewX < 1) or (NewX > MaxX);
    var IsYOutOfBounds := (NewY < 0) or (NewY > MaxY);

    if IsXOutOfBounds or IsYOutOfBounds then
      Exit;

    if Lines[NewY][NewX] = '#' then
    begin
      var DirectionValue := (Ord(CurrentDirection) + 1) mod 4;
      CurrentDirection := TDirectionEnum(DirectionValue);

      NewX := CurrentPosition.X + Directions[Ord(CurrentDirection)][0];
      newY := CurrentPosition.Y + Directions[Ord(CurrentDirection)][1];
    end;

    CurrentPosition.X := NewX;
    CurrentPosition.Y := NewY;

    if Lines[NewY][NewX] <> 'X' then
    begin
      var TempString := Lines[NewY];
      TempString[NewX] := 'X';
      Lines[NewY] := TempString;
      Result := CountPath(CurrentCount + 1, CurrentPosition, CurrentDirection);
    end
    else
      Result := CountPath(CurrentCount, CurrentPosition, CurrentDirection);
  end;

begin
  var StartingPosition := FindStartingVec;
  WriteLn(Lines[StartingPosition.Y][StartingPosition.X]);

  MaxX := Length(Lines[0]);
  MaxY := Lines.Count - 1;
  
  WriteLn(CountPath(0, StartingPosition, UP));
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
