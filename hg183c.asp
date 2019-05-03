<html>
<head>
<title>Sistem Kompaun Halangan</title>
</head>
<body onload='self.print()' topmargin="0" leftmargin="0">
<%	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"

    d_tarikh = Request.querystring("d_tarikhr")
	h_tarikh = Request.querystring("h_tarikhr")
	
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
    <td width="20%" >&nbsp;</td>
    <td width="60%" align="center"><font size="3"><b>LAPORAN PENDAPATAN HASIL MINGGUAN -KOMPAUN HALANGAN </b></font></td>
    <td width="20%" >&nbsp;</td>
  </tr>
    <tr>
      <td >&nbsp;</td>
      <td align="center"><font size="3"><b>TARIKH DARI :&nbsp; <%=d_tarikh%>&nbsp;&nbsp;HINGGA&nbsp;&nbsp;<%=h_tarikh%></b></font></td>
      <td >&nbsp;</td>
    </tr>
</table>
<%
	end sub

		r = " select nvl(count(*),0) kira,nvl(sum(amaun_bayar),0) amaun_bayar, "
		r = r & " to_char(tkh_kompaun,'dd/mm/yyyy')tkh_kompaun,tempat "
		r = r & " from kompaun.halangan where tkh_kompaun between  to_date('"&d_tarikh&"','dd/mm/yyyy')"
		r = r & " and to_date('"&h_tarikh&"','dd/mm/yyyy') group by tkh_kompaun,tempat "
		Set rsr = objConn.Execute(r)	

	    if rsr.eof then
		response.write "<br><br><br><br><br>"
		response.write "<p align=center><b><font size=6 color=#AA0000>Tiada Maklumat</font></b></p>"
		response.end		
	    
		else   		
%>
<br>
<table width="85%" cellspacing="0" border="1" align="center">
      <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;" align="center">
        <td width="5%" height="21">Bil</td>
        <td width="16%">Tarikh</td>
        <td width="15%">Bil Kompaun </td>
        <td width="49%">Tempat</td>
        <td width="15%">Amaun Bayar</td>
      </tr>
	<%
	     bil = 0
		 Do While Not rsr.eof
			bil     = cint(bil) + 1
			kira = rsr("kira")
	    	amaun_bayar = rsr("amaun_bayar")
	    	tkh_kompaun = rsr("tkh_kompaun")
	    	tempat = rsr("tempat")
		 	jamaun= cdbl(rsr("amaun_bayar"))

		 total_amaun = jamaun + total_amaun	
		'end if
	%>
      
	<tr bgcolor="<%=color2%>" style="font-family: Trebuchet MS; font-size: 10pt;  ">
        <td align="center"><%=bil%></td>
        <td align="center"><%=tkh_kompaun%></td>
        <td align="center"><%=kira%></td>
        <td>&nbsp;<%=tempat%></td>
        <td align="right"><%if cdbl(rsr("amaun_bayar")) > 0 then%><%=formatnumber(rsr("amaun_bayar"),2)%><%else%>&nbsp;<%end if%>&nbsp;</td>
    <% rsr.movenext
	  loop%>
  </tr>
	<tr bgcolor="<%=color2%>" style="font-family: Trebuchet MS; font-size: 10pt;font-weight:bold;  ">
	  <td height="23" colspan="4" align="right">&nbsp;Jumlah Keseluruhan&nbsp; </td>
	  <td align="right"><%=formatnumber(total_amaun,2)%>&nbsp;</td>
    </tr>
</table>	
  <%
  end if
 ' End Sub
  %>

</form>
</body>
</html>