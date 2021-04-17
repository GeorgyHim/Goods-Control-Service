unit Main;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, IBX.IBQuery;

type
  TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Panel1: TPanel;
    TabControl1: TTabControl;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    dsFutura: TDataSource;
    dsInfo: TDataSource;
    N5: TMenuItem;
    miNewFutura: TMenuItem;
    miDelFutura: TMenuItem;
    N6: TMenuItem;
    miAddGood: TMenuItem;
    miDelGood: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    N8: TMenuItem;
    N7: TMenuItem;
    AddComing: TMenuItem;
    available: TMenuItem;
    Graphic: TMenuItem;
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure miNewFuturaClick(Sender: TObject);
    procedure miDelFuturaClick(Sender: TObject);
    procedure miAddGoodClick(Sender: TObject);
    procedure dsFuturaDataChange(Sender: TObject; Field: TField);
    procedure miDelGoodClick(Sender: TObject);
    procedure AddComingClick(Sender: TObject);
    procedure upd(qnt : Float32);
    procedure availableClick(Sender: TObject);
    procedure GraphicClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses ClientsList, GoodsList, DataModule, NewFutura, OrderingGoods, Сoming,
  Report, Graphic;

procedure TFormMain.availableClick(Sender: TObject);
begin
  FormReport := TFormReport.Create(Application);
  FormReport.ShowModal;
  FormReport.Release;
end;

procedure TFormMain.dsFuturaDataChange(Sender: TObject; Field: TField);
begin
  dm.SelectFuturaInfo(dm.qFuturaID.Value);
end;

procedure TFormMain.FormActivate(Sender: TObject);
var changeQuery : TIBQuery;
begin
  TabControl1Change(nil);
  dsFutura.DataSet := dm.qFutura;
  dsInfo.DataSet := dm.qFuturaInfo;

  //dm.qFutura.First;
  //while not dm.qFutura.Eof do begin
    changeQuery := dm.GetTMPQuery('UPDATE FUTURA SET DONE = '' Выполнено'' where '
      + 'futura.DONE = ''+''' );
    changeQuery.ExecSQL;
    changeQuery := dm.GetTMPQuery('UPDATE FUTURA SET DONE = '' Ожидает'' where '
      + 'futura.DONE = ''-''' );
      changeQuery.ExecSQL;
      TabControl1Change(nil);
  //end;

end;

procedure TFormMain.miNewFuturaClick(Sender: TObject);
var id : int64;
begin
  FormNewFutura := TFormNewFutura.Create(Application);
  FormNewFutura.ShowModal;
  if FormNewFutura.ModalResult = mrOk then
    begin
      id := dm.NewFutura(-1,
            FormNewFutura.SelectedDate, FormNewFutura.SelectedNumber,
            FormNewFutura.SelectedClientID);

      // Сразу же создать накладные для успеха и для ожидания
      dm.NewDelivery(FormNewFutura.SelectedDate, FormNewFutura.SelectedNumber + '_-',
                    FormNewFutura.SelectedClientID, False);
      dm.NewDelivery(FormNewFutura.SelectedDate, FormNewFutura.SelectedNumber + '_+',
                    FormNewFutura.SelectedClientID, True);

      //dsFutura.DataSet.DisableControls;
      TabControl1Change(nil); // Обновляем набор значений для накладных
      dm.qFutura.Locate('ID', id, []);
      //dsFutura.DataSet.EnableControls;
    end;
  FormNewFutura.Release;
end;

procedure TFormMain.N2Click(Sender: TObject);
begin
  FormClients := TFormClients.Create(Application);
  FormClients.ShowModal;
  FormClients.Release;
end;

procedure TFormMain.N3Click(Sender: TObject);
begin
  FormGoods := TFormGoods.Create(Application);
  FormGoods.ShowModal;
  FormGoods.Release;
end;

procedure TFormMain.N4Click(Sender: TObject);
begin
 Close;
end;

procedure TFormMain.GraphicClick(Sender: TObject);
begin
  FormGraphic := TFormGraphic.Create(Application);
  FormGraphic.ShowModal;
  FormGraphic.Release;
end;

procedure TFormMain.AddComingClick(Sender: TObject);
var i, j : Integer;
fut_id, idSucces, idWait : int64;
  qnt : Float32;
begin
  FormComing := TFormComing.Create(Application);
  FormComing.ShowModal;
  if FormComing.ModalResult = mrOk then
    begin
      // Вносим изменения в базу
      dm.NewComing(FormComing.SelectedGoodsID,
            FormComing.SelectedQnt, FormComing.SelectedDate);

      // Сохраняем новое количество товара
      qnt := dm.GetRests(FormComing.SelectedGoodsID, FormComing.SelectedDate);

      // Пересчитываем кол-во товара и высылаем если можем
      Sleep(300);

      dsFutura.DataSet.DisableControls;
      TabControl1.TabIndex := 1;
      dsFuturaDataChange(nil, nil);
      TabControl1Change(nil);
      dsFutura.DataSet.EnableControls;

      // Обновляем Futura- и Futura+
      upd(qnt);

      end;

  FormComing.Release;
end;

procedure TFormMain.upd(qnt : Float32);
var i, j : Integer;
fut_id, idSucces, idWait : int64;
s : string;
changeQuery : TIBQuery;
begin
  dm.qFutura.First;
      for i := 0 to dm.qFutura.RecordCount - 1 do
        begin
          s := dm.qFutura.FieldByName('FUTURA_NO').AsString;
          if (s[Length(s)] <> '-') then begin
            dm.qFutura.Next;
            continue;
          end;

          fut_id := dm.qFutura.FieldByName('ID').Value;
          dm.qFuturaInfo.First;
          for j := 0 to dm.qFuturaInfo.RecordCount - 1 do
            begin
              if (FormComing.SelectedGoodsID <>
                  dm.qFuturaInfo.FieldByName('GOODS_ID').AsLargeInt) or
              (dm.qFuturaInfo.FieldByName('QUANTITY').AsFloat > qnt) then
                begin
                  dm.qFuturaInfo.Next;
                  Continue;
                end;

                // Выводим сообщение что отправили товар
                MessageDlg('Отправили товар ' +
                    dm.qFuturaInfo.FieldByName('G_NAME').AsString +
                    ' клиенту ' + dm.qFuturaNAME.AsString, mtInformation, [mbOK], 0);

                // Добавить в +
                idSucces := fut_id + 1;
                dm.NewFuturaInfo(idSucces, dm.qFuturaInfoGOODS_ID.AsLargeInt,
                    dm.qFuturaInfoQUANTITY.AsFloat, dm.qFuturaInfoSUMMA.AsFloat);


                // Удалить из -
                dm.FuturaInfoDelete(dm.qFuturaInfoFUTURA_ID.AsLargeInt,
                                    dm.qFuturaInfoGOODS_ID.AsLargeInt);
                TabControl1Change(nil);
                //dm.qFutura.Transaction.Commit;

                // Если все выдали
                if dm.qFuturaInfo.RecordCount = 0 then
                begin
                  // Помечаем запрос как выполненный
                  changeQuery := dm.GetTMPQuery('UPDATE FUTURA SET DONE = ''Выполнено'' where ' +
                          'id = ' +  (fut_id - 1).ToString);
                  changeQuery.ExecSQL;
                  changeQuery.Transaction.Commit;
                  break;
                end;

              dm.qFuturaInfo.Next;
            end;
            dm.qFutura.Next;
          end;
      dsFutura.DataSet.DisableControls;
      TabControl1Change(nil);
      dsFutura.DataSet.EnableControls;
end;





procedure TFormMain.miAddGoodClick(Sender: TObject);
var
  not_avail : Boolean;
  nid, idSucces, idWait : int64;
  changeQuery : TIBQuery;
begin
  nid := dm.qFuturaID.Value;
  not_avail := false;
  ProductSelect := TProductSelect.Create(Application);
  ProductSelect.FuturaType := 1;
  ProductSelect.FuturaDate := dm.qFuturaFUTURA_DATE.Value;
  ProductSelect.ShowModal;
  if ProductSelect.ModalResult = mrOk then
    begin
      // Создаем поле с товаром в ЗАКАЗЕ
      dm.NewFuturaInfo(nid, ProductSelect.SelectedGoodsID,
                      ProductSelect.SelectedQnt, ProductSelect.SelectedSum);
      not_avail := ProductSelect.not_avail;

      // Добавить товар в футуру доставок соответствующе наличию
      if not_avail then
        // Добавляем в накладную ожидания
        begin
          idWait := nId + 1;
           dm.NewFuturaInfo(idWait, ProductSelect.SelectedGoodsID,
              ProductSelect.SelectedQnt, ProductSelect.SelectedSum);
        end
       else
          // Добавляем в накладную успеха
          begin
            idSucces := nId + 2;
           dm.NewFuturaInfo(idSucces, ProductSelect.SelectedGoodsID,
              ProductSelect.SelectedQnt, ProductSelect.SelectedSum);
          end;

       if not_avail then
        begin
          changeQuery := dm.GetTMPQuery('UPDATE FUTURA SET DONE = ''Ожидает'' where ' +
                          'id = ' +  nid.ToString);
          changeQuery.ExecSQL;
          changeQuery.Transaction.Commit;
        end
       else
        if dm.qFuturaDONE.AsString <> '-' then
          begin
            changeQuery := dm.GetTMPQuery('UPDATE FUTURA SET DONE = ''+'' where ' +
                          'id = ' +  nid.ToString);
            changeQuery.ExecSQL;
            changeQuery.Transaction.Commit;
          end;

      TabControl1Change(nil); // Обновляем набор значений для накладных
      dm.qFutura.Locate('ID', nid, []);
    end;
  ProductSelect.Release;
end;

procedure TFormMain.miDelFuturaClick(Sender: TObject);
var id, idSuccess, idWait : int64;
IN_DATE : TDate; IN_CL_ID : int64;
IN_NO : string;
begin
 if MessageDlg('Удалить?',
                mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      id := dm.qFuturaID.AsLargeInt;
      IN_DATE := dm.qFuturaFUTURA_DATE.Value;
      IN_CL_ID := dm.qFuturaCLIENT_ID.Value;
      IN_NO := dm.qFuturaFUTURA_NO.Value;
      dm.FuturaDelete(id);
      if (TabControl1.TabIndex = 0) then begin
        dm.FuturaDelete(id+1);
        dm.FuturaDelete(id+2);
      end;
      dsFutura.DataSet.DisableControls;
      TabControl1Change(nil); // Обновляем набор значений для накладных
      dsFutura.DataSet.EnableControls;
    end;
end;

procedure TFormMain.miDelGoodClick(Sender: TObject);
var nId, gId : int64;
begin
 if MessageDlg('Удалить запись в накладной?',
                mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      nId := dm.qFuturaInfoFUTURA_ID.AsLargeInt;
      gId := dm.qFuturaInfoGOODS_ID.AsLargeInt;
      dm.FuturaInfoDelete(nId, gId);

      dsFutura.DataSet.DisableControls;
      TabControl1Change(nil); // Обновляем набор значений для накладных
      dsFutura.DataSet.EnableControls;
    end;
end;

procedure TFormMain.TabControl1Change(Sender: TObject);
var id : int64;
Ftype : int8;
begin
  id := dm.qFuturaID.Value;
  Ftype := TabControl1.TabIndex - 1;
  dm.SelectFutura(Ftype);
  dm.qFutura.Locate('ID', id, []);
  SpeedButton2.Enabled := (Ftype = -1);
  miAddGood.Enabled := (Ftype = -1);
  miDelGood.Enabled := (Ftype = -1);
  miDelFutura.Enabled := (Ftype <> 0);
end;

end.
