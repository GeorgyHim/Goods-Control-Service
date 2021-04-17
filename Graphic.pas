unit Graphic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.ComCtrls, Vcl.ExtCtrls, IBX.IBQuery, Data.DB, DateUtils, Math;

type
  TFormGraphic = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    CheckListBox1: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DrawGraphic(selGoods : WideString);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGraphic: TFormGraphic;

implementation

{$R *.dfm}

uses DataModule;

procedure TFormGraphic.Button1Click(Sender: TObject);
var s, selGoods : WideString;
  i, j, k : Integer;
begin
  // Выбираем имена товаров
  k := 0;
  for i  := 0 to CheckListBox1.Count - 1 do
      if CheckListBox1.Checked[i] then
        inc(k);

  selGoods := '';
  if k > 0 then begin
    selGoods := '(';
    j := 0;
    for i  := 0 to CheckListBox1.Count - 1 do
      if CheckListBox1.Checked[i] then begin
        inc(j);
        selGoods := selGoods + '''' + CheckListBox1.Items[i] + '''';
        if j = k then
          selGoods := selGoods + ')'
        else
          selGoods := selGoods + ', ';
      end;
  end;

  DrawGraphic(selGoods);
end;

procedure TFormGraphic.DrawGraphic(selGoods : WideString);
var h, w, r,step, mx, i : integer;
rec : TRect;
d : TDate;
q : TIBQuery;
s : WideString;
successPoints, debtPoints : array of TPoint;
label M;
begin

  // Создание фона
  FormGraphic.Image1.Canvas.Brush.Color := clWhite;
  FormGraphic.Image1.Canvas.FillRect(FormGraphic.Image1.ClientRect);
  FormGraphic.Image1.Canvas.Pen.Color := clBlack;
  w := FormGraphic.Image1.ClientWidth - 30;
  h := FormGraphic.Image1.ClientHeight - 90;

  // Нарисовать и подписать оси
  FormGraphic.Image1.Canvas.MoveTo(10, h);
  FormGraphic.Image1.Canvas.LineTo(w + 5, h);
  FormGraphic.Image1.Canvas.MoveTo(10, h);
  FormGraphic.Image1.Canvas.LineTo(10, 10);

  r := DaysBetween(DateTimePicker1.Date, DateTimePicker2.Date);
  step := (w - 10) div r;
  // Взять данные для графиков
  SetLength(successPoints, r+1);
  SetLength(debtPoints, r+1);
  for i := 0 to r do begin
    successPoints[i].X := 10 + i * step;
    successPoints[i].Y := 0;
    debtPoints[i].X := 10 + i * step;
    debtPoints[i].Y := 0;
  end;

  i := 0;
  mx := 0;
  d := DateTimePicker1.Date;
  FormGraphic.Image1.Canvas.Font.Orientation := 900;
  repeat
    FormGraphic.Image1.Canvas.MoveTo(10 + i * step, h - 4);
    FormGraphic.Image1.Canvas.LineTo(10 + i * step, h + 5);
    FormGraphic.Image1.Canvas.TextOut(3 + i * step, h + 60, DateToStr(d));

    // Формируем значение ломанной для данной даты
    s := 'select  sum(SUM_SUCCESS) as SUM_S, sum(SUM_WAIT) as SUM_W'
          + ' from REPORT_FOR_GOODS_ON_DATE(' + '''' + DateToStr(d) + ''') ';
    if selGoods <> '' then
      s := s + ' where G_NAME in ' + selGoods;
    q := dm.GetTMPQuery(s);
    q.Open;
    if q.RecordCount = 0 then
      goto M;
    q.First;
    mx := Max(mx, q.FieldByName('SUM_S').AsInteger);
    mx := Max(mx, q.FieldByName('SUM_W').AsInteger);
    successPoints[i].Y := q.FieldByName('SUM_S').AsInteger;
    debtPoints[i].Y :=  q.FieldByName('SUM_W').AsInteger;
    M: d := IncDay(d);
    Inc(i);
  until i > r;

  step := (h - 10) div mx;
  FormGraphic.Image1.Canvas.Font.Orientation := 0;
  for i := 0 to r do begin
    successPoints[i].Y := h - successPoints[i].Y * step;
    debtPoints[i].Y := h - debtPoints[i].Y * step;
    FormGraphic.Image1.Canvas.TextOut(successPoints[i].X,
          successPoints[i].Y - 12, IntToStr((h - successPoints[i].Y) div step));
    FormGraphic.Image1.Canvas.TextOut(debtPoints[i].X,
          debtPoints[i].Y - 12, IntToStr((h - debtPoints[i].Y) div step));
  end;

  // Нарисовать ломанные
  Randomize;
  FormGraphic.Image1.Canvas.Pen.Width := 3;
  FormGraphic.Image1.Canvas.Pen.Color := clBlue;
  FormGraphic.Image1.Canvas.Polyline(successPoints);
  FormGraphic.Image1.Canvas.Font.Color := clBlue;
  FormGraphic.Image1.Canvas.TextOut(w - 30, 10, 'Продано');

  FormGraphic.Image1.Canvas.Pen.Color := clRed;
  FormGraphic.Image1.Canvas.Polyline(debtPoints);
  FormGraphic.Image1.Canvas.Font.Color := clRed;
  FormGraphic.Image1.Canvas.TextOut(w - 30, 40, 'Долг');

  FormGraphic.Image1.Canvas.Font.Color := clBlack;
end;


procedure TFormGraphic.FormCreate(Sender: TObject);
var i : integer;
q : TIBQuery;
s : WideString;
begin
  DateTimePicker2.Date := now;
  s := 'select id, name from GOODS order by name';
  q := dm.GetTMPQuery(s);
  q.Open;
  q.First;
  while not q.Eof do
    begin
      CheckListBox1.Items.Add(q.FieldByName('NAME').AsString);
      q.Next;
    end;
  dm.DestroyTMPQuery(q);
end;

procedure TFormGraphic.FormPaint(Sender: TObject);
begin
  //
end;

end.
