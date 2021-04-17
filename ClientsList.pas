unit ClientsList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Menus, Vcl.Grids,
  Vcl.DBGrids;

type
  TFormClients = class(TForm)
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
    ClientID : int64;
    ClientName : string;
  end;

var
  FormClients: TFormClients;

implementation

{$R *.dfm}

uses DataModule, ClientAdd;

procedure TFormClients.DBGrid1TitleClick(Column: TColumn);
var i : Integer;
begin
  IndexNo := Column.Index;
  case IndexNo of
  0:  dm.tClient.IndexName := 'PK_FIRM';
  1:  dm.tClient.IndexName := 'FIRM_IDX1';
  2:  dm.tClient.IndexFieldNames := 'INN;ID';
  3:  dm.tClient.IndexName := 'FIRM_IDX2';
  end;
  //dm.tClient.AfterOpen(nil);
  for i := 0 to DBGrid1.Columns.Count-1 do
    DBGrid1.Columns[i].Title.Font.Style := [];
  DBGrid1.Columns[IndexNo].Title.Font.Style := [fsBold];
end;

procedure TFormClients.FormActivate(Sender: TObject);
begin
  dm.tClient.Open;
  DataSource1.DataSet := dm.tClient;
  ClientID := 0;
  ClientName := '';
  if Tag = 1 then
    begin
      miExit.Caption := 'Выбор';
      DBGrid1.OnDblClick := miExitClick;
    end;
   DBGrid1TitleClick(DBGrid1.Columns[0]);
end;

procedure TFormClients.N2Click(Sender: TObject);
var newid : int64;
begin
  FormClientAdd := TFormClientAdd.Create(Application);
  FormClientAdd.ShowModal;
  if FormClientAdd.ModalResult = mrOk then
    begin
      newid := dm.ClientAdd(FormClientAdd.eName.Text,
                          FormClientAdd.eAddress.Text,
                          FormClientAdd.eINN.Text);
      dm.tClient.Refresh;
      DBGrid1.Columns[IndexNo].Title.Font.Style := [fsBold];
    end;
  dm.tClient.Locate('ID', newid, []);
  FormClientAdd.Release;
end;

procedure TFormClients.N3Click(Sender: TObject);
var id : int64;
begin
  FormClientAdd := TFormClientAdd.Create(Application);
  id := dm.tClient.FieldByName('ID').Value;
  FormClientAdd.eName.Text := dm.tClient.FieldByName('NAME').AsString;
  FormClientAdd.eAddress.Text := dm.tClient.FieldByName('ADDRESS').AsString;
  FormClientAdd.eINN.Text := dm.tClient.FieldByName('INN').AsString;
  FormClientAdd.ShowModal;
  if FormClientAdd.ModalResult = mrOk then
    begin
      dm.ClientEdit(id, FormClientAdd.eName.Text,
                        FormClientAdd.eAddress.Text,
                        FormClientAdd.eINN.Text);
      dm.tClient.Refresh;
      DBGrid1.Columns[IndexNo].Title.Font.Style := [fsBold];
      dm.tClient.Locate('ID', id, []);
    end;
  FormClientAdd.Release;
end;

procedure TFormClients.N4Click(Sender: TObject);
begin
  if MessageDlg('Удалить "' + dm.tClient.FieldByName('NAME').AsString+ '"?',
                mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      dm.ClientDelete(dm.tClient.FieldByName('ID').Value);
      dm.tClient.Refresh;
      DBGrid1.Columns[IndexNo].Title.Font.Style := [fsBold];
    end;

end;

procedure TFormClients.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClientID := dm.tClient.FieldByName('ID').AsLargeInt;
  ClientName := dm.tClient.FieldByName('NAME').AsString;
  dm.tClient.Close;
end;

procedure TFormClients.miExitClick(Sender: TObject);
begin
 Close;
end;

end.
