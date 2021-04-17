program Project1;

uses
  Vcl.Forms,
  OrderingGoods in 'OrderingGoods.pas' {ProductSelect},
  CommonElements in 'CommonElements.pas',
  Main in 'Main.pas' {FormMain},
  DataModule in 'DataModule.pas' {dm: TDataModule},
  ClientsList in 'ClientsList.pas' {FormClients},
  ClientAdd in 'ClientAdd.pas' {FormClientAdd},
  GoodsList in 'GoodsList.pas' {FormGoods},
  GoodsAdd in 'GoodsAdd.pas' {FormGoodsAdd},
  NewFutura in 'NewFutura.pas' {FormNewFutura},
  Report in 'Report.pas' {FormReport},
  Ñoming in 'Ñoming.pas' {FormComing},
  Graphic in 'Graphic.pas' {FormGraphic};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
