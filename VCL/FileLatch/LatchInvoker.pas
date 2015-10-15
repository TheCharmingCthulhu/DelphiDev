unit LatchInvoker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TLInvoker = class(TForm)
    lblInfFileName: TLabel;
    lblInfFilePath: TLabel;
    lblFileName: TLabel;
    edtPath: TEdit;
    btnFilePath: TButton;
    btnOk: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LInvoker: TLInvoker;

implementation

{$R *.dfm}

end.
