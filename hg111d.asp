<html>
<head>
<title>Cetakan Kompaun</title>
</head>
<body>

<form action="hg111d.asp" method="POST">
<% Set objConn = Server.CreateObject("ADODB.Connection")
   objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"

   akaun = request.querystring("no")
   kompaun = request.querystring("ko")
    	
	s = " 		select rowid,no_akaun,no_kompaun,initcap(nama)nama, "
	s = s & " upper(no_kenderaan)no_kenderaan,akta,kesalahan,"
	s = s & " to_char(tkh_kompaun,'dd/mm/yyyy') tkh_kompaun,to_char(masa) masa,initcap(tempat)tempat, "
	s = s & " initcap(tempat1)tempat1,pengeluar_kompaun,daerah,"
	s = s & " to_char(tkh_bayar,'dd/mm/yyyy')tkh_bayar,no_kontena "
	s = s & " from kompaun.halangan "
	's = s & " where no_akaun = '"&akaun&"' and no_kompaun = '"&kompaun&"' "
	s = s & " where no_kompaun = '"&kompaun&"' "
	Set gq = objConn.Execute(s)

	if not gq.eof then
		rowid = gq("rowid")
		akaun = gq("no_akaun")
		kompaun = gq("no_kompaun")
		nama = gq("nama")
		kenderaan = gq("no_kenderaan")
		akta = gq("akta")
		salah = gq("kesalahan")
		tkh_kompaun = gq("tkh_kompaun")		
		waktu = gq("masa")
		tempat = gq("tempat")
		tempat1 = gq("tempat1")
		no_pekerja = gq("pengeluar_kompaun")
				
  		k1 = " select initcap(keterangan) aketer from kompaun.perkara where kod = '"&akta&"' "
  		Set objk1 = objConn.Execute(k1)
  		if not objk1.eof then
	  		aketer = objk1("aketer")
  		 end if	  				
  
  		k2 = "		  select initcap(keterangan) sketer,initcap(keterangan2) sketer2 "
		k2 = k2 & " from kompaun.butir_kesalahan "
  		k2 = k2 & " where akta = '"&akta&"' and kod = '"&salah&"' "
  		Set objk2 = objConn.Execute(k2)
 			if not objk2.eof then
				sketer = objk2("sketer")
				sketer2 = objk2("sketer2")
  			end if	  			
		end if  	
			n = " select initcap(nama)nama from payroll.paymas where no_pekerja = '"&no_pekerja&"' "
   		Set objRsn = objConn.Execute(n)
    		
   		if not objRsn.eof then
    			napek = objRsn("nama")
   		end if
		
		if waktu <> "" then
   				if waktu = 24 then
   					waktu1 = 12
   					ampm = "AM"
   				elseif waktu >=  13 then
   					waktu1 = waktu - 12
   					ampm = "PM"
   			
   				elseif waktu < 13.00 or waktu = 12 then
   					waktu1 = waktu
   					ampm = "AM"	
   				end if
   			end if
%>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="98%">
<tr>
  <td align="center" width="10%" valign="top" rowspan="3" ><img border="0" height="50" src="logompsp.jpg"></td>
  <td valign="top">
      <strong><font size="3" face="Verdana">MAJLIS PERBANDARAN SEBERANG PERAI<br>
      BAHAGIAN PENGUATKUASA<br>NOTIS KESALAHAN SERTA TAWARAN KOMPAUN
      </font></strong></td>
  <td rowspan="3" width="10%"></td>
</tr>

<tr>
  <td colspan=3>&nbsp;</td>
</tr>
</table>

  <table align="center" border="0" cellpadding="0" cellspacing="0" width="98%">
    <tr> 
      <td width="20%"><font face="Verdana" size="2"><b>No Akaun</b></font></td>
      <td width="2%"><font face="Verdana" size="2"><b>&nbsp;:</b></font></td>
      <td ><font face="Verdana" size="2"><b><%=akaun%></b></font></td>
    </tr>
    <tr> 
      <td ><font face="Verdana" size="2"><b>No Kompaun</b></font></td>
      <td ><font face="Verdana" size="2"><b>&nbsp;:</b></font></td>
      <td ><font face="Verdana" size="2"><b><%=kompaun%></b></font></td>
    </tr>
    <tr> 
      <td ><font face="Verdana" size="2"><b>Nama</b></font></td>
      <td ><font face="Verdana" size="2"><b>&nbsp;:</b></font></td>
      <td ><font face="Verdana" size="2"><b><%=nama%></b></font></td>
    </tr>
    <tr>
      <td ><font face="Verdana" size="2"><b>No Kenderaan</b></font></td>
      <td >
        <div align="center"><font face="Verdana" size="2"><b>:</b></font></div>
      </td>
      <td ><font face="Verdana" size="2"><b><%=kenderaan%></b></font></td>
    </tr>
    <tr> 
      <td ><font face="Verdana" size="2"><b>Tarikh</b></font></td>
      <td ><font face="Verdana" size="2"><b>&nbsp;:</b></font></td>
      <td ><font face="Verdana" size="2"><b><%=tkh_kompaun%></b></font></td>
    </tr>
    <tr> 
      <td valign="top"><font face="Verdana" size="2"><b>Tempat</b></font></td>
      <td valign="top"><font face="Verdana" size="2"><b>&nbsp;:</b></font></td>
      <td ><font face="Verdana" size="2"><b> <%=tempat%> 
        <%if tempat1 <> "" then%>
        <br>
        <%=tempat1%> 
        <%end if%>
        </b></font></td>
    </tr>
    <tr> 
      <td ><font face="Verdana" size="2"><b>&nbsp;Masa</b></font></td>
      <td ><font face="Verdana" size="2"><b>&nbsp;:</b></font></td>
      <td ><font face="Verdana" size="2"><b><%=waktu%>&nbsp;<%=ampm%></b></font></td>
    </tr>
    <tr> 
      <td ><font face="Verdana" size="2"><b>&nbsp;Kesalahan</b></font></td>
      <td ><font face="Verdana" size="2"><b>&nbsp;:</b></font></td>
      <td ><font face="Verdana" size="2"><b><%=salah%></b></font></td>
    </tr>
    <tr> 
      <td ><font face="Verdana" size="2"><b>&nbsp;</b></font></td>
      <td ><font face="Verdana" size="2"><b>&nbsp;</b></font></td>
      <td ><font face="Verdana" size="2"><b><%=sketer%> 
        <%if sketer2 <> "" then%>
        <br>
        <%=sketer2%> 
        <%end if%>
        </b></font></td>
    </tr>
    <tr> 
      <td ><font face="Verdana" size="2"><b>&nbsp;Pegawai Yang<br>
        &nbsp;Mengeluarkan Notis</b></font></td>
      <td ><font face="Verdana" size="2"><b>&nbsp;:</b></font></td>
      <td ><font face="Verdana" size="2"><b><%=no_pekerja%>&nbsp;&nbsp;<%=napek%></b></font></td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
  </table>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="98%">
<tr>
  <td align="center" valign="top" colspan="3">
      <font size="2" face="Verdana">Untuk Kegunaan Jabatan Perbendaharaan</font></td>
</tr>

<tr><td colspan="3">&nbsp;</td></tr>

<tr>
  <td width="10%" align="center" valign="top" height="70">
      <strong><font size="3" face="Verdana"><b>45</b></font></strong></td>
      <td valign="top"><font size="2" face="Verdana"><b>No Akaun&nbsp;&nbsp;&nbsp;:&nbsp;<%=akaun%><br>
        No Kompaun&nbsp;:&nbsp;<%=kompaun%> </b></font></td>
  <td width="10%"></td>
</tr>

</table>
</form>
