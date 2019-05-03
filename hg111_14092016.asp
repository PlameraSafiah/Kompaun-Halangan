<%Response.Buffer = True%>
<!--#INCLUDE FILE="halangan.inc"-->
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
nextfield = "nama";
</script>
</head>
<body bgcolor="#FFFFFF">
<!--'#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg111.asp"  > 
<%response.cookies("amenu") = "hg111.asp" 
  
	p = Request.form("B")
	p1 = Request.form("B1")
	p2 = Request.Form("B2")
	p3 = Request.Form("B3")	
	p4 = Request.Form("B4")	
	
	kompaun = Request.Form("kompaun")
	nama = ucase(Request.Form("nama"))
	nama = replace(nama,"'","''")
	kp = Request.Form("kp")
	alamat1 = ucase(Request.Form("alamat1"))
	alamat1 = replace(alamat1,"'","''")
	alamat2 = ucase(Request.Form("alamat2"))
	alamat2 = replace(alamat2,"'","''")
	alamat3 = ucase(Request.Form("alamat3"))
	alamat3 = replace(alamat3,"'","''")
	kenderaan = ucase(request.form("kenderaan")) 
	cukai = request.form("cukai")
	kontena = ucase(request.form("kontena"))
	kenderaan_berat = Request.Form("kenderaan_berat")
	tempat = ucase(request.form("tempat"))
	tempat = replace(tempat,"'","''")
	tempat1 = ucase(request.form("tempat1"))
	tempat1 = replace(tempat1,"'","''")
	akta = request.form("akta")
	salah = request.form("salah")
	salah = replace(salah,"'","''")
	butirsalah = ucase(request.form("butirsalah"))
	butirsalah = replace(butirsalah,"'","''")
	tkh_kompaun = Request.Form("tkh_kompaun")
	waktu = Request.Form("fmasa")
	ampm = Request.Form("ampm")
	no_pekerja = Request.Form("no_pekerja")
	amaun = Request.Form("amaun")
	dae = request.form("dae")

	'## if click Semula ##	
	if p2 = "Semula" then
	response.Redirect "hg111.asp"
	end if
	
	mula
		
	if p4 = "Hapus" then
	
	rowid = request.form("rowid")
	kompaunh = request.form("kompaunh")
	ah = " delete kompaun.halangan where no_kompaun = '"& kompaunh &"' and rowid = '"& rowid &"'"
	set sah = objconn.execute(ah)
	end if
	
'============================== if click button hantar ======================================

	if p = "Hantar" and kompaun <> "" then			
			
'============================== select sekiranya dah bayar ==================================

		my = " select 'x' from kompaun.halangan "
 	    my = my & " where tkh_bayar is not null "
		my = my & " and no_akaun = '"& noakaun &"' "
		Set Rsmy = objConn.Execute(my)
        
        if not Rsmy.eof then
          response.write "<script language = ""vbscript"">"
		  response.write " MsgBox ""Kompaun Sudah DiJelaskan!"", vbInformation, ""Perhatian!"" "
		  response.write "</script>"   
        end if		
		papar
	end if


'============================ if click Cetak Salinan ========================================
	if p3 = "Cetak Salinan" then	
		rowid = request.form("rowid")
		no_akaun = request.form("no_akaun")	
		kompaun = request.form("kompaunh")
		response.redirect "hg111c.asp?no="&no_akaun&"&ko="&kompaun&""
	end if
	
'====================================== if click simpan =====================================
	
	if p1 = "Simpan" then  
	
	if kompaun = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Masukkan No Kompaun"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.kompaun.focus();</script><%
		response.end
	end if
	
	if nama = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Masukkan Nama"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.nama.focus();</script><%
		response.end
	end if
	
	if alamat1 = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Masukkan Alamat"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.alamat1.focus();</script><%
		response.end
	end if
	
	if akta = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Masukkan Akta"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.akta.focus();</script><%
		response.end
	end if
	
	if salah = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Masukkan Kesalahan"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.salah.focus();</script><%
		response.end
	end if
	
	
	if tkh_kompaun = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Masukkan Tarikh Kompaun"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.tkh_kompaun.focus();</script><%
		response.end
	end if
	
	if waktu = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Masukkan Masa Kesalahan"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.fmasa.focus();</script><%
		response.end
	end if
	
	if tempat = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Masukkan Tempat Kesalahan"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.tempat.focus();</script><%
		response.end
	end if
	
	if dae = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Pilih Daerah"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.dae.focus();</script><%
		response.end
	end if
	
	if no_pekerja = "" then
		papar
		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Sila Masukkan No Pekerja Pengeluar Notis"", vbInformation, ""Perhatian!"" "
		response.write "</script>"	%>
		<script language="javascript">komp.no_pekerja.focus();</script><%
		response.end
	end if	
	
	b = " select replace('"&kontena&"',' ','')kontena,replace('"&kenderaan&"',' ','')kenderaan from dual "
	set sb = objconn.execute(b)
	
	if not sb.eof then
		kontena = sb("kontena")
		kenderaan = sb("kenderaan")
	end if
 			
  		p = " select kod from kompaun.akta where kod = '"& akta &"' "
		Set sp = objConn.Execute(p)		
		
		if sp.eof then
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Akta Yang Dipilih Salah"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
		else		
		
		q = " select kod,amaun_maksima maksima from kompaun.butir_kesalahan where kod = '"&salah&"' "
		q = q & " and akta = '"&akta&"' "
		Set sq = objConn.Execute(q)
		
		if sq.eof then
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Kod Kesalahan Salah"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
		else
				 		
		maksima = sq("maksima")
		
		r = " select initcap(nama) nama from payroll.paymas where no_pekerja = '"&no_pekerja&"' "
		r = r & " union "
		r = r & " select initcap(nama) nama from payroll.paymas_sambilan where no_pekerja = '"&no_pekerja&"' "
		Set sr = objConn.Execute(r)
		
		if sr.eof then
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""No Pekerja Yang Dipilih Salah"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
		else 		
  		
  		if waktu > 24 then
  			response.write "<script language=""javascript"">"
       		response.write "var timeID = setTimeout('invalid_masa(""  "");',1) "
       		response.write "</script>"
		else	

	
		if ampm = "PM" then
			if waktu <= 12 then
				masa1 = 12 + waktu
			else
				masa1 = waktu
			end if	
		else
			if waktu >= 12.01 and waktu <=12.59 then
				masa1 = waktu - 12		
			elseif waktu < 12 then
				masa1 = waktu
			else
				masa1 = waktu
				ampm = "PM"
			end if
		end if
	
		y = " select to_date(to_char(sysdate,'ddmmyyyy'),'ddmmyyyy') tkhs, "
		y = y & " to_date(to_char(to_date(substr('"&tkh_kompaun&"',1,2)||substr('"&tkh_kompaun&"',4,2)||substr('"&tkh_kompaun&"',7,4),'ddmmyyyy'),'ddmmyyyy'),'ddmmyyyy') tkh3s from dual "
		Set sy = objConn.Execute(y)
		
		tkhs = sy("tkhs")
		tkh3s = sy("tkh3s")

		if tkh3s > tkhs then
			response.write "<script language=""VBScript"">"
			response.write " MsgBox ""Tarikh Kompaun Lebih Besar"" + vbnewline+""Daripada Tarikh Semasa !!"", vbInformation, ""Perhatian!"" "
			response.write "</script>"
		else
					
		n = " select no_kompaun from kompaun.halangan where no_kompaun = '"&kompaun&"' "
  		Set sn = objConn.Execute(n)
	
		if not sn.eof then
			d = "     update kompaun.halangan set nama = '"& nama &"',kp = '"& kp &"',alamat1 = '"& alamat1 &"', "
			d = d & " alamat2 = '"& alamat2 &"',alamat3 = '"& alamat3 &"', no_kenderaan = '"&kenderaan&"', "
			d = d & " cukai_jalan = '"&cukai&"', no_kontena = '"&kontena&"',kenderaan_berat = '"& kenderaan_berat &"',akta = '"& akta &"', "
			d = d & " kesalahan = '"& salah &"',butir_kesalahan = '"&butirsalah&"', catitan = '"&butirsalah&"', "
			d = d & " tkh_kompaun = to_date('"& tkh_kompaun &"','dd/mm/yyyy'), "
			d = d & " masa = '"& masa1 &"',tempat = '"&tempat&"' ,tempat1 = '"&tempat1&"', "
			d = d & " pengeluar_kompaun = '"& no_pekerja &"' , amaun='"&maksima&"',daerah = '"&dae&"' "
			d = d & " where no_kompaun = '"& kompaun &"' "
			Set objRs2 = objConn.Execute(d)
			'response.write d

		else
		
			'+++++++++++++++++++++++++++++++++++++++++generate no_akaun - ambil no akhir utk mid(tahun,4,1) tambah 1
			cc = "select to_char(sysdate,'dd/mm/yyyy') tkh, "
			cc = cc & " to_char(sysdate,'yyyy') thni from dual" 	
			Set objRscc = objConn.Execute(cc)
			
			tkhbp = objRscc("tkh")
			thn = mid(tkhbp,7,4)
			thni = objRscc("thni")
			digithn = mid(thni,4,1)
			noakn = "76439"&digithn

			aa = "select (max(nvl(siri,1))+1) sirr from hasil.bil "
			aa = aa & " where no_akaun like '"&noakn&"'||'%' and length(no_akaun)=11 "
			Set objRsaa = objConn.Execute(aa)
			
	        msiri = objRsaa("sirr")
			
			if  IsNull(objRsaa("sirr")) then 
        		msiri = 1	
	       end if
		
			bb = "select '76439'||'"&digithn&"'||lpad(to_char('"& msiri &"'),5,'0') as newakaun "
			bb = bb & " from dual "
			Set objRsbb = objConn.Execute(bb)
				nwakaun = objRsbb("newakaun")
				
			'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				
		b2 = "insert into hasil.bil(no_akaun, nama, alamat1, alamat2, alamat3, kategori,"
		b2 = b2 & " no_rujukan,perkara1,"
		b2 = b2 & " amaun,tkh_masuk,siri,tahun,akaun,tkh_entry,penyedia) " 
		b2 = b2 & " values ('"&nwakaun&"','"&nama&"','"&alamat1&"','"&alamat2&"','"&alamat3&"','45', "
		b2 = b2 & " '"&kompaun&"', '"& kenderaan &"','"&maksima&"',to_date('"&tkh_kompaun&"','dd/mm/yyyy'), "		
		b2 = b2 & " '"&msiri&"','"&thn&"','76439',sysdate,'"&no_pekerja&"') "
		set sb2 = objconn.execute(b2)
		
			d = " insert into kompaun.halangan (no_akaun,no_kompaun, nama, kp,alamat1, alamat2, alamat3, "
			d = d & " no_kenderaan,cukai_jalan,akta,kesalahan,tkh_kompaun,tkh_input, masa, tempat, "
			d = d & "  pengeluar_kompaun, amaun,status_kompaun,daerah,butir_kesalahan,no_kontena,kenderaan_berat,tempat1 , catitan) values "
			d = d & " ('"&nwakaun&"','"& kompaun &"' , '"& nama &"' , '"& kp &"' , '"& alamat1 &"' , "
			d = d & " '"& alamat2 &"' , '"& alamat3 &"' , '"& kenderaan &"' , '"& cukai &"' , "
			d = d & " '"& akta &"', '"& salah &"', "
			d = d & " to_date('"& tkh_kompaun &"','dd/mm/yyyy') , "
			d = d & " sysdate , "
			d = d & " '"& masa1 &"' , '"& tempat &"', '"& no_pekerja &"' , '"& maksima &"','I','"&dae&"', "
			d = d & " '"&butirsalah&"','"&kontena&"','"& kenderaan_berat &"','"&tempat1&"' , '"&butirsalah&"') "
			Set objRs2 = objConn.Execute(d)		
			'response.write d	
			
		end if
		end if
		end if
		end if
		end if 
		end if
		papar	
	end if 
sub mula
%>
<table width="95%" align="center" cellspacing=0 bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt;" cellpadding="1">
  <tr> 
    <td width="127" bgcolor="<%=color1%>"><font color="#FFFF00">No Kompaun</font></td>
    <td colspan="2" bgcolor="<%=color2%>"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="kompaun" size="11" value="<%=kompaun%>" maxlength="11" onFocus="nextfield='B';">
      <font color="red">*</font> 
      <input type="submit" value="Hantar" name="B" onFocus="nextfield='done';" style="font-size: 8pt; font-family: Arial; font-weight: bold">
    </td>
    <td bgcolor="<%=color2%>">&nbsp; </td>
    <td colspan="2" bgcolor="<%=color2%>">&nbsp;</td>
  </tr>
   <script>
	document.komp.kompaun.focus()
</script>
  <% end sub 
	 sub papar		
  	s = " 	select rowid, no_kompaun,upper(nama)nama,no_akaun, "
	s = s & " upper(alamat1) alamat1, upper(alamat2) alamat2, upper(alamat3) alamat3, kp, "
	s = s & " no_kenderaan,cukai_jalan, akta,kesalahan,kenderaan_berat,"
	s = s & " to_char(tkh_kompaun,'dd/mm/yyyy') tkh_kompaun,to_char(masa) masa,tempat,tempat1, "
	s = s & " daerah,nvl(amaun,0)amaun,pengeluar_kompaun,daerah,no_resit,nvl(amaun_bayar,0)amaun_bayar,"
	s = s & " to_char(tkh_bayar,'dd/mm/yyyy')tkh_bayar,no_kontena,butir_kesalahan , catitan "
	s = s & " from kompaun.halangan "
	s = s & " where no_kompaun = '"& kompaun &"' "
	Set gq = objConn.Execute(s)
    'response.write s
	if not gq.eof then
		rowid = gq("rowid")
		nama = gq("nama")
		no_akaun = gq("no_akaun")
		alamat1 = gq("alamat1")
		alamat2 = gq("alamat2")
		alamat3 = gq("alamat3")
		kp = gq("kp")
		kenderaan = gq("no_kenderaan")
		cukai = gq("cukai_jalan")
		akta = gq("akta")
		salah = gq("kesalahan")
		tkh_kompaun = gq("tkh_kompaun")		
		kenderaan_berat = gq("kenderaan_berat")
		waktu = gq("masa")
		tempat = gq("tempat")
		tempat1 = gq("tempat1")
		amaun = gq("amaun")
		no_pekerja = gq("pengeluar_kompaun")
		dae = gq("daerah")
		amaun_bayar = cdbl(gq("amaun_bayar"))
		no_resit = gq("no_resit")
		tkh_bayar = gq("tkh_bayar")
		kontena = gq("no_kontena")
		butirsalah = gq("butir_kesalahan")
		catitan = gq("catitan")
				
  		k1 = " select initcap(keterangan) aketer from kompaun.akta where kod = '"&akta&"' "
  		Set objk1 = objConn.Execute(k1)
  		if not objk1.eof then
	  		aketer = objk1("aketer")
  		 end if	  				
  
  		k2 = " select  initcap(keterangan||' '||keterangan2) sketer from kompaun.butir_kesalahan "
  		k2 = k2 & " where akta = '"&akta&"' and kod = '"&salah&"' "
  		Set objk2 = objConn.Execute(k2)
 			if not objk2.eof then				sketer = objk2("sketer") 			
		end if  		
	
	if no_akaun <> "" then %>
	<tr> 
    <td width="127" bgcolor="<%=color1%>"><font  color="#FFFF00">No Akaun</font></td>
    <td colspan="2" bgcolor="<%=color2%>"><font color="red"><b><%=no_akaun%></b></font></td>
    <td bgcolor="<%=color2%>">&nbsp;</td>
    <td colspan="2" bgcolor="<%=color2%>">&nbsp;</td>
  </tr>
        <% end if %>
  <tr> 
    <td width="127" bgcolor="936975"><font  color="#FFFF00">Nama</font></td>
    <td bgcolor="lightgrey" colspan="5"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="nama" size="40" value="<%=nama%>" maxlength="50" onFocus="nextfield='kp';">
      <font color="red">*</font> </td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975"><font  color="#FFFF00">No K/P</font></td>
    <td bgcolor="lightgrey" colspan="5"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="kp" size="14" value="<%=kp%>" maxlength="14" onFocus="nextfield='alamat1';" >
    </td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975"><font  color="#FFFF00">Alamat</font></td>
    <td bgcolor="lightgrey" colspan="5"><font > 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="alamat1" size="50" value="<%=alamat1%>" maxlength="50" onFocus="nextfield='alamat2';">
      <font color="red">*</font></font></td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975">&nbsp;</td>
    <td bgcolor="lightgrey" colspan="5"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="alamat2" size="50" value="<%=alamat2%>" maxlength="50" onFocus="nextfield='alamat3';">
    </td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975">&nbsp;</td>
    <td bgcolor="lightgrey" colspan="5"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="alamat3" size="50" value="<%=alamat3%>" maxlength="50" onFocus="nextfield='kenderaan';">
    </td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975"><font  color="#FFFF00">No Kenderaan</font></td>
    <td bgcolor="lightgrey" colspan="2" ><font > 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="kenderaan" size="12" value="<%=kenderaan%>" maxlength="12" onFocus="nextfield='cukai';">
      </font></td>
    <td width="87" bgcolor="936975"><font  color="#FFFF00">No Cukai Jalan</font></td>
    <td bgcolor="#D3D3D3" colspan="2"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="cukai" size="15" value="<%=cukai%>" maxlength="15" onFocus="nextfield='kontena';">
    </td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975"><font  color="#FFFF00">No Kontena</font></td>
    <td bgcolor="lightgrey" colspan="2" >
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="kontena" size="10" value="<%=kontena%>" maxlength="10" onFocus="nextfield='akta';"></td>
    <td width="87" bgcolor="936975" nowrap><font  color="#FFFF00">Kenderaan Berat</font></td>
    <td bgcolor="#D3D3D3" colspan="2"> 
      &nbsp; <input type="radio" value="Y" name="kenderaan_berat" <%if  kenderaan_berat = "Y" then%>checked<%end if%>>
    YA&nbsp;
    <input type="radio" value="T" name="kenderaan_berat" <%if kenderaan_berat="" or kenderaan_berat="T" then%>checked<%end if%>> 
    TIDAK    </td>
  <!--  </td>-->
  
  </tr>
  

  <%		if waktu <> "" then
   				if waktu = 24 then
   					waktu1 = 12
   					ampm = "AM"
   				elseif waktu >=  13 then
   					waktu1 = waktu - 12
   					ampm = "PM"
   			
   				elseif waktu < 13.00 or waktu = 12 then
   					waktu1 = waktu
   					ampm = "AM"	
   				end if
   			end if
			%>
  <tr> 
    <td width="127" bgcolor="936975"><font color="#FFFF00"> Akta / UUK</font></td>
    <td bgcolor="lightgrey" colspan="5"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="akta" size="4" value="<%=akta%>" maxlength="4" onFocus="nextfield='salah';">      <a href="javascript:void(0)" onClick="open_win('komp.akta','komp.aketer');" onMouseOver="window.status='Senarai Akta';return true;" onMouseOut="window.status='';return true;"> 
      <input type="button" value="List" name="B2" style="font-family: Arial; font-size: 8pt; font-weight: bold">
      </a> <font color="red">* 
      <input type="visible" name="aketer" size="50" value="<%=aketer%>" readonly="true" style="font-family: Trebuchet MS; font-size: 10pt; background-color:lightgrey; border-style: solid; border-color:lightgrey;" >
      </font></td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975"><font  color="#FFFF00"> Kesalahan</font></td>
    <td bgcolor="lightgrey" colspan="5"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="salah" size="10" value="<%=salah%>" maxlength="10" onFocus="nextfield='tkh_kompaun';">
      <a href="javascript:void(0)" onClick="open_salah('komp.salah','akta','komp.sketer');" onMouseOver="window.status='Senarai Akta';return true;" onMouseOut="window.status='';return true;"> 
      <input type="button" value="List" name="B3" style="font-family: Arial; font-size: 8pt; font-weight: bold">
      </a><font color="red">* 
      <input type="visible" name="sketer" size="50" value="<%=sketer%>" readonly="true" style="font-family: Trebuchet MS; font-size: 10pt; background-color:lightgrey; border-style: solid; border-color:lightgrey;">
      </font></td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975"><font  color="#FFFF00">Tarikh</font></td>
    <td bgcolor="lightgrey" colspan="2"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="tkh_kompaun" size="10" value="<%=tkh_kompaun%>" maxlength="10" onFocus="nextfield='fmasa';" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
      &nbsp; <font color="#244980">(dd/mm/yyyy)</font><font color="red">*</font></td>
    <td width="87" bgcolor="936975"><font color="#FFFF00">Waktu</font></td>
    <td bgcolor="#D3D3D3" colspan="2"> 
		<input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="fmasa" value="<%if waktu <> "" then %><%=formatnumber(waktu,2)%><%else%><%=waktu%><%end if%>" size="5" maxlength="5" onFocus="nextfield='tempat';">      
		&nbsp; AM 
      <input type="radio" value="AM" name="ampm" <%if ampm="" or ampm = "AM" then%>checked<%end if%>>
      &nbsp; PM 
      <input type="radio" value="PM" name="ampm" <%if ampm="PM" then%>checked<%end if%>>
    <font color="red">*</font></td>
  </tr>
  <tr>
    <td width="127" bgcolor="936975"><font  color="#FFFF00">Tempat</font></td>
    <td colspan="5" bgcolor="lightgrey"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="tempat" size="50" value="<%=tempat%>" maxlength="50" onFocus="nextfield='tempat1';">
      <font color="red">*</font> </td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975">&nbsp;</td>
    <td colspan="5" bgcolor="lightgrey"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="tempat1" size="50" value="<%=tempat1%>" maxlength="50" onFocus="nextfield='dae';">
    </td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975"><font color="#FFFF00">Daerah</font></td>
    <td colspan="5" bgcolor="lightgrey"> 
      <select name="dae" size="1" onKeyDown="if(event.keyCode==13) event.keyCode=9;" style="font-family: Trebuchet MS; font-size: 10pt;">
        <option value = "">Daerah</option>
        <% if dae <> "" then%>
        <option value="<%=dae%>" selected><%=dae%></option>
        <% end if%>
        <option value="04">04-SPT</option>
        <option value="05">05-SPS</option>
        <option value="06">06-SPU</option>
      </select>&nbsp;<font color="red">*</font>
    </td>
  </tr>
  <tr> 
    <td width="127" bgcolor="936975"><font color="#FFFF00">Catitan</font></td>
    <td colspan="5" bgcolor="lightgrey"> 
      <textarea  style="font-family: Trebuchet MS; font-size: 10pt;" name="butirsalah" rows="3" id="catitan" cols="60" onKeyDown="if(event.keyCode==13) event.keyCode=9;"><%=butirsalah%></textarea>
    </td>
  </tr>
  <tr> 
    <td width="127" align="left" bgcolor="936975"><font color="#FFFF00">Pengeluar 
      Notis</font></td>
    <%	
   		n = " select initcap(nama)nama from payroll.paymas where no_pekerja = '"& no_pekerja &"' "
   		Set objRsn = objConn.Execute(n)
    		
   		if not objRsn.eof then
    			napek = objRsn("nama")
   		end if		
  %>
    <td align="left" bgcolor="lightgrey" colspan="5"> 
      <input type="text" style="font-family: Trebuchet MS; font-size: 10pt;" name="no_pekerja" size="5" value="<%=no_pekerja%>" maxlength="5" onFocus="nextfield='B1';">
      -&nbsp; <font color="#000000"><%=napek%>&nbsp;</font><font color="red">*</font></td>
  </tr>
  <%	if no_resit <> "" or tkh_bayar <> "" or amaun_bayar > 0 then %>
  <tr> 
    <td align="left" bgcolor="white" colspan="6"> 
      <font color="red"><b>Kompaun Ini Telah DiBayar</b></font>
    </td>
  </tr>
  <tr align="left"> 
    <td bgcolor="936975" width="127"><font color="#FFFF00">Tarikh 
      Bayar </font></td>
    <td bgcolor="lightgrey" width="244"><%=tkh_bayar%>&nbsp;</td>
    <td bgcolor="936975" width="75"><font color="#FFFF00">No Resit</font></td>
    <td bgcolor="lightgrey" width="87"><%=no_resit%></td>
    <td bgcolor="936975" width="81"><font color="#FFFF00">Amaun Bayar</font></td>
    <td bgcolor="lightgrey" width="97">RM&nbsp;<%=formatnumber(amaun_bayar,2)%>&nbsp;</td>
  </tr>
  <%	end if %>

  <tr bgcolor="936975" align="center" valign="top"> 
    <td width="127"><font color="red">*</font>Mesti Diisi</td>
    <td width="244" align="right"> 
        <input type="submit" name="B1" value="Simpan" onFocus="nextfield='done';" style="font-family: Arial; font-size: 8pt; font-weight: bold"></form> 
    </td>
    <td width="75" align="right"> 
        <form method="Post" action="hg111.asp" name=hg111a>
          <input type="submit" value="Semula" name="B2" style="font-family: Arial; font-size: 8pt; font-weight: bold">
        </form>
    </td>
    <td align="left"> 
      <form method="Post" action="hg111.asp" name=hg111b>
	          <input type="hidden" name="rowid" value="<%=rowid%>" >
			  <input type="hidden" name="kompaunh" value="<%=kompaun%>" >
		<input type="hidden" name="no_akaun" value="<%=no_akaun%>" >
      <input type="submit" value="Cetak Salinan" name="B3" style="font-family: Arial; font-size: 8pt; font-weight: bold">
      </form>
    </td>
    <form method="Post" action="hg111.asp" name=hg111c>
      <td align="left" width="87"> 
        <input type="hidden" name="rowid" value="<%=rowid%>" >
        <input type="hidden" name="kompaunh" value="<%=kompaun%>" >
		<input type="hidden" name="no_akaun" value="<%=no_akaun%>" >
        <input type="submit" value="Hapus" name="B4" style="font-family: Arial; font-size: 8pt; font-weight: bold">
      </td>
    </form>
  </tr>
</table>	  
  <%  end sub %>
</body>