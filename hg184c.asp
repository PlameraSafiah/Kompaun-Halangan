<html>
<head>
<title>Sistem Kompaun Halangan</title>
</head>
<body onload='self.print()' topmargin="0" leftmargin="0">
<%	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open "dsn=12c;uid=majlis;pwd=majlis;"

    tahund = Request.querystring("tahund")

	f="select to_char(sysdate,'dd-mm-yyyy  hh24:mi:ss') as tkhs from dual "
   	Set objRs1a = objConn.Execute(f)	
   	tkhs = objrs1a("tkhs")

	s = " select nama from majlis.syarikat "     	
	Set objRss = objConn.Execute(s)
	namas = objRss("nama")

%>
<table width="100%" border="0" >
  <tr style="font-family: Trebuchet MS; font-size: 8pt;"> 
    <td width="20%" align="left" ><i><%=tkhs%></i></td>
    <td width="60%"></td>
    <!--<td width="20%" align="right" >Mukasurat&nbsp;<%=muka%></td>-->
  </tr>
<tr style="font-family: Trebuchet MS; font-size: 12pt; font-weight:bold;"> 
    <td colspan="3" align="center" ><%=namas%>
    </td></tr>
<tr>
  <td >&nbsp;</td>
  <td align="center"><font size="3"><b>LAPORAN PENDAKWAAN MENGIKUT TAHUN&nbsp;<%=tahund%></b></font></td>
  <td width="20%" >&nbsp;</td>
</tr>
</table>
	  <%
			'end sub 
		r = " select nvl(count(*),0) kira, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'01','1','0')),0)bulan1, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'02','1','0')),0)bulan2, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'03','1','0')),0)bulan3, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'04','1','0')),0)bulan4, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'05','1','0')),0)bulan5, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'06','1','0')),0)bulan6, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'07','1','0')),0)bulan7, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'08','1','0')),0)bulan8, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'09','1','0')),0)bulan9, "
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'10','1','0')),0)bulan10,"
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'11','1','0')),0)bulan11,"
		r = r & " nvl(sum(decode(to_char(tkh_kompaun,'mm'),'12','1','0')),0)bulan12 "
		r = r & " from kompaun.halangan "
		r = r & " where to_char(tkh_kompaun,'yyyy')='"&tahund&"'"
		r = r & " and status_kompaun='N' "
		Set rsr = objConn.Execute(r)	
		
		'pmahkamah1 = 0
	%>
<br>
<table width="100%" border="1" cellspacing="0" >
      <tr bgcolor="#DDDDDD"  border="1" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold; ">
        <td width="19%" align="center">PERKARA</td>
        <td align="center">Jan</td>
        <td align="center">Feb</td>
        <td align="center">Mac</td>
        <td align="center">Apr</td>
        <td align="center">Mei</td>
        <td align="center">Jun</td>
        <td align="center">Jul</td>
        <td align="center">Ogs</td>
        <td align="center">Sep</td>
        <td align="center">Oct</td>
        <td align="center">Nov</td>
        <td align="center">Dec</td>
        <td align="center">Jum</td>
      </tr>
    <%  	if not rsr.eof then 
			  kira = cdbl(rsr("kira"))
			end if
    %>
      <tr style="font-family: Trebuchet MS; font-size: 10pt; " >
        <td bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; font-weight:bold; ">Kompaun MPSP 303 </td>
        <td align="center"><%if cdbl(rsr("bulan1")) > 0 then%><%=rsr("bulan1")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan2")) > 0 then%><%=rsr("bulan2")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan3")) > 0 then%><%=rsr("bulan3")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan4")) > 0 then%><%=rsr("bulan4")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan5")) > 0 then%><%=rsr("bulan5")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan6")) > 0 then%><%=rsr("bulan6")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan7")) > 0 then%><%=rsr("bulan7")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan8")) > 0 then%><%=rsr("bulan8")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan9")) > 0 then%><%=rsr("bulan9")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan10")) > 0 then%><%=rsr("bulan10")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan11")) > 0 then%><%=rsr("bulan11")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("bulan12")) > 0 then%><%=rsr("bulan12")%><%else%>&nbsp;<%end if%><br>
		</td>
        <td align="center"><%if cdbl(rsr("kira")) > 0 then%><%=rsr("kira")%><%else%>&nbsp;<%end if%></td>
      </tr>
</table>	
<%	'end if %>
</form>
</body>
</html>