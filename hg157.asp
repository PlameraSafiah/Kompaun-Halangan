<%Response.Buffer = True%>
<!-- #INCLUDE file="adovbs.inc" -->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<style>
<!-- a {text-decoration:none}
//-->
</style>
<SCRIPT LANGUAGE="JavaScript">
nextfield = "nopek";

function check(b){
if(b.nopek.value==""){
alert("Sila Masukkan No Pekerja !!");
b.nopek.focus();
return false}

if(b.tkhd.value==""){
alert("Sila Masukkan Tarikh Dari !!");
b.tkhd.focus();
return false}

if(b.tkhh.value==""){
alert("Sila Masukkan Tarikh Hingga !!");
b.tkhh.focus();
return false}
}
</script>
</head>
<body>
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg157.asp" onSubmit="return check(this)">
<%	response.cookies("amenu") = "hg157.asp" 
   	
	proses = Request.form("b")   
	proses2 = request.form("b2")
	
	if proses <> "Cari" then		
		e = " select '01/'||to_char(sysdate,'mm')||'/'||to_char(sysdate,'yyyy') as tkhds , "
		e = e & " to_char(sysdate,'dd/mm/yyyy') as tkhhs from dual "
   		Set objRse = objConn.Execute(e)	   		
   		tkhd = objRse("tkhds")
   		tkhh = objRse("tkhhs")  		
	end if
	
	if proses = "Cari" or proses2 = "Cetak" then
		nopek = Request.form("nopek")
		tkhd = Request.form("tkhd")	
		tkhh = Request.form("tkhh")
	end if
	
	if proses2 = "Cetak" then response.redirect "hg157c.asp?tkhd="&tkhd&"&tkhh="&tkhh&"&nopek="&nopek&""

	
	dnopek = Request.QueryString("dnopek")

	if dnopek <> "" then
		nopek = Request.QueryString("dnopek")
		tkhd = Request.QueryString("dtkhd")
		tkhh = Request.QueryString("dtkhh")
	end if	
	
	n = " select lpad(no_pekerja,5,0)nopek,initcap(nama) nama from "
	n = n & " payroll.paymas where no_pekerja = '"&nopek&"' "
	n = n & " union "
	n = n & " select lpad(no_pekerja,5,0)nopek,initcap(nama) nama from "
	n = n & " payroll.paymas_sambilan where no_pekerja = '"&nopek&"' "
	Set objRsn = Server.CreateObject("ADODB.Recordset")
	Set objRsn = objConn.Execute(n)
	
	if not objRsn.eof then
		napek = objRsn("nama")
		nopek = objRsn("nopek")
	else
		napek = ""
	end if
%>
<table width="100%" bgcolor="<%=color1%>" cellspacing=1 style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
    <tr> 
      <td width="29%" align="right">No Pekerja&nbsp; : </td>
      <td colspan="3"> 
        <input type="text" name="nopek" value="<%=nopek%>" size="5" maxlength="5" onFocus="nextfield='tkhd';">
        &nbsp;&nbsp;-&nbsp;&nbsp;<%=napek%></td>
    </tr>
    <script>
	document.komp.nopek.focus();
</script>
<tr >  
      <td width="29%" align="right">Tarikh Dari&nbsp;:</td>
      <td width="7%"><input type="text" name="tkhd" value="<%=tkhd%>" size="10" maxlength="10" onFocus="nextfield='tkhh';" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">      </td>
      <td width="8%">&nbsp;&nbsp;Hingga</td>
      <td width="56%"> 
        <input type="text" name="tkhh" value="<%=tkhh%>" size="10" maxlength="10" onFocus="nextfield='b';" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
        &nbsp; 
        <input type="submit" value="Cari" name="b" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
        <input type="submit" value="Cetak" name="b2" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
      </td>
</tr></table>
  
<%	Dim iPageSize,iPageCount,iPageCurrent,iRecordsShown
	Dim S
	iPageSize = 10

	If Request.QueryString("page") = "" Then
		iPageCurrent = 1
	Else
		iPageCurrent = CInt(Request.QueryString("page"))
	End If

	if proses = "Cari" or dnopek <> "" or dtkhd <> "" or dtkhh <> "" then
	b = " select 'x' from dual "
	b = b & " where to_date(to_date('"&tkhd&"','dd/mm/yyyy'),'dd-mon-yyyy') > "
	b = b & " to_date(to_date('"&tkhh&"','dd/mm/yyyy'),'dd-mon-yyyy') "
	set sb = objconn.execute(b)
   		
   	if not sb.eof then
 		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Tarikh Dari Lebih Besar "" + vbNewline + "" Daripada Tarikh Hingga"", vbInformation, ""Perhatian!"" "
		response.write "</script>"

	else
		
		k = " select no_pekerja from payroll.paymas where no_pekerja = '"&nopek&"' and lokasi = 101 "
		k = k & " union "
		k = k & " select no_pekerja from payroll.paymas_sambilan where no_pekerja = '"&nopek&"' and lokasi = 101 "
		Set objRsk = objConn.Execute(k)
		
		if proses = "CARI" and objRsk.eof then	
			response.write "<script language=""javascript"">"
			response.write "var timeID = setTimeout('invalid_nopekerja(""  "");',1) "
			response.write "</script>"
			proses = "Cari"			
		else
		
		d = " select rowid,no_kompaun,no_akaun,upper(nama) nama,akta,kesalahan,"
	    d = d & " to_char(tkh_kompaun,'dd/mm/yyyy')tkh_kompaun,nvl(amaun,0)amaun, "
		d = d & " status_kompaun status from kompaun.halangan "
		d = d & " where tkh_kompaun between  to_date('"&tkhd&"','dd/mm/yyyy') and"
		d = d & " to_date('"&tkhh&"','dd/mm/yyyy') "
		d = d & " and lpad(pengeluar_kompaun,5,0) = '"& nopek &"' "
		Set sd = Server.CreateObject ("ADODB.Recordset")

		sd.PageSize = iPageSize
		sd.CacheSize = iPageSize
 		sd.CursorLocation = 3
		sd.Open d, objConn
		iPageCount = sd.PageCount 		
		
		if not sd.bof and not sd.eof then
		kira=sd.recordcount
		rekod="ada"
		If iPageCurrent > iPageCount Then iPageCurrent = iPageCount
		If iPageCurrent < 1 Then iPageCurrent = 1

		bil=0
		bilangan=Request.QueryString("bilangan")
		ms=Request.QueryString("ms")
		
		If bilangan <>"" and ms="next" then
			bil = bilangan
		End If
		If bilangan <>"" and ms="pre" then
			bil = bilangan
		End If
		
		If iPageCount <> 0 Then
			sd.AbsolutePage = iPageCurrent
   			iRecordsShown = 0
			count = 0
		Do While iRecordsShown <iPageSize And Not sd.eof 
			iRecordsShown = iRecordsShown + 1
			count = count + 1
			bil=bil + 1
		sd.movenext
		loop
		end if
		end if		
			
		if sd.bof and sd.eof then
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Maaf,Tiada Rekod"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
		else

		if kira > 0 then
%>  
  <table border=0 cellPadding=0 cellSpacing=1 width="100%" style="font-family: Trebuchet MS; font-size: 10pt;">
    <tr align="right"> 
      <td align="left" colspan=3>Jumlah Rekod : <%=kira%></td>
      <td colspan=8> 
        <% If iPageCurrent <> 1 Then %>
        <a href="hg157.asp?page=1&bilangan=0&ms=pre&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&dnopek=<%=nopek%>&proses=Cari"> 
        <img name="firstrec" border="0" src="firstrec.jpg" width="20" height="20" alt="Halaman Mula"></a> 
        <% End If %>
        <% If iPageCurrent <> 1 Then%>
        <a href="hg157.asp?page=<%= iPageCurrent - 1 %>&bilangan=<%=bil-count-iPageSize%>&ms=pre&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&dnopek=<%=nopek%>&proses=Cari"> 
        <img name="previous" border="0" src="previous.jpg" width="20" height="20" alt="Rekod Sebelum"></a> 
        <% End If %>
        Halaman <%=iPageCurrent%>/ 
        <%if iPageCount=0 then%>
        1 
        <%else%>
        <%=iPageCount%> 
        <%end if%>
        <% If iPageCurrent < iPageCount Then	%>
        <a href="hg157.asp?page=<%= iPageCurrent + 1 %>&bilangan=<%=bil%>&ms=next&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&dnopek=<%=nopek%>&proses=Cari"> 
        <img name="next" border="0" src="next.jpg" width="20" height="20" alt="Rekod Seterusnya"></a> 
        <% End If 
	  If iPageCurrent < iPageCount Then
	  bil = (iPageCount - 1) * iPageSize %>
        <a href="hg157.asp?page=<%=iPageCount %>&bilangan=<%=bil%>&ms=next&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&dnopek=<%=nopek%>&proses=Cari"> 
        <img name="lastrec" border="0" src="lastrec.jpg" width="20" height="20" alt="Halaman Akhir"></a> 
        <% End If %>
      </td>
    </tr>
    <tr align="center" bgcolor="<%=color1%>" > 
      <td width="26">Bil</td>
      <td width="78">No Kompaun</td>
      <td width="93">No Akaun</td>
      <td width="46">Akta</td>
      <td width="65">Kesalahan</td>
      <td width="197">Nama</td>
      <td width="86">Tkh Kompaun</td>
      <td width="52">Amaun</td>
      <td width="110">Status Kompaun</td>
    </tr>
    <%		bil = 0
		ctrz = 0
	
		bilangan=Request.QueryString("bilangan")
		page = Request.QueryString("page")
		ms=Request.QueryString("ms")

		If bilangan <>"" and ms="next" then
			bil = bilangan
		End If
		If bilangan <>"" and ms="pre" then
			bil = bilangan
		End If
		If iPageCount <> 0 Then
			sd.AbsolutePage = iPageCurrent
   			iRecordsShown = 0
			count = 0
			
		Do While iRecordsShown <iPageSize And Not sd.eof 
		bil = bil + 1
		ctrz = cdbl(ctrz) + 1
		rowid = sd("rowid")
		status = sd("status")
		if status = "I" then
			keter = "Belum Bayar"
		elseif status = "P" then
			keter = "Bayar"
		elseif status = "B" then
			keter = "Batal"
		elseif status = "M" then
			keter = "Mahkamah"
		elseif status = "N" then
			keter = "Notis"
		end if	%>
  <a href="hg158a.asp?rowid=<%=rowid%>&amenu='hg157'"> 
  <tr align="center" bgcolor="<%=color2%>" onMouseOver="this.style.backgroundColor='#FFFFCC'" onMouseOut="this.style.backgroundColor='<%=color2%>'"> 
      <td width="26"><%=bil%> </td>
      <td width="78"><%=sd("no_kompaun")%> </td>
      <td width="93"><%=sd("no_akaun")%></td>
      <td width="46" align="center" onMouseover="this.style.backgroundColor='#FFFFCC'" onMouseout="this.style.backgroundColor='#CCCCCC'"><%=sd("akta")%></td>
      <td width="65"  color="Blue"><%=sd("kesalahan")%></td>
      <td width="197" align="left" onMouseover="this.style.backgroundColor='#FFFFCC'" onMouseout="this.style.backgroundColor='#CCCCCC'"> 
        <%=sd("nama")%></td>
      <td width="86" align="center"><%=sd("tkh_kompaun")%></td>
      <td width="52" align="left"><%=FormatNumber(sd("amaun"),2)%></td>
      <td width="110" ><%=keter%></td>
    </tr></a>
    <%	iRecordsShown = iRecordsShown + 1
	count = count + 1
  	sd.MoveNext			
  	Loop
%>
  </table>
<%  	end if		
		end if
		end if
		end if
		end if
  		end if  
%>
</form>
</body>
</html>