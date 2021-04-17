unit Ñoming;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  TFormComing = class(TForm)
    Label1: TLabel;
    lRests: TLabel;
    eName: TEdit;
    Button1: TButton;
    Label3: TLabel;
    eQuantity: TEdit;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    procedure Button1Click(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure eNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     SelectedQnt : Float32;
     SelectedGoodsID : Int64;
     SelectedDate : TDate;
  end;

var
  FormComing: TFormComing;

implementation

{$R *.dfm}

uses GoodsList;

procedure TFormComing.BtnOKClick(Sender: TObject);
begin
  SelectedQnt := StrToFloat(eQuantity.Text);
  SelectedDate := DateTimePicker1.Date;
end;

procedure TFormComing.Button1Click(Sender: TObject);
begin
  FormGoods := TFormGoods.Create(Application);
  FormGoods.Tag := 1;
  FormGoods.ShowModal;
  SelectedGoodsID := FormGoods.GoodsID;
  eName.Text :=  FormGoods.GoodsName;
  FormGoods.Release;
end;

procedure TFormComing.eNameChange(Sender: TObject);
begin
  BtnOK.Enabled:=(eName.Text<>'')
                   and(eQuantity.Text<>'');
end;

end.
