<% Response.Buffer = True %>
<!-- #INCLUDE file="adovbs.inc" -->
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<SCRIPT LANGUAGE="JavaScript">
nextfield = "tkhdari";
</script>
</head>

<body>
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg151.asp" >
<%	response.cookies("amenu") = "hg151.asp" 

	proses = Request.form("b")   
	p2 = request.form("b2")
			
	if proses <> "Cari" then
		
		e = " select '01/'||to_char(sysdate,'mm')||'/'||to_char(sysdate,'yyyy') as tkhds,"
		e = e & " to_char(sysdate,'dd/mm/yyyy') as tkhhs  from dual "
   		Set se = objConn.Execute(e)	
   		tkhd = se("tkhds")
   		tkhh = se("tkhhs")  		
	end if
	
	if proses = "Cari" or p2 = "Cetak" then
		tkhd = Request.form("tkhd")	
		tkhh = Request.form("tkhh")
	end if	
	
	if p2 = "Cetak" then response.redirect "hg151c.asp?tkhd="&tkhd&"&tkhh="&tkhh&""
	
	
	dtkhd = Request.QueryString("dtkhd")
	if dtkhd <> "" then
		tkhd = Request.QueryString("dtkhd")
		tkhh = Request.QueryString("dtkhh")
	end if

%>
  <table bgcolor="<%=color1%>" width="100%" align="center" cellpadding="0" cellspacing="1" border="0" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
    <tr align="center"> 
      <td>Tarikh Kompaun Dari&nbsp; : 
        <input type="text" name="tkhd" value="<%=tkhd%>" onFocus="nextfield='tkhh';" size="10" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
        Hingga&nbsp; 
        <input type="text" name="tkhh" value="<%=tkhh%>" onFocus="nextfield='b';" size="10" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
        <input type="submit" value="Cari" name="b" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
		<input type="submit" value="Cetak" name="b2" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
      </td>
    </tr>
    <script>
	document.komp.tkhd.focus();
</script>
</table>

<%	Dim iPageSize,iPageCount,iPageCurrent,iRecordsShown
	Dim S
	iPageSize = 10

	If Request.QueryString("page") = "" Then
		iPageCurrent = 1
	Else
		iPageCurrent = CInt(Request.QueryString("page"))
	End If
	

	if proses = "Cari" or dtkhd <> "" then
	b = " select to_char(to_date('"&tkhd&"','dd/mm/yyyy'),'ddmmyyyy') as tkha, "
	b = b & " to_char(to_date('"&tkhh&"','dd/mm/yyyy'),'ddmmyyyy') as tkhb from dual "
	set sb = objconn.execute(b)
   		
   	if not sb.eof then
		tkha = sb("tkha")
		tkhb = sb("tkhb") 
		
   	if tkha > tkhb then	
 		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Tarikh Dari Lebih Besar "" + vbNewline + "" Daripada Tarikh Hingga"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
       else
			
		d = " select tkh_kompaun,no_kompaun,upper(nama) nama,status_kompaun, "
	    d = d & " to_char(tkh_kompaun,'yyyy')y, akta,kesalahan, "
		d = d & " lpad(to_char(tkh_kompaun,'mm'),2,0)m,lpad(to_char(tkh_kompaun,'dd'),2,0)d from kompaun.halangan "
		d = d & " where tkh_kompaun between  to_date('"&tkhd&"','dd/mm/yyyy') and"
		d = d & " to_date('"&tkhh&"','dd/mm/yyyy')"
		d = d & " order by to_char(tkh_kompaun,'yyyy'), "
		d = d & " lpad(to_char(tkh_kompaun,'mm'),2,0),lpad(to_char(tkh_kompaun,'dd'),2,0) "	
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
  <table border=0 cellPadding=1 cellSpacing=1 width="100%" align="center" style="font-family: Trebuchet MS; font-size: 10pt;">
    <tr > 
      <td align="left" colspan=2>Jumlah Rekod : <%=kira%></td>
      <td align="right" colspan=5 > 
        <% If iPageCurrent <> 1 Then %>
        <a href="hg151.asp?page=1&bilangan=0&ms=pre&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
        <img name="firstrec" border="0" src="firstrec.jpg" width="20" height="20" alt="Halaman Mula"></a> 
        <% End If %>
        <% If iPageCurrent <> 1 Then%>
        <a href="hg151.asp?page=<%= iPageCurrent - 1 %>&bilangan=<%=bil-count-iPageSize%>&ms=pre&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
        <img name="previous" border="0" src="previous.jpg" width="20" height="20" alt="Rekod Sebelum"></a> 
        <% End If %>
        Halaman <%=iPageCurrent%>/ 
        <%if iPageCount=0 then%>
        1 
        <%else%>
        <%=iPageCount%> 
        <%end if%>
        <% If iPageCurrent < iPageCount Then	%>
        <a href="hg151.asp?page=<%= iPageCurrent + 1 %>&bilangan=<%=bil%>&ms=next&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
        <img name="next" border="0" src="next.jpg" width="20" height="20" alt="Rekod Seterusnya"></a> 
        <% End If 
	  If iPageCurrent < iPageCount Then
	  bil = (iPageCount - 1) * iPageSize %>
        <a href="hg151.asp?page=<%=iPageCount %>&bilangan=<%=bil%>&ms=next&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
        <img name="lastrec" border="0" src="lastrec.jpg" width="20" height="20" alt="Halaman Akhir"></a> 
        <% End If %>
      </td>
    </tr>
    <tr style="color:yellow" align="center" bgcolor="<%=color1%>"> 
      <td width="26">Bil</td>
      <td width="79">No Kompaun</td>
      <td width="190">Nama</td>
      <td width="166">Akta</td>
      <td width="103">Kesalahan</td>
      <td width="100">Tkh Kompaun</td>
      <td width="77">Status</td>
    </tr>
    <% 
		bil = 0
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

		tkh_kompaun = sd("d") +"/"+sd("m")+"/"+sd("y")
		stat = sd("status_kompaun")
		if stat = "I" then status = "Belum Bayar" 
		if stat = "P" then status = "Bayar"
		if stat = "B" then status = "Batal"
		if stat = "M" then status = "Mahkamah"
		if stat = "F" then status = "Notis Pertama"
		if stat = "S" then status = "Notis Kedua"
		if stat = "T" then status = "Notis Ketiga"
		
		sq = " select kod, initcap(keterangan) keterangan from kompaun.perkara "
        sq = sq & " where kod = '"& sd("akta") &"' "
		sq = sq & " and kod <> 'P01' order by kod "
        Set sq = objConn.Execute(sq)
		
		if not sq.eof then
			aktaketer = sq("keterangan")
		end if
		
		
		
	m = " select initcap(keterangan||' '||keterangan2) keterangan from kompaun.jenis_kesalahan "
    m = m & " where kod = '"& sd("kesalahan") &"'  "
    m = m & " and perkara = '"& sd("akta") &"' "
  	Set sm = objConn.Execute(m)		
	
	if not sm.eof then
		salahketer = sm("keterangan")
	end if
%>
    <tr align="center" bgcolor="<%=color2%>"> 
      <td width="26"><%=bil%></td>
      <td width="79"><%=sd("no_kompaun")%></td>
      <td width="190" align="left"><%=sd("nama")%></td>
      <td width="166" align="left"><%=sd("akta")%>-<%=aktaketer%></td>
      <td width="103" align="left"><%=sd("kesalahan")%>-<%=salahketer%></td>
      <td width="100"><%=tkh_kompaun%> </td>
      <td width="77"><%=status%></td>
    </tr>
    <%	iRecordsShown = iRecordsShown + 1
	count = count + 1

  	sd.MoveNext			
  	Loop
%>
  </table>
<%	end if	 
	end if 
	end if		
	end if 
	end if
	end if %>
</form>
</body>
</html>