<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Senarai Ke Jabatan Undang²</title>
<SCRIPT LANGUAGE="JavaScript">
nextfield = "tkhd";
</script>
</head> 
<body>
<!-- #INCLUDE FILE="menukom.asp" -->
<form method="POST" action="hg142.asp" name="komp">
 <% response.cookies("amenu") = "hg142.asp" 
   
   p = Request.form("b")
   tkhd = Request.form("tkhd")
     
   if tkhd = "" then
   		f = " select to_char(sysdate,'dd/mm/yyyy') as tkhh from dual "
   		Set sf = objConn.Execute(f)	
   		tkhd = sf("tkhh")
	end if	
	
	if p = "Cetak" then response.redirect "hg142r.asp?tkhd="&tkhd&""	 
%> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
          <td align="center">Tarikh Undang-Undang 
          <input type="text" name="tkhd" size="10" value="<%=tkhd%>" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
               <input type="submit" value="Cetak" name="b" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold" onFocus="nextfield='done';">
       </td></tr>
	     <script>
	document.komp.tkhd.focus()
</script></table>
</form>
</body>