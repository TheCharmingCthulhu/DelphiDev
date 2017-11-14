unit ModelService;

interface

type
  TfiService = class
  private
    FName: String;
    FAmount: Currency;
    FDate: TDate;
  public
    constructor Create(AName: String; AAmount: Currency; ADate: TDate);

    property Name: String read FName write FName;
    property Amount: Currency read FAmount write FAmount;
    property Date: TDate read FDate write FDate;
  end;

implementation

{ TfiService }

{ TfiService }

constructor TfiService.Create(AName: String; AAmount: Currency; ADate: TDate);
begin
  FName:=AName;
  FAmount:=FAmount;
  FDate:=ADate;
end;

end.
