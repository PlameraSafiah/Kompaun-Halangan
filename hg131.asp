<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Batal Kompaun</title>
<SCRIPT LANGUAGE="JavaScript">
nextfield = "kompaun";
function check(f){

if (f.kompaun.value==""){
alert("Sila Masukkan No Kompaun!");
f.kompaun.focus();
return false;}

}
</script>
</head>
<body>
<!-- '#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg131.asp" >
  <%response.cookies("amenu") = "hg131.asp" 
   
   gnop = request.cookies("gnop")
   p1 = Request.form("B1")
   p2 = Request.form("B2")
   p3 = Request.form("B3")
   kompaun = request.form("kompaun")
   akaun = request.form("akaun")
   batal = request.form("batal")
   tbatal = request.form("tbatal")
   tkh_batal = request.form("tkh_batal")
   pembatal = request.form("pembatal")
   butir = ucase(request.form("butir"))
   butir = replace(butir,"'","''")   
   
    '=====================================Proses RESET  =======================================
  	if p3 = "Reset" then
		kompaun = ""
  		response.redirect "hg131.asp"
  	end if
	
	'=================	
		mula
	'====================================== if click Cari ====================================
	
	if p1 = "Cari" then
	
		a = " select amaun_bayar from kompaun.halangan where (no_kompaun = '"& kompaun &"' or no_akaun= '"& akaun &"')"
		a = a & " and amaun_bayar  > 0  "
		set sa = objconn.execute(a)
		
		if not sa.eof then
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Kompaun Telah Dibayar"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
		else
		 papar
		end if
	 end if
	 
	'======================================= process simpan =================================  
	
	if p2 = "Simpan" then
	tkompaun = request.form("tkompaun")
	
	 yy = " select 'x' from dual "
	 yy = yy & " where to_date(to_date('"&tkh_batal&"','dd/mm/yyyy'),'dd-mon-yyyy') < "
	 yy = yy & " to_date(to_date('"&tkompaun&"','dd/mm/yyyy'),'dd-mon-yyyy') "
	 set syy = objconn.execute(yy)
	 
	 if not syy.eof then	
 		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Tarikh Batal Lebih Kecil "" + vbNewline + "" Daripada Tarikh Kompaun"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
    else
		
	 y = " select 'x' from dual "
	 y = y & " where to_date(to_date('"&tkh_batal&"','dd/mm/yyyy'),'dd-mon-yyyy') > "
	 y = y & " to_date(sysdate,'dd-mon-yyyy') "
	 set sy = objconn.execute(y)
	 
	 if not sy.eof then		
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Maaf, Tarikh Batal Lebih Besar"" + vbNewline + ""        Dari Tarikh Hari Ini"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
		response.end
						
		else
			if batal = "B"  then
			if tkh_batal = "" then
					
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Sila Masukkan Tarikh Batal"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
			
			elseif tkh_batal <> "" then

				f = " update kompaun.halangan set status_kompaun = 'B', no_resit = 'BATAL', "
				f = f & " tkh_batal = to_date('"& tkh_batal &"','dd/mm/yyyy'), "
				f = f & " dibatal_oleh = '"&pembatal&"' "
				f = f & " where no_kompaun = '"& kompaun &"' or no_akaun= '"& akaun &"'"			
				Set sf = objConn.Execute(f)
				
				j = " select * from kompaun.batal_kompaun where no_kompaun = '"& kompaun &"' or no_akaun= '"& akaun &"'"
				Set sj = objConn.Execute(j)
				
				if sj.eof then	
					k = " insert into kompaun.batal_kompaun(no_kompaun,no_akaun, siri, catatan) values "
					k = k & " ('"& kompaun &"','"& akaun &"', '"& pembatal &"', '"& butir &"') "
					Set k = objConn.Execute(k)
				else	
					 m = " update kompaun.batal_kompaun set siri = '"& pembatal &"', catatan = '"& butir &"' "
					 m = m & " where no_kompaun = '"& kompaun &"' or no_akaun= '"& akaun &"'"
					 Set m = objConn.Execute(m)
				end if
				end if	 
			
			else
				if batal = "T" then
				
				g = " update kompaun.halangan set status_kompaun = 'I', no_resit = null, "
				g = g & " tkh_batal = null "
				g = g & " where no_kompaun = or no_akaun= '"& akaun &"'"			
				Set g = objConn.Execute(g)
				
				p = " delete kompaun.batal_kompaun where no_kompaun = '"& kompaun &"' or no_akaun= '"& akaun &"'"
				Set p = objConn.Execute(p)
		
				end if	
			end if
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Data Disimpan"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
		end if
	end if
	papar
	end if
	 
	 '======================================== sub mula ======================================	
	sub mula	%>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td width="43%" align="right">No Akaun</td>
      <td width="57%"><input type="text" name="akaun" size="15" value="<%=akaun%>" maxlength="13" onFocus="nextfield='B1';">
       atau 
        </td>
         </tr>
        <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow"> 
      <td width="43%" align="right">No Kompaun</td>
      <td width="57%"><input type="text" name="kompaun" size="15" value="<%=kompaun%>" maxlength="11" onFocus="nextfield='B1';">
        <input type="submit" value="Cari" name="B1" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
        </td>
    </tr>
  </table>
  <%	end sub  
'===================================== sub papar ===========================================
 	sub papar	
		
		d = " select initcap(nama)nama, akta, kesalahan, to_char(tkh_kompaun,'dd/mm/yyyy') as tkh_kompaun, "
		d = d & " to_char(masa) masa, initcap(tempat)tempat,to_char(tkh_batal,'dd/mm/yyyy') as tkh_batal, "
		d = d & " status_kompaun from kompaun.halangan "
		d = d & " where no_kompaun = '"& kompaun &"' or no_akaun= '"& akaun &"'"
		Set sd = objConn.Execute(d)	
		
	if sd.eof then
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Maaf, Tiada rekod"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
	else
		nama = sd("nama")
		akta = sd("akta")
		salah = sd("kesalahan")
		tkompaun = sd("tkh_kompaun")
		masa = sd("masa")
		tempat = sd("tempat")
		tkh_batal = sd("tkh_batal")
		status_notis = sd("status_kompaun")
				
		p = " select initcap(keterangan) keterangan from kompaun.akta "
        p = p & " where kod = '"& akta &"' "
		Set sp = objConn.Execute(p)
			
		if not sp.eof then
			jenis_akta = sp("keterangan")
  		end if
 			
		r = " select initcap(keterangan||' '||keterangan2) jenis_salah from kompaun.butir_kesalahan "
        r = r & " where kod = '"& salah &"' and akta = '"&akta&"' "
		set sr = objconn.execute(r)
			
		if not sr.eof then
		  jenis_salah = sr("jenis_salah")
        end if
		
		q = " select initcap(catatan)catatan,siri "
		q = q & " from kompaun.batal_kompaun where no_kompaun = '"&kompaun&"' "
		set sq = objconn.execute(q)
		
		if not sq.eof then
			butir = sq("catatan")
			pembatal = sq("siri")
		else 
			butir = ""
			pembatal = ""
		end if
%>
<br>  
  <table width="80%" align="center" cellspacing=1 bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt;">
    <tr> 
      <td width="21%" >Nama</td>
      <td width="79%" bgcolor="<%=color2%>"><%=nama%></td>
    </tr>
    <tr> 
      <td width="21%" >Akta 
        </td>
      <td width="79%" bgcolor="<%=color2%>"> 
        <%=akta%> -- <%=jenis_akta%></td>
    </tr>
    <tr> 
      <td width="21%">Butir 
        Kesalahan</td>
      <td width="79%" bgcolor="<%=color2%>"><%=salah%> 
        -- <%=jenis_salah%></td>
    </tr>
    <tr> 
      <td width="21%">Tarikh 
        Kompaun</td>
      <td width="79%" bgcolor="<%=color2%>"> 
        <%=sd("tkh_kompaun")%> 
		<input type="hidden" name="tkompaun" value="<%=tkompaun%>" ></td>
    </tr>
    <%	masa = sd("masa")
  	
  		if masa = 24 then
   			waktu = 12
   			ampm = "AM"
   		else
   			if masa >=  13 then
   				waktu = masa - 12
   				ampm = "PM"
   			
   			else
   				if masa < 13.00 or masa = 12 then
   				waktu = masa
   				ampm = "AM"	
   			end if
   			end if
   			end if
  
  %>
    <tr bgcolor="<%=color1%>"> 
      <td width="21%" >Masa/Waktu</td>
      <td width="79%" bgcolor="<%=color2%>"><%=FormatNumber(masa,2)%><%=ampm%></td>
    </tr>
    <tr > 
      <td width="21%">Tempat</td>
      <td width="79%" bgcolor="<%=color2%>"><%=tempat%> &nbsp;</td>
    </tr>
    <tr> 
      <td width="21%">Batal ( B / T )</td>
      <td width="79%" bgcolor="<%=color2%>"> 
       <input type="radio" name="batal" value="B" <%if status_notis = "B" then%> checked <% end if %> 
	onClick="B=1;document.komp.tkh_batal.focus();">Batal
        <input type="radio" name="batal" value="T" <%if status_notis <> "B" then%> checked <%end if%>
	onClick="B=0;document.komp.tkh_batal.value='';">Tidak </td>
    </tr>
    <tr> 
      <td width="21%" >Tarikh Batal</td>
      <td bgcolor="<%=color2%>" width="79%"> 
        <input type="text" name="tkh_batal" size="10" value="<%=tkh_batal%>" maxlength="10" onKeyDown="if(event.keyCode==13) event.keyCode=9;" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
        &nbsp; ( 'dd/mm/yyyy' )</td>
    </tr>
     <tr> 
      <td width="21%">Dibatal Oleh</td>
      <td width="79%" bgcolor="<%=color2%>"> 
        <input type="radio" name="pembatal" value="1" <%if pembatal ="1" then%>checked<% end if%> onKeyDown="if(event.keyCode==13) event.keyCode=9;">
        1. YDP 
        <input type="radio" name="pembatal" value="2" <%if pembatal ="2" then%>checked<% end if%> onKeyDown="if(event.keyCode==13) event.keyCode=9;">
        2. SU 
        <input type="radio" name="pembatal" value="3" <%if pembatal ="3" then%>checked<% end if%> onKeyDown="if(event.keyCode==13) event.keyCode=9;">
        3. Pengarah </td>
    </tr>  
    <tr> 
      <td width="21%">Catatan</td>
      <td width="79%" bgcolor="<%=color2%>"> 
        <input type="text" name="butir" value="<%=butir%>" size="70" maxlength="80" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
        </td>
    </tr>
    <tr> 
      <td colspan="2" align="center"> 
          <input type="submit" value="Simpan" name="B2" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
          <input type="submit" value="Reset" name="B3" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
      </td>
    </tr>
  </table>
<%	end if	
	end sub	%>
</form>
</body>
</html>
