unit NotifyEventForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  NotifyExample, RegularExpressions;

type
  TNotifyForm = class(TForm)
    btnAccept: TButton;
    edtItemName: TEdit;
    lblItemName: TLabel;
    lblItemAmount: TLabel;
    edtItemAmount: TEdit;
    lblDefaultPrice: TLabel;
    edtItemPrice: TEdit;
    lblCosts: TLabel;
    edtItemCost: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);
  private
    procedure OnItemChange;
  public
    { Public declarations }
  end;

var
  NotifyForm: TNotifyForm;
  Item: TItem;

implementation

{$R *.dfm}

procedure TNotifyForm.btnAcceptClick(Sender: TObject);
var
  RegEx: TRegEx;
  PriceMatch: TMatch;
  AmountMatch: TMatch;
begin
  if (Length(edtItemAmount.Text) > 0) AND
     (Length(edtItemPrice.Text) > 0) AND
      Assigned(Item) then
  begin
    RegEx.Create('[0-9,]{1,}');
    if RegEx.IsMatch(edtItemPrice.Text) then
      PriceMatch := RegEx.Match(edtItemPrice.Text);

    if RegEx.IsMatch(edtItemAmount.Text) then
      AmountMatch := RegEx.Match(edtItemAmount.Text);

    Item.SetPrice(StrToCurr(PriceMatch.Value));
    Item.SetAmount(StrToInt(AmountMatch.Value));
  end;
end;

procedure TNotifyForm.FormCreate(Sender: TObject);
begin
  Item := TItem.Create('Water', OnItemChange);
  Item.SetPrice(3.59);
end;

procedure TNotifyForm.OnItemChange;
begin
  if Assigned(Item) then
  begin
    edtItemName.Text := Item.Name;
    edtItemAmount.Text := Item.Amount.ToString + ' of ' + Item.Name;
    edtItemPrice.Text := '$' + CurrToStr(Item.Price);
    edtItemCost.Text := '$' + CurrToStr(Item.Cost);
  end;
end;

end.
