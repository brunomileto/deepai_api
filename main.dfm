object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 517
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object imgMain: TImage
    Left = 16
    Top = 32
    Width = 250
    Height = 350
    Stretch = True
  end
  object imgStyle: TImage
    Left = 344
    Top = 32
    Width = 250
    Height = 350
    Stretch = True
  end
  object ImgResult: TImage
    Left = 680
    Top = 32
    Width = 250
    Height = 350
    Stretch = True
  end
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 78
    Height = 18
    Caption = 'Main Image'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 344
    Top = 8
    Width = 79
    Height = 18
    Caption = 'Style Image'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 680
    Top = 8
    Width = 87
    Height = 18
    Caption = 'Result Image'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 680
    Top = 408
    Width = 116
    Height = 18
    Caption = 'Result Image Link'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnGetImg: TButton
    Left = 680
    Top = 473
    Width = 193
    Height = 25
    Caption = 'Get Image'
    TabOrder = 0
    OnClick = btnGetImgClick
  end
  object edtResultLink: TEdit
    Left = 680
    Top = 437
    Width = 193
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object btnMainImage: TButton
    Left = 16
    Top = 407
    Width = 193
    Height = 25
    Caption = 'Get Main Image'
    TabOrder = 2
    OnClick = btnMainImageClick
  end
  object btnStyleImage: TButton
    Left = 344
    Top = 407
    Width = 193
    Height = 25
    Caption = 'Get Style Image'
    TabOrder = 3
    OnClick = btnStyleImageClick
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://api.deepai.org/api/fast-style-transfer'
    ContentType = 
      'multipart/form-data; boundary=-------Embt-Boundary--42BBD36D321F' +
      'D926'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 8
    Top = 448
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkFILE
        Name = 'content'
        Options = [poDoNotEncode]
      end
      item
        Kind = pkHTTPHEADER
        Name = 'api-key'
        Options = [poDoNotEncode]
        Value = '273559c7-7d9c-4c90-800c-20c98aa11395'
      end
      item
        Kind = pkFILE
        Name = 'style'
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 80
    Top = 448
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 160
    Top = 448
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = FDMemTable1
    FieldDefs = <>
    Response = RESTResponse1
    Left = 288
    Top = 448
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'output_url'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 432
    Top = 448
    object FDMemTable1id: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object FDMemTable1output_url: TWideStringField
      FieldName = 'output_url'
      Size = 255
    end
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 528
    Top = 448
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = FDMemTable1
    ScopeMappings = <>
    Left = 560
    Top = 392
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 620
    Top = 389
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'output_url'
      Control = edtResultLink
      Track = True
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 288
    Top = 392
  end
end
