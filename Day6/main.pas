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
  end;

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

{ TAOCSolution }

procedure TAOCSolution.Solve(const Lines: TStringList);

  function FindStartingVec: TSimpleVec;
  begin
    Result.X := -1;
    Result.Y := -1;

    for var LineY := 0 to Lines.Count do
    begin
      var PositionOfSelf := Pos('^', Lines[LineY]);
      if PositionOfSelf > 0 then
      begin
        Result.Y := LineY;
        Result.X := PositionOfSelf;
        Exit;
      end;
    end;
  end;

begin
  var StartingPosition := FindStartingVec;
end;

{$REGION 'Initialization'}

class function TAOCSolution.Solution: IAOCSolution;
begin
  Result := TAOCSolution.Create;
end;

{$ENDREGION}

end.
