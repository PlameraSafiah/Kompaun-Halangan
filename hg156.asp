<% Response.Buffer = True%>
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<SCRIPT LANGUAGE="JavaScript">
nextfield = "tkhd";

	function showkaunter(form)
	{ 
	  var item = form.jkaunter.selectedIndex; 
	  choice = form.jkaunter.options[item].value;
	  if (choice!="") top.location.href=""+(choice); 
	};	
</script>
<style>
<!-- a {text-decoration:none}
//-->
</style>
<!-- #INCLUDE FILE="menukom.asp" -->
<FORM action="hg156.asp" method=post>
  <%	response.cookies("amenu") = "hg156.asp" %>
  <table bgcolor="<%=color1%>" width="100%" cellpadding="0" cellspacing="1" border="0" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
    <tr> 
      <td width="43%" align="right" >Pilih Carian:</td>
      <td width="57%" align="left"> 
        <select name="jkaunter" onChange="showkaunter(this.form);">
          <option selected value="">Pilih satu</option>
          <%	kodp = request.querystring("pilih")
				select case kodp
				case "1"	%>
          <option selected value="hg156.asp?pilih=1">Tarikh Kompaun</option>
          <option value="hg156.asp?pilih=2">No Kompaun</option>
		   <option value="hg156.asp?pilih=3">Tarikh Mahkamah</option>
          <%	case "2"	%>
          <option value="hg156.asp?pilih=1">Tarikh Kompaun</option>
          <option selected value="hg156.asp?pilih=2">No Kompaun</option>
		   <option value="hg156.asp?pilih=3">Tarikh Mahkamah</option>
		       <%	case "3"	%>
          <option value="hg156.asp?pilih=1">Tarikh Kompaun</option>
          <option  value="hg156.asp?pilih=2">No Kompaun</option>
		  <option selected value="hg156.asp?pilih=3">Tarikh Mahkamah</option>
          <%	case "" 	%>
          <option value="hg156.asp?pilih=1">Tarikh Kompaun</option>
          <option value="hg156.asp?pilih=2">No Kompaun</option>
		  <option value="hg156.asp?pilih=3">Tarikh Mahkamah</option>		  
          <%	end select
				kod = Request.QueryString("pilih")%>
        </select>
      </td>
    </tr>
  </table>
</form>
<form method="post" name="komp" action="hg156.asp?pilih=<%=kod%>">
  <table bgcolor="<%=color1%>" cellspacing="1" style="font-family: Trebuchet MS; font-size: 10pt; color:white; font-weight: bold" width="100%" align="center" cellpadding="0">
    <%  kod = request.querystring("pilih")
		kompaund = request.form("kompaund")
		kompaunh = request.form("kompaunh")
		tkhd = request.form("tkhd")
		tkhh = request.form("tkhh")
  		proses = request.form("b")
		proses1 = request.form("b1")
		
		if proses1 = "Reset" then
			kelompokd = ""
			kelompokh = ""
			bulan = ""
			jab = ""
		end if
		
		if tkhd = "" and (kod = "1" or kod ="3") then
		  f = " select '01/'||to_char(sysdate,'mm/yyyy')tkhd, "
		  f = f & " to_char(sysdate,'dd/mm/yyyy') tkhh from dual "
		  set sf = objconn.execute(f)
		  
		  tkhd = sf("tkhd")
		  tkhh = sf("tkhh")
		 end if
 							
		if kod = "1" or kod = "3" then	%>
    <tr> 
      <td width="38%" align="right">Tarikh Kompaun Dari:</td>
      <td width="10%"> 
        <input type="text" name="tkhd" value="<%=tkhd%>" onFocus="nextfield='tkhh';" size="10" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
      </td>
      <td width="10%">&nbsp;Hingga:</td>
      <td width="42%"> 
        <input type="text" name="tkhh" value="<%=tkhh%>" onFocus="nextfield='b';" size="10" maxlength="10" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
        <input type="submit" name="b" value="Hantar">
        <input type="submit" name="b1" value="Reset">
      </td>
    </tr>
    <% elseif kod = "2" then %>
    <tr> 
      <td width="38%" align="right">No Kompaun Dari:</td>
      <td width="10%"> 
        <input type="text" name="kompaund" size="11" maxlength="11" value="<%=kompaund%>" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
      </td>
      <td width="10%">Hingga</td>
      <td width="42%"> 
        <input type="text" name="kompaunh" size="11" maxlength="11" value="<%=kompaunh%>" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
        <input type="submit" name="b" value="Hantar">
        <input type="submit" name="b1" value="Reset">
      </td>
    </tr>
    <%  end if %>
  </table>
  <%  if proses = "Hantar" then
		hantar
	end if
  
sub hantar

	if kod= "2" and (kompaund = "" or kompaunh = "") then
	  response.write "<script language = ""vbscript"">"
	  response.write " MsgBox ""Sila Masukkan No Kompaun !!"", vbInformation, ""Perhatian!"" "
	  response.write "</script>"
	  response.end
    end if

   	if kompaund <> "" and kompaunh <> "" then
	d = " select no_kompaun,upper(nama) nama,to_char(tkh_undang,'dd/mm/yyyy') as tkh_undang, "
	d = d & " to_char(tkh_kompaun,'dd/mm/yyyy') as tkh_kompaun,akta,kesalahan "
	d = d & " from kompaun.halangan "
	d = d & " where no_kompaun between '"&kompaund&"' and '"&kompaunh&"' "
	d = d & " and status_kompaun = 'M' "	
	
	elseif tkhd <> "" and tkhh <> "" and kod = "1" then
	d = " select no_kompaun,upper(nama) nama,to_char(tkh_undang,'dd/mm/yyyy') as tkh_undang, "
	d = d & " to_char(tkh_kompaun,'dd/mm/yyyy') as tkh_kompaun,akta,kesalahan "
	d = d & " from kompaun.halangan "
	d = d & " where tkh_kompaun between to_date('"&tkhd&"','dd/mm/yyyy') "
	d = d & " and to_date('"&tkhh&"','dd/mm/yyyy') "
	d = d & " and status_kompaun = 'M' "
	
	elseif tkhd <> "" and tkhh <> "" and kod = "3" then
	d = " select no_kompaun,upper(nama) nama,to_char(tkh_undang,'dd/mm/yyyy') as tkh_undang, "
	d = d & " to_char(tkh_kompaun,'dd/mm/yyyy') as tkh_kompaun,akta,kesalahan "
	d = d & " from kompaun.halangan "
	d = d & " where tkh_undang between to_date('"&tkhd&"','dd/mm/yyyy') "
	d = d & " and to_date('"&tkhh&"','dd/mm/yyyy') "
	d = d & " and status_kompaun = 'M' "
	
	end if	
	set sd = objconn.execute(d)
	
	if sd.eof then
	  response.write "<script language = ""vbscript"">"
	  response.write " MsgBox ""Maaf, Tiada Rekod !!"", vbInformation, ""Perhatian!"" "
	  response.write "</script>"
    else	
%>
  <table border="1" width="100%" align="center" cellpadding="1" cellspacing="0">
    <tr style="font-family: Trebuchet MS; font-size: 10pt; color:yellow" align="center" bgcolor="<%=color1%>"> 
      <td width="3%">Bil</td>
      <td width="10%">Akta / UUK</td>
      <td width="8%">Kesalahan</td>
      <td width="12%">No Kompaun</td>
      <td width="41%">Nama</td>
      <td width="13%">Tkh Kompaun</td>
      <td width="13%">Tkh Mahkamah</td>
    </tr>
    <%  bil = 0
	    do while Not sd.eof 
		bil = bil + 1	  %>
    <tr style="font-family: Trebuchet MS; font-size: 10pt;" align="center" bgcolor="<%=color2%>"> 
      <td width="3%"><%=bil%></td>
      <td width="10%"><%=sd("akta")%></td>
      <td width="8%"><%=sd("kesalahan")%></td>
      <td width="12%"><%=sd("no_kompaun")%></td>
      <td width="41%" align="left"><%=sd("nama")%></td>
      <td width="13%"><%=sd("tkh_kompaun")%></td>
      <td width="13%"><%=sd("tkh_undang")%></td>
    </tr>
    <%  	sd.MoveNext			
		  	Loop	
			end if	%>
  </table>
  <%  end sub	  %>
</form>
