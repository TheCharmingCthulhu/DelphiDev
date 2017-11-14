unit FormSandbox;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.Threading,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, sboxControls,
  sboxListbox;

type
  TfrmSandbox = class(TForm)
    StyleBook1: TStyleBook;
    lblInformation: TLabel;
    FrameListbox: TFrameListbox;
    procedure FormCreate(Sender: TObject);
    procedure lstItemsMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
  private
    procedure Initialize;
  public
  end;

var
  frmSandbox: TfrmSandbox;

implementation

{$R *.fmx}

procedure TfrmSandbox.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TfrmSandbox.Initialize;
begin
  TTask.Run(procedure
  var
    I: Integer;
  begin
    for I := 0 to 200 do
      TThread.Synchronize(nil, procedure
      begin
        if Assigned(FrameListbox.lstItems) then
          FrameListbox.lstItems.Items.Add(I.ToString);
      end);
  end);
end;

procedure TfrmSandbox.lstItemsMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
var
  Offset, Value: Single;
begin
//  Value:=WheelDelta - (WheelDelta mod Trunc(lstItems.ItemHeight));
//
//  Offset:=0;
//
//  lstItems.ScrollBy(0, Value);
//
//  if (WheelDelta < 0) then
//    Offset:=15;

//  ssbarScroll.Value:=Trunc(lstItems.ViewportPosition.Y/lstItems.ItemHeight) + Offset;

  Handled:=True;
end;

end.
