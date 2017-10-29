unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var tf:textfile;
    s:string;
begin
 try
  assignfile(tf,extractfilepath(application.ExeName)+'说明.txt');
  reset(tf);
  while not eof(tf) do
   begin
    readln(tf,s);
    label1.Caption:=label1.Caption+s+#13#10;
   end;
  closefile(tf);
 except
  messagebox(form2.Handle,'说明文件未找到','错误',mb_ok+mb_iconerror);
 end;
end;

end.
 