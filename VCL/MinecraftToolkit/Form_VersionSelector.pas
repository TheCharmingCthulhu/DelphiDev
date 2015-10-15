unit Form_VersionSelector;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  JvExStdCtrls, JvListBox,
  MCUnit, Form_ModdingToolkit;

type
  TVersionSelector = class(TForm)
    lboxVersions: TJvListBox;
    btnSelectVersion: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSelectVersionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure MCToolkitClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure Init;
    procedure Destruct;
  public
    { Public declarations }
  end;

var
  VersionSelector: TVersionSelector;
  MCInfo: TMinecraftInfo;
  MCToolkit: TModdingToolkit;
  MCGameInfo: TGameInfo;


implementation

{$R *.dfm}

procedure TVersionSelector.btnSelectVersionClick(Sender: TObject);
begin
  if lboxVersions.ItemIndex <> -1 then
  begin
    if Pos('Forge Mod Loader',
      lboxVersions.Items[lboxVersions.ItemIndex]) <> 0 then
    begin
      MCGameInfo.SetMinecraftVersion(lboxVersions.Items[lboxVersions.ItemIndex]);

      MCToolkit.MinecraftInfo := MCInfo;
      MCToolkit.GameVersionInfo := MCGameInfo;
      MCToolkit.Show;
      Hide;
    end;
  end;
end;

procedure TVersionSelector.FormCreate(Sender: TObject);
begin
  Init;
end;

procedure TVersionSelector.FormDestroy(Sender: TObject);
begin
  Destruct;
end;

procedure TVersionSelector.Init;
begin
  // CREATE THE MINECRAFT INFO OBJECT
  MCInfo := TMinecraftInfo.Create;
  lboxVersions.Items.AddStrings(MCInfo.Versions);

  // GAME INFO CREATION
  MCGameInfo := TGameInfo.Create;

  // CREATE MODDING TOOLKIT
  MCToolkit := TModdingToolkit.Create(self);
  MCToolkit.OnClose := MCToolkitClose;
end;

procedure TVersionSelector.MCToolkitClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Show;
end;

procedure TVersionSelector.Destruct;
begin
  FreeAndNil(MCInfo);
  FreeAndNil(MCToolkit);
  FreeAndNil(MCGameInfo);
end;

end.
