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
'*********************码垛功能添加**************
'文件是否存在
if loadTechPkg("PLT_INIT.PRG",1) then
	print "码垛加载成功"
end if

'*****************简化版码垛功能添加************
'文件是否存在
if loadTechPkg("NP_INIT.PRG",5) then            'Add by odm
	print "简化版码垛加载成功"
end if

'*********************涂胶功能添加**************
'文件是否存在
if loadTechPkg("GLU_INIT.PRG",3) then
	print "涂胶加载成功"
end if

'*********************焊接功能添加**************
'文件是否存在
try 
	if arcConfig->weldmachine <> "" then
		if loadTechPkg("WELDFUN.PRG",2) then
			print "焊接加载成功"
		end if
	end if 
catch else
end try
end program ' <MyTask>.prg
'加载工艺包程序，返回为true时加载成功
function loadTechPkg(byval techfileName as string,byval techId as long) as long
dim lRet as long = FALSE
if isFileExist(techfileName) then
	'授权是否到期
	if getAuthorTotalTime(techId) > 0 then
	'启动计时
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
'判断文件是否存在  返回 1，存在，其他 不存在
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
