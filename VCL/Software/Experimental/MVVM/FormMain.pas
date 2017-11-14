unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, MainViewModel, FormSoundTrack, Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    btnNew: TBitBtn;
    lvSoundTracks: TListView;
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FViewModel: TMainViewModel;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnNewClick(Sender: TObject);
begin
  if TSoundTrackForm.Run(Self, FViewModel.SoundTrackViewModel) = mrOk then
    FViewModel.CreateTrack;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FViewModel:=TMainViewModel.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FViewModel);
end;

end.

