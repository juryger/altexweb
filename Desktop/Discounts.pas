unit Discounts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, dbModule, Buttons, ExtCtrls;

type
  TDiscountsForm = class(TForm)
    DBGridEh3: TDBGridEh;
    gControlsPanel: TPanel;
    addDiscountButton: TSpeedButton;
    deleteDiscountButton: TSpeedButton;
    procedure addDiscountButtonClick(Sender: TObject);
    procedure deleteDiscountButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DiscountsForm: TDiscountsForm;

implementation

{$R *.dfm}

procedure TDiscountsForm.addDiscountButtonClick(Sender: TObject);
begin
   DBMod.TDiscounts.Insert;
   DBMod.TDiscountsID_COST_DCT.Value := DBMod.TDiscounts.RecordCount + 1;
end;

procedure TDiscountsForm.deleteDiscountButtonClick(Sender: TObject);
begin
   if (DBmod.TDiscounts.RecordCount = 0)
      then exit;

   if (DBmod.TDiscountsID_COST_DCT.Value >= 1) and (DBmod.TDiscountsID_COST_DCT.Value <= 3) then begin
      ShowMessage('Скидки с номерами от 1 до 3 не должны удаляться.');
      exit;
   end;

   if MessageDlg('Хотите удалить скидку от <'+ DBmod.TDiscountsSTART_SUMM.AsString+'> руб.?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;

   DBMod.TDiscounts.Edit;
   DBMod.TDiscountsDEL.Value := 1;
   DBMod.TDiscounts.Post;
end;

end.
