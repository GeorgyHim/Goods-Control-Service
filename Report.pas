unit Report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, IBX.IBQuery, Vcl.CheckLst;

type
  TFormReport = class(TForm)
    Panel1: TPanel;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Button1: TButton;
    DataSource1: TDataSource;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    CheckListBox1: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    allClients : TStringList;
  public
    { Public declarations }
  end;

var
  FormReport: TFormReport;

implementation

{$R *.dfm}

uses DataModule;

procedure TFormReport.Button1Click(Sender: TObject);
var s, selClients, selFuturaWait, selGoods : WideString;
  i, j, k : Integer;
begin
  dm.DestroyTMPQuery(DataSource1.DataSet as TIBQuery);
  s := 'select * from REPORT_FOR_CLIENTS('
      + '''' + DateToStr(DateTimePicker1.Date) + ''') ';

  k := 0;
  for i  := 0 to CheckListBox1.Count - 1 do
      if CheckListBox1.Checked[i] then
        inc(k);

  if k > 0 then begin
    selClients := '(';
    j := 0;
    for i  := 0 to CheckListBox1.Count - 1 do
      if CheckListBox1.Checked[i] then begin
        inc(j);
        selClients := selClients + allClients[i];
        if j = k then
          selClients := selClients + ')'
        else
          selClients := selClients + ', ';
      end;

      // id ожидающих накладных
      selFuturaWait := '( select id from FUTURA where '
            + 'substring(futura_no FROM char_length(futura_no) FOR 1) = ''-'' '
                        + 'and  CLIENT_ID in ' + selClients + ') ';

      // Все товары в ожидающих накладных
      selGoods := '( select G_NAME from futura_info where FUTURA_ID in '
                  + selFuturaWait + ') ';

      s := s + ' where G_NAME in ' + selGoods + ' order by G_NAME';
  end;



  DataSource1.DataSet := dm.GetTMPQuery(s);
  (DataSource1.DataSet as TIBQuery).Close;
  (DataSource1.DataSet as TIBQuery).Open;

  with DataSource1.DataSet as TIBQuery do
    begin
      FieldByName('G_NAME').DisplayLabel := 'Наименование';
      FieldByName('G_NAME').DisplayWidth := 50;
      FieldByName('G_RESTS').DisplayLabel := 'Долги';
      FieldByName('G_MESURE').DisplayLabel := 'ед.изм.';
    end;

   Caption := 'Отчет на ' + DateToStr(DateTimePicker1.Date);
end;

procedure TFormReport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.DestroyTMPQuery(DataSource1.DataSet as TIBQuery);
  FreeAndNil(allClients);
end;

procedure TFormReport.FormCreate(Sender: TObject);
var i : integer;
q : TIBQuery;
s : WideString;
begin
  DataSource1.DataSet := nil;
  DateTimePicker1.Date := now;

  allClients := TStringList.Create;
  s := 'select id, name, inn from firm order by name';
  q := dm.GetTMPQuery(s);
  q.Open;
  q.First;
  while not q.Eof do
    begin
      CheckListBox1.Items.Add(q.FieldByName('NAME').AsString);
      allClients.Add((q.FieldByName('ID').AsString));
      q.Next;
    end;
  dm.DestroyTMPQuery(q);
end;

end.
