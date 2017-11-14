unit FormFincia;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls, Data.Bind.Components,
  Data.Bind.ObjectScope, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, FMX.Layouts, FMX.ListBox, ModelService,
  FMX.Grid.Style, Fmx.Bind.Grid, Data.Bind.Grid, FMX.ScrollBox, FMX.Grid;

type
  TFrmFincia = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    procedure absServiceCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFincia: TFrmFincia;

implementation

{$R *.fmx}
{$R *.Surface.fmx MSWINDOWS}
{$R *.Windows.fmx MSWINDOWS}

uses
  ModuleCore;

procedure TFrmFincia.absServiceCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
var
  Adapter: TListBindSourceAdapter<TfiService>;
  List: TList<TfiService>;
begin
  List:=TList<TfiService>.Create;
  List.Add(TfiService.Create('Smartphone', 11.25, Now));

  Adapter:=TListBindSourceAdapter<TfiService>.Create(Self);
  Adapter.SetList(List);

  ABindSourceAdapter:=Adapter;
end;

end.
