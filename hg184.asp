<% Response.Buffer = True %>
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<script language="javascript">
	
	function invalid_tiada(d)
	{
		alert(d+" Tiada Rekod ");
		return(true);
	}
</script>

</head>
<body>
<!-- '#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg184.asp" >
<%	response.cookies("amenu") = "hg184.asp" 

	proses = Request.form("b")
	proses2   = request.form("breset")
	p2 = request.form("b2")
	tahund = request.form("tahund")
	thnsms = year(date)

   '************ proses reset *****************
	if proses2 = "Reset" then
	tahund = ""
	 end if

		
   '*********** proses cari **************
	'if p2 = "Cetak" then response.redirect "hg184c.asp?tahund="&tahund&""
	if p2 = "Cetak" then
	if tahund = ""  then 
		response.write "<script language = ""vbscript"">"
		response.write " MsgBox ""Sila Pilih Tahun!"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
	else

	ss = " select 'x' from kompaun.halangan "
	ss = ss & " where to_char(tkh_kompaun,'yyyy') = '"&tahund&"' and status_kompaun='N' and rownum=1 "
	set objRss = objconn.execute(ss)		

	 if objRss.eof then
        	response.write "<script language=""javascript"">"
       		response.write "var timeID = setTimeout('invalid_tiada("" "");',1)"
        	response.write "</script>"
        	'response.end
	else
	 response.redirect "hg183c.asp?tahund="&tahund&""
	end if
	end if
	end if

%>
  <table bgcolor="<%=color1%>" width="86%" align="center" cellpadding="0" cellspacing="1" border="0" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
    <tr align="center"> 
      <td>Tahun   :  
        <select name="tahund" size="1" id="tahund" style="font-family: Trebuchet MS; font-size: 10pt;" onkeydown="if(event.keyCode==13) event.keyCode=9;">
          <option selected value="">[Pilih Tahun]</option>
          <%	if tahund <> "" then  %>
          <option selected value="<%=tahund%>"><%=tahund%></option>
          <%   
	  		for h = 2000 to thnsms %>
          <option value="<%=h%>"><%=h%></option>
          <% next
			
        else	
				for k = 2000 to thnsms	%>
          <option value="<%=k%>"><%=k%></option>
          <%	next
		end if	%>
        </select>        &nbsp;
		<input type="hidden" value="<%=i%>" name="tahun">
        <input type="submit" value="Cari" name="b" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
        <input type="submit" value="Cetak" name="b2" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">              
        <input type="submit" name="breset" value="Reset" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold"></td>
    </tr>
<script>
	document.komp.tahund.focus();
</script>
<%
	if proses = "Cari" then
	if tahund = "" then 
	response.write "<script language = ""vbscript"">"
	response.write " MsgBox ""Sila Masukkan Tahun!!"", vbInformation, ""Perhatian!"" "
	response.write "</script>"
	response.end
	end if

	ss = " select 'x' from kompaun.halangan "
	ss = ss & " where to_char(tkh_kompaun,'yyyy') = '"&tahund&"' and status_kompaun='N' and rownum=1 "
	set objRss = objconn.execute(ss)		

	 if objRss.eof then
        	response.write "<script language=""javascript"">"
       		response.write "var timeID = setTimeout('invalid_tiada("" "");',1)"
        	response.write "</script>"
        	response.end
	 end if
	satu
	sub satu %> 
</table>
	  <%
			end sub 
			
		r = " select nvl(count(*),0) kira, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'01','1','0')),0)bulan1, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'02','1','0')),0)bulan2, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'03','1','0')),0)bulan3, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'04','1','0')),0)bulan4, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'05','1','0')),0)bulan5, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'06','1','0')),0)bulan6, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'07','1','0')),0)bulan7, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'08','1','0')),0)bulan8, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'09','1','0')),0)bulan9, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'10','1','0')),0)bulan10,"
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'11','1','0')),0)bulan11,"
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'12','1','0')),0)bulan12 "
		r = r & " from kompaun.halangan "
		r = r & " where to_char(tkh_kompaun,'yyyy')='"&tahund&"'"
		r = r & " and status_kompaun='N' "
		Set rsr = objConn.Execute(r)		%>
<br>
<table width="100%" cellspacing="1" >
      <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold; color:yellow;">
        <td width="19%" align="center">PERKARA</td>
        <td align="center">Jan</td>
        <td align="center">Feb</td>
        <td align="center">Mac</td>
        <td align="center">Apr</td>
        <td align="center">Mei</td>
        <td align="center">Jun</td>
        <td align="center">Jul</td>
        <td align="center">Ogs</td>
        <td align="center">Sep</td>
        <td align="center">Oct</td>
        <td align="center">Nov</td>
        <td align="center">Dec</td>
        <td align="center">Jum</td>
      </tr>
    <%  	if not rsr.eof then 
			  kira = cdbl(rsr("kira"))
			end if
    %>
      <tr bgcolor="#CCCCCC" style="font-family: Trebuchet MS; font-size: 10pt; " >
        <td bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold; color:yellow;">Kompaun MPSP 303 </td>
        <td align="center"><%if cdbl(rsr("bulan1")) > 0 then%><%=rsr("bulan1")%><%else%>&nbsp;<%end if%><br>		</td>
        <td align="center"><%if cdbl(rsr("bulan2")) > 0 then%><%=rsr("bulan2")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan3")) > 0 then%><%=rsr("bulan3")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan4")) > 0 then%><%=rsr("bulan4")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan5")) > 0 then%><%=rsr("bulan5")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan6")) > 0 then%><%=rsr("bulan6")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan7")) > 0 then%><%=rsr("bulan7")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan8")) > 0 then%><%=rsr("bulan8")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan9")) > 0 then%><%=rsr("bulan9")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan10")) > 0 then%><%=rsr("bulan10")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan11")) > 0 then%><%=rsr("bulan11")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan12")) > 0 then%><%=rsr("bulan12")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("kira")) > 0 then%><%=rsr("kira")%><%else%>&nbsp;<%end if%></td>
      </tr>
    </table>	
<%	end if %>
</form>
</body>
</html>