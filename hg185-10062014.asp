<% Response.Buffer = True %>
<!--#include file="focus.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<script language="javascript">
   function invalid_data(a)
    {  
       alert (a+" Tiada Rekod ");
		return(true);
    }
</script>

</head>

<BODY>
<%response.cookies("amenu") = "hg185.asp"%>
<!-- '#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg185.asp" >
  <% 	
  Set objConn = Server.CreateObject("ADODB.Connection")
  objConn.Open "dsn=mpspDSN;uid=majlis;pwd=majlis;"
   
  b1cari = Request.form("B1cari")
  proses2 = Request.Form("breset")
  tahun = Request.Form("tahun")
  fbln  = request.form("bln")

		if proses2 = "Reset" then
			fbln       = ""
			tahun      = ""				
		end if
  
  if b1cari = "Cari" then b1 = "Cari"
  if b1 <> "Cari" then tahun = year(now)
  if b1 = "Cari" then tahun = Request.form("dtahun")
  if b1 <> "Cari" then fbln = Request.form("fbln")

%>
  
  <table align="center" width="93%" bgcolor="<%=color1%>" cellspacing="0" cellpadding="1"  border="0" bordercolor="black" style="font-family: Verdana; font-size: 10pt; color:yellow">
    <tr bgcolor="<%=color1%>"> 
      <td width="40%" align="right">Bulan&nbsp;</td>
      <td width="60%"> 
        <select name="bln" size="1" style="font-family: Trebuchet MS; font-size: 10pt">
          <% if fbln = "" then %>
          <option value ="">Semua Bulan</option>
			<%else
				m = " select bulan,namabulan from iabs.bulan "
				m = m & " where bulan = '"&fbln&"' "
				set sm = objconn.execute(m)	%>
		  <option value="<%=fbln%>"><%=sm("namabulan")%> 
		  <% 
			end if 
				n = "select bulan,namabulan from iabs.bulan"
				'n = n & " group by bulan "	
				set sn = objconn.execute(n)
				do while not sn.eof			%> 
		  <option value="<%=sn("bulan")%>"><%=sn("namabulan")%></option>
  		  <%
			sn.Movenext
			loop	%> 
       </select>
      </td>
	</tr>    
	
	<tr bgcolor="<%=color1%>">
	  <td width="40%" align="right">Tahun&nbsp;</td>
      <td bgcolor="<%=color1%>" align="left"><font color="#FFFFFF"><b></b> 
        <input type="text" name="dtahun" value="<%=tahun%>" size="4" maxlength="4" onFocus="nextfield='B1cari';" >
        <input type="submit" value="Cari" name="B1cari" onFocus="nextfield='done';" style="font-family: Verdana" >
	  <input type="submit" name="breset" value="Reset"></font></td>
    </tr>
  </table><br>
    <script>
	document.komp.dtahun.focus();
</script>
  
  <% if b1 = "Cari" then
   
     x =     " select a.kesalahan,nvl(sum(a.amaun_bayar),0) amaun_bayar,count(1) rekod, "
     x = x & " count(a.amaun_bayar) sudah,initcap(b.keterangan||' '||b.keterangan2) ket "
     x = x & " from kompaun.halangan a, kompaun.jenis_kesalahan b "
	 x = x & "	where to_char(a.tkh_kompaun,'yyyy') = '"& tahun &"' "
	 if fbln <> "" then 
	 x = x & " and to_char(a.tkh_kompaun,'mm') = '"& fbln &"' "
	 end if
     x = x & " and a.kesalahan = b.kod " 
     x = x & " group by a.kesalahan,initcap(b.keterangan||' '||b.keterangan2) " 
     Set rsx = objConn.Execute(x)
     
	 
     if rsx.eof then
        response.write "<script language=""javascript"">"
        response.write "var timeID = setTimeout('invalid_data(""  "");',1) "
        response.write "</script>"
        b1 = "Cari"
     else
     %>
  <table width="80%" cellspacing="1" align="center">
    <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold; color:yellow;" align="center"> 
      <td width="34">Bil</td>
      <td width="543">Jenis Kesalahan </td>
      <td width="90">Rekod</td>
      <td width="104">Belum Bayar </td>
      <td width="108">Sudah Bayar </td>
      <td width="107">Amaun(RM)</td>
    </tr>
<%bil = 0
  belum = 0
  jamaun = 0
  jsudah = 0
  jrekod = 0
  jbelum = 0
  
  Do while not rsx.eof
     kesalahan = rsx("kesalahan")
     amaun = rsx("amaun_bayar")
     rekod = rsx("rekod")
     sudah = rsx("sudah")
     ket = rsx("ket")
     
     belum = cdbl(rekod) - cdbl(sudah)
     jamaun = cdbl(jamaun) + cdbl(amaun)
     jrekod = cdbl(jrekod) + cdbl(rekod)
     jsudah = cdbl(jsudah) + cdbl(sudah)
     jbelum = cdbl(jbelum) + cdbl(belum)
     
     bil = bil + 1	
%>

    <tr bgcolor="<%=color2%>" style="font-family: Trebuchet MS; font-size: 10pt;  "> 
      <td align="center" width="34"><%=bil%></td>
      <td align="left" width="543"><%=ket%></td>
      <td align="center" width="90"><%=rekod%></td>
      <td align="center" width="104"> 
        <%if belum > 0 then%>
        <%=formatnumber(belum,0)%> 
        <%else%>
        &nbsp; 
        <%end if%>
        &nbsp;</td>
      <td align="center" width="108"> 
        <%if cdbl(rsx("sudah")) > 0 then%>
        <%=formatnumber(rsx("sudah"),0)%> 
        <%else%>
        &nbsp; 
        <%end if%>
        &nbsp;</td>
      <td align="right" width="107"> 
        <%if cdbl(rsx("amaun_bayar")) > 0 then%>
        <%=formatnumber(rsx("amaun_bayar"),2)%> 
        <%else%>
        &nbsp; 
        <%end if%>
        &nbsp;</td>
    </tr>
    <% rsx.movenext
        loop %>
    <tr bgcolor="<%=color1%>"  style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;  "> 
      <td align="right" colspan="2">&nbsp;</td>
      <td align="center" width="90"><%=jrekod%></td>
      <td align="center" width="104"><%=jbelum%></td>
      <td align="center" width="108"> 
        <%if jsudah > 0 then%>
        <%=formatnumber(jsudah,0)%> 
        <%else%>
        &nbsp; 
        <%end if%>
        &nbsp;</td>
      <td align="right" width="107"> 
        <%if jamaun > 0 then%>
        <%=formatnumber(jamaun,2)%> 
        <%else%>
        &nbsp; 
        <%end if%>
        &nbsp;</td>
    </tr>
  </table>	 
	 <% 
	 end if
	 end if
	' end Sub %>
</form>
</body>
</html>