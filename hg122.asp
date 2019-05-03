<%Response.Buffer = True%>
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Kemaskini Bayaran</title>
<SCRIPT LANGUAGE="JavaScript">
nextfield = "akaun" ;
function check(b){

if(b.akaun.value==""){
alert("Sila Masukkan No Akaun!!");
b.akaun.focus();
return false}

if(b.tkhbyr.value==""){
alert("Sila Masukkan \nTarikh Bayaran Dibuat!!");
b.tkhbyr.focus();
return false}

if(b.resit.value==""){
alert("Sila Masukkan No Resit!!");
b.resit.focus();
return false}

if(b.amaun.value!=""){
var valid = ".0123456789"
var ok = "yes";
var temp;
for (var i=0; i<b.amaun.value.length; i++) {
temp = "" + b.amaun.value.substring(i, i+1);
if (valid.indexOf(temp) == "-1") ok = "no";
}
if (ok == "no"||b.amaun.value=="0.00") {
alert("Sila Masukkan Amaun Bayaran!!");
b.amaun.focus();
return false}
if(b.amaun.value=="0.00"||b.amaun.value==""){
alert("Anda tidak memasukkan amaun ringgit");
b.amaun.focus();
return false}

}
}
</script>
</head>
<body>
<%response.cookies("amenu") = "hg122.asp"%>
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg122.asp" >
  <%b1 = Request.form("B1")
	b2 = Request.form("B2")
	b3 = Request.form("B3")
	akaun = request.form("akaun")
	tkhbyr = request.form("tkhbyr")
	resit = request.form("resit")
	bil = request.form("bil")
    bilrec = request.form("bilrec")
	
  '================================= rEseT ===========================================
		if b2 = "Reset" then
			bilrec = ""
			akaun = ""
			tkhbyr = ""
			resit = ""
			bil = ""
			kompaun = ""
			amaun = ""
		end if

'   ============
 	  mula
'	============
	
	if b1 = "Hantar" then
		input
	end if

   '================================ pRoseS sImPan ===========================================

	  if bilrec <> "" and b1 <> "Hantar" then 
	  for i = 1 to bilrec 
	  
	  kompaun = "kompaun" + cstr(i)
	  amaun = "amaun" + cstr(i)		
	  frowid = "frowid" + cstr(i)		
	  h = "h" + cstr(i)		
	  kompaun = Request.form(""&kompaun&"")
	  amaun = Request.form(""&amaun&"")
	  rowid = Request.form(""&frowid&"")
	  h = Request.form(""&h&"")  
	 	
	  if b3 = "Simpan" and kompaun <> "" and amaun <> "" then

	  r = " select status_kompaun as status from kompaun.halangan where no_kompaun = '"&kompaun&"' "
	  set sr = objconn.execute(r)
	  
	  if sr.eof then 
	    t = " insert into kompaun.halangan(no_akaun,no_kompaun,tkh_bayar,no_resit,"
		t = t & " amaun_bayar,status_kompaun) values ('"&akaun&"','"&kompaun&"',"
		t = t & " to_date('"&tkhbyr&"','dd/mm/yyyy'),'"&resit&"','"&amaun&"','P')"
		set st = objconn.execute(t)
	else
		status = sr("status")
		if status <> "B" then
			  
	  	s = " update kompaun.halangan set no_akaun = '"&akaun&"',no_resit = '"&resit&"', "
		s = s & " tkh_bayar = to_date('"&tkhbyr&"','dd/mm/yyyy'),amaun_bayar = '"&amaun&"',"
		s = s & " status_kompaun = 'P' where no_kompaun = '"&kompaun&"' "
		s = s & " and status_kompaun <> 'B' "
		set ss = objconn.execute(s)
	  else	  
	  response.write "<script language = ""vbscript"">"
	  response.write " MsgBox ""No Kompaun "& kompaun &" "" + vbNewLine + ""Sudah DiBatal!!"", vbInformation, ""Perhatian!"" "
	  response.write "</script>"
	  
	  end if	  
	  end if
	  
	  elseif h = "Hapus" then
	  	n = " update kompaun.halangan set no_akaun = null,no_resit = null , tkh_bayar = null, "
		n = n & " amaun_bayar = null,status_kompaun = 'I' where rowid = '"&rowid&"' "
		set sn = objconn.execute(n)	 
			
	  end if	  			
	  next	  
	  input
   end if   

sub mula %>
  <table width="100%" bgcolor="<%=color1%>" align="center" cellspacing="1" bordercolor="black" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
    <tr align="right"> 
      <td width="31%" >No Akaun:</td>
      <td align="right" width="12%"> 
        <input type="text" name="akaun" value="<%=akaun%>" size="15" maxlength="13"  onFocus="nextfield='tkhbyr';" >
      </td>
      <td align="left" width="15%"> Tarikh Bayar :</td>
      <td width="42%" align="left"> 
        <input type="text" name="tkhbyr" value="<%=tkhbyr%>" size="10" maxlength="10"  onFocus="nextfield='resit';" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
      </td>
    </tr>
    <tr align="right"> 
      <td width="31%">No Resit:</td>
      <td align="right" width="12%"> 
          <input type="text" name="resit" value="<%=resit%>" size="6" maxlength="6"  onFocus="nextfield='bil';">
      </td>
      <td align="left" width="15%">Bilangan Kompaun:</td>
      <td align="left" width="42%"> 
        <input type="text" name="bil" value="<%=bil%>" size="2" maxlength="2"  onFocus="nextfield='B1';">
        <input type="submit" value="Hantar" name="B1" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
        <input type="submit" value="Reset" name="B2" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
      </td>
    </tr>
    <script>
	document.komp.akaun.focus();
</script>
  </table>
  <%end sub	%>
  </form>
<form name=hg122 method="POST" action="hg122.asp">
<%
'===================================== sub input ============================================
 sub input  
 
 j = " select rowid,no_kompaun kompaun,nvl(amaun_bayar,0) amaun from kompaun.halangan "
 j = j & " where no_akaun = '"&akaun&"' "
 set sj = objconn.execute(j)
  
 %>
 <br>
  <table width="43%" align="center" cellspacing="1" bordercolor="black" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow" >
    <tr bgcolor="<%=color1%>" align="center"> 
      <td width="18%">Bil</td>
      <td width="41%">No Kompaun</td>
      <td width="41%" colspan="2">Amaun Bayaran</td>
    </tr>
    <% 	
	if sj.eof then	
	if bil = "" then bil = 1
	  
     for i = 1 to bil  
		kompaun = ""
		amaun = "" %>
    <tr bgcolor="<%=color2%>" align="center" style="color:black"> 
      <td width="18%"><%=i%></td>
      <td width="41%"> 
        <input type="text" name="kompaun<%=i%>" value="<%=kompaun%>" size="11" maxlength="11" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
      </td>
      <td width="41%" colspan="2"> 
        <input type="text" name="amaun<%=i%>" value="<%=amaun%>" size="10" maxlength="10" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
      </td>
    </tr>
    <tr> 
      <% next 	
	   else	
	   i = 0
	   bil = 0
	do while not sj.eof
		i = i + 1
		bil = bil + 1
		rowid = sj("rowid")		
		kompaun = sj("kompaun")
		amaun = sj("amaun")	
	%>
    <tr bgcolor="<%=color2%>" align="center" style="color:black"> 
      <td width="18%"><%=i%></td>
      <td width="41%"> 
        <input type="text" name="kompaun<%=i%>" value="<%=kompaun%>" size="11" maxlength="11" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
      </td>
      <td width="20%"> 
        <input type="text" name="amaun<%=i%>" value="<%=amaun%>" size="10" maxlength="10" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
      </td>
      <td width="21%"> 
        <input type="submit" value="Hapus" name="h<%=i%>" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold"  onClick="return confirm(' Hapus Satu Data ?')">
         <input type="hidden" name="frowid<%=i%>" value="<%=rowid%>" >
		 </td>
    </tr>
    <tr> 
      <% sj.movenext
	  loop 
	  end if %>
      <td colspan="4" align="center"> 
        <input type="hidden" name="bilrec" value="<%=bil%>" >
        <input type="submit" value="Simpan" name="B3" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
      </td>
    </tr>
  </table>
  <%	end sub	%>
</form>
</body>
</html>