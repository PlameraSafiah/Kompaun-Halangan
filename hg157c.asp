<html>
<head>
<title>Cetakan Kompaun Mengikut Pegawai</title>
</head>
<body onload='self.print()' topmargin="0" leftmargin="0">
<%	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"

    tkhd = Request.querystring("tkhd")
    tkhh = Request.querystring("tkhh")
	nopek = request.querystring("nopek")
	
	f="select to_char(sysdate,'dd-mm-yyyy  hh24:mi:ss') as tkhs from dual "
   	Set objRs1a = objConn.Execute(f)	
   	tkhs = objrs1a("tkhs")
      	
	s = " select nama from majlis.syarikat "     	
	Set objRss = objConn.Execute(s)
	namas = objRss("nama")
	
	n = " select initcap(nama) nama from payroll.paymas where no_pekerja = '"&nopek&"' "
	n = n & " union "
	n = n & " select initcap(nama) nama from payroll.paymas_sambilan where no_pekerja = '"&nopek&"' "
	Set objRsn = objConn.Execute(n)
	
	if not objRsn.eof then
		napek = objRsn("nama")
	else
		napek = ""
	end if
	
		d = " select no_akaun,no_kompaun,upper(nama) nama,akta,kesalahan,"
	    d = d & " to_char(tkh_kompaun,'dd/mm/yyyy')tkh_kompaun,nvl(amaun,0)amaun, "
		d = d & " status_kompaun status from kompaun.halangan "
		d = d & " where tkh_kompaun between  to_date('"&tkhd&"','dd/mm/yyyy') and"
		d = d & " to_date('"&tkhh&"','dd/mm/yyyy') "
		d = d & " and lpad(pengeluar_kompaun,5,0) = '"& nopek &"' order by no_akaun"
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
    <td width="60%" align="center"><font size="3"><b>LAPORAN KOMPAUN MENGIKUT 
      PEGAWAI </b></font></td>
    <td width="20%" >&nbsp;</td>
  </tr>
</table>
<table width="100%" align="center" border="0" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold">
  <tr> 
    <td width="14%" nowrap>
      <div align="right">No Pekerja :</div>
    </td>
    <td width="86%" ><%=nopek%>-<%=napek%>&nbsp;&nbsp;&nbsp;Tarikh Dari&nbsp;:&nbsp;<%=tkhd%>&nbsp;Hingga&nbsp;<%=tkhh%></td>
  </tr>
</table>
<hr>
<%	end sub	
    sub badan		%>
<table border="0" width="100%" align="center" style="font-family: Trebuchet MS; font-size: 10pt;">
  <tr style="font-weight:bold;"> 
    <td align="center" width="3%">Bil</td>
    <td align="center" width="11%">No Kompaun</td>
    <td align="center" width="11%">No Akaun</td>
    <td width="20%" align="center">Nama</td>
    <td align="center" width="34%">Kesalahan</td>
    <td align="center" width="10%">Tkh Kompaun</td>
    <td align="center" width="9%">Amaun</td>
    <td align="center" width="13%">Status Kompaun</td>
  </tr>
  <%	ctr = 0
  	ctrz = 0
	bil = 0

	Do while not sd.eof	
	bil = bil + 1
	ctr = cdbl(ctr) + 1
	kompaun = sd("no_kompaun")
    ctrz = cdbl(ctrz) + 1
		status = sd("status")
		if status = "I" then
			keter = "Belum Bayar"
		elseif status = "P" then
			keter = "Bayar"
		elseif status = "B" then
			keter = "Batal"
		elseif status = "M" then
			keter = "Mahkamah"
		elseif status = "N" then
			keter = "Notis"
		end if
		
	m = " select initcap(keterangan||' '||keterangan2) keterangan from kompaun.butir_kesalahan "
    m = m & " where kod = '"& sd("kesalahan") &"'  "
    m = m & " and akta = '"& sd("akta") &"' "
  	Set sm = objConn.Execute(m)		
	
	if not sm.eof then
		salahketer = sm("keterangan")
	end if
		
    	if ctr = 40 then
    		ctr = 1  	  %>
</table>
<%mula%>
<table width="100%" height="46" border="0" align="center" >
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;"> 
    <td width="3%">Bil</td>
    <td width="11%">No Kompaun</td>
    <td width="11%">No Akaun</td>
    <td width="20%">Nama</td>
    <td width="34%">Kesalahan</td>
    <td width="10%">Tkh Kompaun</td>
    <td width="9%">Amaun</td>
    <td width="13%">Status Kompaun</td>
  </tr>
  <%	end if	%>
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt;"> 
    <td height="20" width="3%" valign="top"><%=bil%></td>
    <td height="20" width="11%" valign="top"><%=sd("no_kompaun")%></td>
    <td height="20" width="11%" valign="top"><%=sd("no_akaun")%></td>
    <td width="20%" align="left" valign="top"><%=sd("nama")%></td>
    <td height="20" width="34%" valign="top"> 
      <div align=justify><%=sd("kesalahan")%>-<%=salahketer%></div>
    </td>
    <td height="20" width="10%" valign="top"><%=sd("tkh_kompaun")%></td>
    <td height="20" valign="top" width="9%"><%=formatnumber(sd("amaun"),2)%></td>
    <td height="20" width="13%" valign="top" align="left"><%=keter%></td>
  </tr>
  <%	sd.MoveNext
	Loop
%>
</table>
<%	end sub	%>

</body>
</html>

