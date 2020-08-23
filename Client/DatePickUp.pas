unit DatePickUp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls;

type
  TDPickUpForm = class(TForm)
    MonthCalendar1: TMonthCalendar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    UseStoreCheckBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DPickUpForm: TDPickUpForm;

implementation

{$R *.DFM}

procedure TDPickUpForm.FormCreate(Sender: TObject);
begin
   MonthCalendar1.Date := Date();
end;

end.
