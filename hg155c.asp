<html>
<head>
<title>Cetakan Pembatalan</title>
</head>
<body onload='self.print()' topmargin="0" leftmargin="0">
<%	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"

    tkhd = Request.querystring("tkhd")
    tkhh = Request.querystring("tkhh")
	
	f="select to_char(sysdate,'dd-mm-yyyy  hh24:mi:ss') as tkhs from dual "
   	Set objRs1a = objConn.Execute(f)	
   	tkhs = objrs1a("tkhs")
      	
	s = " select nama from majlis.syarikat "     	
	Set objRss = objConn.Execute(s)
	namas = objRss("nama")
	
		d = " select no_kompaun,no_akaun,upper(nama) nama, to_char(tkh_batal,'dd/mm/yyyy')tkh_batal,"
	    d = d & " to_char(tkh_kompaun,'dd/mm/yyyy')tkh_kompaun, "
		d = d & " decode(dibatal_oleh,1,'YDP',2,'SU',3,'Pengarah',null) pembatal from kompaun.halangan "
		d = d & " where tkh_kompaun between  to_date('"&tkhd&"','dd/mm/yyyy') and "
		d = d & " to_date('"&tkhh&"','dd/mm/yyyy') and status_kompaun = 'B' "
		d = d & " order by no_kompaun "
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
    <td width="20%" align="right" >Page <%=muka%></td>
  </tr>
  <tr> 
    <td width="20%" align="left" >&nbsp;</td>
    <td width="60%" align="center"></td>
    <td width="20%" align="right" >&nbsp;</td>
  </tr><tr> 
    <td colspan="3" align="center" >
     <font size="4"><b><%=namas%></b></font>
    </td></tr><tr> 
    <td width="20%" >&nbsp;</td>
    <td width="60%" align="center"><font size="3"><b>LAPORAN PEMBATALAN 
      KOMPAUN</b></font></td>
    <td width="20%" >&nbsp;</td>
  </tr>
</table>
<table width="85%" align="center" border="0" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold">
  <tr> 
    <td width="14%" nowrap>
      <div align="right">Tarikh Dari :</div>
    </td>
    <td width="86%" ><%=tkhd%>&nbsp;Hingga&nbsp;<%=tkhh%></td>
  </tr>
</table>
<hr>
<%	end sub	
    sub badan		%>
<table border="0" width="85%" align="center" style="font-family: Trebuchet MS; font-size: 10pt;">
  <tr style="font-weight:bold;"> 
    <td align="center">Bil</td>
    <td align="center">No Kompaun</td>
    <td align="center">No Akaun</td>
    <td width="40%" align="center">Nama</td>
    <td align="center">Tkh Kompaun</td>
    <td align="center">Tkh Batal</td>
    <td align="center">Dibatal </td>
  </tr>
  <%	ctr = 0
  	ctrz = 0
	bil = 0

	Do while not sd.eof
	
	bil = bil + 1
	ctr = cdbl(ctr) + 1
    	ctrz = cdbl(ctrz) + 1
    	if ctr = 40 then
    		ctr = 1  	
  %>
</table>
<%mula%>
<table width="85%" height="46" border="0" align="center" >
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;"> 
    <td>Bil</td>
    <td>No Kompaun</td>
    <td>No Akaun</td>
    <td>Nama</td>
    <td>Tkh Kompaun</td>
    <td>Tkh Batal</td>
    <td>Dibatal </td>
  </tr>
  <%	end if	%>
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt;"> 
    <td height="20"><%=bil%></td>
    <td height="20"><%=sd("no_kompaun")%></td>
    <td height="20"><%=sd("no_akaun")%></td>
    <td width="40%" align="left"><%=sd("nama")%></td>
    <td height="20"><%=sd("tkh_kompaun")%></td>
    <td height="20"><%=sd("tkh_batal")%></td>
    <td height="20"><%=sd("pembatal")%></td>
  </tr>
  <%	sd.MoveNext
	Loop
%>
</table>
<%	end sub	%>

</body>
</html>

