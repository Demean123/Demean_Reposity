program continue
  dim sPLT_FILE as string ="_NPltDAT.PRG"
  dim sVPLT_FILE as string="_VPltDAT.PRG"
  
  ?InitNewPltData
  ?InitNewVerPltData
  if isFileExist(sPLT_FILE) = 0  then
    load _NPltDAT.PRG
  end if
    if isFileExist(sVPLT_FILE) = 0  then
    load _VPltDAT.PRG
  end if
  while True
    call setworkpiece
   sleep 1000
  end while
terminate program