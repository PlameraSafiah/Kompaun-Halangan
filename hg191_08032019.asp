<%Response.Buffer = True%>
<!--#INCLUDE FILE="halangan.inc"-->
<!--#include file="tarikh.inc"-->
<!--#include file="focus.inc"-->
<html>
<head>
<title>Sistem Kompaun Halangan</title>

<script>
function cssHorScrolls(){
document.body.style.overflowX = 'hidden'
document.body.style.overflowY = 'scroll'
document.test0.kod1.focus();
}

function enter(nextfield,nama){
var nama = nama
var nextfiled = nextfield

//nextfield = "tsaman"; // name of first box on page
netscape = "";
ver = navigator.appVersion; len = ver.length;
for(iln = 0; iln < len; iln++) if (ver.charAt(iln) == "(") break;
netscape = (ver.charAt(iln+1).toUpperCase() != "C");

function keyDown(DnEvents) { // handles keypress
// determines whether Netscape or Internet Explorer
k = (netscape) ? DnEvents.which : window.event.keyCode;
if (k == 13) { // enter key pressed
if (nextfield == 'done') return true; // submit, we finished all fields
else { // we're not done yet, send focus to next box
eval('document.myform.' + nextfield + '.focus()');
return false;
      }
    }
}
document.onkeydown = keyDown; // work together to analyze keystrokes
if (netscape) document.captureEvents(Event.KEYDOWN|Event.KEYUP);}
//  End -->
</script>

<script language="javascript">
function invalid_maklumat(a)
    {  
       alert (a+" Maklumat Tidak Lengkap !!! ");
		return(true);
    }
function invalid_bayar(a)
    {  
       alert (a+" Kompaun Ini Sudah Bayar !!! ");
		return(true);
    }
function invalid_batal(a)
    {  alert (a+" Kompaun Ini Telah Di Batalkan !!! ");
		return(true); }
function invalid_tarikh(b)
    {  
       alert (b+" Tarikh Salah !!! ");
		return(true);
    }
function invalid_rekod(b)
    {  
       alert (b+" Tiada Rekod !!! ");
		return(true);
    }
function invalid_rekod2(b)
    {  
       alert (b+" Kes Telah Di Bawa Ke Mahkamah !!! ");
		return(true);
    }
function invalid_rekod1(b)
    {  
       alert (b+" Kompaun Telah Di Bayar !!! ");
		return(true);
    }
function invalid_kompaun1(b)
    {  
       alert (b+" Sila Masukkan Tarikh Ke Jabatan Undang-undang !!! ");
		return(true);
    }
function invalid_kompaun3(b)
    {  
       alert (b+" Sila Masukkan No Kompaun !!! ");
		return(true);
    }
</script>
</head>

<body bgcolor="#FFFFFF">
<!--'#INCLUDE FILE="menukom.asp" -->
<form name="myform" action="hg191.asp" method="POST"> 
<%	
	
	Set objConn = Server.CreateObject("ADODB.Connection")
    ObjConn.Open "dsn=12c;uid=majlis;pwd=majlis;"	
   
	response.cookies("amenu") = "hg191.asp"  
	 
	b1save = Request.form("b1save")
	b1batal = Request.form("b1batal")
	proses = Request.Form("B1")
	kompaun = request.form("kompaun")
	noakaun = request.form("noakaun")

	if b1save = "Save" then
		proses = "Save"
	end if
	
	if b1batal = "Batal" then
		proses = "Batal"
	end if	

	if proses = "Reset" then
		response.redirect "hg191.asp"
	end if	
	
  '**************************************PROCESS BATAL****************************************************
  if proses = "Batal" then
   	response.write "batal"
  	h = " select rowid  from kompaun.halangan where no_akaun = '"& noakaun &"' and no_kompaun = '"& kompaun &"' "
		set Rsh = objconn.execute(h)
		
		if not Rsh.eof then
		
			rowa = Rsh("rowid")
		   
		rr = " select to_char(sysdate,'dd/mm/yyyy')sis from dual "
set objrr = objconn.execute(rr)

sis = objrr("sis")
'response.write sis


           	r1 = " update kompaun.halangan set  tkh_batal = to_date('"& sis &"','dd/mm/yyyy') "           	          
           	r1 = r1 & " where rowid = '"& rowa &"' "
response.write r1
           Set Rsr1 = objConn.Execute(r1)


		end if
		mula
  end if	
	
  '************************************* PROSES INSERT ****************************************************

  if proses = "Save" then
     no_saman = ucase(Request.form("no_saman"))
	 no_saman2 = ucase(Request.form("no_saman2"))
	 tnotis = Request.form("tnotis")
	 rowid = Request.form("rowid")
	 rujukan = ucase(Request.form("rujukan"))
     tsaman = Request.form("tsaman")
	 tdaftar = Request.form("tdaftar")
	 tundang = Request.form("tundang")
	 tsekat = Request.form("tsekat")
     kereta = ucase(Request.form("kereta"))
     nama = ucase(Request.form("nama"))
     kp = ucase(Request.form("kp"))
     alamat1 = ucase(Request.form("alamat1"))
     alamat2 = ucase(Request.form("alamat2"))
     alamat3 = ucase(Request.form("alamat3"))
	 alamat1 = replace(alamat1,"'","''")
     alamat2 = replace(alamat2,"'","''")
     alamat3 = replace(alamat3,"'","''")
     mahkamah = Request.form("mahkamah")
     keputusan = ucase(Request.form("keputusan"))
     amaun_denda = Request.form("denda")
 
     y = " select to_date(to_char(sysdate,'ddmmyyyy'),'ddmmyyyy') tkhs , "
     y = y & " to_date('"&vtarikh_saman&"','ddmmyyyy') tkh2s from dual "
     Set objRsy = objConn.Execute(y)
     
     tkhs = objRsy("tkhs")
     tkh2s = objRsy("tkh2s")
     
     if tkh2s > tkhs then
        mula
        papar
        response.write "<script language=""javascript"">"
        response.write "var timeID = setTimeout('invalid_tarikh(""  "");',1) "
        response.write "</script>"
        response.end
     else
        g = " select rowid from kompaun.mahkamah where no_kompaun = '"& kompaun &"' "
		'response.Write(g)
        Set Rsg = objConn.Execute(g)        
        
		if Rsg.eof then
		
		
           s =     "insert into kompaun.mahkamah (no_saman,no_saman2, tarikh_saman, no_kompaun, no_daftar, nama, kp, "
           s = s & " alamat1, alamat2, alamat3, mahkamah, keputusan, amaun_denda,tkh_daftar) "
           s = s & " values ('"& no_saman &"' ,'"& no_saman2 &"' , to_date('"& tsaman &"','ddmmyyyy'), "
           s = s & " '"& kompaun &"', '"& kereta &"', '"& nama &"', '"& kp &"', "
           s = s & " '"& alamat1 &"', '"& alamat2 &"', '"& alamat3 &"', '"& mahkamah &"', "
           s = s & " '"& keputusan &"', '"& amaun_denda &"', to_date('"& tdaftar &"','ddmmyyyy')) " 
		   'response.Write(s)
           Set Rss = objConn.Execute(s)
		   
		   		  
        else
		
		
		   row = Rsg("rowid")
		   
           r = " update kompaun.mahkamah "
           r = r & " set "
           r = r & " no_saman = '"& no_saman &"', "
		   r = r & " no_saman2 = '"& no_saman2 &"', "
           r = r & " no_daftar = '"& kereta &"', "
           r = r & " tarikh_saman = to_date('"& tsaman &"','ddmmyyyy'), "
           r = r & " nama = '"& nama &"',kp = '"& kp &"', "
           r = r & " alamat1 = '"& alamat1 &"',alamat2 = '"& alamat2 &"',alamat3 = '"& alamat3 &"',"
           r = r & " mahkamah = '"& mahkamah &"', "
           r = r & " keputusan = '"& keputusan &"', "
           r = r & " amaun_denda = '"& amaun_denda &"', "
		   r = r & " tkh_daftar = to_date('"& tdaftar &"','ddmmyyyy') "
           r = r & " where rowid = '"& row &"' "
		   'response.Write(r)
           Set Rsr = objConn.Execute(r)
		   
		   
        end if
		
		h = " select rowid  from kompaun.halangan where no_akaun = '"& noakaun &"' and no_kompaun = '"& kompaun &"' "
		set Rsh = objconn.execute(h)
		
		if not Rsh.eof then
			rowa = Rsh("rowid")
			
		

		   
           	r1 = " update kompaun.halangan set  no_kenderaan = '"& kereta &"', "           	
           	r1 = r1 & " nama = '"& nama &"',kp = '"& kp &"', "
           	r1 = r1 & " alamat1 = '"& alamat1 &"',alamat2 = '"& alamat2 &"',alamat3 = '"& alamat3 &"', "
			r1 = r1 & " tkh_notis1 = to_date('"& tnotis &"','ddmmyyyy'), " 
			r1 = r1 & " tkh_undang = to_date('"& tundang &"','ddmmyyyy'), " 
			r1 = r1 & " tkh_sekat = to_date('"& tsekat &"','ddmmyyyy'), "
			r1 = r1 & " status_kompaun = 'M' "           
           	r1 = r1 & " where rowid = '"& rowa &"' "
           Set Rsr1 = objConn.Execute(r1)
		'response.write r1
		
		else
			s =     "insert into kompaun.halangan (no_kenderaan,nama,kp,alamat1,alamat2,alamat3,tkh_notis1,tkh_undang,status_kompaun,tkh_sekat) "
           	s = s & " values ('"& kereta &"', '"& nama &"', '"& kp &"', "
			s = s & " '"& alamat1 &"', '"& alamat2 &"', '"& alamat3 &"', to_date('"& tnotis &"','ddmmyyyy'), "
			s = s & " 'M', to_date('"& tundang &"','ddmmyyyy'), to_date('"& tsekat &"','ddmmyyyy'))"
			Set Rss1 = objConn.Execute(s)
		end if
		
		u = " update hasil.bil set perkara5 = '"& rujukan &"' , tarikh_notis1 = to_date('"& tnotis &"','ddmmyyyy')  where rowid = '"& rowid &"' "
		set Rsu = objconn.execute(u)

     end if
     'mula
     papar
  end if
	
'***************************************	PROSES CARI	***************************************************
	
   if proses = "Cari" then

     if kompaun = ""  then
        mula
        response.write "<script language=""javascript"">"
        response.write "var timeID = setTimeout('invalid_kompaun3(""  "");',1) "
        response.write "</script>"
        response.end
			
     else
	 
        sk =      "select * from kompaun.halangan "
        sk = sk & " where no_kompaun = '"& kompaun &"' "
        set rssk = objconn.execute(sk)
        
        if rssk.eof then
           mula
           response.write "<script language=""javascript"">"
           response.write "var timeID = setTimeout('invalid_rekod(""  "");',1) "
           response.write "</script>"
           response.end
        else
			papar
        end if
     end if
  end if

  if proses = "" then     mula	
  
sub mula	%>      
<table width="95%" align="center" cellspacing=0 bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt;" cellpadding="1">
        <tr> 
          <td width="19%" bgcolor="<%=color1%>">&nbsp;<font color="#FFFF00">No 
          Kompaun</font></td>
          <td bgcolor="#CCCCCC"> <input type="text" name="kompaun" maxlength="11" value="<%=kompaun%>" size="12" onFocus="enter('B1','1');" >
            
            <font face="Arial" size="1">
            <input type="submit" value="Cari" name="B1"  style="font-family: Verdana; font-size: 8pt" onFocus="enter('done','1');">
            </font> </td>
        </tr>
		</table>
        <%end sub
'**************************************************************************************************
  sub papar
  kereta = replace(kereta," ","")

  d =     "select no_saman,no_saman2,to_char(tarikh_saman,'ddmmyyyy') tsaman,no_daftar, "
  d = d & "       nama,kp,alamat1,alamat2,alamat3,mahkamah,initcap(keputusan) keputusan, "
  d = d & "       nvl(amaun_denda,0) amaun_denda,to_char(tkh_keputusan,'ddmmyyyy') tkeputusan,to_char(tkh_daftar,'ddmmyyyy') tdaftar"
  d = d & "  from kompaun.mahkamah "
  d = d & " where no_kompaun = '"& kompaun &"' "
  Set Rsd = objConn.Execute(d)
  
  if not Rsd.eof then  
     tsaman = Rsd("tsaman")
     kereta = rsd("no_daftar")
     no_saman = rsd("no_saman")  
	 no_saman2 = rsd("no_saman2")  
     mahkamah = rsd("mahkamah")
     keputusan = rsd("keputusan")
     tkeputusan = rsd("tkeputusan")
     amaun_denda = rsd("amaun_denda")
	 tdaftar = Rsd("tdaftar")
  end if
  
  e = 	"select to_char(tkh_undang,'ddmmyyyy') tkh_undang,no_akaun,nama,kp,alamat1,alamat2,alamat3, "
  e = e & " no_kenderaan,masa,to_char(tkh_kompaun,'ddmmyyyy') tkompaun, "
  e = e & " to_char(tkh_sekat,'ddmmyyyy') tkh_sekat,to_char(tkh_batal,'ddmmyyyy') tkh_batal, "
  e = e & " to_char(tkh_notis1,'ddmmyyyy') tarikh_notis1 from kompaun.halangan "
  e = e & " where no_kompaun = '"& kompaun &"' "
  set rse = objConn.Execute(e)
  
  if not rse.eof then
  	nama = rse("nama")
	kp = rse("kp")
	alamat1 = rse("alamat1")
	alamat2 = rse("alamat2")
	alamat3 = rse("alamat3")
	kereta = rse("no_kenderaan")
	tkompaun = rse("tkompaun")
	tnotis = rse("tarikh_notis1")
	masa = rse("masa")
	noakaun = rse("no_akaun")
	tundang = rse("tkh_undang")
	tsekat = rse("tkh_sekat")
	tbatal = rse("tkh_batal")
	
	if cdbl(masa) > 0 then
        if cdbl(masa) <= 12 then 
           ampm = "AM"
        elseif cdbl(masa) > 12 and cdbl(masa) < 13 then
           ampm = "PM"
        elseif cdbl(masa) >= 13 and cdbl(masa) < 24 then
           masa = cdbl(masa) - 12
           ampm = "PM"
        end if
     end if

  end if
 
  z =     "select rowid,no_resit,to_char(tkh_bayar,'ddmmyyyy')tkh_bayar,to_char(tkh_masuk,'ddmmyyyy') tkompaun, "
  z = z & " masa,perkara5,to_char(tarikh_notis1,'ddmmyyyy') tarikh_notis1"
  z = z & "  from hasil.bil "
  z = z & " where no_rujukan = '"& kompaun &"' and no_akaun = '"& noakaun &"' "
  Set rsz = objConn.Execute(z)
  'response.write z
     
  if not rsz.eof then
  	 rowid = rsz("rowid")
	 noresit = rsz("no_resit")
	 tkhbyr = rsz("tkh_bayar")
	 rujukan = rsz("perkara5")  
  end if			
  %>   
      
<table width="95%" align="center" cellspacing=0 bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt;" cellpadding="1">
<%if noresit <> "" then%>
      <tr bgcolor="#CCCCCC"> 
        <td colspan="2" height="11" align="center" bgcolor="<%=color1%>"><b><font color="#FF0000" face="verdana" size="3">            
            Perhatian!!! </font><font color="#000000">Kompaun Telah Dibayar Pada</font>
            <font color="#FF0000" size="3"><%=tkhbyr%> Bernombor Resit :<%=noresit%></font></b> 
<%elseif tbatal <> "" then%>
		<tr bgcolor="#CCCCCC"> 
        <td colspan="2" height="11" align="center" ><b><font color="#FF0000" face="verdana" size="3">            
            Perhatian!!! </font><font color="#000000">Kompaun Telah Dibatalkan Dari Ke Mahkamah</font></b>	
<%end if%>
        </td>
      </tr>
      <tr> 
        <td width="25%" bgcolor="<%=color1%>">&nbsp;<font color="#FFFF00">No 
          Kompaun</font></td>
        <td width="75%" bgcolor="#CCCCCC"> 
          <input type="text" name="kompaun" maxlength="11" value="<%=kompaun%>" size="12" onFocus="enter('tundang','1');" >
          &nbsp;
          <input type="hidden" name="noakaun" value="<%=noakaun%>" ></td>
      </tr>
      <tr> 
        <td nowrap bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Tarikh 
          Hantar Ke Jabatan Undang-undang</font></td>
        <td bgcolor="#CCCCCC"> 
          <input name="tundang" type="text" id="tundang" onFocus="enter('kereta','2');" value="<%=tundang%>" size="8" maxlength="8">
          &nbsp; <font face="Arial" size="1" color="244980"><b> ( 'ddmmyyyy' )</b></font> 
        </td>
      </tr>
      <tr> 
        <td nowrap bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Tarikh Sekatan </font></td>
        <td bgcolor="#CCCCCC"> 
          <input name="tsekat" type="text" id="tsekat" onFocus="enter('kereta','2');" value="<%=tsekat%>" size="8" maxlength="8">
          &nbsp; <font face="Arial" size="1" color="244980"><b> ( 'ddmmyyyy' )</b></font> 
        </td>
      </tr>
      <tr> 
        <td bgcolor="<%=color1%>" width="25%"><font color="#FFFF00">&nbsp;No 
          Kenderaan</font></td>
        <td bgcolor="#CCCCCC"> 
          <input name="kereta" type="text" value="<%=kereta%>" size="19" maxlength="20">
        </td>
      </tr>
      <tr> 
        <td height="25" nowrap bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Tarikh 
          Kompaun</font></td>
        <td bgcolor="#CCCCCC"><%=tkompaun%></td>
      </tr>
      <tr> 
        <td height="25" nowrap bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Waktu 
          Kompaun </font></td>
        <td bgcolor="#CCCCCC"><%=masa%>&nbsp;<%=ampm%></td>
      </tr>
      <tr> 
        <td nowrap bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Tarikh 
          Notis</font></td>
        <td bgcolor="#CCCCCC"> 
          <input name="tnotis" type="text" id="tnotis" onFocus="enter('rujukan','2');" value="<%=tnotis%>" size="8" maxlength="8">
          <input name="rowid" type="hidden" value="<%=rowid%>">
          &nbsp; <font face="Arial" size="1" color="244980"><b> ( 'ddmmyyyy' )</b></font></td>
      </tr>
      <tr> 
        <td nowrap bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;No 
          Rujukan </font></td>
        <td bgcolor="#CCCCCC"> 
          <input name="rujukan" type="text" id="rujukan" onFocus="enter('tdaftar','2');" value="<%=rujukan%>" size="40" maxlength="40">
          &nbsp;</td>
      </tr>
      <tr> 
        <td nowrap bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Tarikh 
          Daftar</font></td>
        <td bgcolor="#CCCCCC"> 
          <input name="tdaftar" type="text" id="tdaftar" onFocus="enter('tsaman','2');" value="<%=tdaftar%>" size="8" maxlength="8">
          &nbsp; <font face="Arial" size="1" color="244980"><b> ( 'ddmmyyyy' )</b></font> 
        </td>
      </tr>
      <tr> 
        <td bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Tarikh 
          Sebutan</font></td>
        <td bgcolor="#CCCCCC"> 
          <input type="text" name="tsaman" value="<%=tsaman%>" size="8" maxlength="8" onFocus="enter('no_saman','2');">
          &nbsp; <font face="Arial" size="1" color="244980"><b> ( 'ddmmyyyy' )</b></font></td>
      </tr>
      <tr> 
        <td bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;No 
          Saman 1</font></td>
        <td bgcolor="#CCCCCC"> 
          <input type="text" name="no_saman" value="<%=no_saman%>" size="20" maxlength="20" onFocus="enter('no_saman2','2');">
          <b><font  color="#FFFF00">&nbsp;</font></b> </td>
      </tr>
      <tr> 
        <td bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00"> 
          &nbsp;No Saman 2</font></td>
        <td bgcolor="#CCCCCC"> 
          <input type="text" name="no_saman2" value="<%=no_saman2%>" size="20" maxlength="20" onFocus="enter('nama','2');">
        </td>
      </tr>
      <tr> 
        <td bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Nama</font></td>
        <td bgcolor="#CCCCCC"> 
          <input type="text" name="nama" value="<%=nama%>" size="50" maxlength="50" onFocus="enter('kp','2');">
          <font color="#FF0000">(*)</font></td>
      </tr>
      <tr> 
        <td bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;No 
          KP</font></td>
        <td bgcolor="#CCCCCC"> 
          <input type="text" name="kp" value="<%=kp%>" size="15" maxlength="14" onFocus="enter('alamat1','2');">
        </td>
      </tr>
      <tr> 
        <td bgcolor="<%=color1%>" valign="top" width="25%"><font  color="#FFFF00">&nbsp;Alamat</font></td>
        <td bgcolor="#CCCCCC"> 
          <input type="text" name="alamat1" value="<%=alamat1%>" size="50" maxlength="50" onFocus="enter('alamat2','2');">
          <br>
          <input type="text" name="alamat2" value="<%=alamat2%>" size="50" maxlength="50" onFocus="enter('alamat3','2');">
          <br>
          <input type="text" name="alamat3" value="<%=alamat3%>" size="50" maxlength="50" onFocus="enter('alamat4','2');">
		   <br>
          <input type="text" name="alamat4" value="<%=alamat4%>" size="50" maxlength="50" onFocus="enter('mahkamah','2');">
        </td>
      </tr>
      <tr> 
        <td bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Mahkamah</font></td>
        <td bgcolor="#CCCCCC"><font face="Arial Narrow"> 
          <select name="mahkamah" onFocus="enter('keputusan','2');">
            <%	if mahkamah <> "" then
  			ss = " select decode('"& mahkamah &"','1','BW','2','BM','3','NT',null) vterang from dual " 
  			Set objRsqs = objConn.Execute(ss)			
  %>
            <option value="<%=mahkamah%>" selected><%=mahkamah%> - <%=objRsqs("vterang")%></option>
            <%	else	%>
            <option value=""> Sila Pilih Mahkamah </option>
            <%	end if		%>
            <option value="1">1 - BW</option>
            <option value="2">2 - BM</option>
            <option value="3">3 - NT</option>
          </select>
          </font><font color="#FF0000">(*)</font></td>
      </tr>
      <tr> 
        <td bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Keputusan 
          Kes</font></td>
        <td bgcolor="#CCCCCC"> 
          <input type="text" name="keputusan" value="<%=keputusan%>" size="105" maxlength="100" onFocus="enter('b1save','2');">
        </td>
      </tr>
	  <tr> 
        
      <td bgcolor="<%=color1%>" width="25%"><font  color="#FFFF00">&nbsp;Bayaran 
        Denda Mahkamah</font></td>
        <td bgcolor="#CCCCCC"> 
          <input type="text" name="denda" value="<%=denda%>" size="20" maxlength="100" onFocus="enter('b1batal','2');">
        </td>
      </tr>
      <tr> 
        <td colspan="2" align="center" bgcolor="#CCCCCC">
        <input type="submit" name="b1batal" value="Batal" onFocus="enter('b1save','2');" > 
          <input type="submit" name="b1save" value="Save" onFocus="enter('done','2');" >
          <input type="submit" name="b1" value="Reset">
        </td>
      </tr>
    </table>
<% end sub %>
</form>
</body>