<%Response.Buffer = True%>
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<!--#INCLUDE FILE="halangan.inc"-->
<html>
<head>
<title>Kemaskini Bayaran</title>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
nextfield = "kompaun";
//End -->
</script>
</head>

<SCRIPT LANGUAGE="JavaScript">
function check(b){
if(b.tindakan.value==""){
alert("Sila Masukkan Tindakan Notis!!");
b.tindakan.focus();
return false}
}
</script>

<body bgcolor="#FFFFFF">
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg159a.asp"> 
<%	
    no_kompaun = request.querystring("no_kompaun")
	amenu = request.querystring("amenu")
	
    response.cookies("amenu") = "&amenu&" 
	

	b1 = Request.form("B1")
	b2 = Request.form("B2")
	b3 = Request.form("B3")
	kompaun = Request.form("kompaun")

 '================================= rEseT ===========================================
		if b3 = "Reset" then
			kompaun = ""
		end if

'   ============
 	  papar
'	============

   '================================ Simpan ===========================================
   if b2 = "Simpan" then
		no_kompaun = request.form("no_kompaun")
		'amaun_bayar = Request.form("amaun_bayar")
		tindakan = request.form("tindakan")
		tindakan1 = request.form("tindakan1")
		tindakan2 = request.form("tindakan2")
		
	 y = " select 'x' from dual "
	 y = y & " where to_date(to_date('"&tbayar&"','dd/mm/yyyy'),'dd-mon-yyyy') < "
	 y = y & " to_date(to_date('"&tkh_kompaun&"','dd/mm/yyyy'),'dd-mon-yyyy') "
	 set sy = objconn.execute(y)
	 
	 if not sy.eof then	
 		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Tarikh Bayaran Lebih Kecil "" + vbNewline + "" Daripada Tarikh Kompaun"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
    else	   
	
		x = " select 'x' from dual "
		x = x & " where to_date(to_date('"&tbayar&"','dd/mm/yyyy'),'dd-mon-yyyy') > "
	    x = x & " to_date(sysdate,'dd-mon-yyyy') "
		set sx = objconn.execute(x)
		
		if not sx.eof then	
 		response.write "<script language=""VBScript"">"
		response.write " MsgBox ""Tarikh Bayaran Lebih Besar "" + vbNewline + "" Daripada Tarikh Hari Ini"", vbInformation, ""Perhatian!"" "
		response.write "</script>"
    	else
				
		f = " update kompaun.halangan set tindakan = '"&tindakan&"', tindakan1 = '"&tindakan1&"' , tindakan2 = '"&tindakan2&"' "
		f = f & " where no_kompaun = '"&no_kompaun&"' "
		set sf = objconn.execute(f)
		
		'response.write f
		end if
		end if				
			papar
   end if    


'===================================== sub papar ============================================
sub papar
  d =     "  select rowid,no_kompaun,no_akaun,no_resit,to_char(tkh_kompaun,'dd/mm/yyyy') tkh_kompaun ,akta,kesalahan, "
  d = d & "  nvl(amaun_bayar,0) amaun_bayar, to_char(tkh_bayar,'dd/mm/yyyy') tkh_bayar,nama,alamat1,alamat2,alamat3,kp, "
  d = d & "  no_kenderaan,cukai_jalan,to_char(nvl(masa,0)) masa,tempat,amaun,pengeluar_kompaun,daerah,no_kontena,butir_kesalahan,tindakan1,tindakan,tindakan2 "
  d = d & "  from kompaun.halangan "
  d = d & "  where no_kompaun= '"& no_kompaun &"'  "
  Set Rsd = objConn.Execute(d)
  
  'response.write d
  if not Rsd.eof then
     rowid = Rsd("rowid")
     resit = Rsd("no_resit")
	 akaun = Rsd("no_akaun")
	 no_kompaun = Rsd("no_kompaun")
     tkh_kompaun = rsd("tkh_kompaun")
	 akta = rsd("akta")
     amaun_bayar = cdbl(Rsd("amaun_bayar"))
	 kesalahan = Rsd("kesalahan")
	 no_akaun = Rsd("no_akaun")
	 nama = Rsd("nama")
	 alamat1 = Rsd("alamat1")
     alamat2 = Rsd("alamat2")
     alamat3 = Rsd("alamat3")
	 kp = Rsd("kp")
     kenderaan = Rsd("no_kenderaan")
	 cukai = Rsd("cukai_jalan")
	 waktu = Rsd("masa")
	 tempat = Rsd("tempat")
	 amaun = Rsd("amaun")
	 no_pekerja = Rsd("pengeluar_kompaun")
	 daerah = Rsd("daerah")
     tkh_bayar = Rsd("tkh_bayar")
	 kontena = Rsd("no_kontena")
	 butirsalah = Rsd("butir_kesalahan")
	 tindakan = Rsd("tindakan")
	 tindakan1 = Rsd("tindakan1")
	 tindakan2 = Rsd("tindakan2")
    
        j =     "select initcap(keterangan) terang from kompaun.jenis_kesalahan "
        j = j & " where upper(kod) = '"& kesalahan &"' and upper(perkara) = '"&akta&"' "
        Set Rsj = objConn.Execute(j)
        
        if not rsj.eof then
           njsalah = Rsj("terang")
        end if	
%>   

 <table bgcolor="<%=color1%>" borderColor=black cellSpacing=1 align="center" width="60%" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">

   <tr> 
     <td width="65%" bgcolor="936975" align="center" colspan="4"><font color="#FFFF00">KEMASKINI TINDAKAN NOTIS</font></td>
  </tr>
  
</table><br>
  
  <table bgcolor="<%=color1%>" borderColor=black cellSpacing=1 align="center" width="60%" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
  
   <tr> 
      <td width="20%" height=24>No Kompaun</td>
      <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=no_kompaun%></td>
    </tr>
       <tr> 
      <td width="20%" height=24>No Akaun</td>
      <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=no_akaun%></td>
    </tr>
     <tr> 
      <td width="20%" height=24>Nama</td>
      <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=nama%></td>
    </tr>
      <tr> 
      <td width="20%" height=24>No KP</td>
      <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=kp%></td>
    </tr>   
    <tr> 
      <td width="20%" height=24>Alamat</td>
      <td width="50%" bgcolor="<%=color2%>" style="color:black"colspan="5">&nbsp;<%=alamat1%></td>
    </tr>
    <tr> 
    <td width="20%" height=24>&nbsp;</td>
    <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=alamat2%>&nbsp; , <%=alamat3%> </td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font  color="#FFFF00">No Kenderaan</font></td>
   <td width="50%" bgcolor="<%=color2%>" style="color:black">&nbsp;<%=kenderaan%></td>
      <td width="133" bgcolor="936975"><font color="#FFFF00">No Kontena</font></td>
   <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="3">&nbsp;<%=kontena%></td>
  </tr>

  
  <%		if waktu <> "" then
   				if waktu = 24 then
   					waktu1 = 12
   					ampm = "Pagi"
   				elseif waktu >=  13 then
   					waktu1 = waktu - 12
   					ampm = "Petang"
   			
   				elseif waktu < 13.00 or waktu = 12 then
   					waktu1 = waktu
   					ampm = "Malam"	
   				end if
   			end if
			
  %>
 
  <tr>
   <td width="96" bgcolor="936975"><font color="#FFFF00">Daerah</font></td>
   <td width="50%" bgcolor="<%=color2%>" style="color:black">&nbsp;
	  <%if daerah="04" then%>04 - SPU<%end if%>
	  <%if daerah="05" then%>05 - SPT<%end if%>
	  <%if daerah="06" then%>06 - SPS<%end if%>
      </td></td>
      <td width="133" bgcolor="936975"><font color="#FFFF00">Waktu</font></td>
    <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="3">&nbsp;<%=formatnumber(waktu,2)%> &nbsp;<%=ampm%>&nbsp;</td>
    </tr>       
  <tr> 
   <td width="133" bgcolor="936975"><font color="#FFFF00">Akta / UUK</font></td>
   <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=akta%>-<%=aketer%></td>
  </tr>
  <tr> 
      <td>Jenis Kesalahan</td>
      <td bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=kesalahan%>-<%=njsalah%></td>
   </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font color="#FFFF00">Butir-Butir Kesalahan</font></td>
   <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=butirsalah%> </td>
  </tr>
    
 <tr> 
    <td align="left" bgcolor="936975" width="133"><font color="#FFFF00">Tarikh 
      Bayar </font></td>
    <td width="50%" bgcolor="<%=color2%>" style="color:black">&nbsp;<%=tkh_bayar%>&nbsp;</td>
    <td align="left" bgcolor="936975" width="74"><font color="#FFFF00">No Resit</font></td>
    <td width="50%" bgcolor="<%=color2%>" style="color:black">&nbsp;<%=no_resit%></td>
    <td align="left" bgcolor="936975" width="96"><font color="#FFFF00">Amaun Bayar</font></td>
    <td width="50%" bgcolor="<%=color2%>" style="color:black">&nbsp;RM&nbsp;<%=formatnumber(amaun_bayar,2)%>&nbsp;</td>
  </tr>
      <tr> 
      <td width="20%" height=24>Tarikh Kompaun</td>
      <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=tkh_kompaun%></td>
    </tr>
  <tr> 
     <td width="133" bgcolor="936975"><font color="#FFFF00">Tindakan Notis</font></td>
     <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5"> 
      <input type="radio" value="Operasi-Sudah Dilaksana" name="tindakan" <%if tindakan="Operasi-Sudah Dilaksana" then%>checked<%end if%> >
      Operasi-Sudah Dilaksana
      <br>
      <input type="radio" value="Operasi-Belum Dilaksana" name="tindakan" <%if tindakan="Operasi-Belum Dilaksana" then%>checked<%end if%> >
      Operasi-Belum Dilaksana
      <br>
      <input type="radio" value="Notis-Sudah Dihantar" name="tindakan" <%if tindakan="Notis-Sudah Dihantar" then%>checked<%end if%> >
      Notis-Sudah Dihantar&nbsp;
      <br>
      <input type="radio" value="Tindakan Jabatan Luar" name="tindakan" <%if tindakan="Tindakan Jabatan Luar" then%>checked<%end if%> >
      Tindakan Jabatan Luar&nbsp;
      <input type="text" name="tindakan2" size="40" value="<%=tindakan2%>" maxlength="60" onFocus="nextfield='B2';"><br>
      <input type="radio" value="Notis-Sudah Dibayar" name="tindakan" <%if tindakan="Notis-Sudah Dibayar" then%>checked<%end if%> >
      Notis-Sudah Dibayar&nbsp;
      <br>
      <input type="radio" value="Notis-Belum Dibayar" name="tindakan" <%if tindakan="Notis-Belum Dibayar" then%>checked<%end if%> >
      Notis-Belum Dibayar&nbsp;
      <br>
      <input type="radio" value="-" name="tindakan" <%if tindakan="-" then%>checked<%end if%> >
      Tiada Tindakan
      </td>
  </tr>
   <tr> 
    <td width="133" align="left" bgcolor="936975"><font color="#FFFF00">Pengeluar 
      Notis</font></td>
    <%	
   		n = " select initcap(nama)nama from payroll.paymas where no_pekerja = '"& no_pekerja &"' "
   		Set objRsn = objConn.Execute(n)
    		
   		if not objRsn.eof then


    			napek = objRsn("nama")
   		end if		
  %>
      <td width="50%" bgcolor="<%=color2%>" style="color:black" colspan="5">&nbsp;<%=no_pekerja%> -&nbsp; 
      <font color="#000000"><%=napek%></font></td>
  </tr>
  
    <tr> 
      <td></td>
      <td> 
        <input type="hidden" name="no_kompaun" value="<%=no_kompaun%>">
        <input type="hidden" name="tkh_kompaun" value="<%=tkh_kompaun%>">
      </td>
    </tr>
    
   
  <tr>
      <td height="19" align="center" bgcolor="936975" colspan="7">
      <input type="submit" value="Simpan" name="B2" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
     </td>
    </tr>   
     
         <%	end if
  		end sub	
		%>   
        <script>
	document.komp.kompaun.focus();
</script>
  </table>
</form>
</body>
</html>

