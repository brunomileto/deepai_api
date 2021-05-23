unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, PNGImage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.DBScope, JPEG, Vcl.OleCtrls, SHDocVw, Vcl.ExtDlgs,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    imgMain: TImage;
    imgStyle: TImage;
    ImgResult: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnGetImg: TButton;
    edtResultLink: TEdit;
    Label6: TLabel;
    IdHTTP1: TIdHTTP;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    FDMemTable1id: TWideStringField;
    FDMemTable1output_url: TWideStringField;
    btnMainImage: TButton;
    btnStyleImage: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure btnGetImgClick(Sender: TObject);
    procedure GetImg(urls : string);
    procedure FormShow(Sender: TObject);
    procedure btnMainImageClick(Sender: TObject);
    procedure btnStyleImageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    resourcesDirectory : string;
    mainImgFile : string;
    styleImgFile : string;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  resourcesDirectory := GetCurrentDir + '/res';
end;

procedure TForm1.btnMainImageClick(Sender: TObject);
begin
  OpenPictureDialog1.Execute();
  if FileExists(OpenPictureDialog1.FileName) then begin
    imgMain.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    mainImgFile :=  OpenPictureDialog1.FileName;
  end;
end;

procedure TForm1.btnStyleImageClick(Sender: TObject);
begin
  OpenPictureDialog1.Execute();
  if FileExists(OpenPictureDialog1.FileName) then begin
    imgStyle.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    styleImgFile :=  OpenPictureDialog1.FileName;
  end;
end;

procedure TForm1.btnGetImgClick(Sender: TObject);
begin

  FDMemTable1.Close;
  RESTRequest1.Params[0].Value := mainImgFile;
  RESTRequest1.Params[2].Value := styleImgFile;
  RESTRequest1.Execute;
  FDMemTable1.Open;
                                //urls := StringReplace(urls, 'https', 'http', [rfReplaceAll, rfIgnoreCase]);
  GetImg(FDMemTable1OUTPUT_URL.AsString);

end;

procedure TForm1.GetImg(urls : string);
var
  MS: TMemoryStream;
  IMG: TJPEGImage;
  IdHTTP1 : TIdHTTP;
begin
  MS := TMemoryStream.Create;
  IdHTTP1 := TIdHTTP.Create(nil);
  try
    IMG := TJPEGImage.Create;
    try
        MS.Clear;
        urls := StringReplace(urls, 'https', 'http', [rfReplaceAll, rfIgnoreCase]);
        IdHTTP1.Get(urls, MS);
        MS.Position := 0;
        MS.SaveToFile(resourcesDirectory + '\output.jpg');
        IMG.LoadFromStream(MS);
        ImgResult.Picture.Assign(IMG);
        Application.ProcessMessages;

    finally
      IMG.Free;
    end;
  finally
    MS.Free;
  end;
end;


end.
