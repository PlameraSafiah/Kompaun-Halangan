<% Response.Buffer = True %>
<!--#include file="focus.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<SCRIPT LANGUAGE="JavaScript">
nextfield = "bulan";
</script>

</head>

<BODY>
<%response.cookies("amenu") = "hg182.asp"%>
<!-- '#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg182.asp" >
  <% 	
  Set objConn = Server.CreateObject("ADODB.Connection")
  objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"
   
  proses = Request.Form("f1")
  proses1 = Request.Form("f2")
  tahun = Request.Form("tahun")
  bulan = Request.Form("bulan")
  
  	if proses1="Cetak" then 		
 	response.redirect"hg182c.asp?tahunr="&tahun&"&bulanr="&bulan&""
  	end if  		

  if bulan = "" then  
  	t = "  select to_char(sysdate,'yyyy') thn, to_char(sysdate,'mm') bln from dual"
	Set rtn = objConn.Execute(t)
	tahun = rtn("thn")
	bulan = rtn("bln") 	 
  end if
		
  if proses = "" then	  satu
  
  If proses = "Papar" and bulan <>"" and tahun <>"" Then
	satu
	papar
  end if

  sub satu %>
  
  <table align="center" width="67%" bgcolor="<%=color1%>" cellspacing="0" cellpadding="1"  border="0" bordercolor="black" style="font-family: Verdana; font-size: 10pt; color:yellow">
    <tr bgcolor="<%=color1%>"> 
      <td width="40%" align="right">Bulan</td>
      <td width="60%"> 
        <input name="bulan" type="text" id="bulan" onFocus="nextfield='tahun';" onKeyDown="if(event.keyCode==13) event.keyCode=9;" value="<%=bulan%>" size="4" maxlength="2">
      </td>
	</tr>    
	
	<tr bgcolor="<%=color1%>">
	  <td width="40%" align="right">Tahun</td>
      <td width="60%"> 
        <input name="tahun" type="text" id="tahun" onFocus="nextfield='f1';" onKeyDown="if(event.keyCode==13) event.keyCode=9;" value="<%=tahun%>" size="4" maxlength="4">
       	<input type="submit" value="Papar" name="f1" onFocus="nextfield='done';">
        <input type="submit" name="f2" value="Cetak">
      </td>
    </tr>
  </table><br>
  <script> 
  document.komp.bulan.focus() 
  </script>
  
  <% end sub
   sub papar
   
   if bulan = "" or tahun = ""  then
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Masukkan Bulan Dan Tarikh"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
		response.end	
   else
   
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
    <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold; color:yellow;" align="center"> 
      <td width="68" height="21">Bil</td>
      <td width="171">Tarikh Bayar</td>
      <td width="204">Bilangan Kompaun</td>
      <td width="311">Amaun Bayar</td>
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
    <tr bgcolor="<%=color1%>"  style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;  "> 
      <td align="right" colspan="2">Jumlah&nbsp;</td>
      <td align="center" width="204"><%=jkira%></td>
  	  <td align="right" width="311"><%=formatnumber(jamaun_bayar,2)%></td>
    </tr>
  </table>	 
	 <% 
	 end if
	 end if
	 end Sub %>
</form>
</body>
</html>