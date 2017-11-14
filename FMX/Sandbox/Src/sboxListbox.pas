unit sboxListbox;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox;

type
  TFrameListbox = class(TFrame)
    sbarScroll: TScrollBar;
    lstItems: TListBox;
    procedure sbarScrollChange(Sender: TObject);
  private
  public
    function AddListboxItem(AControl: TFmxObject): TListboxItem;

    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.fmx}

function TFrameListbox.AddListboxItem(AControl: TFmxObject): TListboxItem;
begin
end;

constructor TFrameListbox.Create(AOwner: TComponent);
begin
  inherited;

  lstItems.ShowScrollBars:=False;

  sbarScroll.ValueRange.ViewportSize:=100;
  sbarScroll.ValueRange.Frequency:=0;
end;

procedure TFrameListbox.sbarScrollChange(Sender: TObject);
begin
  lstItems.ScrollToItem(lstItems.ItemByIndex(Trunc(sbarScroll.ValueRange.RelativeValue * lstItems.Count-1)));
end;

end.
