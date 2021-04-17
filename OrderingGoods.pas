unit OrderingGoods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TProductSelect = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    eName: TEdit;
    ePrice: TEdit;
    eQuantity: TEdit;
    eSum: TEdit;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    Button1: TButton;
    lRests: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure eNameChange(Sender: TObject);
    procedure ePriceChange(Sender: TObject);
    procedure ePriceKeyPress(Sender: TObject; var Key: Char);
    procedure eQuantityChange(Sender: TObject);
    procedure eSumChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    rests : Double;
  public
    { Public declarations }
    SelectedPrice : Float32;
    SelectedQnt : Float32;
    SelectedSum : Float32;
    SelectedGoodsID : Int64;
    FuturaType : int8;
    FuturaDate : TDate;
    not_avail : Boolean;
  end;

var
  ProductSelect: TProductSelect;

implementation
uses CommonElements, GoodsList, DataModule;

{$R *.dfm}

procedure TProductSelect.BtnOKClick(Sender: TObject);
begin
  SelectedPrice := StrToFloat(ePrice.Text);
  SelectedQnt := StrToFloat(eQuantity.Text);
  SelectedSum := StrToFloat(eSum.Text);
end;

procedure TProductSelect.Button1Click(Sender: TObject);
begin
  FormGoods := TFormGoods.Create(Application);
  FormGoods.Tag := 1;
  FormGoods.ShowModal;
  SelectedGoodsID := FormGoods.GoodsID;
  eName.Text :=  FormGoods.GoodsName;
  if FuturaType = 1 then
    begin
      rests := dm.GetRests(SelectedGoodsID, FuturaDate);
      lRests.Caption := 'Остатки: ' + FloatToStr(rests);
    end;  
  FormGoods.Release;
end;

procedure TProductSelect.eNameChange(Sender: TObject);
begin
  btnok.Enabled := ((ename.text<>'')and (eprice.text<>'')
    and (esum.text<>'') and(equantity.text<>''));
end;

procedure TProductSelect.ePriceChange(Sender: TObject);
begin
  if (not ePrice.Focused) or (ePrice.Text='')
   then exit;

  if eQuantity.Text<>'' then
  begin
    eSum.Text:=FloatToStrF(StrToFloat(ePrice.Text)*StrToFloat(eQuantity.Text),
    ffFixed, 15,eSum.Tag); //ffFixed без разделителей, всего цифр, цифр после запятой
    eNameChange(Nil);
    exit;
  end;

  if (eSum.Text<>'') and(StrToFloat(ePrice.Text)<>0) then
  begin
    eQuantity.Text:=FloatToStrF(StrToFloat(eSum.Text)/StrToFloat(ePrice.Text),ffFixed, 15,eSum.Tag);       //fffixed без разделителей, всего цифр, цифр после запятой
    eNameChange(Nil);
    exit;
  end;

  eNameChange(Nil);
end;

procedure TProductSelect.ePriceKeyPress(Sender: TObject; var Key: Char);
begin
  NumberKeyPress(Sender as Tedit, Key);
end;

procedure TProductSelect.eQuantityChange(Sender: TObject);
begin
  if (not eQuantity.Focused) or (eQuantity.Text='')
    then exit;

  if ePrice.Text<>'' then
  begin
    eSum.Text:=FloatToStrF(StrToFloat(ePrice.Text)*StrToFloat(eQuantity.Text),ffFixed, 15,eSum.Tag);       //fffixed без разделителей, всего цифр, цифр после запятой
    eNameChange(Nil);
    exit;
  end;

  if (eSum.Text<>'') and(StrToFloat(eQuantity.Text)<>0) then
  begin
    ePrice.Text:=FloatToStrF(StrToFloat(eSum.Text)/StrToFloat(eQuantity.Text),ffFixed, 15,ePrice.Tag);       //fffixed без разделителей, всего цифр, цифр после запятой
    eNameChange(Nil);
    exit;
  end;
  eNameChange(Nil);
end;

procedure TProductSelect.eSumChange(Sender: TObject);
begin
  if (not eSum.Focused) or (eSum.Text='')
    then exit;

  if (ePrice.Text<>'') and (strToFloat(ePrice.Text)<>0) then
  begin
    eQuantity.Text:=FloatToStrF(StrToFloat(eSum.Text)/StrToFloat(ePrice.Text),ffFixed, 15,eSum.Tag);       //fffixed без разделителей, всего цифр, цифр после запятой
    eNameChange(Nil);
    exit;
  end;

  if (eQuantity.Text<>'') and(StrToFloat(eQuantity.Text)<>0) then
  begin
    ePrice.Text:=FloatToStrF(StrToFloat(eSum.Text)/StrToFloat(eQuantity.Text),
      ffFixed, 15,ePrice.Tag); //ffFixed без разделителей, всего цифр, цифр после запятой
    eNameChange(Nil);
    exit;
  end;
  eNameChange(Nil);
end;

procedure TProductSelect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (ModalResult = mrOk) and (FuturaType = 1) and
      (StrToFloat(eQuantity.Text) > rests) then
      begin
        if (MessageDlg('Товара выписано больше, чем есть на складе. Продолжать?',
          mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo) then
            Action := caNone
        else
          not_avail := True;
      end;
end;

procedure TProductSelect.FormCreate(Sender: TObject);
var
  i: integer;
begin
  not_avail := False;
  for i := 0 to componentcount-1 do // Очищаем едиты
  begin
    if components[i] is tedit then
      (components[i] as tedit).Clear // также можно написать tedit (components[i])
  end;
end;

end.
