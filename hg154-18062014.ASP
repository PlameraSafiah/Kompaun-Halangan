<% Response.Buffer = True %>
<!-- #INCLUDE file="adovbs.inc" -->
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<SCRIPT LANGUAGE="JavaScript">
nextfield = "tkhd";
</script>
</head>

<body>
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg154.asp">
<%	response.cookies("amenu") = "hg154.asp" 

	Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"
   	
   	proses = Request.form("B1")
	proses2 = Request.form("B2")
	   		
	if proses <> "Cari" or proses2 <> "Cetak" then		
		e = " select '01/'||to_char(sysdate,'mm')||'/'||to_char(sysdate,'yyyy') as tkhds from dual "
   		Set objRse = objConn.Execute(e)	
   		tkhd = objRse("tkhds")		
		
		f = " select to_char(sysdate,'dd/mm/yyyy') as tkhhs from dual "
   		Set objRsf = objConn.Execute(f)	
   		tkhh = objRsf("tkhhs")  		
	end if	
	
	if proses = "Cari" or proses2 = "Cetak" then	
		tkhd = Request.form("tkhd")	
		tkhh = Request.form("tkhh")		
	end if
	
	dtkhd = Request.QueryString("dtkhd")

	if dtkhd <> "" then
		tkhd = Request.QueryString("dtkhd")
		tkhh = Request.QueryString("dtkhh")
	end if
	
	if proses2 = "Cetak" then response.redirect "hg154c.asp?tkhd="&tkhd&"&tkhh="&tkhh&""
%>
  <table width="100%" align="center" cellpadding="0" cellspacing="1" border="0" >
    <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td width="727" align="center" >Tarikh Kompaun Dari&nbsp; :&nbsp;&nbsp; 
        <input type="text" name="tkhd" value="<%=tkhd%>" onFocus="nextfield='tkhh';" size="10" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
        &nbsp;Hingga&nbsp; 
        <input type="text" name="tkhh" value="<%=tkhh%>" onFocus="nextfield='B1';" size="10" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
        &nbsp; 
        <input type="submit" value="Cari" name="B1" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
        <input type="submit" value="Cetak" name="B2" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
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
			
		d = " select no_kompaun,nama,to_char(tkh_kompaun,'dd/mm/yyyy')tkh_kompaun, "
		d = d & " to_char(tkh_bayar,'dd/mm/yyyy')tkh_bayar,akta,kesalahan,"
		d = d & " nvl(amaun_bayar,0)amaun_bayar from kompaun.halangan "
		d = d & " where tkh_kompaun between to_date('"& tkhd &"', 'dd/mm/yyyy') "
		d = d & " and to_date('"& tkhh &"' , 'dd/mm/yyyy') "
		d = d & " and amaun_bayar is null and status_kompaun not in ('P','B') "	
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
		response.write " MsgBox ""Maaf,Tiada rekod"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
        else
       if kira > 0 then

%>  
  <table border=0 cellPadding=1 cellSpacing=1 width="727" align="center" style="font-family: Trebuchet MS; font-size: 10pt;">
    <tr > 
      <td align="left" colspan=2>Jumlah Rekod :<%=kira%></td>
      <td align="right" colspan=3 > 
        <% If iPageCurrent <> 1 Then %>
        <a href="hg154.asp?page=1&bilangan=0&ms=pre&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
        <img name="firstrec" border="0" src="firstrec.jpg" width="20" height="20" alt="Halaman Mula"></a> 
        <% End If %>
        <% If iPageCurrent <> 1 Then%>
        <a href="hg154.asp?page=<%= iPageCurrent - 1 %>&bilangan=<%=bil-count-iPageSize%>&ms=pre&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
        <img name="previous" border="0" src="previous.jpg" width="20" height="20" alt="Rekod Sebelum"></a> 
        <% End If %>
        Halaman <%=iPageCurrent%>/ 
        <%if iPageCount=0 then%>
        1 
        <%else%>
        <%=iPageCount%> 
        <%end if%>
        <% If iPageCurrent < iPageCount Then	%>
        <a href="hg154.asp?page=<%= iPageCurrent + 1 %>&bilangan=<%=bil%>&ms=next&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
        <img name="next" border="0" src="next.jpg" width="20" height="20" alt="Rekod Seterusnya"></a> 
        <% End If 
	  If iPageCurrent < iPageCount Then
	  bil = (iPageCount - 1) * iPageSize %>
        <a href="hg154.asp?page=<%=iPageCount %>&bilangan=<%=bil%>&ms=next&dtkhd=<%=tkhd%>&dtkhh=<%=tkhh%>&proses=Cari"> 
        <img name="lastrec" border="0" src="lastrec.jpg" width="20" height="20" alt="Halaman Akhir"></a> 
        <% End If %>
      </td>
    </tr>
    <tr align="center" style="color:yellow" bgcolor="<%=color1%>"> 
      <td width="32">Bil</td>
      <td width="74">No Kompaun</td>
      <td width="219">Nama</td>
      <td width="307">Kesalahan</td>
      <td width="79">Tkh Kompaun</td>
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
	
	m = " select initcap(keterangan||' '||keterangan2) keterangan from kompaun.butir_kesalahan "
    m = m & " where kod = '"& sd("kesalahan") &"'  "
    m = m & " and akta = '"& sd("akta") &"' "
  	Set sm = objConn.Execute(m)		
	
	if not sm.eof then
		salahketer = sm("keterangan")
	end if
		
		
%>
    <tr align="center" bgcolor="<%=color2%>"> 
      <td width="32"><%=bil%></td>
      <td width="74"><%=sd("no_kompaun")%></td>
      <td width="219" align="left"><%=sd("nama")%></td>
      <td width="307"> 
        <div align = left><%=salahketer%></div></td>
      <td width="79"><%=sd("tkh_kompaun")%></td>
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
%> 
</form>
<%end if%>
</body>
</html>