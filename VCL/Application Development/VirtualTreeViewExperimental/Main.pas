unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    vst1: TVirtualStringTree;
    Button1: TButton;
    procedure vst1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure Button1Click(Sender: TObject);
    procedure vst1DrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  PVirtualItem = ^TVirtualItem;
  TVirtualItem = Record
    Id: Integer;
    Items: Array[0..9] of Integer;
  End;

procedure TForm1.Button1Click(Sender: TObject);
var
  I, J: Integer;
  Item: PVirtualNode;
  NodeData: TVirtualItem;
begin
  vst1.NodeDataSize := SizeOf(TVirtualItem);

  vst1.BeginUpdate;

  for I := 0 to 100 do
  begin
    NodeData.Id := I + 1000 * Random(100000);

    for J := 0 to 9 do
      NodeData.Items[J] := Random(J * 1);

    Item := vst1.AddChild(nil);
    Item.SetData(NodeData);
  end;

  NodeData.Id := -1;
  for J := 0 to 9 do
      NodeData.Items[J] := Random(J * 10000);

  Item := vst1.AddChild(nil);
  Item.SetData(NodeData);

  NodeData.Id := 0;
  for J := 0 to 9 do
      NodeData.Items[J] := Random(J * 1);

  Item := vst1.AddChild(nil);
  Item.SetData(NodeData);

  vst1.EndUpdate;
end;

procedure TForm1.vst1DrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; const Text: string;
  const CellRect: TRect; var DefaultDraw: Boolean);
var
  Spacing: Integer;
begin
  if Column = 0 then
    Spacing := 50;

  if vst1.Header.Columns[Column].Width < (vst1.Canvas.TextWidth(Text) + Spacing) then
    vst1.Header.Columns[Column].Width := vst1.Canvas.TextWidth(Text) + 50;
end;

procedure TForm1.vst1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  NodeData: PVirtualItem;
  I: Integer;
  ItemsText: string;
begin
  NodeData := Node.GetData;

  vst1.BeginUpdate;

  case Column of
    0:
    begin
      CellText := IntToStr(NodeData.Id);
    end;

    1:
    begin
      ItemsText := '';

      for I := 0 to 9 do
        ItemsText := ItemsText + IntToStr(NodeData.Items[I]);

      CellText := ItemsText;
    end;
  end;

  vst1.EndUpdate;
end;

end.
