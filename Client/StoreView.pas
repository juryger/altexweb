unit StoreView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask;

type
  TStoreViewForm = class(TForm)
    Label1: TLabel;
    BalanceBox: TEdit;
    Label2: TLabel;
    IncomeBox: TEdit;
    Label3: TLabel;
    OutcomeBox: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure closeButtonClick(Sender: TObject);
    procedure IncomeBoxExit(Sender: TObject);
    procedure OutcomeBoxExit(Sender: TObject);
    procedure IncomeBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OutcomeBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    num: Integer;
    income: Integer;
    outcome: Integer;
  end;

var
  StoreViewForm: TStoreViewForm;

implementation

{$R *.dfm}

procedure TStoreViewForm.closeButtonClick(Sender: TObject);
begin
  Close();
end;

procedure TStoreViewForm.IncomeBoxExit(Sender: TObject);
begin
  if (IncomeBox.Text <> '0') then
    OutcomeBox.Text := '0';
end;

procedure TStoreViewForm.OutcomeBoxExit(Sender: TObject);
begin
  if (OutcomeBox.Text <> '0') then
    IncomeBox.Text := '0';
end;

procedure TStoreViewForm.IncomeBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key < 48) AND (Key > 57) then
    IncomeBox.Text := '0';
end;

procedure TStoreViewForm.OutcomeBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key < 48) AND (Key > 57) then
    OutcomeBox.Text := '0';
end;

procedure TStoreViewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  income := StrToInt(IncomeBox.Text);
  outcome := StrToInt(OutcomeBox.Text);
end;

procedure TStoreViewForm.FormShow(Sender: TObject);
begin
  BalanceBox.Text := IntToStr(num);
end;

end.
