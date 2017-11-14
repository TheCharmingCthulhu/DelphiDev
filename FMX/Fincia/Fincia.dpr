program Fincia;

uses
  System.StartUpCopy,
  FMX.Forms,
  FormFincia in 'Views\FormFincia.pas' {FrmFincia},
  ModuleCore in 'Controllers\ModuleCore.pas' {ModCore: TDataModule},
  ModelService in 'Models\ModelService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TModCore, ModCore);
  Application.CreateForm(TFrmFincia, FrmFincia);
  Application.Run;
end.
