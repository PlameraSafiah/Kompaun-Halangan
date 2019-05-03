<% Response.Buffer = True %>
<html>
<head>
<title>Sistem Kompaun Halangan</title>
</head>
<body>
<!-- '#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg181z.asp" >
<%	response.cookies("amenu") = "hg181z.asp" 

	i = request.querystring("i")
	p2 = request.form("b2")
	bkembali= request.form("bkembali")
	tahun = request.form("tahun")

	if p2 = "Cetak" then response.redirect "hg1811c.asp?i="&tahun&""

%>
  <table align="center" bgcolor="<%=color1%>" width="86%" cellpadding="0" cellspacing="1" border="0" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow; font-weight:bold;">
    <tr align="center"> 
      <td>Tahun  : <%=i%>&nbsp;
		<input type="hidden" value="<%=i%>" name="tahun">
        <input type="submit" value="Cetak" name="b2" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">              
      <input name="button" type="button" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold" onClick="javscript:history.back()" value="Kembali"></td>
    </tr>
</table>

	  <%
		r = " select nvl(count(*),0) kira, nvl(sum(amaun_bayar),0)amaun_bayar,  "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'01','1','0')),0)bulan1, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'01',amaun_bayar,'0')),0)amaun1, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'02','1','0')),0)bulan2, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'02',amaun_bayar,'0')),0)amaun2, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'03','1','0')),0)bulan3, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'03',amaun_bayar,'0')),0)amaun3, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'04','1','0')),0)bulan4, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'04',amaun_bayar,'0')),0)amaun4, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'05','1','0')),0)bulan5, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'05',amaun_bayar,'0')),0)amaun5, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'06','1','0')),0)bulan6, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'06',amaun_bayar,'0')),0)amaun6, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'07','1','0')),0)bulan7, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'07',amaun_bayar,'0')),0)amaun7, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'08','1','0')),0)bulan8, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'08',amaun_bayar,'0')),0)amaun8, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'09','1','0')),0)bulan9, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'09',amaun_bayar,'0')),0)amaun9, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'10','1','0')),0)bulan10,"
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'10',amaun_bayar,'0')),0)amaun10,"
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'11','1','0')),0)bulan11,"
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'11',amaun_bayar,'0')),0)amaun11,"
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'12','1','0')),0)bulan12, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'12',amaun_bayar,'0')),0)amaun12 "
		r = r & " from kompaun.halangan "
		r = r & " where to_char(tkh_kompaun,'yyyy')='"&i&"'"
		r = r & " and amaun_bayar is not null "
		Set rsr = objConn.Execute(r)	

		pbayar1 = 0
		pbayar2 = 0
		pbayar3 = 0
		pbayar4 = 0
		pbayar5 = 0
		pbayar6 = 0
		pbayar7 = 0
		pbayar8 = 0
		pbayar9 = 0
		pbayar10 = 0
		pbayar11 = 0
		pbayar12 = 0
	%>
<br>
<table width="100%" cellspacing="1" align="center">
      <tr bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold; color:yellow;" align="center">
        <td width="17%" height="21">PERKARA</td>
        <td>Jan</td>
        <td>Feb</td>
        <td>Mac</td>
        <td>Apr</td>
        <td>Mei</td>
        <td>Jun</td>
        <td>Jul</td>
        <td>Ogs</td>
        <td>Sep</td>
        <td>Oct</td>
        <td>Nov</td>
        <td>Dec</td>
        <td>Jum</td>
      </tr>
    <%    if not rsr.eof then 
			  kira = cdbl(rsr("kira"))
			  amaun_bayar = cdbl(rsr("amaun_bayar"))
    	   end if

		t = " select nvl(count(*),0) kira, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'01','1','0')),0)bulan1, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'02','1','0')),0)bulan2, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'03','1','0')),0)bulan3, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'04','1','0')),0)bulan4, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'05','1','0')),0)bulan5, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'06','1','0')),0)bulan6, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'07','1','0')),0)bulan7, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'08','1','0')),0)bulan8, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'09','1','0')),0)bulan9, "
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'10','1','0')),0)bulan10,"
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'11','1','0')),0)bulan11,"
		t = t & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'12','1','0')),0)bulan12 "
		t = t & " from kompaun.halangan "
		t = t & " where to_char(tkh_kompaun,'yyyy')='"&i&"'"
		t = t & " and amaun_bayar is null "
		Set rst = objConn.Execute(t)	
		
		ptunggak1 = 0
		ptunggak2 = 0
		ptunggak3 = 0
		ptunggak4 = 0
		ptunggak5 = 0
		ptunggak6 = 0
		ptunggak7 = 0
		ptunggak8 = 0
		ptunggak9 = 0
		ptunggak10 = 0
		ptunggak11 = 0
		ptunggak12 = 0
	
	 	if not rst.eof then 			kira = cdbl(rst("kira"))

		s = " select nvl(count(*),0)kira, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'01','1','0')),0)bulan1, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'02','1','0')),0)bulan2, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'03','1','0')),0)bulan3, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'04','1','0')),0)bulan4, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'05','1','0')),0)bulan5, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'06','1','0')),0)bulan6, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'07','1','0')),0)bulan7, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'08','1','0')),0)bulan8, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'09','1','0')),0)bulan9, "
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'10','1','0')),0)bulan10,"
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'11','1','0')),0)bulan11,"
		s = s & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'12','1','0')),0)bulan12 "
		s = s & " from kompaun.halangan "
		s = s & " where to_char(tkh_kompaun,'yyyy')='"&i&"'"
		Set rss = objConn.Execute(s)	
	  		
	  	if not rss.eof then 
			kira = cdbl(rss("kira"))
			if cdbl(rsr("bulan1")) > 0 then  pbayar1 = round((cdbl(rsr("bulan1"))/cdbl(rss("bulan1"))) * 100,2)	
			if cdbl(rsr("bulan2")) > 0 then  pbayar2 = round((cdbl(rsr("bulan2"))/cdbl(rss("bulan2"))) * 100,2)	
			if cdbl(rsr("bulan3")) > 0 then  pbayar3 = round((cdbl(rsr("bulan3"))/cdbl(rss("bulan3"))) * 100,2)	
			if cdbl(rsr("bulan4")) > 0 then  pbayar4 = round((cdbl(rsr("bulan4"))/cdbl(rss("bulan4"))) * 100,2)	
			if cdbl(rsr("bulan5")) > 0 then  pbayar5 = round((cdbl(rsr("bulan5"))/cdbl(rss("bulan5"))) * 100,2)	
			if cdbl(rsr("bulan6")) > 0 then  pbayar6 = round((cdbl(rsr("bulan6"))/cdbl(rss("bulan6"))) * 100,2)	
			if cdbl(rsr("bulan7")) > 0 then  pbayar7 = round((cdbl(rsr("bulan7"))/cdbl(rss("bulan7"))) * 100,2)	
			if cdbl(rsr("bulan8")) > 0 then  pbayar8 = round((cdbl(rsr("bulan8"))/cdbl(rss("bulan8"))) * 100,2)	
			if cdbl(rsr("bulan9")) > 0 then  pbayar9 = round((cdbl(rsr("bulan9"))/cdbl(rss("bulan9"))) * 100,2)	
			if cdbl(rsr("bulan10")) > 0 then  pbayar10 = round((cdbl(rsr("bulan10"))/cdbl(rss("bulan10"))) * 100,2)	
			if cdbl(rsr("bulan11")) > 0 then  pbayar11 = round((cdbl(rsr("bulan11"))/cdbl(rss("bulan11")))* 100,2)	
			if cdbl(rsr("bulan12")) > 0 then  pbayar12 = round((cdbl(rsr("bulan12"))/cdbl(rss("bulan12"))) * 100,2)
	
			if cdbl(rst("bulan1")) > 0 then  ptunggak1 = round((cdbl(rst("bulan1"))/cdbl(rss("bulan1"))) * 100,2)	
			if cdbl(rst("bulan2")) > 0 then  ptunggak2 = round((cdbl(rst("bulan2"))/cdbl(rss("bulan2"))) * 100,2)	
			if cdbl(rst("bulan3")) > 0 then  ptunggak3 = round((cdbl(rst("bulan3"))/cdbl(rss("bulan3"))) * 100,2)	
			if cdbl(rst("bulan4")) > 0 then  ptunggak4 = round((cdbl(rst("bulan4"))/cdbl(rss("bulan4"))) * 100,2)	
			if cdbl(rst("bulan5")) > 0 then  ptunggak5 = round((cdbl(rst("bulan5"))/cdbl(rss("bulan5"))) * 100,2)	
			if cdbl(rst("bulan6")) > 0 then  ptunggak6 = round((cdbl(rst("bulan6"))/cdbl(rss("bulan6"))) * 100,2)	
			if cdbl(rst("bulan7")) > 0 then  ptunggak7 = round((cdbl(rst("bulan7"))/cdbl(rss("bulan7"))) * 100,2)	
			if cdbl(rst("bulan8")) > 0 then  ptunggak8 = round((cdbl(rst("bulan8"))/cdbl(rss("bulan8"))) * 100,2)	
			if cdbl(rst("bulan9")) > 0 then  ptunggak9 = round((cdbl(rst("bulan9"))/cdbl(rss("bulan9"))) * 100,2)	
			if cdbl(rst("bulan10")) > 0 then  ptunggak10 = round((cdbl(rst("bulan10"))/cdbl(rss("bulan10"))) * 100,2)	
			if cdbl(rst("bulan11")) > 0 then  ptunggak11 = round((cdbl(rst("bulan11"))/cdbl(rss("bulan11"))) * 100,2)	
			if cdbl(rst("bulan12")) > 0 then  ptunggak12 = round((cdbl(rst("bulan12"))/cdbl(rss("bulan12"))) * 100,2)	
			end if

		jbayar = round((cdbl(rsr("kira"))/cdbl(rss("kira"))) * 100,2)	
		jtunggak = round((cdbl(rst("kira"))/cdbl(rss("kira"))) * 100,2)
    %>


      <tr bgcolor="#CCCCCC" style="font-family: Trebuchet MS; font-size: 10pt;" align="center">
        <td  bgcolor="<%=color1%>" align="left" style="font-weight:bold; color:yellow;">Bil Kompaun <br>Telah Dibayar</td>
        <td ><%if cdbl(rsr("bulan1")) > 0 then%><%=rsr("bulan1")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar1) > 0 then%><%=pbayar1%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan2")) > 0 then%><%=rsr("bulan2")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar2) > 0 then%><%=pbayar2%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan3")) > 0 then%><%=rsr("bulan3")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar3) > 0 then%><%=pbayar3%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan4")) > 0 then%><%=rsr("bulan4")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar4) > 0 then%><%=pbayar4%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan5")) > 0 then%><%=rsr("bulan5")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar5) > 0 then%><%=pbayar5%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan6")) > 0 then%><%=rsr("bulan6")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar6) > 0 then%><%=pbayar6%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan7")) > 0 then%><%=rsr("bulan7")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar7) > 0 then%><%=pbayar7%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan8")) > 0 then%><%=rsr("bulan8")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar8) > 0 then%><%=pbayar8%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan9")) > 0 then%><%=rsr("bulan9")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar9) > 0 then%><%=pbayar9%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan10")) > 0 then%><%=rsr("bulan10")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar10) > 0 then%><%=pbayar10%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan11")) > 0 then%><%=rsr("bulan11")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar11) > 0 then%><%=pbayar11%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("bulan12")) > 0 then%><%=rsr("bulan12")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(pbayar12) > 0 then%><%=pbayar12%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rsr("kira")) > 0 then%><%=rsr("kira")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl (jbayar) < cdbl(jbayar) then %><%=jbayar%>&nbsp;<%elseif cdbl(jbayar) > 0 then%>
        	<%=jbayar%>%&nbsp;<%end if%></td>
      </tr>
      <tr bgcolor="#CCCCCC" style="font-family: Trebuchet MS; font-size: 10pt; " align="center">
        <td bgcolor="<%=color1%>" align="left" style="font-weight:bold; color:yellow;">Bil Kompaun Tertunggak</td>
        <td><%if cdbl(rst("bulan1")) > 0 then%><%=rst("bulan1")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak1) > 0 then%><%=ptunggak1%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan2")) > 0 then%><%=rst("bulan2")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak2) > 0 then%><%=ptunggak2%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan3")) > 0 then%><%=rst("bulan3")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak3) > 0 then%><%=ptunggak3%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan4")) > 0 then%><%=rst("bulan4")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak4) > 0 then%><%=ptunggak4%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan5")) > 0 then%><%=rst("bulan5")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak5) > 0 then%><%=ptunggak5%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan6")) > 0 then%><%=rst("bulan6")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak6) > 0 then%><%=ptunggak6%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan7")) > 0 then%><%=rst("bulan7")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak7) > 0 then%><%=ptunggak7%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan8")) > 0 then%><%=rst("bulan8")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak8) > 0 then%><%=ptunggak8%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan9")) > 0 then%><%=rst("bulan9")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak9) > 0 then%><%=ptunggak9%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan10")) > 0 then%><%=rst("bulan10")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak10) > 0 then%><%=ptunggak10%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan11")) > 0 then%><%=rst("bulan11")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak11) > 0 then%><%=ptunggak11%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("bulan12")) > 0 then%><%=rst("bulan12")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl(ptunggak12) > 0 then%><%=ptunggak12%>%&nbsp;<%end if%></td>
        <td><%if cdbl(rst("kira")) > 0 then%><%=rst("kira")%><%else%>&nbsp;<%end if%><br>
        	<%if cdbl (jtunggak) < cdbl(jtunggak) then %><%=jtunggak%>&nbsp;<%elseif cdbl(jtunggak) > 0 then%>
        	<%=jtunggak%>%&nbsp;<%end if%></td>
      </tr>
      <tr bgcolor="#CCCCCC" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold;" align="center">
        <td height="38" align="left" bgcolor="<%=color1%>" style="color:yellow;">Jumlah Kompaun Dikeluarkan</td>
        <td><%if cdbl(rss("bulan1")) > 0 then%><%=rss("bulan1")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan2")) > 0 then%><%=rss("bulan2")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan3")) > 0 then%><%=rss("bulan3")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan4")) > 0 then%><%=rss("bulan4")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan5")) > 0 then%><%=rss("bulan5")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan6")) > 0 then%><%=rss("bulan6")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan7")) > 0 then%><%=rss("bulan7")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan8")) > 0 then%><%=rss("bulan8")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan9")) > 0 then%><%=rss("bulan9")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan10")) > 0 then%><%=rss("bulan10")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan11")) > 0 then%><%=rss("bulan11")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("bulan12")) > 0 then%><%=rss("bulan12")%><%else%><%end if%><br></td>
        <td><%if cdbl(rss("kira")) > 0 then%><%=rss("kira")%><%else%><%end if%></td>
      </tr>
      <tr bgcolor="#CCCCCC" style="font-family: Trebuchet MS; font-size: 9pt; font-weight:bold;" align="center">
        <td height="38" align="left" bgcolor="<%=color1%>" style="color:yellow;">Jumlah Amaun <br>Bayaran (RM) </td>
        <td><%if cdbl(rsr("amaun1")) > 0 then%><%=formatnumber(rsr("amaun1"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun2")) > 0 then%><%=formatnumber(rsr("amaun2"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun3")) > 0 then%><%=formatnumber(rsr("amaun3"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun4")) > 0 then%><%=formatnumber(rsr("amaun4"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun5")) > 0 then%><%=formatnumber(rsr("amaun5"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun6")) > 0 then%><%=formatnumber(rsr("amaun6"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun7")) > 0 then%><%=formatnumber(rsr("amaun7"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun8")) > 0 then%><%=formatnumber(rsr("amaun8"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun9")) > 0 then%><%=formatnumber(rsr("amaun9"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun10")) > 0 then%><%=formatnumber(rsr("amaun10"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun11")) > 0 then%><%=formatnumber(rsr("amaun11"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun12")) > 0 then%><%=formatnumber(rsr("amaun12"),2)%><%else%><%end if%><br>
        <td><%if cdbl(rsr("amaun_bayar")) > 0 then%><%=formatnumber(rsr("amaun_bayar"),2)%><%else%><%end if%></td>
      </tr>
  </table>	
</form>
</body>
</html>