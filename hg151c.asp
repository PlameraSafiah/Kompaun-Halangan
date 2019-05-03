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
	
		d = " select no_kompaun,upper(nama) nama,status_kompaun, "
	    d = d & " akta,kesalahan,to_char(tkh_kompaun,'yyyy')y, "
		d = d & " to_char(tkh_kompaun,'mm')m,to_char(tkh_kompaun,'dd')d from kompaun.halangan "
		d = d & " where tkh_kompaun between  to_date('"&tkhd&"','dd/mm/yyyy') and"
		d = d & " to_date('"&tkhh&"','dd/mm/yyyy')"
		d = d & " order by to_char(tkh_kompaun,'yyyy'), "
		d = d & " to_char(tkh_kompaun,'mm'),to_char(tkh_kompaun,'dd') "
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
      TARIKH </b></font></td>
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
<table border="0" width="98%" align="center" style="font-family: Trebuchet MS; font-size: 10pt;">
  <tr style="font-weight:bold;"> 
    <td align="center" width="4%">Bil</td>
    <td align="center" width="12%">No Kompaun</td>
    <td width="24%" align="center">Nama</td>
    <td width="12%" align="center"> 
      <div align="left">Akta</div>
    </td>
    <td width="23%" align="center"> 
      <div align="left">Kesalahan</div>
    </td>
    <td align="center" width="12%">Tkh Kompaun</td>
    <td align="center" width="13%">Status</td>
  </tr>
  <%	ctr = 0
  	ctrz = 0
	bil = 0

	Do while not sd.eof
	
	bil = bil + 1
	ctr = cdbl(ctr) + 1
    ctrz = cdbl(ctrz) + 1
	tkh_kompaun = cstr(sd("d"))+"/"+cstr(sd("m"))+"/"+cstr(sd("y"))
	stat = sd("status_kompaun")
	if stat = "I" then status = "Belum Bayar" 
	if stat = "P" then status = "Bayar"
	if stat = "B" then status = "Batal"
	if stat = "M" then status = "Mahkamah"
	if stat = "F" then status = "Notis Pertama"
	if stat = "S" then status = "Notis Kedua"
	if stat = "T" then status = "Notis Ketiga"
	
			sq = " select kod, initcap(keterangan) keterangan from kompaun.perkara "
        sq = sq & " where kod = '"& sd("akta") &"' "
		sq = sq & " and kod <> 'P01' order by kod "
        Set sq = objConn.Execute(sq)
		
		if not sq.eof then
			aktaketer = sq("keterangan")
		end if
		
		
		
	m = " select initcap(keterangan||' '||keterangan2) keterangan from kompaun.jenis_kesalahan "
    m = m & " where kod = '"& sd("kesalahan") &"'  "
    m = m & " and perkara = '"& sd("akta") &"' "
  	Set sm = objConn.Execute(m)		
	
	if not sm.eof then
		salahketer = sm("keterangan")
	end if
	
   	if ctr = 40 then
   		ctr = 1  	
  %>
</table>
<%mula%>
<table width="98%" height="46" border="0" align="center" >
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;"> 
    <td width="3%">Bil</td>
    <td width="13%">No Kompaun</td>
    <td width="24%">Nama</td>
    <td width="13%" align="left">Akta</td>
    <td width="23%" align="left">Kesalahan</td>
    <td width="12%">Tkh Kompaun</td>
    <td width="12%">Status</td>
  </tr>
  <%	end if	%>
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt;"> 
    <td height="20" width="3%"><%=bil%></td>
    <td height="20" width="13%"><%=sd("no_kompaun")%></td>
    <td width="24%" align="left"><%=sd("nama")%></td>
    <td width="13%" align="left"><%=sd("akta")%>-<%=aktaketer%></td>
    <td width="23%" align="left"><%=sd("kesalahan")%>-<%=salahketer%></td>
    <td height="20" width="12%"><%=tkh_kompaun%></td>
    <td height="20" width="12%"><%=status%></td>
  </tr>
  <%	sd.MoveNext
	Loop
%>
</table>
<%	end sub	%>

</body>
</html>

