<html>
<head>
<title>Cetakan Laporan Pendapatan</title>
<STYLE TYPE="text/css">
#tengah {
width: 6cm;
}
</STYLE>
</head>
<body onload='self.print()' topmargin="0" leftmargin="0">
<%	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"

    tahund = Request.querystring("tahund")
    tahunh = Request.querystring("tahunh")
	
	if tahund <> tahunh then ayat = "TAHUN " + cstr(tahund) + " HINGGA " + cstr(tahunh)
	if tahund = tahunh then ayat = "TAHUN :" + cstr(tahund)

	s = " select nama,to_char(sysdate,'dd-mm-yyyy  hh24:mi:ss') as tkhs  from majlis.syarikat "     	
	Set objRss = objConn.Execute(s)
	namas = objRss("nama")
	tkhs = objRss("tkhs")

%>
<table width="100%" border="0" >
  <tr style="font-family: Trebuchet MS; font-size: 8pt;"> 
    <td colspan="3"><i><%=tkhs%></i></td>
  </tr>
<tr style="font-family: Trebuchet MS; font-size: 12pt; font-weight:bold;"> 
    <td colspan="3" align="center" ><%=namas%>
    </td></tr>
<tr>
  <td >&nbsp;</td>
    <td align="center"><font size="3"><b>LAPORAN PENDAPATAN HASIL - KOMPAUN HALANGAN</b></font></td>
  <td >&nbsp;</td>
</tr>
<tr> 
    <td width="20%" >&nbsp;</td>
    <td width="60%" align="center"><font size="3"><b><%=ayat%></b></font></td>
    <td width="20%" >&nbsp;</td>
  </tr>
</table>
<br>
<%	satu
	sub satu %> 
  <table width="86%" cellspacing="1" align="center">
  <tr>  
    <td valign="top" width="40%"><table width="100%" border="1" cellspacing="0" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;">
      <tr>
        <td bgcolor="#DDDDDD" align="center">PERKARA</td>
      </tr>
      <tr height="30">
        <td nowrap>Bil Kompaun Telah Dibayar <br>
          &nbsp;</td>
      </tr>
      <tr height="30">
        <td>Bil Kompaun Tertunggak <br>
          &nbsp;</td>
      </tr>
      <tr height="30">
        <td>Jumlah Kompaun</td>
      </tr>
      <tr height="30">
        <td>Jumalah Amaun Bayaran (RM)</td>
      </tr>
<br>
    </table></td>
	<%	end sub 
	
	total_bayar = 0
	total_tunggak = 0
	total_kompaun = 0
	total_amaunbayar = 0
	percentbyr = 0
	percenttunggak = 0
	kira = 0
	
	for i = tahund to tahunh 
	kira = kira + 1
	jkompaun = 0
	jbayar = 0
	jtunggak = 0 
	pbayar = 0
	ptunggak = 0	
	 
	 '******** jumlah semua kompaun *********
	k = " select count(*) jkompaun from kompaun.halangan "
	k = k & " where to_char(tkh_kompaun,'yyyy')='"&i&"' "
	set kj = objconn.execute(k)
	
	if not kj.eof then jkompaun = cint(kj("jkompaun"))
	
	'********** jumlah kompaun yg telah bayar & amaun ************
	t = " select count(*) jbayar,nvl(sum(amaun_bayar),0)amaun_bayar from kompaun.halangan "
	t = t & " where to_char(tkh_kompaun,'yyyy')='"&i&"'  and amaun_bayar is not null "
	set kt = objconn.execute(t)
	
	if not kt.eof then 
	jbayar = cint(kt("jbayar"))
	amaun_bayar = cdbl(kt("amaun_bayar"))
	end if
	
	'******* pengiraan kompaun yg tertunggak *********
	jtunggak = cint(jkompaun) - cint(jbayar)
	
	total_bayar = cint(total_bayar) + cint(jbayar)
	total_tunggak = cint(total_tunggak) + cint(jtunggak)
	total_kompaun = cint(total_kompaun) + cint(jkompaun) 	
	total_amaunbayar = cdbl(total_amaunbayar) + cdbl(amaun_bayar) 	
	
	percentbyr = round((total_bayar/total_kompaun) * 100,2)
	percenttunggak = round((total_tunggak/total_kompaun) * 100,2)
	
	if jbayar > 0 then  pbayar = round((jbayar/jkompaun) * 100,2)	
	if jtunggak > 0 then ptunggak = round((jtunggak/jkompaun) * 100,2)	
		
		'**************** sometimes bila bundarkan can b more then 100% ***********'		
		peratus = (pbayar + ptunggak) 
		
		g = " select ('"&peratus&"' - 100) peratus from dual "
		set rg = objconn.execute(g)		
		if not rg.eof then 	peratus = cdbl(rg("peratus"))

		if peratus > 0 then peratusx = ptunggak - peratus
		'*************** end of count **********************************************'	
	%>
    <td width="20%" valign="top"><table width="100%" border="1" align="center" cellspacing="0" style="font-family: Trebuchet MS; font-size: 10pt; ">
	  <tr  align="center" style="font-weight:bold;">
		<a href="hg1811c.asp?i=<%=i%>">
 	 <td bgcolor="#DDDDDD"  nowrap onMouseOver="this.style.backgroundColor='666666'" onMouseOut="this.style.backgroundColor='#DDDDDD' ">&nbsp;<%=i%></td></a>
      </tr>
      <tr align="center" height="30">
        <td><%=jbayar%><br><%=pbayar%>%</td>
      </tr>
      <tr align="center" height="30">
        <td><%=jtunggak%><br><%=ptunggak%>%</td>
      </tr>
      <tr align="center" style="font-weight:bold;" height="30">
        <td><%=jkompaun%></td>
      </tr>
      <tr align="center" style="font-weight:bold;" height="30">
        <td ><%if cdbl(kt("amaun_bayar")) > 0 then%><%=formatnumber(kt("amaun_bayar"),2)%><%else%>&nbsp;<%end if%>
      </tr>
<br>
    </table></td>
	<%	pkira = kira mod 3
		if pkira = 0 then satu
		next %>
	
    <td width="20%" valign="top"><table width="100%" border="1" align="center" cellspacing="0" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;">
      <tr  align="center">
        <td bgcolor="#DDDDDD">JUMLAH</td>
      </tr>
      <tr align="center" height="30">
        <td><%=total_bayar%><br>&nbsp;<%=percentbyr%>%</td>
      </tr>
      <tr align="center" height="30">
        <td><%=total_tunggak%><br>&nbsp;<%=percenttunggak%>%</td>
      </tr>
      <tr align="center" height="30">
        <td><%=total_kompaun%></td>
      </tr>
      <tr align="center" height="30">
        <td><%if total_amaunbayar > 0 then%><%=formatnumber(total_amaunbayar,2)%><%else%>&nbsp;<%end if%>
      </tr>
<br>
    </table></td>
	<%	tambah = 2 - cint(pkira)	
	for k = 1 to tambah  %>
</td>
   <td width="20%" valign="top">&nbsp;
</td>
<%	next	%>
  </tr>
</table>
</form>
</body>
</html>