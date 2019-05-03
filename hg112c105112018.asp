<%response.buffer = True %>

<html>
<head>
<title>Notis Kompaun</title>

<STYLE TYPE="text/css">
<!--
#tengah {
text-align: justify;
}
    -->
</STYLE>
</head>


<body topmargin="0" leftmargin="0">
<form method="POST" action="hg112c1.asp">


<% 
	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"
	
	bilcount = Request.form("bilrec")
	
	tt = " select to_char(sysdate,'dd-mm-yyyy hh24:mi:ss') tkhs, to_char(sysdate,'dd/mm/yyyy') tkhss from dual "
	Set objRstt = objConn.Execute(tt)
	tkhd = objRstt("tkhs")
	tkhdd = objRstt("tkhss")
	
		for i = 1 to bilcount

		hrowid = "hrowid" + cstr(i)
		hkompaun = "hkompaun" + cstr(i)
		hprint = "hprint" + cstr(i)
	
		frowid = Request.form(""&hrowid&"")
	    fkompaun = Request.form(""&hkompaun&"")
		fprint = Request.form(""&hprint&"")
				
		if fprint = "Y" then
		
  		d = " select no_kompaun,upper(nama) nama,alamat1, alamat2, alamat3, nvl(to_char(masa),0) masa, "
		d = d & " to_char(tkh_kompaun,'dd/mm/yyyy') as tkh_kompaun,akta,kesalahan,initcap(tempat)tempat,"
		d = d & " initcap(tempat1)tempat1,nvl(amaun,0)amaun,no_fail,butir_kesalahan, catitan , "
        d = d &  "to_char(tkh_kompaun,'mm') tkhmm, to_char(tkh_kompaun,'yyyy') tkhyy "
		d = d & " from kompaun.halangan "
		d = d & " where rowid = '"&frowid&"' "
		d = d & " and status_kompaun = 'N' "
		Set sd = objConn.Execute(d)
		
		
		if not sd.eof then	
		akta = sd("akta")
		kesalahan = sd("kesalahan")
		waktu = sd("masa")
		no_kompaun = sd("no_kompaun")
        tkhmm = sd("tkhmm")
	    tkhyy = sd("tkhyy")


		'kemaskini untuk keluarkan catitan --- > nadia (03032017)   
		pq = " select initcap(catitan) as catitan from kompaun.halangan  "
		pq = pq & " where rowid = '"&frowid&"' and status_kompaun = 'N' "
		set spq = objconn.execute(pq)

		
		p = " update kompaun.halangan set cetak_notis = 'Y', tkh_notis1 = to_date('"&tkhdd&"','dd/mm/yyyy') "
		p = p & " where rowid = '"&frowid&"' "
		set sp = objconn.execute(p)
		
		
		
		sqd = " select initcap(keterangan) keterangan from kompaun.akta "
    	sqd = sqd & " where kod = '"& akta &"' "
	  	Set Sqd = objConn.Execute(sqd)
		if not Sqd.eof then
			aktaketer = Sqd("keterangan")
		end if
		
		
		
'	    m = " select initcap('"&replace(sd("butir_kesalahan"),"'","")&"') catitan from dual "
'		set sm = objconn.execute(m)
'		if not sm.eof then catitan = sm("catitan")			
	
	
	 
		c = " select upper(keterangan||' '||keterangan2) terang from kompaun.butir_kesalahan " 
		c = c & " where akta = '"&akta&"' and kod = '"&kesalahan&"' "
		Set sc = objConn.Execute(c)
		
		
		
		if not sc.eof then
			jenis_salah = sc("terang")
		end if
		
		
		
		
    	if waktu = 24 then
   				waktu1 = 12
   				ampm = "Pagi"
   			else
			
   			if waktu >=  13 and waktu < 19 then
   				waktu1 = waktu - 12
   				ampm = "Petang"   			
   			else
			
			if waktu >=  19 then
   				waktu1 = waktu - 12
   				ampm = "Malam"   			
   			else
			
			if waktu >=  12.00 and waktu < 13 then
   				waktu1 = waktu
   				ampm = "Tengahari"   			
   			else
   				if waktu < 12.00 then
   				waktu1 = waktu
   				ampm = "Pagi"	
   			end if
   			end if
			end if
		    end if
   		end if
				
				
				
				
		akta1 = mid(akta,1,1)
		
		if akta1 = "A" then 
			ayat = "Seksyen"
		else
			ayat = 	"Undang-Undang Kecil"
		end if
			
%>
<p class="standard"></p>
<br>
<p class="standard">
  
  
  
  <table width="78%" cellspacing=0 cellpadding=0 style="font-family: Times New Roman; font-size: 11pt;" align="center">
    <tr>
      <td colspan="3"><table width="100%" height="64" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="13%" height="64" align="center"><img src="mpsp.jpg" width="60" height="64"></td>
            <td width="71%" align="center"><font color="#005E2F"><b>MAJLIS 
                PERBANDARAN SEBERANG PERAI</b></font><font size="1"><br>
                Menara MPSP,
                Jalan Perda Utama, Bandar Perda, 14000 Bukit Mertajam<br>
                No. Telefon : 04-549 7555 No. Faks : 04-538 9700, 539 5588 </font></td>
            <td width="16%" align="left">&nbsp;</td>
          </tr>
      </table>
      <img src="line.jpg" width="600" height="12"></td>
    </tr>
    <tr > 
      <td width="13%">No Fail</td>
      <td width="3%">:</td>
      <td colspan="2" width="84%">NH/303/<%=tkhmm%>/<%=tkhyy%>&nbsp;&nbsp;<%=no_kompaun%></td>
    </tr>
    <tr > 
      <td  width="13%">Tarikh</td>
      <td  width="3%" >:</td>
      <td colspan="2" width="84%" ><%=tkhdd%></td>
    </tr>
    <tr valign="baseline"> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr bordercolor="#CC3300" > 
      <td colspan="3">Kepada :</td><td width="20%" rowspan="4"><img src="cop.jpeg" width="260" height="55"><font color="#990000" face="Tahoma, Geneva, sans-serif"><br>
        &nbsp;&nbsp;<B>UNTUK TINDAKAN MAHKAMAH</B></font></td>
    </tr>
    <tr > 
      <td colspan="3"><%=sd("nama")%></td>
    </tr>
    <tr > 
      <td colspan="3"><%=sd("alamat1")%></td>
    </tr>
    <tr > 
      <td colspan="3"><%=sd("alamat2")%>&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3"><%=sd("alamat3")%>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr >
      <td colspan="3">Tuan/Puan,</td>
    </tr>
    <tr>
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3"><u><b>PEMBERITAHUAN TENTANG 
        KESALAHAN :<%=jenis_salah%></b></u></td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3">Rujukan <%=ayat%>&nbsp;<%=kesalahan%>,&nbsp;<%=aktaketer%>.</td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3"><u><b>BUTIR-BUTIR KESALAHAN</b></u> </td>
    </tr>
  </table>    
  <table width=78% cellspacing="0" cellpadding="0" style="font-family: Times New Roman; font-size: 11pt;" align="center">
    <tr > 
      <td width=24%>&nbsp;NO KOMPAUN</td>
      <td width=76%>: <%=sd("no_kompaun")%></td>
    </tr>
    <tr > 
      <td width=24%>&nbsp;TARIKH</td>
      <td width=76%>: <%=sd("tkh_kompaun")%></td>
    </tr>
    <tr > 
      <td width=24%>&nbsp;WAKTU</td>
      <td width=76%>: <%=FormatNumber(waktu1,2)%>&nbsp;<%=ampm%></td>
    </tr>
    <tr > 
      <td width=24%>&nbsp;TEMPAT</td>
      <td width=76%>: <%=sd("tempat")%></td>
    </tr>
    <tr >
      <td width=24%></td>
      <td width=76%>&nbsp;&nbsp;<%=sd("tempat1")%></td>
    </tr>
    <tr > 
      <td width=24%>&nbsp;CATITAN</td>
      <td width=76% rowspan="2" valign="top">: <%=spq("catitan")%></td>
    </tr>
    <tr> 
      <td width=24%>&nbsp;</td>
    </tr>
  </table>



  <table width="78%" border="0" cellspacing="0" cellpadding="1" align="center" style="font-family: Times New Roman; font-size: 11pt;">
    <tr> 
      <td> 
        <p align="justify" id=tengah>2. Dengan ini adalah diberitahu tuan/puan 
          bolehlah bertemu dengan Pegawai Kompaun di Jabatan Undang-Undang, Majlis 
          Perbandaran Seberang Perai, Jalan Perda Utama, Bandar Perda, 14000 Bukit 
          Mertajam atau Pegawai Penguatkuasa, Majlis Perbandaran Seberang Perai, Jalan 
          Betek, 14000 Bukit Mertajam di antara 8.00 pagi hingga 4.00 petang pada 
          hari bekerja dalam tempoh 14 hari dari tarikh notis ini dikeluarkan 
          untuk menyelesaikan kes ini supaya dakwaan di mahkamah tidak perlu diteruskan. 
          Sila abaikan notis ini sekiranya pembayaran sudah dibuat.</p>
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td> 
        <p align="justify" id=tengah>3. Pembayaran boleh dibuat dengan 
          <b>WANG TUNAI / KIRIMAN POS / CEK</b> dibayar kepada Majlis Perbandaran 
          Seberang Perai, Menara MPSP, Jalan Perda Utama, Bandar Perda, 14000 Bukit Mertajam 
          dan di palang dengan perkataan <b>"AKAUN PENERIMAAN SAHAJA"</b>.</p>      </td>
    </tr>
	 <tr>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td > 
        <p> Sekian, terima kasih.</p>      </td>
    </tr>
    <tr> 
      <td>        <p ><br>
          <br>
          <br>
          <br>
          Pengarah Direktorat Penguatkuasaan<br>
          b.p Setiausaha Perbandaran <br>
          Majlis Perbandaran Seberang Perai</p>
        <p ><br>
          &nbsp;</p>
        <p style="font-size: 9pt;">(Notis ini adalah cetakan berkomputer. Tandatangan tidak diperlukan.)</p>
      </td>
    </tr>
	<tr> 
      <td height="20">&nbsp;<br>&nbsp;<br></td>
    </tr>
    <tr>
      <td align="left" > 
        &nbsp;PK-PPH / DP Lampiran 3 </td>
    </tr>
    <tr>
      <td align="left" > 
        &nbsp;Keluaran 1 (01.05.2017) </td>
    </tr>
  </table>
  
  
<%	end if
	end if
	next	
%>
</form>
</body>
</html>