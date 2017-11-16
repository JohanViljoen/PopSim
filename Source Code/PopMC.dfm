object MCForm: TMCForm
  Left = 1352
  Top = 126
  Width = 491
  Height = 789
  Caption = 'Monte Carlo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    475
    751)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 40
    Width = 473
    Height = 225
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 16
      Top = 104
      Width = 145
      Height = 113
      Caption = 'Community size'
      TabOrder = 0
      object Label3: TLabel
        Left = 16
        Top = 24
        Width = 17
        Height = 13
        Caption = 'Min'
      end
      object Label5: TLabel
        Left = 16
        Top = 48
        Width = 20
        Height = 13
        Caption = 'Max'
      end
      object Label4: TLabel
        Left = 16
        Top = 72
        Width = 43
        Height = 13
        Caption = 'Step size'
      end
      object Label6: TLabel
        Left = 16
        Top = 96
        Width = 33
        Height = 13
        Caption = 'Steps: '
      end
      object PBSuperSpin8: TPBSuperSpin
        Left = 56
        Top = 16
        Width = 81
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 0
        MaxValue = 1000000
        MinValue = 1
        NumberFormat = Standard
        OnChange = PBSuperSpin8Change
        TabOrder = 0
        Value = 50
        Increment = 1
        RoundValues = False
        Wrap = False
      end
      object PBSuperSpin9: TPBSuperSpin
        Left = 56
        Top = 40
        Width = 81
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 0
        MaxValue = 1000000
        MinValue = 1
        NumberFormat = Standard
        OnChange = PBSuperSpin8Change
        TabOrder = 1
        Value = 300
        Increment = 1
        RoundValues = False
        Wrap = False
      end
      object PBSuperSpin10: TPBSuperSpin
        Left = 72
        Top = 64
        Width = 65
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 0
        MaxValue = 100000
        NumberFormat = Standard
        OnChange = PBSuperSpin8Change
        TabOrder = 2
        Value = 25
        Increment = 1
        RoundValues = False
        Wrap = False
      end
    end
    object GroupBox3: TGroupBox
      Left = 168
      Top = 104
      Width = 145
      Height = 113
      Caption = 'Heterozygotic Advantage'
      TabOrder = 1
      object Label7: TLabel
        Left = 16
        Top = 24
        Width = 28
        Height = 13
        Caption = 'Min %'
      end
      object Label8: TLabel
        Left = 16
        Top = 48
        Width = 31
        Height = 13
        Caption = 'Max %'
      end
      object Label9: TLabel
        Left = 16
        Top = 72
        Width = 43
        Height = 13
        Caption = 'Step size'
      end
      object Label10: TLabel
        Left = 16
        Top = 96
        Width = 33
        Height = 13
        Caption = 'Steps: '
      end
      object PBSuperSpin2: TPBSuperSpin
        Left = 64
        Top = 19
        Width = 68
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 5
        MaxValue = 10000
        MinValue = -100
        NumberFormat = Standard
        OnChange = PBSuperSpin2Change
        TabOrder = 0
        Value = 2
        Increment = 0.01
        RoundValues = False
        Wrap = False
      end
      object PBSuperSpin3: TPBSuperSpin
        Left = 64
        Top = 43
        Width = 68
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 5
        MaxValue = 10000
        MinValue = -100
        NumberFormat = Standard
        OnChange = PBSuperSpin2Change
        TabOrder = 1
        Value = 4
        Increment = 0.01
        RoundValues = False
        Wrap = False
      end
      object PBSuperSpin4: TPBSuperSpin
        Left = 72
        Top = 67
        Width = 60
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 3
        NumberFormat = Standard
        OnChange = PBSuperSpin2Change
        TabOrder = 2
        Increment = 0.001
        RoundValues = False
        Wrap = False
      end
      object CheckBox4: TCheckBox
        Left = 96
        Top = 92
        Width = 41
        Height = 17
        Caption = 'Log'
        TabOrder = 3
        OnClick = CheckBox4Click
      end
    end
    object Button1: TButton
      Left = 16
      Top = 16
      Width = 137
      Height = 81
      Caption = 'Run'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button1Click
    end
    object GroupBox4: TGroupBox
      Left = 320
      Top = 8
      Width = 145
      Height = 81
      TabOrder = 3
      object Label16: TLabel
        Left = 16
        Top = 8
        Width = 97
        Height = 13
        Caption = 'Initial prevalence (%)'
      end
      object PBSuperSpin12: TPBSuperSpin
        Left = 40
        Top = 24
        Width = 60
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 2
        NumberFormat = Standard
        OnChange = PBSuperSpin12Change
        TabOrder = 0
        Increment = 0.01
        RoundValues = False
        Wrap = False
      end
      object CheckBox5: TCheckBox
        Left = 16
        Top = 56
        Width = 97
        Height = 17
        Caption = 'Use previous'
        TabOrder = 1
      end
    end
    object GroupBox6: TGroupBox
      Left = 168
      Top = 8
      Width = 145
      Height = 89
      TabOrder = 4
      object Label1: TLabel
        Left = 8
        Top = 13
        Width = 25
        Height = 13
        Caption = 'Runs'
      end
      object Label2: TLabel
        Left = 8
        Top = 37
        Width = 47
        Height = 13
        Caption = 'Threshold'
      end
      object Label11: TLabel
        Left = 8
        Top = 61
        Width = 46
        Height = 13
        Caption = 'Max gens'
      end
      object PBSuperSpin5: TPBSuperSpin
        Left = 64
        Top = 8
        Width = 73
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 0
        MaxValue = 100000
        NumberFormat = Standard
        OnChange = PBSuperSpin5Change
        TabOrder = 0
        Value = 10
        Increment = 1
        RoundValues = False
        Wrap = False
      end
      object PBSuperSpin1: TPBSuperSpin
        Left = 64
        Top = 32
        Width = 73
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 0
        NumberFormat = Standard
        TabOrder = 1
        Value = 1000
        Increment = 10
        RoundValues = False
        Wrap = False
      end
      object PBSuperSpin6: TPBSuperSpin
        Left = 64
        Top = 56
        Width = 73
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 0
        MaxValue = 100000
        MinValue = 1
        NumberFormat = Standard
        TabOrder = 2
        Value = 1000
        Increment = 1
        RoundValues = False
        Wrap = False
      end
    end
    object GroupBox7: TGroupBox
      Left = 320
      Top = 88
      Width = 145
      Height = 129
      Caption = 'Homozygotic Advantage'
      TabOrder = 5
      object Label17: TLabel
        Left = 16
        Top = 40
        Width = 28
        Height = 13
        Caption = 'Min %'
      end
      object Label18: TLabel
        Left = 16
        Top = 64
        Width = 31
        Height = 13
        Caption = 'Max %'
      end
      object Label19: TLabel
        Left = 16
        Top = 88
        Width = 43
        Height = 13
        Caption = 'Step size'
      end
      object Label20: TLabel
        Left = 16
        Top = 112
        Width = 33
        Height = 13
        Caption = 'Steps: '
      end
      object PBSuperSpin13: TPBSuperSpin
        Left = 64
        Top = 35
        Width = 68
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 3
        MaxValue = 10000
        MinValue = -100
        NumberFormat = Standard
        OnChange = PBSuperSpin13Change
        TabOrder = 0
        Value = 2
        Increment = 0.01
        RoundValues = False
        Wrap = False
      end
      object PBSuperSpin14: TPBSuperSpin
        Left = 64
        Top = 59
        Width = 68
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 3
        MaxValue = 10000
        MinValue = -100
        NumberFormat = Standard
        OnChange = PBSuperSpin13Change
        TabOrder = 1
        Value = 4
        Increment = 0.01
        RoundValues = False
        Wrap = False
      end
      object PBSuperSpin15: TPBSuperSpin
        Left = 72
        Top = 83
        Width = 60
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 3
        NumberFormat = Standard
        OnChange = PBSuperSpin13Change
        TabOrder = 2
        Increment = 0.001
        RoundValues = False
        Wrap = False
      end
      object CheckBox3: TCheckBox
        Left = 16
        Top = 16
        Width = 121
        Height = 17
        Caption = '= Heterozygotic Adv.'
        TabOrder = 3
        OnClick = CheckBox3Click
      end
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 344
    Width = 472
    Height = 409
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 0
    Width = 209
    Height = 17
    Caption = 'Mutation Establishment'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 24
    Width = 161
    Height = 17
    Caption = 'Equilibrium levels'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = RadioButton2Click
  end
  object GroupBox5: TGroupBox
    Left = 0
    Top = 272
    Width = 473
    Height = 73
    TabOrder = 4
    object Label12: TLabel
      Left = 136
      Top = 32
      Width = 58
      Height = 13
      Caption = 'Total Runs :'
    end
    object Label13: TLabel
      Left = 136
      Top = 48
      Width = 39
      Height = 13
      Caption = '0 runs/s'
    end
    object Label14: TLabel
      Left = 8
      Top = 21
      Width = 28
      Height = 13
      Caption = 'Width'
    end
    object Label15: TLabel
      Left = 8
      Top = 45
      Width = 31
      Height = 13
      Caption = 'Height'
    end
    object PBSuperSpin7: TPBSuperSpin
      Left = 48
      Top = 16
      Width = 65
      Height = 22
      Cursor = crDefault
      Alignment = taRightJustify
      Decimals = 0
      NumberFormat = Standard
      OnChange = PBSuperSpin7Change
      TabOrder = 0
      Value = 500
      Increment = 10
      RoundValues = False
      Wrap = False
    end
    object PBSuperSpin11: TPBSuperSpin
      Left = 48
      Top = 40
      Width = 65
      Height = 22
      Cursor = crDefault
      Alignment = taRightJustify
      Decimals = 0
      NumberFormat = Standard
      OnChange = PBSuperSpin11Change
      TabOrder = 1
      Value = 500
      Increment = 10
      RoundValues = False
      Wrap = False
    end
    object CheckBox2: TCheckBox
      Left = 136
      Top = 14
      Width = 81
      Height = 17
      Caption = 'Display'
      TabOrder = 2
      OnClick = CheckBox2Click
    end
    object CheckBox1: TCheckBox
      Left = 280
      Top = 14
      Width = 97
      Height = 17
      Caption = 'Graphs'
      TabOrder = 3
      OnClick = CheckBox1Click
    end
  end
  object FormStorage1: TFormStorage
    UseRegistry = False
    StoredProps.Strings = (
      'PBSuperSpin1.Value'
      'PBSuperSpin2.Value'
      'PBSuperSpin3.Value'
      'PBSuperSpin4.Value'
      'PBSuperSpin5.Value'
      'PBSuperSpin6.Value'
      'PBSuperSpin7.Value'
      'PBSuperSpin8.Value'
      'PBSuperSpin9.Value'
      'PBSuperSpin10.Value'
      'PBSuperSpin11.Value'
      'PBSuperSpin12.Value'
      'PBSuperSpin13.Value'
      'PBSuperSpin14.Value'
      'PBSuperSpin15.Value'
      'RadioButton1.Checked'
      'RadioButton2.Checked'
      'CheckBox1.Checked'
      'CheckBox2.Checked'
      'CheckBox3.Checked'
      'CheckBox4.Checked'
      'CheckBox5.Checked')
    StoredValues = <>
    Left = 64
    Top = 360
  end
end
