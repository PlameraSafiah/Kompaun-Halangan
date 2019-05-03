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
eval('document.hg172.'+nextfield + '.focus()');
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
<form name=hg172 method="POST" action="hg172.asp">
  <%	response.cookies("amenu") = "hg172.asp" 

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
	  		fkod = request.form("fkod")
			fketer = ucase(request.form("fketer"))
			fketer = replace(fketer,"'","''")
			fketer2 = ucase(request.form("fketer2"))
			fketer2 = replace(fketer2,"'","''")
			famaun = request.form("famaun")
			hrowid = request.form("hrowid")
			
			if fkod = "" or fketer = "" then
				response.write "<script language=""VBScript"">"
				response.write " MsgBox ""Sila Isi Kod Dan Keterangan"", vbInformation, ""Perhatian!"" "
				response.write "</script>"
			else
			
			if hrowid <> "" then
			   f = " delete kompaun.butir_kesalahan where rowid = '"&hrowid&"' "
			   set sf = objconn.execute(f)
			end if 
			m = " select kod from kompaun.butir_kesalahan where kod = '"&fkod&"' and akta = '"&akta&"' "
			set sm = objconn.execute(m)
			
			if not sm.eof then 
				response.write "<script language = ""vbscript"">"
		 		response.write " MsgBox ""Kod Telah Wujud!"", vbInformation, ""Perhatian!"" "
	     		response.write "</script>"
		 	else			
			g = " insert into kompaun.butir_kesalahan(akta,kod,keterangan,keterangan2,amaun_maksima) "
			g = g & " values('"&akta&"','"&fkod&"','"&fketer&"','"&fketer2&"','"&famaun&"') "
			set sg = objconn.execute(g)
				fkod = ""
				fketer = ""
				fketer2 = ""
				famaun = ""			
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
		keterf2 = "keterf2" + cstr(i)
		amaunf = "amaunf" + cstr(i)
		pg = "pg" + cstr(i)
		e = "e" + cstr(i)
		h = "h" + cstr(i)
	
		xrowid = request.form (""& rowidf &"")
		xkod = request.form (""& kodf &"")
		xketer = request.form (""& keterf &"")
		xketer2 = request.form (""& keterf2 &"")
		xamaun = request.form (""& amaunf &"")
		pg = request.form (""& pg &"")
		e = request.form (""& e &"")
		h = request.form (""& h &"")		

		if e = "Edit" then
		   hrowid = xrowid
		   fkod = xkod
		   fketer = xketer
		   fketer2 = xketer2
		   famaun = xamaun	
		   p = "Hantar"
		  
		elseif h = "Hapus" then
		   h = " delete kompaun.butir_kesalahan where rowid = '"&xrowid&"' "
	       set sh = objconn.execute(h)
		   p = "Hantar"		 
		end if		
	  next
	 end if	 
	 
	if p2 = "Cetak" then response.redirect "hg172c.asp?akta="&akta&""
%>
 <table width="100%" border="0" cellspacing="1">
    <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td width="43%" align="right"> Akta :</td>
      <td width="57%"> 
        <input type="text" name="akta" size="4" maxlength="3" value="<%=akta%>" onFocus="nextfield='B1';">
        <font face="Trebuchet MS" size="2">
		<a href="javascript:void(0)" onClick="open_winakta1('hg172.akta');" onMouseOver="window.status='Senarai Akta';return true;" onMouseOut="window.status='';return true;"> 
        <input type="button" name="b" value="?" style="font-family:Trebuchet MS; font-size: 8pt;">
        </a> 
        <input type="submit" name="B1" value="Hantar" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold" onFocus="nextfield='done';">
        <input type="submit" name="B2" value="Cetak" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold">
        <input type="submit" name="B3" value="Reset" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold">
        </font> </td>
    </tr>
	    <script>
	document.hg172.akta.focus();
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
		if akta = "" then
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Sila Masukkan Akta!"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
			response.end 
		end if
		
		g = " select kod from kompaun.akta where kod = '"&akta&"' "
		set gg = objconn.execute(g)
		
		if gg.eof then 
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Akta Salah!"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
		else
		
		d = " select rowid, kod, initcap(keterangan) keterangan,nvl(amaun_maksima,0)amaun_maksima, "
		d = d & " initcap(keterangan2)keterangan2 "
		d = d & " from kompaun.butir_kesalahan where akta like '"&akta&"' order by kod"
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
%>  
  <table border=0 cellPadding=1 cellSpacing=1 width="727" align="center" style="font-family: Trebuchet MS; font-size: 10pt;">
    <tr > 
      <td align="left" colspan=2>Jumlah Rekod :<%=kira%></td>
      <td align="right" colspan=5 > 
        <% If iPageCurrent <> 1 Then %>
        <a href="hg172.asp?page=1&bilangan=0&ms=pre&dakta=<%=akta%>&p=Hantar"> 
        <img name="firstrec" border="0" src="firstrec.jpg" width="20" height="20" alt="Halaman Mula"></a> 
        <% End If %>
        <% If iPageCurrent <> 1 Then%>
        <a href="hg172.asp?page=<%= iPageCurrent - 1 %>&bilangan=<%=(iPageSize * (iPageCurrent-1))-iPageSize%>&ms=pre&dakta=<%=akta%>&p=Hantar"> 
        <img name="previous" border="0" src="previous.jpg" width="20" height="20" alt="Rekod Sebelum"></a> 
        <% End If %>
        Halaman <%=iPageCurrent%>/ 
        <%if iPageCount=0 then%>
        1 
        <%else%>
        <%=iPageCount%> 
        <%end if%>
        <% If iPageCurrent < iPageCount Then	%>
        <a href="hg172.asp?page=<%= iPageCurrent + 1 %>&bilangan=<%=iPageSize * iPageCurrent %>&ms=next&dakta=<%=akta%>&p=Hantar"> 
        <img name="next" border="0" src="next.jpg" width="20" height="20" alt="Rekod Seterusnya"></a> 
        <% End If 
	  If iPageCurrent < iPageCount Then
	  bil = (iPageCount - 1) * iPageSize %>
        <a href="hg172.asp?page=<%=iPageCount %>&bilangan=<%=bil%>&ms=next&dakta=<%=akta%>&p=Hantar"> 
        <img name="lastrec" border="0" src="lastrec.jpg" width="20" height="20" alt="Halaman Akhir"></a> 
        <% End If %>
      </td>
    </tr>
    <tr align="center" style="color:yellow" bgcolor="<%=color1%>"> 
      <td width="17" >Bil</td>
      <td width="85" >Kod</td>
      <td width="426" >Keterangan</td>
      <td width="76" >Amaun</td>
      <td width="107" >&nbsp;</td>
    </tr>
    <tr align="center" style="color:yellow" bgcolor="<%=color1%>"> 
      <td width="17" >&nbsp;</td>
      <td width="85" > 
        <input type="text" name="fkod" size="10" maxlength="10" value="<%=fkod%>" onFocus="nextfield='fketer';">
      </td>
      <td width="426" > 
        <input type="text" name="fketer" size="55" maxlength="70" value="<%=fketer%>" onFocus="nextfield='fketer2';">
        <input type="text" name="fketer2" size="55" maxlength="50" value="<%=fketer2%>" onFocus="nextfield='famaun';">
      </td>
      <td width="76" > 
        <input type="text" name="famaun" size="5" maxlength="5" value="<%=famaun%>" onFocus="nextfield='B4';">
      </td>
      <td width="107" > 
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
		keter2 = sd("keterangan2")
		amaun = sd("amaun_maksima")
%>
    <tr align="center" bgcolor="<%=color2%>"> 
      <td width="17" ><%=bil%></td>
      <td width="85" ><%=sd("kod")%></td>
      <td align="left" width="426"><%=sd("keterangan")%><%if keter2 <> "" then%>
	  <br><%=keter2%><%end if%></td>
      <td align="left" width="76"><%=formatnumber(sd("amaun_maksima"),2)%></td>
      <td align="left" width="107"> 
        <div align="left"><font face="Trebuchet MS" size="2"> 
          <input type="submit" name="e<%=bil%>" value="Edit" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold">
          <input type="hidden" name="rowidf<%=bil%>" value="<%=rowid%>" >
          <input type="hidden" name="kodf<%=bil%>" value="<%=kod%>" >
          <input type="hidden" name="keterf<%=bil%>" value="<%=keter%>" >
          <input type="hidden" name="keterf2<%=bil%>" value="<%=keter2%>" >
          <input type="hidden" name="amaunf<%=bil%>" value="<%=amaun%>" >
          <input type="hidden" name="pg<%=bil%>" value="<%=iPageCurrent%>" >
          <input type="submit" name="h<%=bil%>" value="Hapus" style="font-family:Trebuchet MS; font-size: 8pt; font-weight: bold">
          </font></div>
      </td>
    </tr>
    <%	iRecordsShown = iRecordsShown + 1
	count = count + 1

  	sd.MoveNext			
  	Loop
%>
  </table>
<%	end if	 %> 
<input type="hidden" name="bilrec" value="<%=bil%>" >
<%end if
  end if%>
<input type="hidden" name="hrowid" value="<%=hrowid%>" >
</form>
</body>
</html>