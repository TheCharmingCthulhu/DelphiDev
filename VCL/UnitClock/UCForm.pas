unit UCForm;

interface

uses
  SysUtils, DateUtils, Winapi.Windows, Winapi.Messages, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExStdCtrls, JvHtControls,
  JvExControls, JvLookOut, Vcl.CheckLst, JvExCheckLst, JvCheckListBox,
  JvGroupBox, JvLabel, Vcl.Buttons, JvExButtons, JvBitBtn, JvEdit,
  RegularExpressions, UnitCore, StringExtensions, Vcl.ComCtrls, JvExComCtrls,
  JvListView, JvComCtrls, Vcl.Mask, JvExMask, JvSpin, JvButtons, Vcl.ExtCtrls,
  JvExExtCtrls, JvExtComponent, JvPanel, Vcl.ImgList, JvImageList;

type
  TMain = class(TForm)
    grpFixCostsMgr: TJvGroupBox;
    lblMonthInfo: TJvLabel;
    lblMonth: TJvLabel;
    lblStillToPayInfo: TJvLabel;
    lblStillToPay: TJvLabel;
    lblFixCostsInfo: TJvLabel;
    edtItemName: TJvEdit;
    edtItemCost: TJvEdit;
    btnInsert: TJvBitBtn;
    btnRemove: TJvBitBtn;
    lblItemNameInfo: TJvLabel;
    lblItemCostInfo: TJvLabel;
    lvFixCosts: TJvListView;
    grpMoneyCalc: TJvGroupBox;
    edtSpCash: TJvSpinEdit;
    lblCashInfo: TJvLabel;
    lblDaysInfo: TJvLabel;
    edtSpDays: TJvSpinEdit;
    lblRemainingCashInfo: TJvLabel;
    lblRemainingCash: TJvLabel;
    lblPossibleSavingsInfo: TJvLabel;
    lblPossibleSavings: TJvLabel;
    pcUnitClock: TJvPageControl;
    tsUnitUtilities: TTabSheet;
    tsProjectManager: TTabSheet;
    lvProjectManager: TJvListView;
    lblProjectListInfo: TJvLabel;
    pnlTools: TJvPanel;
    imglstStatus: TJvImageList;
    procedure btnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lstFixCostsClickCheck(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure lvFixCostsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvFixCostsItemChecked(Sender: TObject; Item: TListItem);

    procedure CashAnalyzer_SetValues(Sender: TObject);
  private
    FFixCostMgr: TFixCostManager;
    FCashAnalyzer: TCashAnalyzer;

    procedure InitFixCostMgr;
    procedure FixCostMgr_OnItemUpdate;

    procedure InitCashAnalyzer;
    procedure CashAnalyzer_OnCashUpdate(const ARemainingCash: Currency);

    procedure CalculateStillToPay;
  public
    { Public declarations }
  end;

var
  Main: TMain;

const
  CURRENCY_TYPE: string = 'EUR';

implementation

{$R *.dfm}

procedure TMain.btnInsertClick(Sender: TObject);
var
  RegEx: TRegEx;
  Name: string;
  Cost: Currency;
begin
  if NOT (edtItemName.IsEmpty) AND
     NOT (edtItemCost.IsEmpty) then
  begin
    RegEx.Create('[A-z0-9,]{1,}');
    if RegEx.IsMatch(edtItemName.Text) then
      Name := RegEx.Match(edtItemName.Text).Value;

    if RegEx.IsMatch(edtItemCost.Text) then
      Cost := StrToCurr(RegEx.Match(edtItemCost.Text).Value);

    FFixCostMgr.AddItem(Name, Cost);
  end;
end;

procedure TMain.btnRemoveClick(Sender: TObject);
begin
  if lvFixCosts.ItemIndex <> -1 then
    FFixCostMgr.RemoveItem(lvFixCosts.ItemIndex);
end;

procedure TMain.CalculateStillToPay;
var
  StillToPay: Currency;
  I: Integer;
begin
  StillToPay := 0;

  for I := 0 to lvFixCosts.Items.Count-1 do
  begin
    if NOT lvFixCosts.Items[I].Checked then
    begin
      StillToPay := StillToPay + FFixCostMgr.Items[I].Cost;
    end;
  end;

  lblStillToPay.Caption := CurrToStrF(StillToPay, ffFixed, 2) + ' ' + CURRENCY_TYPE;
end;

procedure TMain.CashAnalyzer_OnCashUpdate(const ARemainingCash: Currency);
begin
  lblRemainingCash.Caption :=
    CurrToStrF(ARemainingCash, ffFixed, 2) + ' ' + CURRENCY_TYPE;
end;

procedure TMain.CashAnalyzer_SetValues(Sender: TObject);
begin
  if(edtSpCash.Value > 0) AND
    (edtSpDays.Value > 0) then
  begin
    FCashAnalyzer.SetCash(edtSpCash.Value);
    FCashAnalyzer.SetDays(Round(edtSpDays.Value));
  end;
end;

procedure TMain.FixCostMgr_OnItemUpdate;
var
  I: Integer;
  LItem: TJvListItem;
begin
  lvFixCosts.Items.BeginUpdate;
  for I := 0 to lvFixCosts.Items.Count-1 do
  begin
    lvFixCosts.Items.Item[I].Free;
  end;
  lvFixCosts.Items.Clear;

  for I := 0 to FFixCostMgr.ItemCount-1 do
  begin
    LItem := lvFixCosts.Items.AddItem(nil);
    LItem.Caption := FFixCostMgr.Items[I].Name;
    LItem.SubItems.Add(CurrToStrF(FFixCostMgr.Items[I].Cost, ffFixed, 2) + ' ' + CURRENCY_TYPE);
    LItem.Checked := False;
  end;
  lvFixCosts.Items.EndUpdate;

  CalculateStillToPay;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  InitFixCostMgr;
  InitCashAnalyzer;
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  FFixCostMgr.SaveToFile;
  FreeAndNil(FFixCostMgr);

  FreeAndNil(FCashAnalyzer);
end;

procedure TMain.InitCashAnalyzer;
begin
  FCashAnalyzer := TCashAnalyzer.Create;
  FCashAnalyzer.OnCashUpdate := CashAnalyzer_OnCashUpdate;
end;

procedure TMain.InitFixCostMgr;
var
  Y, M, D: Word;
begin
  FFixCostMgr := TFixCostManager.Create;
  FFixCostMgr.OnItemUpdate := FixCostMgr_OnItemUpdate;
  FFixCostMgr.LoadFromFile;

  // Initialize Month Name.
  DecodeDate(Now, Y, M, D);
  lblMonth.Caption := FormatSettings.LongMonthNames[MonthOfTheYear(Now)];
end;

procedure TMain.lstFixCostsClickCheck(Sender: TObject);
begin
  CalculateStillToPay;
end;

procedure TMain.lvFixCostsItemChecked(Sender: TObject; Item: TListItem);
begin
  CalculateStillToPay;
end;

procedure TMain.lvFixCostsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if lvFixCosts.ItemIndex <> -1 then
  begin
    btnRemove.Enabled := True;
  end else
  begin
    btnRemove.Enabled := False;
  end;
end;

end.
