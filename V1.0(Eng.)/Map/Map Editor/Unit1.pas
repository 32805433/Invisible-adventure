unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, WinProcs;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
 //   Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    Image5: TImage;
    GroupBox1: TGroupBox;
    Image6: TImage;
    Image7: TImage;
    GroupBox2: TGroupBox;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Button5: TButton;
    Button6: TButton;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    Edit2: TEdit;
    Image26: TImage;
    ComboBox1: TComboBox;
    Button7: TButton;
    Button8: TButton;
    procedure Button1Click(Sender: TObject);
    procedure imu(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 //   procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure sc(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    function stairsok:boolean;
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const sn=22;

type ss=set of 1..10;

var
  Form1: TForm1;
  size,i1,i2,i3,i,floor,level,snum,snum2:integer;
  sb:array [1..5,1..25,1..25] of Tspeedbutton;
  stairnum:array [1..5] of ss;
  sss:ss;
 // l:array [1..100] of Tspeedbutton;
  f:boolean;

implementation

uses unit2;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
 try
  size:=strtoint(edit1.Text);
  level:=strtoint(edit2.Text);
 except
  exit;
 end;
 if (size<2) or (size>25) or (level<1) or (level>5) then
  exit;
 for i1:=1 to level do
  for i2:=1 to size do
   for i3:=1 to size do
    begin
     sb[i1,i2,i3]:=Tspeedbutton.Create(form1);
     with sb[i1,i2,i3] do
      begin
       parent:=form1;
       name:='sb'+inttostr(i1*10000+i2*100+i3);
       left:=sn*i2-9;
       top:=size*sn-i3*sn+40;
       width:=sn;
       height:=sn;
       groupindex:=0;
       onclick:=sc;
       visible:=false;
       tag:=0;
      end;
    end;
 for i2:=1 to size do
  for i3:=1 to size do
   sb[1,i2,i3].Visible:=true;
 label1.Visible:=false;
 edit1.Visible:=false;
 label2.Visible:=false;
 edit2.Visible:=false;
 button1.Visible:=false;
 groupbox1.Visible:=true;
 groupbox2.Visible:=true;
 combobox1.Visible:=true;
 for i1:=1 to level do
  combobox1.Items.Add(inttostr(i1));
 combobox1.ItemIndex:=0;
 floor:=1;
 snum:=0;
 snum2:=0;
 sss:=[];
 for i:=1 to 5 do
  stairnum[i]:=[];
 f:=true;
end;

procedure TForm1.imu(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var a,b,k:integer;
    s:string;
    ff:boolean;
begin
 a:=(groupbox1.Left+Timage(sender).Left+x+sn-14) div sn;
 b:=size-((groupbox1.Top+Timage(sender).Top+y+sn-39) div sn)+1;
 if (a>0)and(a<=size)and(b>0)and(b<=size)and(groupbox1.Left+(Timage(sender).Left+x) mod sn<>16)and(groupbox1.Top+(Timage(sender).Top+y) mod sn<>16)and((a>1)or(b>1)or(floor>1)) then
  begin
   if (401<=sb[floor,a,b].Tag)and(sb[floor,a,b].Tag<=403) then
    sb[floor,a,b].Hint:='';
   if sb[floor,a,b].Tag=601 then
    begin
     k:=strtoint(sb[floor,a,b].Hint);
     stairnum[floor]:=stairnum[floor]-[k];
     dec(snum2);
     ff:=false;
     for i:=1 to 5 do
      if k in stairnum[i] then
       begin
        ff:=true;
        break;
       end;
     if not ff then
      begin
       sss:=sss-[k];
       dec(snum);
      end;
    end;
   if (Timage(sender).Tag=601)and(snum2=20) then
    begin
     showmessage('Too many stairs!');
     exit;
    end;
   sb[floor,a,b].Glyph:=Timage(sender).Picture.Bitmap;
   sb[floor,a,b].Tag:=Timage(sender).Tag;
   if i<100 then
    inc(i)
    else
     i:=1;
 //  l[i]:=sb[floor,a,b];
 //  button2.Enabled:=true;
   if (401<=sb[floor,a,b].Tag)and(sb[floor,a,b].Tag<=403) then
    begin
     if not inputquery('Setting','Enter the word',s) then
      exit;
     sb[floor,a,b].Hint:=s;
    end;
   if sb[floor,a,b].Tag=601 then
    begin
{     s:=sb[floor,a,b].Hint;
     inputquery('Setting','Enter the identifier of the stairs(1~10)',s);
     try
      k:=strtoint(s);
     except
      showmessage('Invalid identifier!');
      exit;
     end;
     if (k<1)or(k>10) then
      begin
       showmessage('Invalid identifier!');
       exit;
      end;
     sb[floor,a,b].Hint:=s;
     s:=sb[i1,i2,i3].Hint;   }
     ff:=false;
     repeat
      if not inputquery('Setting','Enter the identifier of the stairs(1~10)',s) then
       begin
        sb[floor,a,b].Glyph:=nil;
        sb[floor,a,b].Tag:=0;
        exit;
       end;
      try
       k:=strtoint(s);
       if (k<1)or(k>10) then
        raise Exception.Create('');
       ff:=true;
      except
       showmessage('Invalid identifier!');
      end;
     until ff;
     ff:=true;
     for i:=1 to level do
      if (abs(floor-i)<>1)and(k in stairnum[i]) then
       begin
        showmessage('The connected stair should be in the adjacent level and at most 2 stairs with the same identifier can appear in the same map!');
        ff:=false;
        break;
       end;
     if ff then
      begin
       sb[floor,a,b].Hint:=s;
       stairnum[floor]:=stairnum[floor]+[k];
       inc(snum2);
       if not(k in sss) then
        begin
         sss:=sss+[k];
         inc(snum);
        end;
      end
      else
       begin
        sb[floor,a,b].Glyph:=nil;
        sb[floor,a,b].Tag:=0;
       end;
    end;
   f:=true;
  end;
end;

{procedure TForm1.Button2Click(Sender: TObject);
begin
 l[i].Glyph:=nil;
 l[i].Tag:=0;
 l[i]:=nil;
 if i>1 then
  dec(i)
  else
   i:=100;
 if l[i]=nil then
  button2.Enabled:=false;
 f:=true;
end;     }

procedure TForm1.Button3Click(Sender: TObject);
begin
 if f then
  if messagebox(form1.Handle,'The game hasn'+#39+'t been saved yet,are you sure to quit?','Warning',mb_yesno+mb_iconquestion)=7 then
   exit;
 winexec(pchar(ExtractFilename(application.ExeName){+'Project1.exe'}),sw_show);
 f:=false;
 close;
end;

procedure TForm1.Button4Click(Sender: TObject);
var tf:textfile;
begin
 if not stairsok then
  begin
   showmessage('The stairs are not in pairs');
   exit;
  end;
 if savedialog1.Execute then
  try
   assignfile(tf,savedialog1.FileName);
   rewrite(tf);
   writeln(tf,size,' ',level);
   for i1:=1 to level do
    for i3:=size downto 1 do
     begin
      for i2:=1 to size do
       write(tf,sb[i1,i2,i3].tag,' ');
      writeln(tf);
     end;
   for i1:=1 to level do
    for i3:=size downto 1 do
     for i2:=1 to size do
      if (401<=sb[i1,i2,i3].Tag)and(sb[i1,i2,i3].Tag<=403)or(sb[i1,i2,i3].Tag=601) then
       writeln(tf,i1,' ',i2,' ',i3,' ',sb[i1,i2,i3].Hint);
   closefile(tf);
   f:=false;
   showmessage('Completed!')
  except
   showmessage('Saving error!');
  end;
end;

procedure TForm1.sc(Sender: TObject);
var //sp:Tspeedbutton;
    s:string;
    ff:boolean;
    k:longint;
    t1,t2,i:integer;
begin
// sp:=sender as Tspeedbutton;
{ ff:=false;
 for i1:=1 to size do
  begin
   for i2:=1 to size do
    if sb[i1,i2,i3]=sp then
     begin
      ff:=true;
      break;
     end;
   if ff then
    break;
  end;            }
 s:=Tspeedbutton(sender).Name;
 delete(s,1,2);
 k:=strtoint(s);
 i1:=k div 10000;
 k:=k mod 10000;
 i2:=k div 100;
 i3:=k mod 100;
 if (401<=sb[i1,i2,i3].Tag)and(sb[i1,i2,i3].Tag<=403) then
  begin
   s:=sb[i1,i2,i3].Hint;
   if not inputquery('Setting','Enter the word',s) then
    exit;
   sb[i1,i2,i3].Hint:=s;
  end;
 if sb[i1,i2,i3].Tag=601 then
  begin
   s:=sb[i1,i2,i3].Hint;
   t1:=strtoint(s);
   ff:=false;
   repeat
    if not inputquery('Setting','Enter the identifier of the stairs(1~10)',s) then
     exit;
    try
     t2:=strtoint(s);
     if (t2<1)or(t2>10) then
      raise Exception.Create('');
     ff:=true;
    except
     showmessage('Invalid identifier!');
    end;
   until ff;
   stairnum[floor]:=stairnum[floor]-[t1];
   ff:=true;
   for i:=1 to level do
    if (abs(floor-i)<>1)and(t2 in stairnum[i]) then
     begin
      showmessage('The connected stair should be in the adjacent level and at most 2 stairs with the same identifier can appear in the same map!');
      ff:=false;
      break;
     end;
   if ff then
    begin
     sb[i1,i2,i3].Hint:=s;
     stairnum[floor]:=stairnum[floor]+[t2];
     inc(snum2);
     if not(t2 in sss) then
      begin
       sss:=sss+[t2];
       inc(snum);
      end;
    end
    else
     stairnum[floor]:=stairnum[floor]+[t1];
  end;
 f:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
var s:string;
begin
 i:=0;
 f:=false;
 s:=extractfilepath(application.ExeName);
 delete(s,length(s)-10,11);
 opendialog1.InitialDir:=s;
 savedialog1.InitialDir:=s;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if f then
  if messagebox(form1.Handle,'The game hasn'+#39+'t been saved yet,are you sure to quit?','Warning',mb_yesno+mb_iconquestion)=7 then
   canclose:=false;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 button1.Visible:=true;
 label1.Visible:=true;
 edit1.Visible:=true;
 label2.Visible:=true;
 edit2.Visible:=true;    
 button5.Visible:=false;
 button6.Visible:=false;
end;

procedure TForm1.Button6Click(Sender: TObject);
var tf:textfile;
    a,k:integer;
    h:string;
begin
 if opendialog1.Execute then
  begin
   try
    assignfile(tf,opendialog1.FileName);
    reset(tf);
    readln(tf,size,level);
    if (size<2) or (size>25) or (level<1) or (level>5) then
     begin
      showmessage('Map error!');
      exit;
     end;
    for i1:=1 to level do
     for i2:=1 to size do
      for i3:=1 to size do
       begin
        sb[i1,i2,i3]:=Tspeedbutton.Create(form1);
        with sb[i1,i2,i3] do
         begin
          parent:=form1;
          name:='sb'+inttostr(i1*10000+i2*100+i3);
          left:=sn*i2-9;
          top:=size*sn-i3*sn+40;
          width:=sn;
          height:=sn;
          groupindex:=0;
          onclick:=sc;
          visible:=false;
          tag:=0;
         end;
       end;
    for i1:=1 to level do
     for i3:=size downto 1 do
      for i2:=1 to size do
       begin
        read(tf,a);
        sb[i1,i2,i3].tag:=a;
        case a of
         0:sb[i1,i2,i3].Glyph:=image5.Picture.Bitmap;
         1:sb[i1,i2,i3].Glyph:=image10.Picture.Bitmap;
         2:sb[i1,i2,i3].Glyph:=image1.Picture.Bitmap;
         101:sb[i1,i2,i3].Glyph:=image4.Picture.Bitmap;
     //    102:sb[i1,i2,i3].Glyph:=image24.Picture.Bitmap;
         103:sb[i1,i2,i3].Glyph:=image24.Picture.Bitmap;
     //    104:sb[i1,i2].Glyph:=image6.Picture.Bitmap;
     //    105:sb[i1,i2].Glyph:=image12.Picture.Bitmap;
         106:sb[i1,i2,i3].Glyph:=image25.Picture.Bitmap;
         201:sb[i1,i2,i3].Glyph:=image14.Picture.Bitmap;
         202:sb[i1,i2,i3].Glyph:=image12.Picture.Bitmap;
     //    203:sb[i1,i2].Glyph:=image13.Picture.Bitmap;
         204:sb[i1,i2,i3].Glyph:=image13.Picture.Bitmap;
         205:sb[i1,i2,i3].Glyph:=image6.Picture.Bitmap;
         301:sb[i1,i2,i3].Glyph:=image3.Picture.Bitmap;
         302:sb[i1,i2,i3].Glyph:=image2.Picture.Bitmap;
         303:sb[i1,i2,i3].Glyph:=image18.Picture.Bitmap;
         304:sb[i1,i2,i3].Glyph:=image20.Picture.Bitmap;
         305:sb[i1,i2,i3].Glyph:=image21.Picture.Bitmap;
         306:sb[i1,i2,i3].Glyph:=image22.Picture.Bitmap;
         401:sb[i1,i2,i3].Glyph:=image15.Picture.Bitmap;
         402:sb[i1,i2,i3].Glyph:=image16.Picture.Bitmap;
         403:sb[i1,i2,i3].Glyph:=image17.Picture.Bitmap;
         404:sb[i1,i2,i3].Glyph:=image23.Picture.Bitmap;
         405:sb[i1,i2,i3].Glyph:=image19.Picture.Bitmap;
         501:sb[i1,i2,i3].Glyph:=image11.Picture.Bitmap;
         502:sb[i1,i2,i3].Glyph:=image9.Picture.Bitmap;
         503:sb[i1,i2,i3].Glyph:=image7.Picture.Bitmap;
         504:sb[i1,i2,i3].Glyph:=image8.Picture.Bitmap;
         601:sb[i1,i2,i3].Glyph:=image26.Picture.Bitmap;
        end;
       end;
    if sb[1,1,1].Tag<>0 then
     raise Exception.Create('');
    try
     sss:=[];
     snum:=0;
     for i:=1 to 5 do
      stairnum[i]:=[];
     while not eof(tf) do
      begin
       readln(tf,i1,i2,i3,h);
       delete(h,1,1);
       sb[i1,i2,i3].Hint:=h;
       if sb[i1,i2,i3].Tag=601 then
        begin
         k:=strtoint(h);
         stairnum[i1]:=stairnum[i1]+[k];
         inc(snum2);
         if not(k in sss) then
          begin
           sss:=sss+[k];
           inc(snum);
          end;
        end;
      end;
    except
   //  showmessage('Map error!')
    end;
    if not stairsok then
     raise Exception.Create('');
    closefile(tf);
    for i2:=1 to size do
     for i3:=1 to size do
      sb[1,i2,i3].Visible:=true;
    button5.Visible:=false;
    button6.Visible:=false;
    groupbox1.Visible:=true;
    groupbox2.Visible:=true;
    combobox1.Visible:=true;
    for i1:=1 to level do
     combobox1.Items.Add(inttostr(i1));
    combobox1.ItemIndex:=0;
    floor:=1;
   except
    for i1:=1 to level do
     for i2:=1 to size do
      for i3:=1 to size do
       sb[i1,i2,i3].Destroy;
    showmessage('Map error!');
    exit;
   end;
  end;
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_return then
  button1.Click;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 for i1:=1 to size do
  for i2:=1 to size do
   sb[floor,i1,i2].Visible:=false;  
 floor:=combobox1.ItemIndex+1;
 for i1:=1 to size do
  for i2:=1 to size do
   sb[floor,i1,i2].Visible:=true;
end;

function Tform1.stairsok:boolean;
var c:array [1..10] of boolean;
    ff:boolean;
begin
 fillchar(c,sizeof(c),0);
 for i:=1 to 5 do
  begin
   for i1:=1 to 10 do
    if i1 in stairnum[i] then
     c[i1]:=not c[i1];
  end;
 ff:=true;
 for i:=1 to 10 do
  if c[i] then
   begin
    ff:=false;
    break;
   end;
 stairsok:=ff;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
 form2.ShowModal;
end;

end.
