unit NotifyExample;

interface

uses
  SysUtils, Classes;
type
  TNotifyEvent = procedure of object;

  TItem = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FName: String;
    FAmount: Integer;
    FPrice: Currency;
    FCost: Currency;
  public
    constructor Create(const AName: String;
      const ACallback: TNotifyEvent);
    destructor Destroy; override;

    procedure SetPrice(const APrice: Currency);
    procedure SetAmount(const AAmount: Integer);

    property Name: String read FName;
    property Amount: Integer read FAmount;
    property Price: Currency read FPrice;
    property Cost: Currency read FCost;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

{ TItem }

constructor TItem.Create(const AName: String; const ACallback: TNotifyEvent);
begin
  FName := AName;
  FOnChange := ACallback;
end;

destructor TItem.Destroy;
begin

  inherited;
end;

procedure TItem.SetAmount(const AAmount: Integer);
begin
  FAmount := AAmount;
  FCost := FPrice * FAmount;
  if Assigned(FOnChange) then
    FOnChange;
end;

procedure TItem.SetPrice(const APrice: Currency);
begin
  FPrice := APrice;
  if Assigned(FOnChange) then
    FOnChange;
end;

end.
