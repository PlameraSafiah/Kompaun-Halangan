<html>
<head>
<title>Sistem Kompaun Halangan</title>
</head>
<body onload='self.print()' topmargin="0" leftmargin="0">
<%	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"
   
    tahun = Request.querystring("tahunr")
    bulan = Request.querystring("bulanr")
      	
	s = " select nama,to_char(sysdate,'dd-mm-yyyy  hh24:mi:ss') as tkhs from majlis.syarikat "     	
	Set objRss = objConn.Execute(s)
	namas = objRss("nama")
	tkhs = objRss("tkhs")
     
    muka = 0 
	mula
	sub mula	
	muka = cdbl(muka) + 1			

   %>
<table width="100%" border="0" >
  <tr style="font-family: Trebuchet MS; font-size: 8pt;"> 
    <td width="20%" align="left" ><i><%=tkhs%></i></td>
    <td width="60%"></td>
    <td width="20%" align="right" >Mukasurat&nbsp;<%=muka%></td>
  </tr>
<tr style="font-family: Trebuchet MS; font-size: 12pt; font-weight:bold;"> 
    <td colspan="3" align="center" ><%=namas%>
    </td></tr><tr> 
    <td width="20%" height="48" >&nbsp;</td>
    <td width="60%" align="center"><font size="3"><b>LAPORAN PENDAPATAN HASIL-KOMPAUN HALANGAN<br>BULAN <%=bulan%>
	 TAHUN <%=tahun%> </b></font></td>
    <td width="20%" >&nbsp;</td>
  </tr>
</table>
<br>  
  <% end sub   
   
   	 x = " select to_char(tkh_bayar,'dd/mm/yyyy') tkh_bayar,nvl(count(*),0) kira,"
	 x = x & " sum(nvl(amaun_bayar,0))amaun_bayar"   	
   	 x = x & " from kompaun.halangan"	
	 x = x & " where to_char(tkh_bayar,'mmyyyy') = '"&bulan&"' || '"&tahun&"' "
   	 x = x & " group by to_char(tkh_bayar,'dd/mm/yyyy') "
     Set rsx = objConn.Execute(x) 
	 
	    if rsx.eof then
		response.write "<br><br><br><br><br>"
		response.write "<p align=center><b><font size=6 color=#AA0000>Tiada Maklumat</font></b></p>"
		response.end		
	    
		else    
     %>
  <table width="68%" cellspacing="1" align="center">
    <tr align="center" bgcolor="#dddddd" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;"> 
      <td>Bil</td>
      <td>Tarikh Bayar</td>
      <td>Bilangan Kompaun</td>
      <td>Amaun Bayar</td>
    </tr>
    <%	
	  bil=0
	  jkira=0
	  jamaun_bayar=0
	  jumlah=0
	  do while not rsx.eof
	 	tkh_bayar=rsx("tkh_bayar")
		kira=rsx("kira")
		amaun_bayar=rsx("amaun_bayar")
		bil=bil+1
		jkira=cdbl(jkira)+cdbl(kira)
		jamaun_bayar=cdbl(jamaun_bayar)+cdbl(amaun_bayar)	 %>
    <tr bgcolor="<%=color2%>" style="font-family: Trebuchet MS; font-size: 10pt;  "> 
      <td align="center" width="68"><%=bil%></td>
      <td align="center" width="171"><%=tkh_bayar%></td>
      <td align="center" width="204"><%=kira%></td>
	  <td align="right" width="311"><%=formatnumber(amaun_bayar,2)%></td>
    </tr>
    <% rsx.movenext
        loop %>
    <tr bgcolor="#dddddd"  style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;  "> 
      <td align="right" colspan="2">Jumlah&nbsp;</td>
      <td align="center" width="204"><%=jkira%></td>
  	  <td align="right" width="311"><%=formatnumber(jamaun_bayar,2)%></td>
    </tr>
  </table>	 
	 <% 
  end if %>
</form>
</body>
</html>