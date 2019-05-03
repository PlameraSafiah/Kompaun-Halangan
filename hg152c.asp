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
	
		d = " select count(*) bilangan,to_char(tkh_kompaun,'yyyy')y,  "
	    d = d & " lpad(to_char(tkh_kompaun,'mm'),2,0)m, "
		d = d & " lpad(to_char(tkh_kompaun,'dd'),2,0)d from kompaun.halangan "
		d = d & " where tkh_kompaun between  to_date('"&tkhd&"','dd/mm/yyyy') and"
		d = d & " to_date('"&tkhh&"','dd/mm/yyyy')"
		d = d & " group by to_char(tkh_kompaun,'yyyy'), "
		d = d & " lpad(to_char(tkh_kompaun,'mm'),2,0),lpad(to_char(tkh_kompaun,'dd'),2,0) "
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
    <td width="60%" align="center"><font size="3"><b>LAPORAN BILANGAN KOMPAUN MENGIKUT 
      TARIKH </b></font></td>
    <td width="20%" >&nbsp;</td>
  </tr>
</table>
<!--<table width="85%" align="center" border="0" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold">
  <tr> 
    <td width="14%" nowrap>
      <div align="right">Tarikh Dari :</div>
    </td>
    <td width="86%" ><%=tkhd%>&nbsp;Hingga&nbsp;<%=tkhh%></td>
  </tr>
</table>-->
<hr>
<%	end sub	
    sub badan		%>
<table border="1" width="50%" align="center" style="font-family: Trebuchet MS; font-size: 10pt;" cellpadding="1" cellspacing="0">
  <tr style="font-weight:bold;"> 
    <td align="center" width="4%">Bil</td>
    <td align="center" width="12%">Bilangan Kompaun</td>
    <td width="24%" align="center">Tkh Kompaun</td>
  </tr>
  <%	ctr = 0
  	ctrz = 0
	bil = 0

	Do while not sd.eof
	
	bil = bil + 1
	ctr = cdbl(ctr) + 1
    ctrz = cdbl(ctrz) + 1
	tkh_kompaun = cstr(sd("d"))+"/"+cstr(sd("m"))+"/"+cstr(sd("y"))	
	
   	if ctr = 40 then
   		ctr = 1  	
  %>
</table>
<%mula%>
<table width="50%" height="46" border="1" align="center" cellpadding="1" cellspacing="0" >
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;"> 
    <td width="3%">Bil</td>
    <td width="13%">Bilangan Kompaun</td>
    <td width="24%">Tkh Kompaun</td>
  </tr>
  <%	end if	%>
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt;"> 
    <td height="20" width="3%"><%=bil%></td>
    <td height="20" width="13%"><%=sd("bilangan")%></td>
    <td width="24%" align="center"><%=tkh_kompaun%></td>
  </tr>
  <%	sd.MoveNext
	Loop
%>
</table>
<%	end sub	%>

</body>
</html>

