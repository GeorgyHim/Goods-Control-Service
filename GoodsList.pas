unit GoodsList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Menus, Vcl.Grids,
  Vcl.DBGrids;

type
  TFormGoods = class(TForm)
    MainMenu1: TMainMenu;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    miExit: TMenuItem;
    procedure miExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    IndexNo : Integer;
  public
    { Public declarations }
    GoodsID : int64;
    GoodsName : string;
  end;

var
  FormGoods: TFormGoods;

implementation

{$R *.dfm}

uses DataModule, GoodsAdd;

procedure TFormGoods.DBGrid1TitleClick(Column: TColumn);
var i : Integer;
begin
  IndexNo := Column.Index;
  case IndexNo of
  0:  dm.tGoods.IndexName := 'PK_GOODS';
  1:  dm.tGoods.IndexName := 'GOODS_IDX1';
  2:  dm.tGoods.IndexFieldNames := 'MESURE;ID';
  3:  dm.tGoods.IndexName := 'GOODS_IDX2';
  end;
  dm.tGoods.AfterOpen(nil);
  for i := 0 to DBGrid1.Columns.Count-1 do
    DBGrid1.Columns[i].Title.Font.Style := [];
  DBGrid1.Columns[IndexNo].Title.Font.Style := [fsBold];

end;

procedure TFormGoods.FormActivate(Sender: TObject);
begin
  dm.tGoods.Open;
  DataSource1.DataSet := dm.tGoods;
  GoodsID := 0;
  GoodsName := '';
  if Tag = 1 then
    begin
      miExit.Caption := 'Выбор';
      DBGrid1.OnDblClick := miExitClick;
    end;
  DBGrid1TitleClick(DBGrid1.Columns[0]);
end;

procedure TFormGoods.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GoodsID := dm.tGoods.FieldByName('ID').AsLargeInt;
  GoodsName := dm.tGoods.FieldByName('NAME').AsString;
  dm.tGoods.Close;
end;

procedure TFormGoods.N2Click(Sender: TObject);
  var newid : int64;
begin
  FormGoodsAdd := TFormGoodsAdd.Create(Application);
  FormGoodsAdd.ShowModal;
  if FormGoodsAdd.ModalResult = mrOk then
    begin
      newid := dm.GoodsAdd(FormGoodsAdd.eName.Text,
                          FormGoodsAdd.eMeasure.Text,
                          StrToFloat(FormGoodsAdd.eVAT.Text));
      dm.tGoods.Refresh;
      DBGrid1.Columns[IndexNo].Title.Font.Style := [fsBold];
      dm.tGoods.Locate('ID', newid, []);
    end;
  FormGoodsAdd.Release;
end;

procedure TFormGoods.N3Click(Sender: TObject);
var id : int64;
begin
  FormGoodsAdd := TFormGoodsAdd.Create(Application);
  id := dm.tGoods.FieldByName('ID').Value;
  FormGoodsAdd.eName.Text := dm.tGoods.FieldByName('NAME').AsString;
  FormGoodsAdd.eMeasure.Text := dm.tGoods.FieldByName('MESURE').AsString;
  FormGoodsAdd.eVAT.Text := dm.tGoods.FieldByName('VAT').AsString;
  FormGoodsAdd.eQNT.Text := dm.tGoods.FieldByName('QNT').AsString;
  FormGoodsAdd.ShowModal;
  if FormGoodsAdd.ModalResult = mrOk then
    begin
      dm.GoodsEdit(id, FormGoodsAdd.eName.Text,
                        FormGoodsAdd.eMeasure.Text,
                        StrToFloat(FormGoodsAdd.eVAT.Text),
                        StrToFloat(FormGoodsAdd.eQNT.Text));
      dm.tGoods.Refresh;
      DBGrid1.Columns[IndexNo].Title.Font.Style := [fsBold];
    end;
  dm.tGoods.Locate('ID', id, []);
  FormGoodsAdd.Release;
end;

procedure TFormGoods.N4Click(Sender: TObject);
begin
  if MessageDlg('Удалить "' + dm.tGoods.FieldByName('NAME').AsString+ '"?',
                mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      dm.GoodsDelete(dm.tGoods.FieldByName('ID').Value);
      dm.tGoods.Refresh;
      DBGrid1.Columns[IndexNo].Title.Font.Style := [fsBold];
    end;
end;

procedure TFormGoods.miExitClick(Sender: TObject);
begin
  Close;
end;

end.
