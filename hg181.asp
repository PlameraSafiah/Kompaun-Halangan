<% Response.Buffer = True %>
<!--#include file="focus.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<SCRIPT LANGUAGE="JavaScript">
nextfield = "tkhdari";
</script>
<style type="text/css">
<!--
.style1 {color: #FFFF00}
-->
</style>
</head>
<body>
<!-- '#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg181.asp" >
<%	response.cookies("amenu") = "hg181.asp" 

	proses = Request.form("b")
	proses2   = request.form("breset")
	p2 = request.form("b2")
	tahund = request.form("tahund")
	tahunh = request.form("tahunh")
	thnsms = year(date)

   '************ proses reset *****************
	if proses2 = "Reset" then
	tahund = ""
	tahunh = ""
	 end if
	 
	if p2 = "Cetak" then
	if tahund = "" or tahunh = "" then 
		response.write "<script language = ""vbscript"">"
		response.write " MsgBox ""Sila Pilih Tahun!"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
	else
	 response.redirect "hg181c.asp?tahund="&tahund&"&tahunh="&tahunh&""
	end if
	end if
	
%>
  <table bgcolor="<%=color1%>" width="86%" align="center" cellpadding="0" cellspacing="1" border="0" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
    <tr align="center"> 
      <td>Tahun  Dari&nbsp; :
        <select name="tahund" size="1" id="tahund" style="font-family: Trebuchet MS; font-size: 10pt;" onkeydown="if(event.keyCode==13) event.keyCode=9;">
          <option selected value="">[Pilih Tahun]</option>
          <%	if tahund <> "" then  %>
          <option selected value="<%=tahund%>"><%=tahund%></option>
          <%   for h = 2000 to thnsms %>
          <option value="<%=h%>"><%=h%></option>
          <% next			
        else	
				for k = 2000 to thnsms	%>
          <option value="<%=k%>"><%=k%></option>
          <%	next
		end if	%>
        </select>       
        Hingga 
        <select name="tahunh" size="1" id="select"  style="font-family: Trebuchet MS; font-size: 10pt;" onkeydown="if(event.keyCode==13) event.keyCode=9;">
          <option selected value="">[Pilih Tahun]</option>
          <%	if tahunh <> "" then  %>
          <option selected value="<%=tahunh%>"><%=tahunh%></option>
          <% 	for h1 = 2000 to thnsms %>
          <option value="<%=h1%>"><%=h1%></option>
          <% next			
       			else	
				for k1 = 2000 to thnsms	%>
          <option value="<%=k1%>"><%=k1%></option>
          <%	next
		end if	%>
        </select>
        <input type="submit" value="Cari" name="b" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
	    <input type="submit" value="Cetak" name="b2" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
		<input type="submit" name="breset" value="Reset" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
            </td>
    </tr>
</table>
<script>
	document.komp.tahund.focus();
</script>
<%	if proses = "Cari" then 	
	if tahund = "" or tahunh = "" then 
		response.write "<script language = ""vbscript"">"
		response.write " MsgBox ""Sila Pilih Tahun!"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
		response.end 
	end if
	
	satu
	sub satu %> 
<table width="86%" cellspacing="0" border="0" align="center">
  <tr>  
    <td width="40%" valign="top"><table width="100%" cellspacing="1" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold; color:yellow;">
      <tr bgcolor="<%=color1%>">
        <td align="center">PERKARA</td>
      </tr>
      <tr bgcolor="<%=color1%>">
        <td nowrap>Bil Kompaun Telah Dibayar <br>&nbsp;</td>
      </tr>
      <tr bgcolor="<%=color1%>">
        <td>Bil Kompaun Tertunggak <br>&nbsp;</td>
      </tr>
      <tr bgcolor="<%=color1%>">
        <td>Jumlah Kompaun Dikeluarkan</td>
      </tr>
      <tr bgcolor="<%=color1%>">
        <td>Jumlah Amaun Bayaran (RM) </td>
      </tr>
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
    <td width="20%" valign="top"><table width="100%" align="center" cellspacing="1" style="font-family: Trebuchet MS; font-size: 10pt; ">
	 <tr bgcolor="<%=color1%>" align="center" style="font-weight:bold; color:yellow; " nowrap onMouseOver="this.style.backgroundColor='#996600'" onMouseOut="this.style.backgroundColor='#936975' " >
          <a href="hg181z.asp?i=<%=i%>">
	 <td>&nbsp;<%=i%></td></a>
      </tr>
      <tr bgcolor="#CCCCCC" align="center">
        <td><%=jbayar%><br><%=pbayar%>%</td>
      </tr>
      <tr bgcolor="#DDDDDD" align="center">
        <td><%=jtunggak%><br><%=ptunggak%>%</td>
      </tr>
      <tr bgcolor="#CCCCCC" align="center" style="font-weight:bold;">
        <td><%=jkompaun%></td>
      </tr>
      <tr bgcolor="#CCCCCC" align="center" style="font-weight:bold;">
        <td ><%if cdbl(kt("amaun_bayar")) > 0 then%><%=formatnumber(kt("amaun_bayar"),2)%><%else%>&nbsp;<%end if%>
      </tr>
    </table></td>
	<%	pkira = kira mod 3
		if pkira = 0 then satu
		next %>
	
    <td width="20%" valign="top"><table width="100%" align="center" cellspacing="1" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;">
      <tr bgcolor="<%=color1%>" align="center" style="font-weight:bold; color:yellow;" >
        <td>JUMLAH</td>
      </tr>
      <tr bgcolor="#CCCCCC" align="center">
        <td><%=total_bayar%><br>&nbsp;<%=percentbyr%>%</td>
      </tr>
      <tr bgcolor="#DDDDDD" align="center">
        <td><%=total_tunggak%><br>&nbsp;<%=percenttunggak%>%</td>
      </tr>
      <tr bgcolor="#CCCCCC" align="center" style="font-weight:bold; ">
        <td><%=total_kompaun%></td>
      </tr>
      <tr bgcolor="#CCCCCC" align="center" style="font-weight:bold; ">
        <td><%if total_amaunbayar > 0 then%><%=formatnumber(total_amaunbayar,2)%><%else%>&nbsp;<%end if%>
      </tr>
    </table></td>
		<%	tambah = 2 - cint(pkira)	
	for k = 1 to tambah  %>
   <td width="20%" valign="top">&nbsp;
</td>
<%	next	%>
  </tr>
</table>
<%	end if %>
</form>
</body>
</html>