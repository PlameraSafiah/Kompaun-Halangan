<html>
<head>
<title>Cetakan Kompaun Belum DiBayar</title>
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
	
		d = " select no_kompaun,no_akaun,nama,to_char(tkh_kompaun,'dd/mm/yyyy')tkh_kompaun, "
		d = d & " to_char(tkh_bayar,'dd/mm/yyyy')tkh_bayar,akta,kesalahan,"
		d = d & " nvl(amaun_bayar,0)amaun_bayar from kompaun.halangan "
		d = d & " where tkh_kompaun between to_date('"& tkhd &"', 'dd/mm/yyyy') "
		d = d & " and to_date('"& tkhh &"' , 'dd/mm/yyyy') "
		d = d & " and amaun_bayar is null and status_kompaun not in ('P','B') "
		d = d & " and tkh_undang is null order by no_kompaun "
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
    <td width="60%" align="center"><font size="3"><b>LAPORAN KOMPAUN BELUM BAYAR</b></font></td>
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
<table border="0" width="100%" align="center" style="font-family: Trebuchet MS; font-size: 10pt;">
  <tr style="font-weight:bold;"> 
    <td align="center" width="3%">Bil</td>
    <td align="center" width="14%">No Kompaun</td>
    <td align="center" width="14%">No Akaun</td>
    <td width="35%" align="center">Nama</td>
    <td align="center" width="34%">Kesalahan</td>
    <td align="center" width="14%">Tkh Kompaun</td>
  </tr>
  <%	ctr = 0
  	ctrz = 0
	bil = 0

	Do while not sd.eof	
	bil = bil + 1
	ctr = cdbl(ctr) + 1
	kompaun = sd("no_kompaun")
    ctrz = cdbl(ctrz) + 1
		
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
    <td width="14%">No Kompaun</td>
    <td width="14%">No Akaun</td>
    <td width="35%">Nama</td>
    <td width="34%">Kesalahan</td>
    <td width="14%">Tkh Kompaun</td>
  </tr>
  <%	end if	%>
  <tr align="center" style="font-family: Trebuchet MS; font-size: 10pt;"> 
    <td height="20" width="3%" valign="top"><%=bil%></td>
    <td height="20" width="14%" valign="top"><%=sd("no_kompaun")%></td>
    <td height="20" width="14%" valign="top"><%=sd("no_akaun")%></td>
    <td width="35%" align="left" valign="top"><%=sd("nama")%></td>
    <td height="20" width="34%" valign="top">
<div align=justify><%=salahketer%></div></td>
    <td height="20" width="14%" valign="top"><%=sd("tkh_kompaun")%></td>
  </tr>
  <%	sd.MoveNext
	Loop
%>
</table>
<%	end sub	%>

</body>
</html>

