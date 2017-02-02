unit BeforePricePrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TBeforPricePrintForm = class(TForm)
    Label1: TLabel;
    PriceCheckBox: TCheckBox;
    ColorCatalogCheckBox: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BeforPricePrintForm: TBeforPricePrintForm;

implementation

{$R *.DFM}

end.
