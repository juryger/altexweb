unit Rekvizits;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TRekForm = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    Edit2: TEdit;
    Label2: TLabel;
    Bevel2: TBevel;
    Edit3: TEdit;
    Label3: TLabel;
    Bevel3: TBevel;
    Edit4: TEdit;
    Label4: TLabel;
    Bevel4: TBevel;
    Edit5: TEdit;
    Label5: TLabel;
    Bevel5: TBevel;
    Edit6: TEdit;
    Label6: TLabel;
    Bevel6: TBevel;
    Panel2: TPanel;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RekForm: TRekForm;

implementation

uses dbModule;

{$R *.DFM}

procedure TRekForm.FormCreate(Sender: TObject);
begin
   if (DBmod.TEE.Active=false) then DBmod.TEE.Active := true;
   DBmod.TEE.First;
   if (DBmod.TEE.RecordCount>0) then
   begin
      Edit1.Text := DBmod.TEE.FieldByName('Seller').AsString;
      Edit2.Text := DBmod.TEE.FieldByName('Address').AsString;
      Edit3.Text := DBmod.TEE.FieldByName('INN').AsString;
      Edit4.Text := DBmod.TEE.FieldByName('Rsht').AsString;
      Edit5.Text := DBmod.TEE.FieldByName('Bik').AsString;
      Edit6.Text := DBmod.TEE.FieldByName('Ksht').AsString;
   end
   else begin
      Edit1.Clear; Edit2.Clear; Edit3.Clear; Edit4.Clear;
      Edit5.Clear; Edit6.Clear;
   end;
end;

procedure TRekForm.Panel1Click(Sender: TObject);
begin
   Close;
end;

procedure TRekForm.Panel2Click(Sender: TObject);
begin
   if (DBmod.TEE.RecordCount=0) then DBmod.TEE.Insert
   else DBmod.TEE.Edit;
   DBmod.TEE.FieldByName('Seller').AsString  := Edit1.Text;
   DBmod.TEE.FieldByName('Address').AsString  := Edit2.Text;
   DBmod.TEE.FieldByName('INN').AsString     := Edit3.Text;
   DBmod.TEE.FieldByName('Rsht').AsString    := Edit4.Text;
   DBmod.TEE.FieldByName('Bik').AsString     := Edit5.Text;
   DBmod.TEE.FieldByName('Ksht').AsString    := Edit6.Text;
   DBmod.TEE.Post;
   Close;
end;

end.
