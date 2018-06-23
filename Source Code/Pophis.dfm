object Hisblad: THisblad
  Left = 292
  Top = 364
  Width = 702
  Height = 319
  Caption = 'Mutation statistics'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Chart2: TChart
    Left = 0
    Top = 0
    Width = 625
    Height = 249
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    BackWall.Dark3D = False
    Title.Text.Strings = (
      'Mutation Histogram')
    DepthAxis.Automatic = False
    DepthAxis.AutomaticMaximum = False
    DepthAxis.AutomaticMinimum = False
    DepthAxis.Maximum = -0.5
    DepthAxis.Minimum = -0.5
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Minimum = 0.01
    Legend.Alignment = laLeft
    Legend.Visible = False
    View3D = False
    TabOrder = 0
    object CheckBox3: TCheckBox
      Left = 1
      Top = 1
      Width = 97
      Height = 17
      Caption = 'Logarithmic'
      TabOrder = 0
      OnClick = CheckBox3Click
    end
    object CheckBox4: TCheckBox
      Left = 97
      Top = 1
      Width = 97
      Height = 17
      Caption = 'Normalise'
      TabOrder = 1
      OnClick = CheckBox4Click
    end
    object CheckBox1: TCheckBox
      Left = 176
      Top = 0
      Width = 97
      Height = 17
      Caption = 'Sort'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBox2: TCheckBox
      Left = 240
      Top = 0
      Width = 49
      Height = 17
      Caption = 'Ho'
      TabOrder = 3
      OnClick = CheckBox2Click
    end
    object CheckBox5: TCheckBox
      Left = 288
      Top = 0
      Width = 49
      Height = 17
      Caption = 'He'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBox5Click
    end
    object Bargraph1: TBarSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'Bargraph1'
      MultiBar = mbNone
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object FormStorage1: TFormStorage
    UseRegistry = False
    StoredProps.Strings = (
      'CheckBox1.Checked'
      'CheckBox2.Checked'
      'CheckBox3.Checked'
      'CheckBox4.Checked'
      'CheckBox5.Checked')
    StoredValues = <>
    Left = 112
    Top = 80
  end
end
