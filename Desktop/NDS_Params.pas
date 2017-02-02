unit NDS_Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TNdsParamsForm = class(TForm)
    GroupBox1: TGroupBox;
    simpleViewRadioButton: TRadioButton;
    ndsViewRadioButton: TRadioButton;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    noNdsViewRadioButton: TRadioButton;
    TicketCheckBox: TCheckBox;
    InvoiceCheckBox: TCheckBox;
    procedure ndsViewRadioButtonClick(Sender: TObject);
    procedure simpleViewRadioButtonClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure noNdsViewRadioButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NdsParamsForm: TNdsParamsForm;

implementation

uses dbModule;

{$R *.DFM}

procedure TNdsParamsForm.ndsViewRadioButtonClick(Sender: TObject);
begin
   Edit1.Color := clWindow;
   Edit1.ReadOnly := false;
   TicketCheckBox.Enabled := true;
   InvoiceCheckBox.Enabled := true;
end;

procedure TNdsParamsForm.noNdsViewRadioButtonClick(Sender: TObject);
begin
   Edit1.Color := clBtnFace;
   Edit1.ReadOnly := true;
   TicketCheckBox.Enabled := true;
   InvoiceCheckBox.Enabled := true;
end;

procedure TNdsParamsForm.simpleViewRadioButtonClick(Sender: TObject);
begin
   Edit1.Color := clBtnFace;
   Edit1.ReadOnly := true;
   TicketCheckBox.Enabled := false;
   InvoiceCheckBox.Enabled := false;
end;

procedure TNdsParamsForm.BitBtn1Click(Sender: TObject);
begin
   DBMod.TINF.Edit;
   DBMod.TINF.FieldByName('NDS').AsFloat := StrToFloat(Edit1.Text);
   DBMod.TINF.Post;
end;

end.
