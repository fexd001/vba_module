VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "MyFile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private streamObj As Object
Private nonBomFlg As Boolean
Private filename_fullpath As String


' �R���X�g���N�^
Private Sub Class_Initialize()
    ' ���݂̑I���Z���ŏ������B
    Set streamObj = CreateObject("ADODB.Stream")
    nonBomFlg = True
End Sub



' �t�@�C���̃G���R�[�h���w�肷�郁�\�b�h�Q�B
' �w��ł��镶���G���R�[�f�B���O�̎�ނ́A
' ���W�X�g���̈ȉ��p�X�ɂ���T�u�L�[���m�F
' HKEY_CLASSES_ROOT\MIME\Database\Charset
Public Sub setChara_SJIS()
    streamObj.Charset = "Shift-JIS"
End Sub
Public Sub setChara_JIS()
    streamObj.Charset = "iso-2022-jp"
End Sub
Public Sub setChara_EUC()
    streamObj.Charset = "euc-jp"
End Sub
Public Sub setChara_Unicode()
    streamObj.Charset = "Unicode"
End Sub
Public Sub setChara_UTF7()
    streamObj.Charset = "UTF-7"
End Sub
Public Sub setChara_UTF8()
    streamObj.Charset = "UTF-8"
    nonBomFlg = False
End Sub
Public Sub setChara_UTF8N()
    streamObj.Charset = "UTF-8"
    nonBomFlg = True
End Sub


''''''''''''''''''''''''''''''''''''''''''''''''''
' �����@�@�F �w�肵���t�@�C���̃X�g���[�����J���B
' �����P�@�F �t�@�C�����B�i��΃p�X�j
' �Ԃ�l�@�F �Ȃ��B
' �g�p���@�F Dim file As MyFile
'            Set file = New MyFile
'            file.openStream ("C:\test.txt")
''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub openStream(arg1 As String)
     ' �����R�[�h���w�肵�ăt�@�C�����I�[�v��
    streamObj.Open
    streamObj.LoadFromFile (arg1)
    ' �w��̃t�@�C�����ŏ������B
    filename_fullpath = arg1
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''
' �����@�@�F �t�@�C���̃X�g���[�������B
' �����@�@�F �Ȃ��B
' �Ԃ�l�@�F �Ȃ��B
' �g�p���@�F Dim file As MyFile
'            Set file = New MyFile
'            file.openStream ("C:\test.txt")
'            file.closeStream()
''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub closeStream()
    streamObj.Close
    Set streamObj = Nothing
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''
' �����@�@�F �t�@�C����ۑ�����B
' �����@�@�F �Ȃ��B
' �Ԃ�l�@�F �Ȃ��B
' �g�p���@�F Dim file As MyFile
'            Set file = New MyFile
'            file.openStream ("C:\test.txt")
'            file.saveStream()
''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub saveStream()
    If streamObj.Charset = "UTF-8" Then
        If nonBomFlg Then
            ' �擪��BOM���
            streamObj.Position = 0
            streamObj.Type = 1 '�u1:TypeBinary�v
            streamObj.Position = 3
            bytData = streamObj.read
            streamObj.Close
            
            ' UTF-8N�R�[�h�̃f�[�^��ۑ�
            streamObj.Open
            streamObj.Type = 1 '�u1:TypeBinary�v
            streamObj.write bytData
        End If
    End If
    
    ' �t�@�C���ɏ�������
    streamObj.SaveToFile filename_fullpath, 2 '�u2:adSaveCreateOverWrite�v
End Sub

''''''''''''''''''''''''''''''''''''''''''''''''''
' �����@�@�F �t�@�C���̏I�[���𔻒f����^�U�l���擾����B
' �����@�@�F �Ȃ��B
' �Ԃ�l�@�F �Ȃ��B
' �g�p���@�F Dim file As MyFile
'            Set file = New MyFile
'            file.openStream ("C:\test.txt")
'            Do While Not file.isEos
'                MsgBox file.readLine
'            Loop
''''''''''''''''''''''''''''''''''''''''''''''''''
Public Function isEos() As Boolean
    isEos = streamObj.eos
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''
' �����@�@�F �X�g���[������P�s�������ǂݍ��ށB
' �����P�@�F �ǂݍ��ݍs�ԍ��B
' �Ԃ�l�@�F �P�s������B
' �g�p���@�F Dim file As MyFile
'            Set file = New MyFile
'            file.openStream ("C:\test.txt")
'            Do While Not file.isEos
'                MsgBox file.readLine
'            Loop
''''''''''''''''''''''''''''''''''''''''''''''''''
Public Function readLine(Optional line_number As Long) As String
    Dim str As String
    Dim pos As Long
    
    If line_number > 0 Then
        ' �ǂݍ��ݍs���w�肳�ꂽ�ꍇ�A�X�g���[���ʒu��擪�ɂ���B
        streamObj.Position = 0
        
        ' �w��s - 1�񂾂��s�X�L�b�v����B
        Dim skip_count As Long
        skip_count = line_number - 1
        For idx = 1 To skip_count
            streamObj.SkipLine
        Next
    End If
    
    pos = streamObj.Position
    ' �s�擾�
    str = streamObj.ReadText(-2) ' �u-2:adReadLine�v

    readLine = str
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''
' �����@�@�F �X�g���[���֕�������������ށB
' �����P�@�F �������ޕ�����B
' �Ԃ�l�@�F �Ȃ��B
' �g�p���@�F Dim file As MyFile
'            Set file = New MyFile
'            file.openStream ("C:\test.txt")
'            file.writeStream ("Hello." & vbNewLine)
''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub writeStream(line As String)
    ' �������ݑO�Ɍ��݈ʒu��ێ��B
    pos = streamObj.Position
    ' �X�g���[���̏I�[�Ɉړ���A�������݁B
    streamObj.Position = streamObj.Size
    streamObj.WriteText line
    ' ���݈ʒu��߂��B
    streamObj.Position = pos
End Sub




''''''''''''''''''''''''''''''''''''''''''''''''''
' �����@�@�F �X�g���[���֕�������������ށB
' �����P�@�F �������ޕ�����B
' �Ԃ�l�@�F �Ȃ��B
' �g�p���@�F Dim file As MyFile
'            Set file = New MyFile
'            file.openStream ("C:\test.txt")
'            file.writeStream ("Hello.")
''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub setStreamPosition(line_number As Long)
    If line_number < 1 Then
        ' �����ΏۊO�B
        Exit Sub
    End If
    
    ' �ǂݍ��ݍs���w�肳�ꂽ�ꍇ�A�X�g���[���ʒu��擪�ɂ���B
    streamObj.Position = 0
    
    ' �w��s - 1�񂾂��s�X�L�b�v����B
    Dim skip_count As Long
    skip_count = line_number - 1
    For idx = 1 To skip_count
        streamObj.SkipLine
    Next
End Sub

