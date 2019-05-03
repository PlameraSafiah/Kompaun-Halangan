<%Response.Buffer = True%>
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Senarai Ke Jabatan Undang²</title>
<script language="Javascript">
nextfield = "b";
</script>
</head> 
<body>
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg113.asp"> 
 <%	 
   p = Request.form("b")   
   bilcount= ""
   mula
  '==================================== PROSES Hantar =====================================================
	
	if p = "Hantar" then Hantar
		 
  '============================================ proses Hantar ============================================
  	bilcount = Request.form("bilrec")
	
	if bilcount <> "" and p <> "Hantar" then 	
		for i = 1 to bilcount
		
			ftkhn = "ftkhn"+ cstr(i)
			frowid = "frowid" + cstr(i)
			b1 = "b1" + cstr(i)
		
			htkhn = Request.form(""&ftkhn&"")	
			hrowid = Request.form(""&frowid&"")
			b1 = Request.form(""&b1&"")

		if b1 = "Simpan" then 
		
	 y = " select 'x' from dual "
	 y = y & " where to_date(to_date('"&htkhn&"','dd/mm/yyyy'),'dd-mon-yyyy') > "
	 y = y & " to_date(sysdate,'dd-mon-yyyy') "
	 set sy = objconn.execute(y)
	 
	 if not sy.eof then
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Maaf, Tarikh Notis Lebih Besar"" + vbNewline + ""        Dari Tarikh Hari Ini"", vbInformation, ""Perhatian!"" "
		response.write "</script>"		
	else	
			r = " update kompaun.halangan set tkh_notis1 = to_date('"&htkhn&"','dd/mm/yyyy') "
			r = r & " where rowid = '"& hrowid &"' "
			Set rr = objConn.Execute(r)	
		end if
	end if
		next		
		Hantar
	end if
	
	sub mula
%> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td align="center">Input Tarikh Notis 
        <input type="submit" value="Hantar" name="b" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold" onFocus="nextfield='done';">
      </td>
    </tr>
  </table>
 <%  end sub
 '============================================== SUB Hantar ====================================
	  sub Hantar
		d = " select rowid,no_kompaun,no_akaun,initcap(nama) nama,"
		d = d & " to_char(tkh_kompaun,'dd/mm/yyyy')tkh_kompaun,no_fail "
		d = d & " from kompaun.halangan "
		d = d & " where cetak_notis = 'Y' and status_kompaun = 'N' "
		d = d & " and tkh_notis1 is null order by no_kompaun "
		Set sd = objConn.Execute(d)		
		
	 if sd.eof then 
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Maaf,Tiada Rekod!"", vbInformation, ""Perhatian!"" "
		response.write "</script>"   
	 else 		
%><br>
  <table width="100%" align="center" cellspacing="1">
    <tr bgcolor="<%=color1%>" align="center" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td width="4%">Bil</td>
      <td width="11%">No Akaun</td>
      <td width="11%">No Kompaun</td>
      <td width="27%">Nama</td>
      <td width="23%">No Fail</td>
      <td width="13%">Tkh Kompaun</td>
      <td width="11%">Tkh Notis</td>
      <td width="11%">Proses</td>
    </tr>
    <% 	bil = 0  	
 	Do while not sd.EOF
   	bil = bil + 1
%>
    <tr bgcolor="<%=color2%>" align="center" style="font-family: Trebuchet MS; font-size: 10pt;"> 
      <td width="4%"><%=bil%></td>
      <td width="11%"><%=sd("no_akaun")%></td>
      <td width="11%"><%=sd("no_kompaun")%></td>
      <td width="27%"  align="left"><%=sd("nama")%></td>
      <td width="23%"  align="left"><%=sd("no_fail")%></td>
      <td width="13%"><%=sd("tkh_kompaun")%></td>
      <td width="11%"> 
        <input type="text" name="ftkhn<%=bil%>" size="10" value="<%=htkhn%>" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')" onFocus="nextfield='tkhh';" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
      </td>
      <td width="11%">
        <input type="submit" value="Simpan" name="b1<%=bil%>" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold" onFocus="nextfield='done';">
      </td>
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