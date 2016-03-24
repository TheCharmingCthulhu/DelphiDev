unit RBAMazeForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons, Generics.Collections;

type
  TMazeGrid = Array of Array of Integer;
  TMazeDirection = (mdUp, mdDown, mdLeft, mdRight);

  TMain = class(TForm)
    dgMap: TDrawGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dgMapDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    FMaze: TMazeGrid;
    FSolution: TList<TPoint>;

    function GetNextNeighbour(AX, AY: Integer; AMaze: TMazeGrid; AStack: TStack<TPoint>): TPoint;
    procedure DepthSearchMaze(AX, AY: Integer; AMaze: TMazeGrid; AStack: TStack<TPoint>; AReverse: Boolean = False);
  public
    { Public declarations }
  end;

var
  Main: TMain;

const
  MAZE_WIDTH: Integer = 3;
  MAZE_HEIGHT: Integer = 3;
  
implementation

{$R *.dfm}

procedure TMain.DepthSearchMaze(AX, AY: Integer; AMaze: TMazeGrid; AStack: TStack<TPoint>; AReverse: Boolean = False);
var
  Dir: Integer;
  Target: TPoint;
begin
  // Mark the current Cell!
  AMaze[AX][AY]:=1;

  // Check if we want to return homebase X: 0; Y: 0!
  if NOT AReverse then
    AStack.Push(TPoint.Create(AX, AY));

  // Retrieve best possible Neighbour Cell
  Target:=GetNextNeighbour(AX, AY, AMaze, AStack);
  AX:=Target.X;
  AY:=Target.Y;

  if (AX = -1) AND (AY = -1) then
  begin
    Target:=AStack.Pop;
    FSolution.Add(Target);
    
    if AStack.Count > 0 then
      DepthSearchMaze(Target.X, Target.Y, AMaze, AStack, True)
    else
      Exit;
  end else
    DepthSearchMaze(AX, AY, AMaze, AStack);
end;

procedure TMain.dgMapDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  I: Integer;
  SolutionPoint: TRect;
  CellText: String;
begin
  if Length(FMaze) > 0 then
    if Length(FMaze[0]) > 0 then
      with TDrawGrid(Sender) do
      begin
        if FMaze[ACol][ARow] = 1 then
        begin
          Canvas.Brush.Color:=clSkyBlue;
          Canvas.FillRect(Rect);
        end;
      end;

  for I := 0 to FSolution.Count-1 do
  begin
    with TDrawGrid(Sender) do
    begin
      SolutionPoint:=CellRect(FSolution[I].X, FSolution[I].Y);
      CellText:=IntToStr(I);
      Canvas.TextRect(SolutionPoint, SolutionPoint.CenterPoint.X, SolutionPoint.CenterPoint.Y, 
        CellText);
    end;
  end;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetLength(FMaze, 0);

  FSolution.Clear;
  FreeAndNil(FSolution);
end;

procedure TMain.FormCreate(Sender: TObject);
var
  I: Integer;
  Points: TStack<TPoint>;
begin
  try
    FSolution:=TList<TPoint>.Create;
    
    Points:=TStack<TPoint>.Create;
    Points.Clear;

    SetLength(FMaze, MAZE_WIDTH);
    for I := 0 to Length(FMaze)-1 do
      SetLength(FMaze[I], MAZE_HEIGHT);

    dgMap.ColCount:=MAZE_WIDTH;
    dgMap.RowCount:=MAZE_HEIGHT;

    DepthSearchMaze(0, 0, FMaze, Points);
  finally
    Points.Clear;
    FreeAndNil(Points);
  end;
end;

function TMain.GetNextNeighbour(AX, AY: Integer; AMaze: TMazeGrid; AStack: TStack<TPoint>): TPoint;
var
  HasSolution: Boolean;
  I: Integer;
  Times: Integer;
  Dir: Integer;
begin
  HasSolution:=False;
  Times:=4;

  repeat
    Dir:=Random(4);
    
    case Dir of
      0:  
      begin
        if AX + 1 < Length(AMaze) then
          if AMaze[AX + 1][AY] <> 1 then
            if (AStack.Peek.X <> AX + 1) AND (AX + 1 < Length(AMaze)) then
            begin
              HasSolution:=True;
              Result.Create(AX + 1, AY);
              Exit;
            end;
            
        Dec(Times);
      end;

      1:
      begin
        if AX - 1 > -1 then
          if AMaze[AX - 1][AY] <> 1 then
            if (AStack.Peek.X <> AX - 1) AND (AX - 1 > -1) then
            begin
              HasSolution:=True;
              Result.Create(AX - 1, AY);
              Exit;
            end;
            
        Dec(Times);
      end;

      2:
      begin
        if AY + 1 < Length(AMaze[0]) then
          if AMaze[AX][AY + 1] <> 1 then
            if (AStack.Peek.Y <> AY + 1) AND (AY + 1 < Length(AMaze[0])) then
            begin
              HasSolution:=True;
              Result.Create(AX, AY + 1);
              Exit;
            end;
            
        Dec(Times);
      end;
      
      3:
      begin
        if AY - 1 > -1 then
          if AMaze[AX][AY - 1] <> 1 then
            if (AStack.Peek.Y <> AY - 1) AND (AY - 1 > -1) then
            begin
              HasSolution:=True;
              Result.Create(AX, AY - 1);
              Exit;
            end;
            
        Dec(Times);
      end;
    end;
  until Times = 0;

  if HasSolution = False then
    Result.Create(-1, -1);
end;

end.
