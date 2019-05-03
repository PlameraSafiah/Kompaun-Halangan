<% Response.Buffer = True %>
<!-- #INCLUDE file="adovbs.inc" -->
<!--#INCLUDE FILE="halangan.inc"-->
<!--#include file="tarikh.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<script language="javascript">
<!-- Begin
nextfield = "akta";
netscape = "";
ver = navigator.appVersion; len = ver.length;
for(iln = 0; iln < len; iln++) if (ver.charAt(iln)=="(")break;
netscape = (ver.charAt(iln+1).toUpperCase()!="C");

function keyDown(DnEvents){
k = (netscape)?DnEvents.which : window.event.keyCode;
if(k==13){//enter key pressed
if (nextfield=='done') return true; //submit
else{//send focus to next box
eval('document.hg171.'+nextfield + '.focus()');
return false;
	}
  }
 }
document.onkeydown = keyDown;// work together to analyze keystrokes
if (netscape)document.captureEvents(Event.KEYDOWN|Event.KEYUP);
//End-->
</script>
</head>

<body>
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=hg171 method="POST" action="hg171.asp">
  <%	response.cookies("amenu") = "hg171.asp" 

	Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"
   	
   	p = Request.form("B1")
	p2 = Request.form("B2")
	p3 = Request.form("B3")
	p4 = Request.form("B4")
	bilrec = request.form("bilrec")
	akta = ucase(Request.form("akta"))
		
	if p3 = "Reset" then
		pg = ""
		akta = ""
	end if
	
	dakta = Request.QueryString("dakta")
	pp = Request.QueryString("p")

	if pp <> "" then
		akta = Request.QueryString("dakta")
		p = Request.QueryString("p")	
	end if
	
		 '***************** iNput rEcorD *****************
	  if p4 = "Simpan" then
	  		aktaf = ucase(request.form("aktaf"))
			fketer = ucase(request.form("fketer"))
			fketer = replace(fketer,"'","''")
			hrowid = request.form("hrowid")
			
			if aktaf = "" or fketer = "" then
				response.write "<script language=""VBScript"">"
				response.write " MsgBox ""Sila Isi Kod Dan Keterangan"", vbInformation, ""Perhatian!"" "
				response.write "</script>"
			else
			
			if hrowid <> "" then
			   f = " delete kompaun.akta where rowid = '"&hrowid&"' "
			   set sf = objconn.execute(f)
			end if 
			m = " select kod from kompaun.akta where kod = '"&aktaf&"'"
			set sm = objconn.execute(m)
			
			if not sm.eof then 
				response.write "<script language = ""vbscript"">"
		 		response.write " MsgBox ""Akta Telah Wujud!"", vbInformation, ""Perhatian!"" "
	     		response.write "</script>"
		 	else			
			g = " insert into kompaun.akta values('"&aktaf&"','"&fketer&"') "
			set sg = objconn.execute(g)
				aktaf = ""
				fketer = ""			
			end if
			end if
			p = "Hantar"			
	  end if				
	
		 '***************** EdIt oR deleTe RecOrd ********
	 if bilrec <> "" then

	  for i = 1 to bilrec
	    rowidf = "rowidf" + cstr(i)
		kodf = "kodf" + cstr(i)
		keterf = "keterf" + cstr(i)		
		pg = "pg" + cstr(i)
		e = "e" + cstr(i)
		h = "h" + cstr(i)
	
		xrowid = request.form (""& rowidf &"")
		xkod = request.form (""& kodf &"")
		xketer = request.form (""& keterf &"")
		pg = request.form (""& pg &"")
		e = request.form (""& e &"")
		h = request.form (""& h &"")		

		if e = "Edit" then
		   hrowid = xrowid
		   aktaf = xkod
		   fketer = xketer	
		   p = "Hantar"
		  
		elseif h = "Hapus" then
		   h = " delete kompaun.akta where rowid = '"&xrowid&"' "
	       set sh = objconn.execute(h)
		   p = "Hantar"		 
		end if		
	  next
	 end if	 
	 
	if p2 = "Cetak" then response.redirect "hg171c.asp?akta="&akta&""
%>
 <table width="100%" border="0" cellspacing="1">
    <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td width="29%" align="right"> Akta :</td>
      <td width="71%"> 
        <input type="text" name="akta" size="4" maxlength="3" value="<%=akta%>" onFocus="nextfield='B1';">
        <font face="Trebuchet MS" size="2"> <a href="javascript:void(0)" onClick="open_winakta1('hg171.akta');" onMouseOver="window.status='Senarai Akta';return true;" onMouseOut="window.status='';return true;"> 
        <input type="button" name="b" value="?" style="font-family:Trebuchet MS; font-size: 8pt;">
        </a></font><font color="red"><%if aketer <> "" then %> 
        <input type="visible" name="aketer" size="50" value="<%=aketer%>" readonly="true">
        <%end if %><input type="submit" name="B1" value="Hantar" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold" onFocus="nextfield='done';">
        <input type="submit" name="B2" value="Cetak" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold">
        <input type="submit" name="B3" value="Reset" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold">
        </font> </td>
    </tr>
    <script>
	document.hg171.akta.focus();
</script>
  </table>
  <%	Dim iPageSize,iPageCount,iPageCurrent,iRecordsShown
	Dim S
	iPageSize = 10

	If Request.QueryString("page") = "" and pg = "" Then
		iPageCurrent = 1
	Elseif pg <> "" then 
		iPageCurrent = CInt(pg)
	Elseif Request.QueryString("page") <> "" then
		iPageCurrent = CInt(Request.QueryString("page"))		
	End If

	if p = "Hantar" or dakta <> "" then	
		pg = ""	
		d = " select rowid, kod, initcap(keterangan) keterangan from kompaun.akta "
		d = d & " where kod like '"&akta&"'||'%' order by kod"
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
		end if			%>  
  <table border=0 cellPadding=1 cellSpacing=1 width="727" align="center" style="font-family: Trebuchet MS; font-size: 10pt;">
    <tr > 
      <td align="left" colspan=2>Jumlah Rekod :<%=kira%></td>
      <td align="right" colspan=4 > 
        <% If iPageCurrent <> 1 Then %>
        <a href="hg171.asp?page=1&bilangan=0&ms=pre&dakta=<%=akta%>&p=Hantar"> 
        <img name="firstrec" border="0" src="firstrec.jpg" width="20" height="20" alt="Halaman Mula"></a> 
        <% End If %>
        <% If iPageCurrent <> 1 Then%>
       	<a href="hg171.asp?page=<%= iPageCurrent - 1 %>&bilangan=<%=(iPageSize * (iPageCurrent-1))-iPageSize%>&ms=pre&dakta=<%=akta%>&p=Hantar"> 
        <img name="previous" border="0" src="previous.jpg" width="20" height="20" alt="Rekod Sebelum"></a> 
        <% End If %>
        Halaman <%=iPageCurrent%>/ 
        <%if iPageCount=0 then%>
        1 
        <%else%>
        <%=iPageCount%> 
        <%end if%>
        <% If iPageCurrent < iPageCount Then	%>
       	<a href="hg171.asp?page=<%= iPageCurrent + 1 %>&bilangan=<%=iPageSize * iPageCurrent %>&ms=next&dakta=<%=akta%>&p=Hantar"> 
        <img name="next" border="0" src="next.jpg" width="20" height="20" alt="Rekod Seterusnya"></a> 
        <% End If 
	  If iPageCurrent < iPageCount Then
	  bil = (iPageCount - 1) * iPageSize %>
        <a href="hg171.asp?page=<%=iPageCount %>&bilangan=<%=bil%>&ms=next&dakta=<%=akta%>&p=Hantar"> 
        <img name="lastrec" border="0" src="lastrec.jpg" width="20" height="20" alt="Halaman Akhir"></a> 
        <% End If %>
      </td>
    </tr>
    <tr align="center" style="color:yellow" bgcolor="<%=color1%>"> 
      <td width="34" >Bil</td>
      <td width="67" >Akta</td>
      <td width="502" >Keterangan</td>
      <td width="111" >&nbsp;</td>
    </tr>
    <tr align="center" style="color:yellow" bgcolor="<%=color1%>"> 
      <td width="34" >&nbsp;</td>
      <td width="67" > 
        <input type="text" name="aktaf" size="4" maxlength="3" value="<%=aktaf%>" onFocus="nextfield='fketer';">
      </td>
      <td width="502" > 
        <input type="text" name="fketer" size="65" maxlength="65" value="<%=fketer%>" onFocus="nextfield='B4';">
      </td>
      <td width="111" >
        <input type="submit" name="B4" value="Simpan" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold" onFocus="nextfield='done';">
	</td>
    </tr>
    <%	if bilangan = "" then
			bil = (ipagecurrent - 1) * 10
		end if		
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
		rowid = sd("rowid")
		kod = sd("kod")
		keter = sd("keterangan")
%>
    <tr align="center" bgcolor="<%=color2%>"> 
      <td width="34" ><%=bil%></td>
      <td width="67" ><%=sd("kod")%></td>
      <td align="left" width="502"><%=sd("keterangan")%></td>
      <td align="left" width="111">
        <input type="submit" name="e<%=bil%>" value="Edit" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold">
        <input type="hidden" name="rowidf<%=bil%>" value="<%=rowid%>" >
		<input type="hidden" name="kodf<%=bil%>" value="<%=kod%>" >
		<input type="hidden" name="keterf<%=bil%>" value="<%=keter%>" >
		<input type="hidden" name="pg<%=bil%>" value="<%=iPageCurrent%>" >
        <input type="submit" name="h<%=bil%>" value="Hapus" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold">
        </td>
    </tr>
 <%	iRecordsShown = iRecordsShown + 1
	count = count + 1
  	sd.MoveNext			
  	Loop	%>
  </table>
<%	end if	%> 
<input type="hidden" name="bilrec" value="<%=bil%>" >
<%	end if	%>
<input type="hidden" name="hrowid" value="<%=hrowid%>" >
</form>
</body>
</html>