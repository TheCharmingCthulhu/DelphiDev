unit rawGenerator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Win.Registry, System.IniFiles, System.Generics.Defaults,
  System.Generics.Collections, System.Contnrs, System.SyncObjs, rawInterpreter;

type
  TrawGenerator = class
  private
  protected
  public
    class procedure SaveToFile(ARawInterpreter: TrawInterpreterClass; const AFileName: String);
    class function LoadFromFile(ARawInterpreterClass: TrawInterpreterClass; const AFileName: String): TrawInterpreter;
  end;

implementation

{ TrawGenerator }

class function TrawGenerator.LoadFromFile(ARawInterpreterClass: TrawInterpreterClass; const AFileName: String):
  TrawInterpreter;
begin
  Result:=ARawInterpreterClass.Create;
end;

class procedure TrawGenerator.SaveToFile(ARawInterpreter: TrawInterpreterClass; const AFileName: String);
begin

end;

end.
