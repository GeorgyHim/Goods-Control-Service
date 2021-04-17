unit CommonElements;


interface
  uses vcl.StdCtrls;

  function checkstrfloat(s: string):boolean;
  procedure NumberKeyPress (edt: Tedit; var key :char; Positiveonly : boolean=true);

implementation
uses system.sysutils ;

  function checkstrfloat(s: string):boolean;
  begin  // ���������, �������� �� ������ ������������ ������
    try
      strtofloat (s);
      result:=true;
    except
      result:=false;
    end;
  end;

  procedure NumberKeyPress(edt: Tedit; var Key: Char; Positiveonly : boolean=true);
var
  s: string;
begin
  if key=#8 then  // ��� BackSpace
    Exit;

  if key<>#8 then begin
    // ��������� �������� �������
    if ((key='.') or (key=',')) then key:=FormatSettings.DecimalSeparator;

    if (key=FormatSettings.DecimalSeparator) and(edt.Tag=0) then
      begin
        key:=#0;
        exit;
     end;

     if (key='-') then    // ���� ����� ����� ������ �� ����� ������� � ���
      begin
      if ((not Positiveonly) and (edt.selstart=0)) then exit
      else key:=#0;
      exit
      end;
     end;

    // ��������� ������ �� �����
    s:=Copy(edt.Text,1,edt.SelStart) + key +
    copy(edt.Text,edt.SelStart+1,length(edt.Text));  //SelStart - ��������� �������

    if not (checkstrfloat(s)) then
      key:= #0

    else begin
      if ((s<>'') and (pos(FormatSettings.DecimalSeparator, s) > 0) and
        (edt.SelStart = pos(FormatSettings.DecimalSeparator, s) + edt.Tag)) then key:=#0;
      end;

    end;
end.


