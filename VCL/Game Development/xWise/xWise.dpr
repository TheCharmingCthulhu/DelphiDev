program xWise;

{$APPTYPE GUI}

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Win.Registry,
  System.IniFiles,
  System.Generics.Defaults,
  System.Generics.Collections,
  System.Contnrs,
  System.SyncObjs,
  SfmlAudio in 'Src\SfmlAudio.pas',
  SfmlGraphics in 'Src\SfmlGraphics.pas',
  SfmlNetwork in 'Src\SfmlNetwork.pas',
  SfmlSystem in 'Src\SfmlSystem.pas',
  SfmlWindow in 'Src\SfmlWindow.pas',
  xwEngine in 'Src\xwEngine.pas',
  xwEngineTypes in 'Src\xwEngineTypes.pas';

var
  EngineState: TxwEngineState;
  Engine: TwxEngine;

begin
  try
    Engine:=TwxEngine.Create(ENGINE_FRAMETIME);

    while Engine.IsRunning do
    begin
      Engine.Update;
    end;
  finally
    FreeAndNil(Engine);
  end;
end.
