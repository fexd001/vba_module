VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "MyRange"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private rng As Range

' �R���X�g���N�^
Private Sub Class_Initialize()
    ' ���݂̑I���Z���ŏ������B
    Set rng = Selection
End Sub


Public Sub init(argRange As Range)
    ' �w��̑I���Z���ŏ������B
    Set rng = argRange
End Sub


' �Z���͈͂�Setter
Public Sub setRange(ByVal argRng As Range)
    Set rng = argRng
End Sub

' �Z���͈͂�Getter
Public Function getRange() As Range
    Set getRange = rng
End Function


Public Sub selectRange()
    rng.Select
End Sub


Private Function common(command As String, arg As Integer) As MyRange
    ' �đI�������͈͂��擾����B
    Dim newRange As Range
    Set newRange = getRangeCell(rng, command, arg)
    
    
    ' �Ԃ�l�͐V���ȃI�u�W�F�N�g�Ƃ��ĕԂ��B
    ' �܂莩�����g�͈̔͂͏��������Ȃ��B
    Dim newObj As MyRange
    Set newObj = New MyRange
    Call newObj.setRange(newRange)
    
    ' �Ԃ�l
    Set common = newObj
End Function

Public Function top(arg As Integer) As MyRange
    ' �Ԃ�l
    Set top = common("top", arg)
End Function
Public Function left(arg As Integer) As MyRange
    ' �Ԃ�l
    Set left = common("left", arg)
End Function
Public Function right(arg As Integer) As MyRange
    ' �Ԃ�l
    Set right = common("right", arg)
End Function
Public Function bottom(arg As Integer) As MyRange
    ' �Ԃ�l
    Set bottom = common("bottom", arg)
End Function


Public Function topLimit(arg As Integer) As MyRange
    ' �Ԃ�l
    Set topLimit = common("topLimit", arg)
End Function
Public Function leftLimit(arg As Integer) As MyRange
    ' �Ԃ�l
    Set leftLimit = common("leftLimit", arg)
End Function
Public Function rightLimit(arg As Integer) As MyRange
    ' �Ԃ�l
    Set rightLimit = common("rightLimit", arg)
End Function
Public Function bottomLimit(arg As Integer) As MyRange
    ' �Ԃ�l
    Set bottomLimit = common("bottomLimit", arg)
End Function


Public Function topResize(arg As Integer) As MyRange
    ' �Ԃ�l
    Set topResize = common("topResize", arg)
End Function
Public Function leftResize(arg As Integer) As MyRange
    ' �Ԃ�l
    Set leftResize = common("leftResize", arg)
End Function
Public Function rightResize(arg As Integer) As MyRange
    ' �Ԃ�l
    Set rightResize = common("rightResize", arg)
End Function
Public Function bottomResize(arg As Integer) As MyRange
    ' �Ԃ�l
    Set bottomResize = common("bottomResize", arg)
End Function


Public Function getRowsCount() As Long
    getRowsCount = rng.Rows.count
End Function
Public Function getColumnsCount() As Long
    getColumnsCount = rng.Columns.count
End Function


Public Function toString() As String
    toString = rng.Address
End Function