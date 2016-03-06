unit tbMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvComponentBase, JvDockControlForm, JvDockTree, JvDockVIDStyle,
  Vcl.ExtCtrls, Vcl.ComCtrls, JvExComCtrls, JvListView, Vcl.StdCtrls, JvExStdCtrls, JvGroupBox, JvStatusBar, JvExControls, JvLabel, JvListComb,
  System.ImageList, Vcl.ImgList, JvImageList, tbwTechnobaseDataProvider;

type
  TMain = class(TForm)
    lvMediaLibrary: TJvListView;
    grpLiveFeed: TJvGroupBox;
    lbl1: TJvLabel;
    lbl2: TJvLabel;
    sbrFeedBar: TJvStatusBar;
    tmrLiveFeedTicker: TTimer;
    lblInfoDJOnAir: TJvLabel;
    lblInfoCurrentTrack: TJvLabel;
    imglst: TJvImageList;
    procedure FormCreate(Sender: TObject);
    procedure tmrLiveFeedTickerTimer(Sender: TObject);
  private

    procedure Initialize;
    procedure SynchronizeTime;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TMain.Initialize;
begin
  SynchronizeTime;
end;

procedure TMain.SynchronizeTime;
begin
  sbrFeedBar.Panels[0].Text := 'Time: ' + TimeToStr(Now);
end;

procedure TMain.tmrLiveFeedTickerTimer(Sender: TObject);
begin
  SynchronizeTime;
end;

end.
