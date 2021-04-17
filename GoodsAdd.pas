unit GoodsAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormGoodsAdd = class(TForm)
    eName: TLabeledEdit;
    eMeasure: TLabeledEdit;
    eVAT: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    eQNT: TLabeledEdit;
    procedure eNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGoodsAdd: TFormGoodsAdd;

implementation

{$R *.dfm}

procedure TFormGoodsAdd.eNameChange(Sender: TObject);
begin
  BitBtn1.Enabled:=(eName.Text<>'')
                   and(eMeasure.Text<>'')
                   and (eVAT.Text<>'');
end;

end.
