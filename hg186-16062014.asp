<%Response.Buffer = True%>
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>
<script language="Javascript">
nextfield = "tkh1";
</script>
</head> 
<body>
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg186.asp"> 
 <%	 
   p = Request.form("b")
   p1 = Request.form("b1")
   tkh1 = Request.form("tarikh")
   tkh2 = Request.form("tarikh1")
   
   if tkh2 = "" then
   		f = " select '01/'||to_char(sysdate,'mm/yyyy') as tkh1, "
		f = f & " to_char(sysdate,'dd/mm/yyyy') as tkh2 from dual "
   		Set sf = objConn.Execute(f)
		tkh1 = sf("tkh1")	
   		tkh2 = sf("tkh2")
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
      <td align="center">Tarikh  
        <input type="text" name="tarikh" size="10" value="<%=tkh1%>" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')" onFocus="nextfield='tkh2';">
        Hingga: 
        <input type="text" name="tarikh1" size="10" value="<%=tkh2%>" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')" onFocus="nextfield='b';">
        <input type="submit" value="Cari" name="b" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold" onFocus="nextfield='done';">
      </td>
    </tr>
  </table>
 <%   
   '==================================== PROSES CARI =====================================================
	
	if p = "Cari" then
		f = " select to_char(round(to_date('"& tkh2 &"','dd/mm/yyyy') - 14 ),'dd/mm/yyyy') tkhs from dual "
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
		d = " select rowid,no_kompaun,initcap(nama) nama,tkh_undang,no_akaun,tempat,tempat1,tkh_kompaun, "
		d = d & " to_char(tkh_notis1,'dd/mm/yyyy')tkh_notis3,akta,kesalahan "
		d = d & " from kompaun.halangan "
		d = d & " where tkh_undang between to_date('"& tkh1 &"','dd/mm/yyyy') "
		d = d & " and  to_date('"& tkh2 &"','dd/mm/yyyy') and status_kompaun = 'M' order by no_kompaun "
		Set sd = objConn.Execute(d)		
		'response.write (d)
	 if sd.eof then 
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Maaf,Tiada Rekod!"", vbInformation, ""Perhatian!"" "
		response.write "</script>"   
	 else 		
%><br>
  <table width="100%" align="center" cellspacing="1">
    <tr bgcolor="<%=color1%>" align="center" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td width="3%">Bil</td>
      <td width="9%">No Akaun</td>
      <td width="9%">No Kompaun</td>
      <td width="9%">Tkh Kompaun</td>
      <td width="25%">Nama</td>
      <td width="20%">Tempat Kesalahan</td>
      <td width="8%">Akta / UUK</td>
      <td width="8%">Kesalahan</td>
      <td width="12%">Tarikh Notis</td>
      <td width="12%">Tarikh Undang-undang</td>
    </tr>
    <% 	bil = 0  	
 	Do while not sd.EOF
   	bil = bil + 1
%>
    <tr bgcolor="<%=color2%>" align="center" style="font-family: Trebuchet MS; font-size: 10pt;"> 
      <td width="3%"><%=bil%></td>
      <td width="9%"><%=sd("no_kompaun")%></td>
      <td width="9%"><%=sd("no_akaun")%></td>
      <td width="9%"><%=sd("tkh_kompaun")%></td>
      <td width="25%"><div align="left"><%=sd("nama")%></div></td>
      <td width="20%"><%=sd("tempat")%><%=sd("tempat1")%></td>
      <td width="8%"><%=sd("akta")%></td>
      <td width="8%"><%=sd("kesalahan")%></td>
      <td width="12%"><%=sd("tkh_notis3")%></td>
      <td width="12%"><%=sd("tkh_undang")%></td>
      <input type="hidden" name="frowid<%=bil%>" value="<%=sd("rowid")%>" >
    </tr>
    <%	sd.MoveNext			
  		Loop	%>
  
  </table>  
<input type="hidden" name="bilrec" value="<%=bil%>" >
<%	end if
	end sub
%>
</form>
</body>