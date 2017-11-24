object Form1: TForm1
  Left = 406
  Top = 209
  Width = 737
  Height = 487
  Caption = 'PopSim'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 625
    Top = 122
    Width = 72
    Height = 13
    Caption = 'Generations : 0'
  end
  object Label12: TLabel
    Left = 629
    Top = 136
    Width = 28
    Height = 13
    Caption = 'gen/s'
  end
  object Button2: TButton
    Left = 624
    Top = 38
    Width = 97
    Height = 25
    Caption = 'Step'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 624
    Top = 8
    Width = 97
    Height = 25
    Caption = 'Run'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button3Click
  end
  object Chart1: TChart
    Left = 0
    Top = 159
    Width = 721
    Height = 290
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    BackWall.Dark3D = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      'Prevalence')
    BottomAxis.Logarithmic = True
    DepthAxis.Automatic = False
    DepthAxis.AutomaticMaximum = False
    DepthAxis.AutomaticMinimum = False
    DepthAxis.Maximum = -0.5
    DepthAxis.Minimum = -0.5
    LeftAxis.ExactDateTime = False
    LeftAxis.Logarithmic = True
    LeftAxis.Title.Caption = '%'
    Legend.Visible = False
    View3D = False
    Color = clWhite
    TabOrder = 2
    DesignSize = (
      721
      290)
    object Label13: TLabel
      Left = 7
      Top = 112
      Width = 18
      Height = 13
      Caption = 'Log'
    end
    object Button4: TButton
      Left = 3
      Top = 3
      Width = 49
      Height = 25
      Caption = 'Clear'
      TabOrder = 0
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 56
      Top = 3
      Width = 49
      Height = 25
      Caption = 'Save'
      TabOrder = 1
      OnClick = Button5Click
    end
    object CheckBox3: TCheckBox
      Left = 624
      Top = 6
      Width = 89
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Logarithmic'
      TabOrder = 2
      OnClick = CheckBox3Click
    end
    object CheckBox4: TCheckBox
      Left = 8
      Top = 96
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = CheckBox4Click
    end
    object CheckBox8: TCheckBox
      Left = 112
      Top = 8
      Width = 41
      Height = 17
      Caption = 'He'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBox8Click
    end
    object CheckBox9: TCheckBox
      Left = 156
      Top = 8
      Width = 41
      Height = 17
      Caption = 'Ho'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
      OnClick = CheckBox9Click
    end
    object CheckBox10: TCheckBox
      Left = 200
      Top = 8
      Width = 41
      Height = 17
      Caption = 'W'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = CheckBox10Click
    end
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlue
      Dark3D = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlack
      Dark3D = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object GroupBox1: TGroupBox
    Left = 344
    Top = 0
    Width = 273
    Height = 153
    Caption = 'Population'
    TabOrder = 3
    object Label9: TLabel
      Left = 196
      Top = 18
      Width = 37
      Height = 13
      Caption = 'Width : '
      OnClick = Label9Click
    end
    object Label10: TLabel
      Left = 193
      Top = 42
      Width = 40
      Height = 13
      Caption = 'Height : '
      OnClick = Label9Click
    end
    object Label11: TLabel
      Left = 9
      Top = 64
      Width = 59
      Height = 13
      Caption = 'Population : '
    end
    object Label2: TLabel
      Left = 8
      Top = 130
      Width = 57
      Height = 13
      Caption = 'Community :'
    end
    object Label14: TLabel
      Left = 80
      Top = 99
      Width = 30
      Height = 13
      Caption = 'sigma:'
    end
    object ScrollBar3: TScrollBar
      Left = 8
      Top = 16
      Width = 185
      Height = 17
      LargeChange = 20
      Max = 2000
      Min = 10
      PageSize = 0
      Position = 800
      TabOrder = 0
      OnChange = ScrollBar3Change
    end
    object ScrollBar4: TScrollBar
      Left = 8
      Top = 40
      Width = 185
      Height = 17
      LargeChange = 20
      Max = 2000
      Min = 10
      PageSize = 0
      Position = 625
      TabOrder = 1
      OnChange = ScrollBar4Change
    end
    object PBSuperSpin3: TPBSuperSpin
      Left = 64
      Top = 125
      Width = 81
      Height = 22
      Cursor = crDefault
      Alignment = taRightJustify
      Decimals = 3
      MaxValue = 9999999
      MinValue = 1
      NumberFormat = Standard
      OnChange = PBSuperSpin3Change
      TabOrder = 2
      Increment = 1
      RoundValues = False
      Wrap = False
    end
    object ScrollBar2: TScrollBar
      Left = 144
      Top = 126
      Width = 121
      Height = 18
      LargeChange = 20
      Min = 1
      PageSize = 0
      Position = 100
      TabOrder = 3
      OnScroll = ScrollBar2Scroll
    end
    object CheckBox1: TCheckBox
      Left = 200
      Top = 80
      Width = 65
      Height = 17
      Caption = 'Display'
      TabOrder = 4
      OnClick = CheckBox1Click
    end
    object CheckBox6: TCheckBox
      Left = 200
      Top = 104
      Width = 57
      Height = 17
      Caption = 'Graph'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object CheckBox7: TCheckBox
      Left = 8
      Top = 98
      Width = 65
      Height = 17
      Caption = 'Gaussian'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = CheckBox7Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 337
    Height = 153
    Caption = 'Mutations'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label1: TLabel
      Left = 224
      Top = 18
      Width = 41
      Height = 13
      Caption = 'Carrier %'
    end
    object Label4: TLabel
      Left = 224
      Top = 53
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label7: TLabel
      Left = 8
      Top = 109
      Width = 41
      Height = 13
      Caption = 'De novo'
    end
    object Label8: TLabel
      Left = 152
      Top = 109
      Width = 33
      Height = 13
      Caption = 'x10E-6'
    end
    object Label5: TLabel
      Left = 272
      Top = 53
      Width = 35
      Height = 13
      Caption = '0.000%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 53
      Width = 131
      Height = 13
      Caption = 'Heterozygotic Advantage %'
    end
    object Label17: TLabel
      Left = 8
      Top = 77
      Width = 127
      Height = 13
      Caption = 'Homozygotic Advantage %'
    end
    object Label19: TLabel
      Left = 272
      Top = 40
      Width = 54
      Height = 13
      Caption = 'Prevalence'
    end
    object Label20: TLabel
      Left = 272
      Top = 77
      Width = 35
      Height = 13
      Caption = '0.000%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 232
      Top = 40
      Width = 17
      Height = 13
      Caption = '1+s'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 245
      Top = 101
      Width = 62
      Height = 13
      Caption = 'Wild: 0.000%'
    end
    object Label15: TLabel
      Left = 8
      Top = 77
      Width = 116
      Height = 13
      Caption = 'Homozygotic Advantage'
    end
    object Label16: TLabel
      Left = 224
      Top = 77
      Width = 8
      Height = 13
      Caption = '%'
    end
    object ScrollBar1: TScrollBar
      Left = 88
      Top = 16
      Width = 129
      Height = 17
      LargeChange = 100
      Max = 10000
      PageSize = 0
      Position = 100
      TabOrder = 0
      OnChange = ScrollBar1Change
    end
    object Button1: TButton
      Left = 8
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Initialise'
      TabOrder = 1
      OnClick = Button1Click
    end
    object PBSuperSpin1: TPBSuperSpin
      Left = 144
      Top = 48
      Width = 77
      Height = 22
      Cursor = crDefault
      Alignment = taRightJustify
      Decimals = 4
      MaxValue = 10000
      MinValue = -100
      NumberFormat = Standard
      OnChange = PBSuperSpin1Change
      TabOrder = 2
      Value = 5
      Increment = 0.01
      RoundValues = False
      Wrap = False
    end
    object PBSuperSpin2: TPBSuperSpin
      Left = 80
      Top = 104
      Width = 65
      Height = 22
      Cursor = crDefault
      Alignment = taRightJustify
      Decimals = 2
      MaxValue = 1000000
      NumberFormat = Standard
      OnChange = PBSuperSpin2Change
      TabOrder = 3
      Increment = 0.01
      RoundValues = False
      Wrap = False
    end
    object CheckBox2: TCheckBox
      Left = 80
      Top = 128
      Width = 89
      Height = 17
      Caption = 'Multiple types'
      TabOrder = 4
      OnClick = CheckBox2Click
    end
    object CheckBox5: TCheckBox
      Left = 200
      Top = 128
      Width = 81
      Height = 17
      Caption = 'Histogram'
      TabOrder = 5
      OnClick = CheckBox5Click
    end
    object PBSuperSpin4: TPBSuperSpin
      Left = 144
      Top = 72
      Width = 77
      Height = 22
      Cursor = crDefault
      Alignment = taRightJustify
      Decimals = 4
      MaxValue = 10000
      MinValue = -100
      NumberFormat = Standard
      OnChange = PBSuperSpin4Change
      TabOrder = 6
      Value = -100
      Increment = 1
      RoundValues = False
      Wrap = False
    end
  end
  object Button6: TButton
    Left = 624
    Top = 68
    Width = 97
    Height = 25
    Caption = 'Monte Carlo'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 624
    Top = 98
    Width = 46
    Height = 25
    Caption = 'Save'
    TabOrder = 6
    Visible = False
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 675
    Top = 98
    Width = 46
    Height = 25
    Caption = 'Load'
    TabOrder = 7
    Visible = False
    OnClick = Button8Click
  end
  object CheckBox11: TCheckBox
    Left = 352
    Top = 80
    Width = 105
    Height = 17
    Caption = 'Parent Histogram'
    TabOrder = 8
    OnClick = CheckBox11Click
  end
  object Timer1: TTimer
    Interval = 333
    OnTimer = Timer1Timer
    Left = 192
    Top = 208
  end
  object FormStorage1: TFormStorage
    UseRegistry = False
    StoredProps.Strings = (
      'ScrollBar1.Position'
      'PBSuperSpin1.Value'
      'PBSuperSpin2.Value'
      'PBSuperSpin3.Value'
      'PBSuperSpin4.Value'
      'ScrollBar2.Position'
      'ScrollBar3.Position'
      'ScrollBar4.Position'
      'CheckBox1.Checked'
      'CheckBox2.Checked'
      'CheckBox3.Checked'
      'CheckBox4.Checked'
      'CheckBox5.Checked'
      'CheckBox6.Checked'
      'CheckBox7.Checked'
      'CheckBox8.Checked'
      'CheckBox9.Checked'
      'CheckBox10.Checked')
    StoredValues = <>
    Left = 160
    Top = 208
  end
  object SaveDialog1: TSaveDialog
    Left = 128
    Top = 208
  end
  object OpenDialog1: TOpenDialog
    Left = 96
    Top = 208
  end
  object JvAppInstances1: TJvAppInstances
    MaxInstances = 32
    Left = 240
    Top = 208
  end
end
