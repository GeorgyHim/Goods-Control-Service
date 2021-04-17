unit DataModule;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB, IBX.IBCustomDataSet,
  IBX.IBTable, IBX.IBStoredProc, IBX.IBQuery;

type
  Tdm = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    tClient: TIBTable;
    spClientAdd: TIBStoredProc;
    spClientEdit: TIBStoredProc;
    tGoods: TIBTable;
    spGoodsAdd: TIBStoredProc;
    spGoodsEdit: TIBStoredProc;
    tClientID: TLargeintField;
    tClientNAME: TIBStringField;
    tClientADDRESS: TIBStringField;
    tClientINN: TIBStringField;
    qFutura: TIBQuery;
    spFuturaAdd: TIBStoredProc;
    IBTransaction2: TIBTransaction;
    spFuturaInfoAdd: TIBStoredProc;
    qFuturaInfo: TIBQuery;
    qFuturaInfoFUTURA_ID: TLargeintField;
    qFuturaInfoGOODS_ID: TLargeintField;
    qFuturaInfoG_NAME: TIBStringField;
    qFuturaInfoPRICE: TIBBCDField;
    qFuturaInfoG_MESURE: TIBStringField;
    qFuturaInfoQUANTITY: TFMTBCDField;
    qFuturaInfoSUMMA: TIBBCDField;
    qFuturaInfoG_VAT: TFMTBCDField;
    qFuturaInfoVAT_SUMMA: TIBBCDField;
    qTmp: TIBQuery;
    qFuturaID: TLargeintField;
    qFuturaFUTURA_TYPE: TSmallintField;
    qFuturaFUTURA_DATE: TDateField;
    qFuturaFUTURA_NO: TIBStringField;
    qFuturaCLIENT_ID: TLargeintField;
    qFuturaDONE: TIBStringField;
    qFuturaNAME: TIBStringField;
    qFuturaINN: TIBStringField;
    qFuturaSUMMA: TIBBCDField;
    qFuturaVAT_SUMMA: TIBBCDField;
    spFindDelivery: TIBStoredProc;
    procedure tGoodsAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function ClientAdd(cName, cAddress, cINN : string) : int64;
    procedure ClientEdit(cID : int64; cName, cAddress, cINN : string);
    procedure ClientDelete(cID : int64);

    function GoodsAdd(cName, cMeasure: string; cVAT : Float32) : int64;
    procedure GoodsEdit(cID : int64; cName, cMeasure: string; cVAT, cQNT : Float32);
    procedure GoodsDelete(cID : int64);

    procedure SelectFutura(inType : Int8);
    function NewFutura(IN_TYPE : int8; IN_DATE : TDateTime;
        IN_NO : String; IN_F_ID : int64) : int64;
    procedure FuturaDelete(cID : int64);

    procedure NewFuturaInfo(IN_N_ID, IN_G_ID : int64;
                  IN_QNT, IN_SUMMA :  Double);
    procedure SelectFuturaInfo(inNID : Int64);
    procedure FuturaInfoDelete(nId, gId : int64);

    function GetRests(gId : int64; date : TDate) : Double;
    function GetTMPQuery(SQLstring : WideString) : TIBQuery;
    procedure DestroyTMPQuery(q : TIBQuery);

    procedure NewComing(gID : int64; qnt : Float32; date : TDate);

    procedure NewDelivery(deliv_date : TDate; deliv_no : string;
              cl_id : int64; success : boolean);

    function FindDelivery(IN_DATE : TDate; IN_CL_ID : int64;
                        IN_NO : string) : int64;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Main;

{$R *.dfm}

function Tdm.FindDelivery(IN_DATE : TDate; IN_CL_ID : int64;
                        IN_NO : string) : int64;
begin
  spFindDelivery.Params[1].Value := IN_DATE;
  spFindDelivery.Params[2].Value := IN_CL_ID;
  spFindDelivery.Params[3].Value := IN_NO;

  if (not spFindDelivery.Transaction.InTransaction) then
    spFindDelivery.Transaction.StartTransaction;
  spFindDelivery.ExecProc;
  Result := spFindDelivery.Params[0].Value;
  if spFindDelivery.Transaction.InTransaction then
    spFindDelivery.Transaction.Commit;
end;

procedure Tdm.NewDelivery(deliv_date : TDate; deliv_no : string;
              cl_id : int64; success : boolean);
begin
  // Создание накладной доставки
  NewFutura(0, deliv_date, deliv_no, cl_id)
end;


procedure Tdm.NewComing(gID : int64; qnt : Float32; date : TDate);
var sp : TIBStoredProc;
  id : int64;
begin
    // Создать Футуру с типом 1
    sp := TIBStoredProc.Create(nil);
    sp.Database := IBDatabase1;
    sp.Transaction := IBTransaction1;
    id := NewFutura(1, date, 'coming', 0);
    // Создаем поле для пришедшего товара
    NewFuturaInfo(id, gId, qnt, 0);
    FormMain.dsFutura.DataSet.DisableControls;
    FormMain.TabControl1Change(nil); // Обновляем набор значений для накладных
    dm.qFutura.Locate('ID', id, []);
    FormMain.dsFutura.DataSet.EnableControls;
end;

function Tdm.GetTMPQuery(SQLstring : WideString) : TIBQuery;
begin
  Result := TIBQuery.Create(nil);
  Result.Database := IBDatabase1;
  Result.Transaction := IBTransaction1;
  Result.SQL.Add(SQLstring);
  Result.FetchAll;
end;


procedure Tdm.DestroyTMPQuery(q : TIBQuery);
begin
  if Assigned(q) then
    FreeAndNil(q);
end;


function Tdm.GetRests(gId : int64; date : TDate) : Double;
begin
  qTmp.Close;
  qTmp.SQL.Clear;
  qTmp.SQL.Add('select * from GET_RESTS(' +
              IntToStr(gId) + ',''' + DateToStr(date) + ''')');
  qTmp.Open;
  qTmp.FetchAll;
  qTmp.First;
  Result := qTmp.Fields[0].AsFloat;
  qTmp.Close;
end;


procedure Tdm.NewFuturaInfo(IN_N_ID, IN_G_ID : int64;
                  IN_QNT, IN_SUMMA :  Double);
begin
  spFuturaInfoAdd.Params[0].Value := IN_N_ID;
  spFuturaInfoAdd.Params[1].Value := IN_G_ID;
  spFuturaInfoAdd.Params[2].AsFloat := IN_QNT;
  spFuturaInfoAdd.Params[3].AsFloat := IN_SUMMA;

  if (not spFuturaInfoAdd.Transaction.InTransaction) then
    spFuturaInfoAdd.Transaction.StartTransaction;
  spFuturaInfoAdd.ExecProc;
  if spFuturaInfoAdd.Transaction.InTransaction then
    spFuturaInfoAdd.Transaction.Commit;
end;

procedure Tdm.SelectFuturaInfo(inNID : Int64);
begin
  qFuturaInfo.Close;
  qFuturaInfo.ParamByName('inNID').Value := inNID;
  qFuturaInfo.Open;
end;


procedure Tdm.FuturaInfoDelete(nId, gId : int64);
var sp : TIBStoredProc;
begin
  try
    sp := TIBStoredProc.Create(nil);
    sp.Database := IBDatabase1;
    sp.Transaction := IBTransaction1;
    sp.StoredProcName := 'FUTURA_INFO_DELETE';
    sp.ParamByName('IN_N_ID').Value := nId;
    sp.ParamByName('IN_G_ID').Value := gId;
    if (not sp.Transaction.InTransaction) then
      sp.Transaction.StartTransaction;
    sp.ExecProc;
    if sp.Transaction.InTransaction then
      sp.Transaction.Commit;
  finally
    FreeAndNil(sp);
  end;
end;


function Tdm.NewFutura(IN_TYPE : int8; IN_DATE : TDateTime;
    IN_NO : String; IN_F_ID : int64) : int64;
begin
  spFuturaAdd.Params[1].Value := IN_TYPE;
  spFuturaAdd.Params[2].Value := IN_DATE;
  spFuturaAdd.Params[3].Value := IN_NO;
  spFuturaAdd.Params[4].Value := IN_F_ID;

  if (not spFuturaAdd.Transaction.InTransaction) then
    spFuturaAdd.Transaction.StartTransaction;
  spFuturaAdd.ExecProc;
  Result := spFuturaAdd.Params[0].Value;
  if spFuturaAdd.Transaction.InTransaction then
    spFuturaAdd.Transaction.Commit;
end;

procedure Tdm.FuturaDelete(cID : int64);
var sp : TIBStoredProc;
begin
  try
    sp := TIBStoredProc.Create(nil);
    sp.Database := IBDatabase1;
    sp.Transaction := IBTransaction1;
    sp.StoredProcName := 'FUTURA_DELETE';
    sp.ParamByName('IN_ID').Value := cID;
    if (not sp.Transaction.InTransaction) then
      sp.Transaction.StartTransaction;
    sp.ExecProc;
    if sp.Transaction.InTransaction then
      sp.Transaction.Commit;
  finally
    FreeAndNil(sp);
  end;
end;

procedure Tdm.SelectFutura(inType : Int8);
begin
  qFutura.Close;
  qFutura.ParamByName('in_type').Value := inType;
  qFutura.Open;
end;

function Tdm.ClientAdd(cName, cAddress, cINN : string) : int64;
begin
  spClientAdd.Params[0].Value := cName;
  spClientAdd.Params[1].Value := cAddress;
  spClientAdd.Params[2].Value := cINN;

  if (not spClientAdd.Transaction.InTransaction) then
    spClientAdd.Transaction.StartTransaction;
  spClientAdd.ExecProc;
  Result := spClientAdd.Params[3].Value;
  if spClientAdd.Transaction.InTransaction then
    spClientAdd.Transaction.Commit;
end;

procedure Tdm.ClientEdit(cID : int64; cName, cAddress, cINN : string);
begin
  spClientEdit.Params[0].Value := cID;
  spClientEdit.Params[1].Value := cName;
  spClientEdit.Params[2].Value := cAddress;
  spClientEdit.Params[3].Value := cINN;

  if (not spClientEdit.Transaction.InTransaction) then
    spClientEdit.Transaction.StartTransaction;
  spClientEdit.ExecProc;
  if spClientEdit.Transaction.InTransaction then
    spClientEdit.Transaction.Commit;

   FormMain.TabControl1Change(nil);
end;

procedure Tdm.ClientDelete(cID : int64);
var sp : TIBStoredProc;
begin
  try
    sp := TIBStoredProc.Create(nil);
    sp.Database := IBDatabase1;
    sp.Transaction := IBTransaction1;
    sp.StoredProcName := 'FIRM_DELETE';
    sp.ParamByName('IN_ID').Value := cID;
    if (not sp.Transaction.InTransaction) then
      sp.Transaction.StartTransaction;
    sp.ExecProc;
    if sp.Transaction.InTransaction then
      sp.Transaction.Commit;
  finally
    FreeAndNil(sp);
  end;
end;


procedure Tdm.GoodsDelete(cID : int64);
var sp : TIBStoredProc;
begin
  try
    sp := TIBStoredProc.Create(nil);
    sp.Database := IBDatabase1;
    sp.Transaction := IBTransaction1;
    sp.StoredProcName := 'GOODS_DELETE';
    sp.ParamByName('IN_ID').Value := cID;
    if (not sp.Transaction.InTransaction) then
      sp.Transaction.StartTransaction;
    sp.ExecProc;
    if sp.Transaction.InTransaction then
      sp.Transaction.Commit;
  finally
    FreeAndNil(sp);
  end;

end;

function Tdm.GoodsAdd(cName, cMeasure: string; cVAT : Float32) : int64;
begin
  spGoodsAdd.Params[1].Value := cName;
  spGoodsAdd.Params[2].Value := cMeasure;
  spGoodsAdd.Params[3].Value := cVAT;

  if (not spGoodsAdd.Transaction.InTransaction) then
    spGoodsAdd.Transaction.StartTransaction;
  spGoodsAdd.ExecProc;
  Result := spGoodsAdd.Params[0].Value;
  if spGoodsAdd.Transaction.InTransaction then
    spGoodsAdd.Transaction.Commit;
end;

procedure Tdm.GoodsEdit(cID : int64; cName, cMeasure: string;
                        cVAT, cQNT : Float32);
begin
  spGoodsEdit.Params[0].Value := cID;
  spGoodsEdit.Params[1].Value := cName;
  spGoodsEdit.Params[2].Value := cMeasure;
  spGoodsEdit.Params[3].Value := cVAT;
  spGoodsEdit.Params[4].Value := cQNT;

  if (not spGoodsEdit.Transaction.InTransaction) then
    spGoodsEdit.Transaction.StartTransaction;
  spGoodsEdit.ExecProc;
  if spGoodsEdit.Transaction.InTransaction then
    spGoodsEdit.Transaction.Commit;

  FormMain.TabControl1Change(nil);
end;

procedure Tdm.tGoodsAfterOpen(DataSet: TDataSet);
begin
  tGoods.FieldByName('ID').DisplayLabel := '№';
  tGoods.FieldByName('ID').Alignment := taCenter;

  tGoods.FieldByName('NAME').DisplayLabel := 'Наименование';
  tGoods.FieldByName('NAME').DisplayWidth :=  40;

  tGoods.FieldByName('MESURE').DisplayLabel := 'Ед. изм.';
  tGoods.FieldByName('MESURE').Alignment := taCenter;

  tGoods.FieldByName('VAT').DisplayLabel := 'НДС';
  tGoods.FieldByName('VAT').DisplayWidth := 10;
  (tGoods.FieldByName('VAT') as TNumericField).DisplayFormat := '##0.00';
end;

end.
