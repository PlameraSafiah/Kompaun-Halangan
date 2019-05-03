<%Response.Buffer = True%>
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Kemaskini Bayaran</title>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
nextfield = "kompaun";
//End -->
</script>

<SCRIPT LANGUAGE="JavaScript">
function check(b){
if(b.kompaun.value==""){
alert("Sila Masukkan No Kompaun!!");
b.kompaun.focus();
return false}

if(b.akaun.value==""){
alert("Sila Masukkan No Akaun!!");
b.akaun.focus();
return false}

if(b.resit.value==""){
alert("Sila Masukkan No Resit!!");
b.resit.focus();
return false}

if(b.amaun_bayar.value!=""){
var valid = ".0123456789"
var ok = "yes";
var temp;
for (var i=0; i<b.amaun_bayar.value.length; i++) {
temp = "" + b.amaun_bayar.value.substring(i, i+1);
if (valid.indexOf(temp) == "-1") ok = "no";
}
if (ok == "no"||b.amaun_bayar.value=="0.00") {
alert("Sila Masukkan Amaun Bayaran!!");
b.amaun_bayar.focus();
return false}
if(b.amaun_bayar.value=="0.00"||b.amaun_bayar.value==""){
alert("Anda tidak memasukkan amaun ringgit");
b.amaun_bayar.focus();
return false}

}
if(b.tbayar.value==""){
alert("Sila Masukkan Tarikh Bayaran!!");
b.tbayar.focus();
return false}
}
function invalid_tarikh(c)
	{
		alert (c+" Tarikh Salah !!! ");
		return(true);
	}
</script>
</head>
<body>

<%response.cookies("amenu") = "hg121.asp"%>
<!-- '#INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg121.asp" > 
<%	
	b1 = Request.form("B1")
	b2 = Request.form("B2")
	b3 = Request.form("B3")
	kompaun = Request.form("kompaun")
	akaune   = Request.form("akaune")
	'response.write akaune
  '================================= rEseT ===========================================
		if b3 = "Reset" then
			kompaun = ""
			akaune   = ""
		end if

'   ============
 	  mula
'	============

   '================================ Simpan ===========================================
   if b2 = "Simpan" then
		rowid = request.form("rowid")
		resit = Request.form("resit")
		tbayar = Request.form("tbayar")
		amaun_bayar = Request.form("amaun_bayar")
		tkh_kompaun = request.form("tkh_kompaun")
		akaun = request.form("akaun")
		
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
				
		f = " update kompaun.halangan set no_akaun = '"&akaun&"',no_resit = '"&resit&"', "
		f = f & " tkh_bayar = to_date('"&tbayar&"','dd/mm/yyyy'), "
		f = f & " amaun_bayar = '"&amaun_bayar&"',status_kompaun = 'P' where rowid = '"&rowid&"' "
		set sf = objconn.execute(f)
		end if
		end if				
			papar
   end if    
  
'	============ click cari ============

  if b1 = "Cari" then  
  	
		j = " select 'x' from kompaun.halangan where (no_kompaun = '"&kompaun&"' or no_akaun='"&akaune&"') "
		'response.write j
		set sj = objconn.execute(j)
		
		if not sj.eof then 	
		
      n = "select 'x' from kompaun.halangan where (no_kompaun = '"& kompaun &"' or no_akaun='"&akaune&"') "
	  n = n & " and status_kompaun = 'B' "
      Set Rsn = objConn.Execute(n)
        'response.write n
        if not Rsn.eof then
         response.write "<script language = ""vbscript"">"
		 response.write " MsgBox ""Kompaun Telah Dibatalkan !"", vbInformation, ""Perhatian!"" "
	     response.write "</script>"
        else 			
	 	   papar
		end if
		else
		 response.write "<script language = ""vbscript"">"
		 response.write " MsgBox ""No Kompaun Salah!!"", vbInformation, ""Perhatian!"" "
	     response.write "</script>"
		 b1 = ""
		 end if
  end if
sub mula %>
  <table width="100%" align="center" cellspacing="1" bordercolor="black" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
    <tr bgcolor="<%=color1%>"> 
      <td width="45%" align="right">No Kompaun</td>
      <td align="left" width="55%"> 
        <input type="text" name="kompaun" value="<%=kompaun%>" size="15" maxlength="11"  onFocus="nextfield='B1';"> 
        atau
    
      </td>
    </tr>
     <tr bgcolor="<%=color1%>"> 
      <td width="45%" align="right">No Akaun</td>
      <td align="left" width="55%"> 
        <input type="text" name="akaune" value="<%=akaune%>" size="15" maxlength="13"  onFocus="nextfield='B1';">
      <input type="submit" value="Cari" name="B1" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
      </td>
    </tr>
    <script>
	document.komp.kompaun.focus();
</script>
  </table>
  <br>
<%end sub			

'===================================== sub papar ============================================
sub papar

  d =     "  select rowid,no_akaun,no_resit,to_char(tkh_kompaun,'dd/mm/yyyy') tkh_kompaun ,akta,kesalahan, "
  d = d & "  nvl(amaun_bayar,0) amaun_bayar, to_char(tkh_bayar,'dd/mm/yyyy') tbayar "
  d = d & "  from kompaun.halangan "
  d = d & "  where no_kompaun = '"& kompaun &"' or no_akaun='"&akaune&"' "
  Set Rsd = objConn.Execute(d)
  
  if not Rsd.eof then
     rowid = Rsd("rowid")
     resit = Rsd("no_resit")
	 akaun = Rsd("no_akaun")
     tkh_kompaun = rsd("tkh_kompaun")
	 akta = rsd("akta")
     amaun_bayar = Rsd("amaun_bayar")
     tbayar = Rsd("tbayar")	
	 kesalahan = Rsd("kesalahan")
    
        j =     "select initcap(keterangan) terang from kompaun.jenis_kesalahan "
        j = j & " where upper(kod) = '"& kesalahan &"' and upper(perkara) = '"&akta&"' "
        Set Rsj = objConn.Execute(j)
        
        if not rsj.eof then
           njsalah = Rsj("terang")
        end if	
%>   
  <table bgcolor="<%=color1%>" borderColor=black cellSpacing=1 align="center" width="80%" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
    <tr> 
      <td width="20%" height=24>Tarikh Kompaun</td>
      <td width="50%" bgcolor="<%=color2%>" style="color:black">&nbsp;<%=tkh_kompaun%></td>
    </tr>
    <tr> 
      <td>Jenis Kesalahan</td>
      <td bgcolor="<%=color2%>" style="color:black">&nbsp;<%=kesalahan%>-<%=njsalah%></td>
    </tr>
    <tr> 
      <td >No Akaun</td>
      <td bgcolor="<%=color2%>"> 
        <input type="text" name="akaun" value="<%=akaun%>" size="15" maxlength="13" onFocus="nextfield='resit';">
      </td>
    </tr>
    <tr> 
      <td >No Resit</td>
      <td bgcolor="<%=color2%>"> 
        <input type="text" name="resit" value="<%=resit%>" size="8" maxlength="7" onFocus="nextfield='amaun_bayar';">
      </td>
    </tr>
    <tr> 
      <td >Amaun</td>
      <td bgcolor="<%=color2%>"> 
        <input type="text" name="amaun_bayar" value="<%=FormatNumber(amaun_bayar,2)%>" size="10"  maxlength="14" onFocus="nextfield='tbayar';">
      </td>
    </tr>
    <tr> 
      <td>Tarikh Bayaran</td>
      <td bgcolor="<%=color2%>" style="color:black"> 
        <input type="text" name="tbayar" value="<%=tbayar%>" size="10" maxlength="10" onFocus="nextfield='B2';" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
        (dd/mm/yyyy) 
        <input type="hidden" name="rowid" value="<%=rowid%>">
        <input type="hidden" name="tkh_kompaun" value="<%=tkh_kompaun%>">
      </td>
    </tr>
    <tr>
      <td height="19" align="right" bgcolor="<%=color2%>"><input type="submit" value="Simpan" name="B2" onFocus="nextfield='done';" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold"></td>
     <td bgcolor="<%=color2%>" style="color:black" height="19">
        
       </form>
	     <%	end if
  		end sub	
		if b1 = "Cari" or b2 = "Simpan" then %>
	   <form method="Post" action="hg121.asp" name=hg121><input type="submit" value="Reset" name="B3" style="font-family: Trebuchet MS; font-size: 8pt; font-weight: bold">
      <% end if %></td>
    </tr>
  </table>

</form>
</body>
</html>
