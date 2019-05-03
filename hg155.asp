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
<form name=komp method="POST" action="hg155.asp" >
<%	response.cookies("amenu") = "hg155.asp" 

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
	
	if p2 = "Cetak" then response.redirect "hg155c.asp?tkhd="&tkhd&"&tkhh="&tkhh&""
	
	
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
		
	b = " select to_char(to_date('"&tkhd&"','dd/mm/yyyy'),'dd-mon-yyyy') as tkha, "
	b = b & " to_char(to_date('"&tkhh&"','dd/mm/yyyy'),'dd-mon-yyyy') as tkhb from dual "
	b = b & " where to_date(to_date('"&tkhd&"','dd/mm/yyyy'),'dd-mon-yyyy') > "
	b = b & " to_date(to_date('"&tkhh&"','dd/mm/yyyy'),'dd-mon-yyyy') "
	set sb = objconn.execute(b)
   		
   	if not sb.eof then	
 		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Tarikh Dari Lebih Besar "" + vbNewline + "" Daripada Tarikh Hingga"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
       else
			
		d = " select no_kompaun,no_akaun,upper(nama) nama, to_char(tkh_batal,'dd/mm/yyyy')tkh_batal,"
	    d = d & " to_char(tkh_kompaun,'dd/mm/yyyy')tkh_kompaun "
		d = d & " from kompaun.halangan "
		d = d & " where tkh_kompaun between  to_date('"&tkhd&"','dd/mm/yyyy') and"
		d = d & " to_date('"&tkhh&"','dd/mm/yyyy') and status_kompaun = 'B' "
		d = d & " order by no_kompaun "	
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
      <td align="left" colspan=2 width="143">Jumlah Rekod : <%=kira%></td>
      <td align="right" colspan=4 width="570" > 
        <% If iPageCurrent <> 1 Then %>
        <a href="hg155.asp?page=1&bilangan=0&ms=pre&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
		<img name="firstrec" border="0" src="firstrec.jpg" width="20" height="20" alt="Halaman Mula"></a> 
        <% End If %>
        <% If iPageCurrent <> 1 Then%>
        <a href="hg155.asp?page=<%= iPageCurrent - 1 %>&bilangan=<%=bil-count-iPageSize%>&ms=pre&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
		<img name="previous" border="0" src="previous.jpg" width="20" height="20" alt="Rekod Sebelum"></a> 
        <% End If %>
        Halaman <%=iPageCurrent%>/ 
        <%if iPageCount=0 then%>
        1 
        <%else%>
        <%=iPageCount%> 
        <%end if%>
        <% If iPageCurrent < iPageCount Then	%>
        <a href="hg155.asp?page=<%= iPageCurrent + 1 %>&bilangan=<%=bil%>&ms=next&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
	    <img name="next" border="0" src="next.jpg" width="20" height="20" alt="Rekod Seterusnya"></a> 
        <% End If 
	  If iPageCurrent < iPageCount Then
	  bil = (iPageCount - 1) * iPageSize %>
        <a href="hg155.asp?page=<%=iPageCount %>&bilangan=<%=bil%>&ms=next&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
	   <img name="lastrec" border="0" src="lastrec.jpg" width="20" height="20" alt="Halaman Akhir"></a> 
        <% End If %>
      </td>
    </tr>
    <tr style="color:yellow" align="center" bgcolor="<%=color1%>"> 
      <td width="32">Bil</td>
      <td width="105">No Kompaun</td>
      <td width="105">No Akaun</td>
      <td width="250">Nama</td>
      <td width="120">Tarikh Kompaun</td>
      <td width="89">Tarikh Batal</td>
      <td width="93">Dibatal Oleh</td>
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
    	
    	s = " select decode(siri,1,'YDP',2,'SU',3,'Pengarah',null) siri from kompaun.batal_kompaun "
    	s = s & " where no_kompaun = '"&sd("no_kompaun")&"' "
    	Set objRss = Server.CreateObject("ADODB.Recordset")
    	Set objRss = objConn.Execute(s)
    	
    	if not objRss.eof then
    		batal = objRss("siri")
    	else batal = ""
    	end if	
%>
    <tr align="center" bgcolor="<%=color2%>"> 
      <td width="32"><%=bil%></td>
      <td width="105"><%=sd("no_kompaun")%></td>
      <td width="105"><%=sd("no_akaun")%></td>
      <td width="250" align="left"><%=sd("nama")%></td>
      <td width="120"><%=sd("tkh_kompaun")%> </td>
      <td width="89"><%=sd("tkh_batal")%></td>
      <td width="93"><%=batal%></td>
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
	end if %>
</form>
</body>
</html>