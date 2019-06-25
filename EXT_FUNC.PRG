'------------------------------------------------------------------------------
' File:        <MyTask>.prg
' Purpose:     Just an example of a module header
' Version:     1.00
' Author:      <MyFullName>
' Description:
' History:     YYYY-MM-DD  <MyShortCut>  V1.00
'              Created
'------------------------------------------------------------------------------

' module global "constants"


' module global variables


program
'*********************��⹦������**************
'�ļ��Ƿ����
if loadTechPkg("PLT_INIT.PRG",1) then
	print "�����سɹ�"
end if

'*****************�򻯰���⹦������************
'�ļ��Ƿ����
if loadTechPkg("NP_INIT.PRG",5) then            'Add by odm
	print "�򻯰������سɹ�"
end if

'*********************Ϳ����������**************
'�ļ��Ƿ����
if loadTechPkg("GLU_INIT.PRG",3) then
	print "Ϳ�����سɹ�"
end if

'*********************���ӹ�������**************
'�ļ��Ƿ����
try 
	if arcConfig->weldmachine <> "" then
		if loadTechPkg("WELDFUN.PRG",2) then
			print "���Ӽ��سɹ�"
		end if
	end if 
catch else
end try
end program ' <MyTask>.prg
'���ع��հ����򣬷���Ϊtrueʱ���سɹ�
function loadTechPkg(byval techfileName as string,byval techId as long) as long
dim lRet as long = FALSE
if isFileExist(techfileName) then
	'��Ȩ�Ƿ���
	if getAuthorTotalTime(techId) > 0 then
	'������ʱ
		if startReduceAuthTime(techId) = 0 then
		try
		load$ techfileName
		lRet=TRUE
		catch  else
		end try
		end if 
	end if 
end if

loadTechPkg = lRet
end function
'�ж��ļ��Ƿ����  ���� 1�����ڣ����� ������
function isFileExist(byval stechfileName as string) as long
dim lret as long =FALSE
dim DeviceHandler as long =1
dim lGetNext as long =TRUE
while lGetNext
  try
      Open  stechfileName Mode="r" as #DeviceHandler 
      close #DeviceHandler
      Sleep 5
      lret=TRUE
      lGetNext = FALSE
    catch 5043  ' Port or file is already open
      DeviceHandler = DeviceHandler + 1
      if DeviceHandler > 255 then
        lGetNext = FALSE
      end if
   'catch 4016 4017'  Cannot locate the file.
   catch else
   lGetNext = FALSE
  end try
 end while
isFileExist=lret
end function