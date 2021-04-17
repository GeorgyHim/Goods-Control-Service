unit NewFutura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormNewFutura = class(TForm)
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Номе: TLabel;
    Label3: TLabel;
    eNumber: TEdit;
    eName: TButtonedEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ImageList1: TImageList;
    procedure eNumberChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eNameRightButtonClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SelectedDate : TDate;
    SelectedNumber : string;
    SelectedClientID : Int64;
  end;

var
  FormNewFutura: TFormNewFutura;

implementation

{$R *.dfm}

uses ClientsList;

procedure TFormNewFutura.BitBtn1Click(Sender: TObject);
begin
    SelectedDate := DateTimePicker1.Date;
    SelectedNumber := eNumber.Text;
end;

procedure TFormNewFutura.eNameRightButtonClick(Sender: TObject);
begin
  FormClients := TFormClients.Create(Application);
  FormClients.Tag := 1;
  FormClients.ShowModal;

  SelectedClientID := FormClients.ClientID;
  eName.Text :=  FormClients.ClientName;

  FormClients.Release;
end;

procedure TFormNewFutura.eNumberChange(Sender: TObject);
begin
  BitBtn1.Enabled := (eName.Text <> '') and (eNumber.Text <> '');
end;

procedure TFormNewFutura.FormCreate(Sender: TObject);
begin
  eNumber.Clear;
  eName.Clear;
  DateTimePicker1.Date := Now;
end;

end.
