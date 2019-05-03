<html>
<head>
<title>Cetakan Butir Kesalahan</title>
</head>
<body onload='self.print()' topmargin="0" leftmargin="0">
<%	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"

    akta = Request.querystring("akta")
	
	f = " select to_char(sysdate,'dd-mm-yyyy  hh24:mi:ss') as tkhs from dual "
   	Set objRs1a = objConn.Execute(f)	
   	tkhs = objrs1a("tkhs")
      	
	s = " select nama from majlis.syarikat "     	
	Set objRss = objConn.Execute(s)
	namas = objRss("nama")
	
	w = " select initcap(keterangan)keterangan from kompaun.akta where kod = '"&akta&"' "
	set sw = objconn.execute(w)
		
	if sw.eof then
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Tiada Rekod!"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
		response.end
	else
			keterangan = sw("keterangan")
	end if  
	
		d = " select rowid, kod, initcap(keterangan) keterangan,initcap(keterangan2) keterangan2, akta, "
		d = d & " nvl(amaun_maksima,0)amaun from kompaun.butir_kesalahan where akta = '"&akta&"' order by kod"
		Set sd = objConn.Execute(d)     
     
    muka = 0
    mula
    badan  

	sub mula	
		muka = cdbl(muka) + 1
%>
<table width="110%" border="0" style="font-family: Trebuchet MS; font-size: 11pt;">
  <tr> 
    <td width="20%" align="left" ><i><%=tkhs%></i></td>
    <td width="60%" align="center"></td>
    <td width="20%" align="right" >Page <%=muka%></td>  </tr>
  <tr> 
    <td colspan="3" align="center" > <font size="4"><b><%=namas%></b></font> </td>
  </tr>
  <tr> 
    <td width="20%" >&nbsp;</td>
    <td width="60%" align="center"><font size="3"><b>BUTIR KESALAHAN</b></font></td>
    <td width="20%" >&nbsp;</td>
  </tr>
</table>
<table width="85%" align="center" border="0" style="font-family: Trebuchet MS; font-size: 11pt; font-weight:bold">
  <tr> 
    <td width="14%" nowrap align="right">Akta/UUK : </td>
    <td width="86%" ><%=akta%>-<%=keterangan%></td>
  </tr>
</table>
<hr>
<%	end sub	
    sub badan		%>
<table border="0" width="90%" align="center" style="font-family: Trebuchet MS; font-size: 11pt;">
  <tr style="font-weight:bold;"> 
    <td align="center" width="3%">Bil</td>
    <td align="center" width="7%">Kod</td>
    <td width="70%" align="center">Keterangan</td>
    <td width="20%" align="left">Amaun</td>
  </tr>
  <%	ctr = 0
  	ctrz = 0
	bil = 0

	Do while not sd.eof	
	bil = bil + 1
	ctr = cdbl(ctr) + 1
    	ctrz = cdbl(ctrz) + 1
    	if ctr = 40 then
    		ctr = 1  	  %> 
</table>
<%mula%>
<table width="90%" height="46" border="0" align="center" >
  <tr align="center" style="font-family: Trebuchet MS; font-size: 11pt; font-weight:bold;"> 
    <td width="3%">Bil</td>
    <td width="7%">Kod</td>
    <td width="70%">Keterangan</td>
    <td width="20%" align="left">Amaun</td>
  </tr>
  <%	end if	%> 
  <tr align="center" style="font-family: Trebuchet MS; font-size: 11pt;" valign="top"> 
    <td height="20" width="3%"><%=bil%></td>
    <td height="20" width="7%"><%=sd("kod")%></td>
    <td width="70%" align="left"><%=sd("keterangan")%><br>
      &nbsp;<%=sd("keterangan2")%></td>
    <td width="20%" align="left"> <%=formatnumber(sd("amaun"))%> </td>
  </tr>
  <%	sd.MoveNext
	Loop
%> 
</table>
<%	end sub	%>

</body>
</html>

