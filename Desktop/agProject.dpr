program agProject;

uses
  Forms,
  MAIN in 'MAIN.PAS' {MainForm},
  Sklad in 'Sklad.pas' {SkladForm},
  Logo in 'Logo.pas' {LogoForm},
  dbModule in 'dbModule.pas' {DBmod: TDataModule},
  Nakladnaya in 'Nakladnaya.pas' {NaklForm},
  Sum_Propis_3 in 'Sum_Propis_3.pas',
  DatePickUp in 'DatePickUp.pas' {DPickUpForm},
  Price in 'Price.pas' {PriceForm},
  NDS_Params in 'NDS_Params.pas' {NdsParamsForm},
  Rekvizits in 'Rekvizits.pas' {RekForm},
  UnitMeasuring in 'UnitMeasuring.pas' {UnitMeasuringForm},
  ImagePrepare in 'ImagePrepare.pas' {ImageEditorForm},
  BeforePricePrint in 'BeforePricePrint.pas' {BeforPricePrintForm},
  StoreView in 'StoreView.pas' {StoreViewForm},
  Store in 'Store.pas' {StoreForm},
  AppSettingsHelper in 'AppSettingsHelper.pas',
  FixBDE4GbBug in 'FixBDE4GbBug.pas',
  Discounts in 'Discounts.pas' {DiscountsForm},
  AccountParams in 'AccountParams.pas' {frmAccountParams},
  About in 'about.pas' {AboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Алтех Хозтовары';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDBmod, DBmod);
  Application.CreateForm(TDPickUpForm, DPickUpForm);
  Application.CreateForm(TNdsParamsForm, NdsParamsForm);
  Application.CreateForm(TRekForm, RekForm);
  Application.CreateForm(TUnitMeasuringForm, UnitMeasuringForm);
  Application.CreateForm(TBeforPricePrintForm, BeforPricePrintForm);
  Application.CreateForm(TDiscountsForm, DiscountsForm);
  Application.CreateForm(TfrmAccountParams, frmAccountParams);
  Application.CreateForm(TAboutBox, AboutBox);
  //Application.CreateForm(TSkladForm, SkladForm);
  Application.Run;
end.
