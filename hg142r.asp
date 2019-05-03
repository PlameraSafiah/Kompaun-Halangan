<html>
<head>
<title>Cetakan Laporan Ke Jab Undang²</title>
</head>
<body>
<%	Set objConn = Server.CreateObject("ADODB.Connection")
   	objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"

	tkhd = request.querystring("tkhd")		

	r = " select to_char(sysdate,'ddmmyyyy') tkh from dual "
	Set rr = objConn.Execute(r)
	tkhs = rr("tkh")	

	d = " select no_kompaun,no_akaun,upper(nama) nama, "
	d = d & " to_char(tkh_kompaun,'dd/mm/yyyy') as tkh_kompaun,akta,kesalahan "
	d = d & " from kompaun.halangan "
	d = d & " where tkh_undang = to_date('"&tkhd&"','dd/mm/yyyy') "
	d = d & " and status_kompaun = 'M' order by no_kompaun "
	Set rd = objConn.Execute(d)
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr style="font-family: Trebuchet MS; font-size: 12pt;"> 
    <td width="16%" ></td>
    <td width="69%" >
      <div align="center"><b> LAPORAN KESALAHAN KOMPAUN KE JABATAN UNDANG-UNDANG</b> 
      </div></td>
    <td width="15%" height="19" align="right"><%'=tkhs%></td>
  </tr></table>
<p></p>
<table border="0" width="758">
<tr style="font-family: Trebuchet MS; font-size: 10pt;">
<td width="750">Tarikh Notis :&nbsp;<%=tkhd%></td>
</tr></table><hr>
  
<table border="0" width="100%" align="center">
  <tr style="font-family: Trebuchet MS; font-size: 10pt;" align="center"> 
    <td width="3%">Bil</td>
    <td width="10%">No Kompaun</td>
    <td width="10%">No Akaun</td>
    <td width="33%">Nama</td>
    <td width="9%">Akta/UUK</td>
    <td width="33%">Kesalahan</td>
    <td width="12%">Tkh Kompaun</td>
  </tr>
  <% 	bil = 0	
    	Do while not rd.EOF
    	bil = bil + 1
		akta = rd("akta")
		kesalahan = rd("kesalahan")
		
		 j =     "select initcap(keterangan) terang from kompaun.butir_kesalahan "
        j = j & " where kod = '"&kesalahan&"' and akta = '"&akta&"' "
        Set Rsj = objConn.Execute(j)
        
        if not rsj.eof then
           ketersalah = Rsj("terang")
        end if	
  %>
  <tr style="font-family: Trebuchet MS; font-size: 10pt;" align="center"> 
    <td width="3%"><%=bil%></td>
    <td width="10%"><%=rd("no_kompaun")%></td>
    <td width="10%"><%=rd("no_akaun")%></td>
    <td width="33%" align="left"><%=rd("nama")%></td>
    <td width="9%"><%=rd("akta")%></td>
    <td width="33%" align="left"><%=rd("kesalahan")%>-<%=ketersalah%></td>
    <td width="12%"><%=rd("tkh_kompaun")%></td>
  </tr>
  <%	rd.MoveNext			
  		Loop
  %>
</table>  
</body>
</html>