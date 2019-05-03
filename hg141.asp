<%Response.Buffer = True%>
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Senarai Ke Jabatan Undang²</title>
<script language="Javascript">
nextfield = "tkhd";
</script>
</head> 
<body>
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg141.asp"> 
 <%	 
   p = Request.form("b")
   p1 = Request.form("b1")
   tkhd = Request.form("tkhd")
   tkhh = Request.form("tkhh")
   
   if tkhh = "" then
   		f = " select '01/'||to_char(sysdate,'mm/yyyy') as tkhd, "
		f = f & " to_char(sysdate,'dd/mm/yyyy') as tkhh from dual "
   		Set sf = objConn.Execute(f)
		tkhd = sf("tkhd")	
   		tkhh = sf("tkhh")
	end if	
	 
	 h = " select to_char(sysdate,'dd/mm/yyyy')harini from dual "
	 set sh = objconn.execute(h)
	 harini = sh("harini")
	 
  '============================================ proses Hantar ============================================
  	bilcount = Request.form("bilrec")	
		if p1 = "Proses" then	
		for i = 1 to bilcount
		
			fhantar = "fhantar"+ cstr(i)
			frowid = "frowid" + cstr(i)
		
			hhantar = Request.form(""&fhantar&"")	
			hrowid = Request.form(""&frowid&"")

		if hhantar = "Y" then 	
			r = " update kompaun.halangan set status_kompaun ='M', "
			r = r & " tkh_undang = to_date('"& harini &"','dd/mm/yyyy') "
			r = r & " where rowid = '"& hrowid &"' "
			Set rr = objConn.Execute(r)	
		end if
		next		
		p = "Cari"
	end if
%> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td align="center">Tarikh Notis Dari 
        <input type="text" name="tkhd" size="10" value="<%=tkhd%>" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')" onFocus="nextfield='tkhh';">
        Hingga: 
        <input type="text" name="tkhh" size="10" value="<%=tkhh%>" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')" onFocus="nextfield='b';">
        <input type="submit" value="Cari" name="b" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold" onFocus="nextfield='done';">
      </td>
    </tr>
  </table>
 <%   
   '==================================== PROSES CARI =====================================================
	
	if p = "Cari" then
		f = " select to_char(round(to_date('"& tkhh &"','dd/mm/yyyy') - 14 ),'dd/mm/yyyy') tkhs from dual "
		Set objRsf = objConn.Execute(f)
		
		if objRsf.eof then
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Tarikh Salah!"", vbInformation, ""Perhatian!"" "
		response.write "</script>"      
		else 		
			tkhs = objRsf("tkhs")
			cari
	 	end if
	 end if

 '============================================== SUB CARI ====================================
	  sub cari
		d = " select rowid,no_kompaun,no_akaun,initcap(nama) nama,"
		d = d & " to_char(tkh_notis1,'dd/mm/yyyy')tkh_notis3,akta,kesalahan "
		d = d & " from kompaun.halangan "
		d = d & " where tkh_notis1 between to_date('"& tkhd &"','dd/mm/yyyy') "
		d = d & " and  to_date('"& tkhs &"','dd/mm/yyyy') and status_kompaun = 'N' order by no_kompaun "
		Set sd = objConn.Execute(d)		
		
	 if sd.eof then 
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Maaf,Tiada Rekod!"", vbInformation, ""Perhatian!"" "
		response.write "</script>"   
	 else 		
%><br>
  <table width="100%" align="center" cellspacing="1">
    <tr bgcolor="<%=color1%>" align="center" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td width="3%">Bil</td>
      <td width="8%">Akta / UUK</td>
      <td width="8%">Kesalahan</td>
      <td width="9%">No Kompaun</td>
      <td width="9%">No Akaun</td>
      <td width="46%">Nama</td>
      <td width="10%">Tarikh</td>
      <td width="10%">Ke Jabatan Undang²</td>
    </tr>
    <% 	bil = 0  	
 	Do while not sd.EOF
   	bil = bil + 1
%>
    <tr bgcolor="<%=color2%>" align="center" style="font-family: Trebuchet MS; font-size: 10pt;"> 
      <td width="3%"><%=bil%></td>
      <td width="8%"><%=sd("akta")%></td>
      <td width="8%"><%=sd("kesalahan")%></td>
      <td width="9%"><%=sd("no_kompaun")%></td>
      <td width="9%"><%=sd("no_akaun")%></td>
      <td width="46%">
        <div align="left"><%=sd("nama")%></div>
      </td>
      <td width="10%"><%=sd("tkh_notis3")%></td>
      <td width="10%">
        <input type="checkbox" name="fhantar<%=bil%>" value='Y'>
      </td>
      <input type="hidden" name="frowid<%=bil%>" value="<%=sd("rowid")%>" >
    </tr>
    <%	sd.MoveNext			
  		Loop	%>
    <tr bgcolor="<%=color2%>" align="center"> 
      <td colspan="8"> 
        <input type="submit" value="Proses" name="b1" style="font-family: Trebuchet MS; 
		font-size: 8pt; font-weight: bold" onClick="return confirm('Anda Pasti Untuk Proses Rekod Ini?')">
      </td>
    </tr>
  </table>  
<input type="hidden" name="bilrec" value="<%=bil%>" >
<%	end if
	end sub
%>
</form>
</body>