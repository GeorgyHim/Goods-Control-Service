unit ClientAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormClientAdd = class(TForm)
    eName: TLabeledEdit;
    eAddress: TLabeledEdit;
    eINN: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure eNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClientAdd: TFormClientAdd;

implementation

{$R *.dfm}

procedure TFormClientAdd.eNameChange(Sender: TObject);
begin
  BitBtn1.Enabled:=(eName.Text<>'')
                   and(eAddress.Text<>'')
                   and (eINN.Text<>'');
end;

end.
