<html>
<head>
<title>Cetakan Kompaun Sudah DiBayar</title>
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
	
		d = " select kod, initcap(keterangan) keterangan from kompaun.akta "
		d = d & " where kod like '"&akta&"'||'%' order by kod"
		Set sd = objConn.Execute(d)       
     
    muka = 0
    mula
    badan     

	sub mula	
		muka = cdbl(muka) + 1
%>
<table width="100%" border="0" style="font-family: Trebuchet MS; font-size: 10pt;">
  <tr> 
    <td width="20%" align="left" ><i><%=tkhs%></i></td>
    <td width="60%" align="center"></td>
    <td width="20%" align="right" >Page <%=muka%></td>  </tr>
  <tr>  <td colspan="3" align="left" >&nbsp;</td> </tr>
  <tr> 
    <td colspan="3" align="center" > <font size="4"><b><%=namas%></b></font> </td>
  </tr>
  <tr> 
    <td width="20%" >&nbsp;</td>
    <td width="60%" align="center"><font size="3"><b>AKTA/UUK</b></font></td>
    <td width="20%" >&nbsp;</td>
  </tr>
</table>
<hr>
<%	end sub	
    sub badan		%>
<table border="0" width="90%" align="center" style="font-family: Trebuchet MS; font-size: 10pt;">
  <tr style="font-weight:bold;"> 
    <td align="center" width="6%">Bil</td>
    <td align="center" width="14%">Kod</td>
    <td width="80%" align="center">Keterangan</td>
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
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;"> 
    <td width="6%">Bil</td>
    <td width="14%">Kod</td>
    <td width="80%">Keterangan</td>
  </tr>
  <%	end if	%>
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt;"> 
    <td height="20" width="6%"><%=bil%></td>
    <td height="20" width="14%"><%=sd("kod")%></td>
    <td width="80%" align="left"><%=sd("keterangan")%></td>
  </tr>
  <%	sd.MoveNext
	Loop
%>
</table>
<%	end sub	%>

</body>
</html>

