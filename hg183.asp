<% Response.Buffer = True %>
<!--#include file="focus.inc"-->
<!--#include file="tarikh.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan </title>

<script language="javascript">
	
	function invalid_tiada(d)
	{
		alert(d+" Tiada Rekod ");
		return(true);
	}
</script>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">        
        <LINK REL=StyleSheet HREF="calendar.css" TYPE="text/css">
		<SCRIPT LANGUAGE="JavaScript" SRC="weeklycalendar.js">
		</SCRIPT>
		<script language="javascript">
				buildWeeklyCalendar(0);
		</script>


<SCRIPT LANGUAGE="JavaScript">
nextfield = "d_tarikh";
</script>
<style type="text/css">
<!--
.style6 {font-size: 10pt}
.style8 {color: #FF0000; font-family: "Trebuchet MS"; }
-->
</style>
<BODY>

<!-- '#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg183.asp" >
<%	response.cookies("amenu") = "hg183.asp" 

  proses = Request.Form("f1")
  proses1 = Request.Form("f2")
  proses2   = request.form("breset")
  d_tarikh = Request.Form("d_tarikh")
  h_tarikh = Request.Form("h_tarikh")  		


   '************ proses reset *****************
	if proses2 = "Reset" then
	d_tarikh = ""
	h_tarikh = ""
	 end if
		
  if proses1="Cetak" then 		
  response.redirect"hg183c.asp?d_tarikhr="&d_tarikh&"&h_tarikhr="&h_tarikh&""
  end if
  
  if proses = "" then	
  satu
  end if
  
  If proses = "Papar" Then
	satu
	papar
  end if

  sub satu %>
  <table bgcolor="<%=color1%>" width="85%" align="center" cellpadding="0" cellspacing="1" border="0" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
    <tr>  
      <td align="right" width="34%">Tarikh  Dari&nbsp; </td>
      <td width="66%">:
        <input name="d_tarikh" type="text" id="d_tarikh4" onFocus="nextfield='h_tarikh';" onKeyDown="if(event.keyCode==13) event.keyCode=9;" value="<%=d_tarikh%>" size="10" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
      <input name="button" type="button" onClick="w_displayCalendar('d_tarikh','h_tarikh');" value="..."></td>
    </tr>
    <tr>
      <td  align="right" height="24">Tarikh Hingga&nbsp;</td>
      <td height="24">: <input name="h_tarikh" type="text" id="h_tarikh2" onFocus="nextfield='f1';" onKeyDown="if(event.keyCode==13) event.keyCode=9;" value="<%=h_tarikh%>" size="10" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
        <input type="submit" value="Papar" name="f1" onFocus="nextfield='done';">
      <input type="submit" name="f2" value="Cetak">
      <input name="breset" type="submit" id="breset" value="Reset"></td>
    </tr>
</table>

<%
end sub
   sub papar
   
   if d_tarikh = "" or h_tarikh = ""  then
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Masukkan Tarikh Mingguan"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
		response.end	
   else
		r = " select nvl(count(*),0) kira,nvl(sum(amaun_bayar),0) amaun_bayar, "
		r = r & " to_char(tkh_kompaun,'dd/mm/yyyy')tkh_kompaun,initcap(tempat)tempat "
		r = r & " from kompaun.halangan where tkh_kompaun between  to_date('"&d_tarikh&"','dd/mm/yyyy')"
		r = r & " and to_date('"&h_tarikh&"','dd/mm/yyyy') group by tkh_kompaun,tempat"
		Set rsr = objConn.Execute(r)	

	    if rsr.eof then
		response.write "<br><br><br><br><br>"
		response.write "<p align=center><b><font size=6 color=#AA0000>Tiada Maklumat</font></b></p>"
		response.end		
	    
		else    %>
<br>
<table width="85%" cellspacing="1" align="center">
      <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold; color:yellow;" align="center">
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
	  <td colspan="4" align="right">&nbsp;Jumlah Keseluruhan&nbsp; </td>
	  <td align="right"><%=formatnumber(total_amaun,2)%>&nbsp;</td>
    </tr>
  </table>	
  <%
	 end if
	 end if
	 end Sub %>
  

</form>
</body>
</html>