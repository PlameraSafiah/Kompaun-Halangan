<%Response.Buffer = True%>
<!--#INCLUDE FILE="halangan.inc"-->
<html>
<head>
<title>Tindakan Notis</title>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
nextfield = "tindakan";
//End -->
</script>

<SCRIPT LANGUAGE="JavaScript">
function check(b){
if(b.tindakan.value==""){
alert("Sila Masukkan Kemaskini Tindakan!!");
b.tindakan.focus();
return false}
</script>
</head>



<body bgcolor="#FFFFFF">
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg160a.asp">
<%	
    response.cookies("amenu") = "&amenu&"  
    rowid = request.querystring("rowid")
	amenu = request.querystring("amenu")
	b2 = Request.form("B2")
	
	
	'===================================== sub papar ============================================
	s = " 		select rowid,no_akaun, no_kompaun,initcap(nama)nama, "
	s = s & " initcap(alamat1) alamat1, initcap(alamat2) alamat2, initcap(alamat3) alamat3, kp,  "
	s = s & " upper(no_kenderaan)no_kenderaan,cukai_jalan, akta,kesalahan,"
	s = s & " to_char(tkh_kompaun,'dd/mm/yyyy') tkh_kompaun,to_char(nvl(masa,0)) masa,initcap(tempat)tempat, "
	s = s & " decode(daerah,'04','SPT','05','SPS','06','SPU')daerah,nvl(amaun,0)amaun, "
	s = s & " pengeluar_kompaun,daerah,no_resit,nvl(amaun_bayar,0)amaun_bayar,"
	s = s & " to_char(tkh_bayar,'dd/mm/yyyy')tkh_bayar,no_kontena,butir_kesalahan,tindakan "
	s = s & " from kompaun.halangan "
	s = s & " where rowid= '"& rowid &"'"
	Set gq = objConn.Execute(s)

	'response.write s

	if not gq.eof then
		rowid = gq("rowid")
		kompaun = gq("no_kompaun")
		no_akaun = gq("no_akaun")
		nama = gq("nama")
		alamat1 = gq("alamat1")
		alamat2 = gq("alamat2")
		alamat3 = gq("alamat3")
		kp = gq("kp")
		kenderaan = gq("no_kenderaan")
		cukai = gq("cukai_jalan")
		akta = gq("akta")
		salah = gq("kesalahan")
		tkh_kompaun = gq("tkh_kompaun")		
		waktu = gq("masa")
		tempat = gq("tempat")
		amaun = gq("amaun")
		no_pekerja = gq("pengeluar_kompaun")
		daerah = gq("daerah")
		amaun_bayar = cdbl(gq("amaun_bayar"))
		no_resit = gq("no_resit")
		tkh_bayar = gq("tkh_bayar")
		kontena = gq("no_kontena")
		butirsalah = gq("butir_kesalahan")
		tindakan = gq("tindakan")

				
  		k1 = " select initcap(keterangan) aketer from kompaun.perkara where kod = '"&akta&"' "
  		Set objk1 = objConn.Execute(k1)
  		if not objk1.eof then
	  		aketer = objk1("aketer")
  		 end if	  				
  
  		k2 = "		  select initcap(keterangan) sketer from kompaun.butir_kesalahan "
  		k2 = k2 & " where akta = '"&akta&"' and kod = '"&salah&"' "
  		Set objk2 = objConn.Execute(k2)
 			if not objk2.eof then
				sketer = objk2("sketer")
  			end if	  			
		end if  	    
	
%>
<table width="65%" align="center" cellspacing=1 bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt;" cellpadding="1" border="0">

   <tr> 
     <td width="65%" bgcolor="936975" align="center" colspan="4"><font color="#FFFF00">MAKLUMAT NOTIS KOMPAUN HALANGAN</font></td>
  </tr>
  
</table><br>
<table width="65%" align="center" cellspacing=1 bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt;" cellpadding="1" border="0">
  <tr> 
     <td width="133" bgcolor="936975"><font color="#FFFF00">No Kompaun</font></td>
     <td bgcolor="lightgrey" colspan="5"><%=kompaun%> </td>
  </tr>
  <tr> 
     <td width="133" bgcolor="936975"><font color="#FFFF00">No Akaun</font></td>
     <td bgcolor="lightgrey" colspan="5"><%=no_akaun%> </td>
  </tr>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font  color="#FFFF00">Nama</font></td>
    <td bgcolor="lightgrey" colspan="5"> <%=nama%> </td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font  color="#FFFF00">No K/P</font></td>
    <td bgcolor="lightgrey" colspan="5"> <%=kp%> </td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font  color="#FFFF00">Alamat</font></td>
    <td bgcolor="lightgrey" colspan="5"> <%=alamat1%> </td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975">&nbsp;</td>
    <td bgcolor="lightgrey" colspan="5"> <%=alamat2%> </td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975">&nbsp;</td>
    <td bgcolor="lightgrey" colspan="5"> <%=alamat3%> </td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font  color="#FFFF00">No Kenderaan</font></td>
    <td bgcolor="lightgrey" colspan="5"><%=kenderaan%></td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font color="#FFFF00">No Kontena</font></td>
    <td bgcolor="lightgrey" colspan="5" > <%=kontena%></td>
  </tr>
 <!-- <tr> 
    <td width="133" bgcolor="936975"><font color="#FFFF00">Jenis Pemilikan</font></td>
    <td bgcolor="lightgrey" colspan="5" > <%'=JMilik%></td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font color="#FFFF00">Jenis Kenderaan</font></td>
    <td bgcolor="lightgrey" colspan="5" > <%'=Jkenderaan%></td>
  </tr>-->
  
  
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
     <td width="133" bgcolor="936975"><font color="#FFFF00">No Cukai Jalan</font></td>
     <td bgcolor="lightgrey" colspan="5"><%=cukai%> </td>
  </tr>
  
  <tr>
   <td width="96" bgcolor="936975"><font color="#FFFF00">Daerah</font></td>
    <td bgcolor="lightgrey" width="118" colspan="5">
	  <%if daerah="04" then%>04 - SPU<%end if%>
	  <%if daerah="05" then%>05 - SPT<%end if%>
	  <%if daerah="06" then%>06 - SPS<%end if%>
      </td></td>
    </tr>
    
    
     <tr> 
     <td width="133" bgcolor="936975"><font color="#FFFF00">Waktu</font></td>
     <td bgcolor="lightgrey" colspan="5"> <%=formatnumber(waktu,2)%> &nbsp;<%=ampm%>&nbsp;</td>
  </tr>
  
 
            
  <tr> 
    <td width="133" bgcolor="936975"><font color="#FFFF00">Akta / UUK</font></td>
    <td bgcolor="lightgrey" colspan="5"><%=akta%>-<%=aketer%></td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font  color="#FFFF00"> Kesalahan</font></td>
    <td bgcolor="lightgrey" colspan="5"><%=salah%>-<%=sketer%></td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font color="#FFFF00">Butir-Butir Kesalahan</font></td>
    <td bgcolor="lightgrey" colspan="5"> <%=butirsalah%> </td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975" height="8"><font  color="#FFFF00">Tarikh</font></td>
    <td bgcolor="lightgrey" colspan="5" height="8"> <%=tkh_kompaun%> &nbsp; </td>
  </tr>
  <tr> 
    <td width="133" bgcolor="936975"><font color="#FFFF00">Tempat</font></td>
    <td bgcolor="lightgrey" colspan="5"><%=tempat%></td>
  </tr>
 
  
  <tr> 
    <td width="133" bgcolor="936975"><font color="#FFFF00">Tindakan Notis</font></td>
    <td bgcolor="lightgrey" colspan="5" rowspan="2"><%=tindakan%><br>
    </td>
  </tr>
  

  
  <tr> 
    <td width="133" bgcolor="936975">&nbsp;</td>
  </tr>
  <!--<tr> 
    <td align="left" bgcolor="936975" width="133"><font  color="#FFFF00">Amaun</font></td>
    <td align="left" bgcolor="lightgrey" colspan="4">RM 
      <input name="amaun" type="text" onfocus="nextfield='no_pekerja';" value="<%=amaun%>" size="14" maxlength="14">
    </td>
  </tr>-->
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
    <td align="left" bgcolor="lightgrey" colspan="5"> <%=no_pekerja%> -&nbsp; 
      <font color="#000000"><%=napek%></font></td>
  </tr>
  <%	if no_resit <> "" or tkh_bayar <> "" or amaun_bayar > 0 then %>
  <tr> 
    <td align="left" bgcolor="936975" width="133"><font color="#FFFF00">No Resit 
      </font></td>
    <td align="left" bgcolor="lightgrey" colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left" bgcolor="936975" width="133"><font color="#FFFF00">Tarikh 
      Bayar </font></td>
    <td align="left" bgcolor="lightgrey" width="161"><%=tkh_bayar%>&nbsp;</td>
    <td align="left" bgcolor="936975" width="74"><font color="#FFFF00">No Resit</font></td>
    <td align="left" bgcolor="lightgrey" width="60"><%=no_resit%></td>
    <td align="left" bgcolor="936975" width="96"><font color="#FFFF00">Amaun Bayar</font></td>
    <td align="left" bgcolor="lightgrey" width="118">RM&nbsp;<%=formatnumber(amaun_bayar,2)%>&nbsp;</td>
  </tr>
  
  <script>
	document.komp.kompaun.focus()
</script>
 <!--<tr> 
    <td align="left" bgcolor="936975" width="133"><font color="#FFFF00">Amaun 
      Bayar </font></td>
    <td align="left" bgcolor="lightgrey" colspan="5">&nbsp;</td>
  </tr>-->
  <%	end if %>
</table>	  
</body>