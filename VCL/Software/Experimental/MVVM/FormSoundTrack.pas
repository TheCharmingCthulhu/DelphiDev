unit FormSoundTrack;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SoundTrackViewModel, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TSoundTrackForm = class(TForm)
    btnOK: TBitBtn;
    edtTitle: TLabeledEdit;
    edtArtist: TLabeledEdit;
    edtAlbum: TLabeledEdit;
    edtDuration: TLabeledEdit;
    dtpDate: TDateTimePicker;
    Label1: TLabel;
    btnCancel: TBitBtn;
    procedure edtTitleChange(Sender: TObject);
    procedure edtArtistChange(Sender: TObject);
    procedure edtAlbumChange(Sender: TObject);
    procedure edtDurationChange(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
  private
    FViewModel: TSoundTrackViewModel;
  public
    class function Run(AOwner: TComponent; AViewModel: TSoundTrackViewModel): TModalResult;

    property ViewModel: TSoundTrackViewModel read FViewModel write FViewModel;
  end;

var
  SoundTrackForm: TSoundTrackForm;

implementation

{$R *.dfm}

{ TSoundTrackForm }

procedure TSoundTrackForm.dtpDateChange(Sender: TObject);
begin
  FViewModel.SoundTrack.AssignDate(Date);
end;

procedure TSoundTrackForm.edtAlbumChange(Sender: TObject);
begin
  FViewModel.SoundTrack.Album:=edtAlbum.Text;
end;

procedure TSoundTrackForm.edtArtistChange(Sender: TObject);
begin
  FViewModel.SoundTrack.Artist:=edtArtist.Text;
end;

procedure TSoundTrackForm.edtDurationChange(Sender: TObject);
begin
  FViewModel.SoundTrack.Duration:=edtDuration.Text;
end;

procedure TSoundTrackForm.edtTitleChange(Sender: TObject);
begin
  FViewModel.SoundTrack.Title:=edtTitle.Text;
end;

class function TSoundTrackForm.Run(AOwner: TComponent; AViewModel: TSoundTrackViewModel): TModalResult;
var
  Form: TSoundTrackForm;
begin
  Form:=TSoundTrackForm.Create(AOwner);
  Form.ViewModel:=AViewModel;
  Result:=Form.ShowModal;
end;

end.
