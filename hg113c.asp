<html>
<head>
</head>
<body topmargin="0" leftmargin="0" >
<%	
	Set objConn = Server.CreateObject ("ADODB.Connection")
  	ObjConn.Open "dsn=12c;uid=majlis;pwd=majlis;"
  	 	 
	 rowid = request.querystring("rowid")	 
	 kompaun = request.querystring("ko")
	 no_akaun = request.querystring("no")
	 nop = Request.Cookies("gnop")
	 nama = request.cookies("cookies")
	        
		d = " select initcap(nama) nama,lpad(no_pekerja,5,0)nop,lokasi from payroll.paymas "
		d = d & " where no_pekerja = '"&nop&"' "
		Set objRs2 = objConn.Execute(d)        		 		
        		
        if not objRs2.eof then
        	nama = objRs2("nama")
			nop = objRs2("nop")
			jab = objRs2("lokasi")
        else
        	nama = Request.Cookies("gnop")
		end if
		
  		
		
		b = "select no_kompaun,no_akaun,nama,alamat1,alamat2,alamat3, "
		b = b & " to_char(tkh_kompaun,'dd/mm/yyyy')tkh1,kesalahan, "
		b = b & " initcap(tempat)tempat,initcap(tempat1)tempat1,butir_kesalahan perkara,tindakan, "
		b = b & " akta perkara1,to_char(sysdate,'dd/mm/yyyy') tkh,pengeluar_kompaun,no_kenderaan "
		b = b & " from kompaun.halangan "
		'b = b & " where no_akaun = '"& no_akaun &"' and no_kompaun = '"&kompaun&"' "
		b = b & " where no_kompaun = '"&kompaun&"' "
		Set sb = objConn.Execute(b)
		
		if not sb.eof then
		no_kompaun = sb("no_kompaun")
		no_akaun = sb("no_akaun")
		salah = sb("kesalahan")
		akta = sb("perkara1")
		perkara = sb("perkara")
		tkh1 = sb("tkh1")
		tempat = sb("tempat")
		tempat1 = sb("tempat1")
		no_kenderaan = sb("no_kenderaan")
		pengeluar = sb("pengeluar_kompaun")
		tkh = sb("tkh")
		tindakan = sb("tindakan")
		
	    
		'papar butir kesalahan  ---> nadia (03032017) 
		kd1 = " select initcap(catitan) catitan from kompaun.halangan where no_kompaun = '"&kompaun&"' "
  		Set objkd1 = objConn.Execute(kd1)
		
		
		k1 = " select initcap(keterangan) aketer from kompaun.perkara where kod = '"&akta&"' "
  		Set objk1 = objConn.Execute(k1)
  		if not objk1.eof then
	  		aketer = objk1("aketer")
  		 end if	 
		
		
		
		d = " select initcap(nama) nama,lpad(no_pekerja,5,0)nop,lokasi from payroll.paymas "
		d = d & " where no_pekerja = '"&pengeluar&"' "
		Set sd = objConn.Execute(d)        		 		
        		
        if not sd.eof then
        	npengeluar = sd("nama")
			nopengeluar = sd("nop")
        else
        	nama = Request.Cookies("gnop")
		end if
		
		k2 = "		  select initcap(keterangan) sketer,initcap(keterangan2) sketer2 from kompaun.butir_kesalahan "
  		k2 = k2 & " where akta = '"&akta&"' and kod = '"&salah&"' "
  		Set objk2 = objConn.Execute(k2)
 				if not objk2.eof then
	  				sketer = objk2("sketer")
					sketer2 = objk2("sketer2")
  		  		end if
		  
		response.write"<p>&nbsp;</p>"
		response.write"<p>&nbsp;</p>"
		response.write"<p>&nbsp;</p><br><br>"
		response.write"<p>&nbsp;&nbsp;&nbsp;"&sb("nama")&"<br>"
		response.write"&nbsp;&nbsp;&nbsp;"&sb("alamat1")&"<br>"
		response.write"&nbsp;&nbsp;&nbsp;"&sb("alamat2")&"<br>"
		response.write"&nbsp;&nbsp;&nbsp;"&sb("alamat3")&"</p></br>"
		response.write"<p>&nbsp;</p>"
		
		
		
%>
<table width="400">
		
		<tr>
		<td colspan="3"><b>SALINAN KOMPAUN BERTARIKH&nbsp;:&nbsp;<%=tkh%></b></td>
		</tr>
		
		<tr>
		<td colspan="3">&nbsp;</td>
		</tr>                                         
		
		<tr>
		<td width="102"><b>No. Akaun</b></td>
		<td width="11"><b>:</b></td>
		<td width="286"><%=no_akaun%></td>
		</tr>   
		
		<tr>
		<td><b>No. Kompaun</b></td>
		<td><b>:</b></td>
		<td><%=no_kompaun%></td>
		</tr>   
		
		<tr>
		<td><b>No. Kenderaan</b></td>
		<td><b>:</b></td>
		<td><%=no_kenderaan%></td>
		</tr> 
		
		<tr>
		<td><b>Tarikh</b></td>
		<td><b>:</b></td>
		<td><%=tkh1%></td>
		</tr> 
		
		<tr>
		<td><b>Tempat</b></td>
		<td><b>:</b></td>
		<td><%=tempat%></td>
		</tr> 
		
		<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td><%=tempat1%></td>
		</tr> 		
</table>
<table width="638">		
		
		
		<tr>
		<td><b>Akta :</b></td>
        <td width="237"><b>Tindakan Notis :</b></td>
		</tr> 
		
		<tr>
		<td><%=akta%>&nbsp;-&nbsp;<%=aketer%></td>
        <td><%=tindakan%></td>
		</tr> 
				
		<tr>
		<td width="389"><b>Kesalahan :</b></td>
		</tr>
		
		<tr>
		<td><%=sketer%><%=sketer2%></td>
		</tr>
		
		<tr>
		<td><b>Butir-Butir Kesalahan : </b></td>
		</tr> 
		
		<tr>
		<td><%=objkd1("catitan")%></td>
		</tr>
		
		<tr>
		<td><b>Pegawai Yang Mengeluarkan Kompaun : </b></td>
		</tr>
		
		<tr>
		<td><%=nopengeluar%>&nbsp;-&nbsp;<%=npengeluar%></td>
		</tr>
		
		 	 		
</table>

<table width="90%">
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td width="14%">45&nbsp;</td>
    <td width="75%">KOMPAUN HALANGAN</td>
    <td width="11%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="14%">&nbsp;</td>
    <td width="75%"><%=sb("nama")%></td>
    <td width="11%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="14%">&nbsp;</td>
    <td width="75%"><%=sb("alamat1")%></td>
    <td width="11%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="14%">&nbsp;</td>
    <td width="75%"><%=sb("alamat2")%>&nbsp;</td>
    <td width="11%"></td>
  </tr>
  <tr> 
    <td width="14%">&nbsp;</td>
    <td width="75%"><%=sb("alamat3")%>&nbsp;</td>
    <td width="11%"></td>
  </tr>
  <tr> 
    <td width="14%">&nbsp;</td>
    <td width="75%">No.Kompaun : <%=sb("no_kompaun")%></td>
    <td width="11%">&nbsp;</td>
  </tr>
  <!-- <tr> 
    <td width="14%"></td>
    <td width="75%">Jumlah Perlu Dibayar : <%'=FormatNumber(sb("amaun"),2)%></td>
    <td width="11%"></td>
  </tr>-->
  <tr> 
    <td width="14%" height="22">&nbsp;</td>
    <td width="75%" height="22"><%=sb("no_akaun")%>&nbsp;&nbsp; <%=sb("tkh1")%> 
      &nbsp;&nbsp;<%=jab%>- 45</td>
    <td width="11%" height="22">&nbsp;</td>
  </tr>
  
  <tr> 
    <td width="14%">&nbsp;Disediakan :</td>
    <td width="75%"><%=nop%>-<%=nama%></td>
    <td width="11%">&nbsp;</td>
  </tr>
  
</table>	
<%	end if	%>
</body>
</html>