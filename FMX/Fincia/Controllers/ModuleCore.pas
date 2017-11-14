unit ModuleCore;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TModCore = class(TDataModule)
    sbTheme: TStyleBook;
  private
  public
  end;

var
  ModCore: TModCore;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
