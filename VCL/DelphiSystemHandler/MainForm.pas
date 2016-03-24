unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, JvExExtCtrls,
  JvExtComponent, JvPanel, Vcl.StdCtrls, Vcl.Buttons, JvExButtons, JvButtons,
  Vcl.ComCtrls, JvExComCtrls, JvComCtrls, sButton, sPageControl, acHeaderControl,
  sSkinManager, sListBox, sLabel, sPanel, Vcl.Grids, Vcl.ValEdit, sComboBox, dshLibrary;

type
  TMain = class(TForm)
    pcUtilities: TsPageControl;
    tsLibrary: TsTabSheet;
    sButton1: TsButton;
    lstLibraries: TsListBox;
    smAlphaSkin: TsSkinManager;
    p1: TsPanel;
    lbl1: TsLabel;
    p2: TsPanel;
    btnLoadSourcePath: TsButton;
    btnClear: TsButton;
    btnAdd: TsButton;
    p3: TsPanel;
    lbl2: TsLabel;
    cbbDelphiVersion: TsComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FLibraryMgr: TdshLibraryManager;

    procedure Initialize;
    procedure Finalize;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.Finalize;
begin

end;

procedure TMain.FormCreate(Sender: TObject);
begin
  FLibraryMgr := TdshLibraryManager.Create;

  Initialize;
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FLibraryMgr);

  Finalize;
end;

procedure TMain.Initialize;
begin

end;

end.
