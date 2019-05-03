<%response.buffer = True %>
<!-- #INCLUDE file="adovbs.inc" -->
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<script language="Javascript">
nextfield = "tkhd";
function check2(f){
if(f.ftkh.value==""){
alert("Sila Masukkan Tarikh Notis !!!")
f.ftkh.focus();
return false;}
}
    
</script>
</head>
<body>
<!-- '#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg116.asp">
<%	response.cookies("amenu") = "hg116.asp" 
   
	ftkhd = request.querystring("ftkhd")
	ftkhh = request.querystring("ftkhh")
	ftkhn = request.querystring("ftkhn")
	fkompd = request.querystring("fkompd")
	fkomph = request.querystring("fkomph")
	fp4 = request.querystring("fp4")
	fdaerah = request.querystring("fdaerah")
	
	p1=Request.form("B1")
	p2 = Request.form("B2")
	p3 = Request.form("B3")
	p4 = request.form("B4")
	p5 = request.form("B5")
	p6 = request.form("B6")
	p7 = request.form("B7")
	tkhn = Request.form("tkhn")
	tkhd = Request.form("tkhd")
	tkhh = Request.form("tkhh")
	nokomd = request.form("nokomd")
	nokomh = request.form("nokomh")
	kompd = request.form("kompd")
	komph = request.form("komph")
	daerah = request.form("daerah")
	
	if ftkhn <> "" then
		tkhd = request.querystring("ftkhd")
		tkhh = request.querystring("ftkhh")
		tkhn = request.querystring("ftkhn")
		p4 = request.querystring("fp4")
		kompd = request.querystring("fkompd")
		komph = request.querystring("fkomph")
		daerah = request.querystring("fdaerah")
	end if
	
	kepala	
	
	if tkhd = "" or tkhh = "" or tkhn = "" then
		n = "  select to_char(add_months(to_date('01/'||to_char(sysdate,'mm/yyyy'),'dd/mm/yyyy'),-1),'dd/mm/yyyy') tkhd,"
		n = n & " to_char(sysdate,'dd/mm/yyyy')tkhh from dual"
		set sn = objconn.execute(n)
		
		'if tkhd = "" then tkhd = sn("tkhd")
		'if tkhh = "" then tkhh = sn("tkhh")
		if tkhn = "" then tkhn = sn("tkhh")
	end if
	
	if p1= "Pencarian" then
		mula
	elseif p2 = "Cetak Semula Notis" then
		mula2
	elseif p3 = "Reset" then
		p3 = ""	
	end if
	
	'================================== proses cetak =========================================
	if p5 = "Cetak" then  response.redirect "hg116c.asp?nokomd="& nokomd &"&nokomh="& nokomh &""
	
	
	'================================== Proses Notis ========================================
	bilcount = Request.form("bilrec")
	if p6 = "Proses Notis" then
		
		for i = 1 to bilcount

		hnotis = "hnotis" + cstr(i)
		hrowid = "hrowid" + cstr(i)
		hkompaun = "hkompaun" + cstr(i)
		hstatus = "hstatus" + cstr(i)
		hprint = "hprint" + cstr(i)
		hno_fail = "hno_fail" + cstr(i)
	
		fnotis = Request.form(""&hnotis&"")
		frowid = Request.form(""&hrowid&"")
	    fkompaun = Request.form(""&hkompaun&"")
		fstatus = Request.form(""&hstatus&"")
		fprint = Request.form(""&hprint&"")
		fprint = Request.form(""&hprint&"")
		hno_fail = ucase(Request.form(""&hno_fail&""))
				
		next
		p4 = "Cari" 
	end if

'***************************************** SUB KEPALA ***********************************************
	sub kepala
%>
<table width=" 100%" cellspacing=0 cellpadding=0>
<tr bgcolor="<%=color1%>"> 
<td align="center">
<input type="submit" value="Pencarian" name="B1"  style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
<input type="submit" value="Reset" name="B3"  style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
</td></tr></table>
<%	end sub		
'==============================================================================================

	Dim iPageSize,iPageCount,iPageCurrent,iRecordsShown
	Dim S
	iPageSize = 10

	If Request.QueryString("page") = "" Then
		iPageCurrent = 1
	Else
		iPageCurrent = CInt(Request.QueryString("page"))
	End If

  b4 = Request.QueryString("b2")

  if p4 = "Cari" then   
		f = " select to_char(round(to_date('"& tkhn &"','dd/mm/yyyy') - 14 ),'dd/mm/yyyy') tkhs from dual "
		Set objRsf = objConn.Execute(f)
		if objRsf.eof then
			mula
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Maaf,Tarikh Salah!"", vbInformation, ""Perhatian!"" "
			response.write "</script>"    
		else 		
			tkhs = objRsf("tkhs")			
			mula
			form
		end if	
	end if	

'========================================= SUB MULA ==============================================
	
sub mula%>	
  <table width="100%" cellpadding=0 cellspacing=0 bordercolor="#CCCCCC" bgcolor="<%=color2%>">
    
  
    <tr bgcolor="<%=color2%>" style="font-family: Trebuchet MS; font-size: 10pt;"> 
      <td width="38%" align="right">Tarikh Notis :</td>
      <td width="33%" align="left"> 
        &nbsp;<input name="tkhn" type="text" value="<%=tkhn%>" size="10" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')" onFocus="nextfield='B4';">
      </td>
      <td width="29%" align="left">&nbsp;</td>
    </tr>
    
    <tr bgcolor="<%=color2%>" style="font-family: Trebuchet MS; font-size: 10pt;"> 
      <td width="38%" align="right">Kod Daerah :</td>
      <td width="33%" align="left"> 
        &nbsp;
      <select name="daerah" onFocus="nextfield='tahun';">
        <option value="">Semua</option>
        <%if daerah <> "" then%>
        <option value="<%=daerah%>" selected>
        <%if daerah = "" then%>
        <%=daerah%>- semua
        <%elseif daerah = "04" then%>
        <%=daerah%>- SPU
        <%elseif daerah = "05" then%>
        <%=daerah%>- SPT
        <%elseif daerah = "06" then%>
        <%=daerah%>- SPS
        <%end if
		  end if%> 
        </option>
        <option value="04">04- SPU</option>
        <option value="05">05- SPT</option>
        <option value="06">06- SPS</option>
      </select>
       <input type="submit" value="Cari" name="B4"  style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold" onFocus="nextfield='done';">
      </td>
      <td width="29%" align="left">&nbsp;</td>
    </tr>
    
  </table>
  <%end sub			

'************************************* SUB MULA2 *********************************************
	
	sub mula2		%>
  <table width="100%" cellspacing="0" cellpadding=0>
    <tr bgcolor="<%=color2%>" style="font-family: Trebuchet MS; font-size: 10pt;"> 
      <td align="center">No Kompaun Dari 
        <input type="text" name="nokomd" size="11" value="<%=nokomd%>" maxlength="11" onFocus="nextfield='nokomh';">
        Hingga 
        <input type="text" name="nokomh" size="11" value="<%=nokomh%>" maxlength="11" onFocus="nextfield='B5';">
        <input type="submit" value="Cetak" name="B5" onFocus="nextfield='done';"  style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold" >
      </td>
    </tr>
    <script>
	document.komp.nokomd.focus()
</script>
  </table>
<%		end sub

'================================= SUB FORM ====================================================
	sub form

		d = " select rowid, no_kompaun, initcap(nama) nama,status_kompaun status, "
		d = d & " to_char(tkh_kompaun,'ddmmyyyy') tkh_kompaun, tkh_notis1,no_fail, daerah ,"
     	d = d & " akta,kesalahan,cetak_notis "
		d = d & " from kompaun.halangan "		
		d = d & " where  tkh_kompaun < to_date('"& tkhs &"','dd/mm/yyyy') and daerah like '"& daerah &"'||'%'"
		if tkhd <> "" and tkhh <> ""  then
		d = d & " and tkh_kompaun between to_date('"&tkhd&"','dd/mm/yyyy') and to_date('"&tkhh&"','dd/mm/yyyy')"
		end if
		if kompd <> ""  then
		d = d & " and no_kompaun between '"&kompd&"' and '"&komph&"' "
		end if
		d = d & " and amaun_bayar is null and status_kompaun not in ('P','B','M') "
		d = d & " order by substr(tkh_kompaun,5,4),substr(tkh_kompaun,3,2),substr(tkh_kompaun,1,2)"
		Set sd = Server.CreateObject("ADODB.Recordset")
   		
		
		'response.write d
		
		
			sd.PageSize = iPageSize
			sd.CacheSize = iPageSize
 		    sd.CursorLocation = 3
		    sd.Open d, objConn
	
			'sd.Open d, objConn, adOpenStatic
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
%><br>
  <table width="100%" align="center" cellspacing=1>
    <tr align="right" style="font-family: Trebuchet MS; font-size: 10pt;"> 
      <td colspan="3" align="left" >Jumlah Rekod : <%=kira%></td>
      <td colspan="7" > 
        <% If iPageCurrent <> 1 Then %>
        <a href="hg116.asp?page=1&bilangan=0&ms=pre&ftkhd=<%=tkhd%>&ftkhh=<%=tkhh%>&ftkhn=<%=tkhn%>&fkompd=<%=kompd%>&fdaerah=<%=daerah%>&fkomph=<%=komph%>&fp4=Cari"> 
        <img name="firstrec" border="0" src="firstrec.jpg" width="20" height="20" alt="Halaman Mula"></a> 
        <% End If %>
        <% If iPageCurrent <> 1 Then%>
        <a href="hg116.asp?page=<%= iPageCurrent - 1 %>&bilangan=<%=bil-count-iPageSize%>&ms=pre&ftkhd=<%=tkhd%>&ftkhh=<%=tkhh%>&ftkhn=<%=tkhn%>&fdaerah=<%=daerah%>&fkompd=<%=kompd%>&fkomph=<%=komph%>&fp4=Cari"> 
        <img name="previous" border="0" src="previous.jpg" width="20" height="20" alt="Rekod Sebelum"></a> 
        <% End If %>
        Halaman <%=iPageCurrent%>/ 
        <%if iPageCount=0 then%>
        1 
        <%else%>
        <%=iPageCount%> 
        <%end if%>
        <% If cint(iPageCurrent) < cint(iPageCount) Then	%>
        <a href="hg116.asp?page=<%= iPageCurrent + 1 %>&bilangan=<%=bil%>&ms=next&ftkhd=<%=tkhd%>&ftkhh=<%=tkhh%>&ftkhn=<%=tkhn%>&fkompd=<%=kompd%>&fdaerah=<%=daerah%>&fkomph=<%=komph%>&fp4=Cari"> 
        <img name="next" border="0" src="next.jpg" width="20" height="20" alt="Rekod Seterusnya"></a> 
        <% End If 
	  If cint(iPageCurrent) < cint(iPageCount) Then
	  bil = (iPageCount - 1) * iPageSize %>
        <a href="hg116.asp?page=<%=iPageCount %>&bilangan=<%=bil%>&ms=next&ftkhd=<%=tkhd%>&ftkhh=<%=tkhh%>&ftkhn=<%=tkhn%>&fkompd=<%=kompd%>&fdaerah=<%=daerah%>&fkomph=<%=komph%>&fp4=Cari"> 
        <img name="lastrec" border="0" src="lastrec.jpg" width="20" height="20" alt="Halaman Akhir"></a> 
        <% End If %>
      </td>
    </tr>
    <tr bgcolor="<%=color1%>" align="center" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td width="55">Bil</td>
      <td width="117">Akta/UUK</td>
      <td width="117">Kesalahan</td>
      <td width="95">Daerah</td>
      <td width="176">No Kompaun</td>
      <td width="375">Nama</td>
      <td width="154">Tarikh Kompaun</td>
      <td width="154">Tarikh Notis</td>
      <td width="117">Cetakan</td>
    </tr>
    <% 	bil = 0
		ctrz = 0
	
		bilangan=Request.QueryString("bilangan")
		ms=Request.QueryString("ms")
		page = Request.QueryString("page")
	
		if page = "" or page = 1 then
			tot = 0
		else
			tot = (page-1)*20
		end if	

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
		tot = cdbl(tot) + 1
		hno_fail = sd("no_fail")
	%>
    <tr bgcolor="<%=color2%>"  style="font-family: Trebuchet MS; font-size: 10pt;"> 
      <td width="55" align="center"><%=tot%></td>
      <td width="117" align="center"><%=sd("akta")%></td>
      <td width="117" align="center"><%=sd("kesalahan")%> 
        <input type="hidden" name="ftnotis2<%=bil%>" value="<%'=sd("tarikh_notis2")%>" >
      </td>
      
      <td width="95" align="center"><%=sd("daerah")%>
      </td>

      <td width="176" align="center"><%=sd("no_kompaun")%></td>
      <td width="375"><%=sd("nama")%></td>
      <td width="154" align="center"><%=sd("tkh_kompaun")%></td>
       <td width="154" align="center"><%=sd("tkh_notis1")%></td>
       <td width="117"  align="center"> 
        <input type="checkbox" name="hprint<%=bil%>" value='Y' <% if sd("cetak_notis")="Y" then %>checked <%end if %>>
        <input type="hidden" name="hrowid<%=bil%>" value="<%=sd("rowid")%>" >
        <input type="hidden" name="hkompaun<%=bil%>" value="<%=sd("no_kompaun")%>">
        <input type="hidden" name="hstatus<%=bil%>" value="<%=sd("status")%>" >
        
      </td>
    </tr>
    <%	iRecordsShown = iRecordsShown + 1
		count = count + 1		
		sd.MoveNext			
  		Loop				%>
  </table>  
<table width ="100%" align="center">
<tr>
<td width="50%" height="21" align="right">
<input type="hidden" name="bilrec" value="<%=bil%>">
<input type="hidden" name="tkhs" value="<%=tkh%>" >
</td>
<td width="50%" height="21" align="left">
<input type="submit" value="Cetak" name="B7"  style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold" onClick="this.form.action='hg112c1.asp?notis=hg112.asp';">
</td>
</tr></table>
<%		end if
		end if		
	end sub
%>
</form>
</body>