<%response.buffer=true%>
<html>
<head>
<style>
<!-- a {text-decoration:none}
//-->
</style>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
nextfield = "akta";
netscape = "";
ver = navigator.appVersion; len = ver.length;
for(iln = 0; iln < len; iln++) if (ver.charAt(iln)=="(")break;
netscape = (ver.charAt(iln+1).toUpperCase()!="C");

function keyDown(DnEvents){
k = (netscape)?DnEvents.which : window.event.keyCode;
if(k==13){//enter key pressed
if (nextfield=='done') return true; //submit
else{//send focus to next box
eval('document.kukaw.'+nextfield + '.focus()');

return false;
	}
  }
 }
document.onkeydown = keyDown;// work together to analyze keystrokes
if (netscape)document.captureEvents(Event.KEYDOWN|Event.KEYUP);

//End-->
</script>
<SCRIPT LANGUAGE="javascript">	  
function open_test(m,p_item,q_item,s_item,t_item)
	  { 
	   var pass = p_item.value
       var pass1 = t_item.value
	   var dot = pass.indexOf(".")
	   var dot1 = pass1.indexOf(".")	  
	   var formname = pass.substring(0,dot)
	   var formname1 = pass1.substring(0,dot1)  
	   var fieldname = pass.substring(dot+1)
	   var fieldname1 = pass1.substring(dot1+1)
	   opener.document[formname][fieldname].value = q_item.value	   	   
	   opener.document[formname1][fieldname1].value = s_item.value	    
	   self.close()  	   
	  
    }	  
</script>
<title>Senarai Akta</title>
</head>
<body bgColor=#FFFFFF>
<form name=kukaw method="post" action="akta.asp">
  <%
  	Set Conn = Server.CreateObject("ADODB.Connection")
  	Conn.Open "dsn=12c;uid=majlis;pwd=majlis;"	
	
	p1 = request.form("b1")
	pemilik=request.querystring("pemilik")
	ex=request.querystring("ex")
	pemilik1 = request.form("pemilik1")
	ex1 = request.form("ex1")
	akta = request.form("akta")
	
	mula		
		
	if pemilik1 = "" and pemilik <> "" then 
		pemilik1 = pemilik
	end if
	
	if ex1 = "" and ex <> "" then
		ex1 = ex
	end if
	
	if pemilik <> ""  or p1 = "HANTAR"  then hantar
			
	sub mula
%>
  <table width="90%" border="0" cellspacing="2" align="center">
    <tr bgcolor="#9FB86E"> 
      <td bgcolor="936975" width="55%" align="right"><font color="#FFFF00" face="Trebuchet MS" size="2"> 
	Akta: <input type="text" name="akta" size="3" maxlength="3" value="<%=akta%>"></font>
      </td>
      <td width="45%" bgcolor="936975"><font face="Trebuchet MS" size="2"> 
        <input type="submit" name="b1" value="HANTAR" style="font-family:Trebuchet MS; font-size: 8pt;">
        <input type="hidden" name="pemilik" value="<%=pemilik%>" >
		<input type="hidden" name="ex" value="<%=ex%>" >
        </font></td>
    </tr>
  </table>
  <script>
	document.kukaw.b1.focus()
</script>   
<br>
  <% end sub
	sub hantar
	
	sqd = " select upper(kod)kod, initcap(keterangan) keterangan from kompaun.akta "
    sqd = sqd & " where kod like '"& akta &"'||'%' "
    sqd = sqd & " and kod <> 'P01' order by kod "
  	Set Sqd = Conn.Execute(Sqd)
	
	if Sqd.eof then
		response.write "<script language=Javascript>"
		response.write "alert(""Tiada rekod""); "
		response.write "self.close(); "
		response.write "</script>"
	else	

%>
   <br>
  <table width="80%" align=center border=0 cellspacing=1>
    <tr bgcolor="936975"> 
      <td width="20%" bgcolor="936975"><font face="Trebuchet MS" size="2" color="#FFFF00">Kod 
        Akta</font></td>
      <td width="80%"><font face="Trebuchet MS" size="2" color="#FFFF00">Keterangan</font></td>
      <td width="80%">&nbsp;</td>
    </tr>
    <%	ctrz = 0
  	do while Sqd.EOF = false 
	ctrz = ctrz + 1
	kod = Sqd("kod")
  	keterangan = Sqd("keterangan")
	
%>
    <tr onMouseOver="this.style.backgroundColor='#CFD996'" onMouseOut="this.style.backgroundColor='lightgrey'" bgcolor='#CCCCCC'"> 
       <td width="20%"> 
        <input type="hidden" name="kod<%=ctrz%>" value="<%=kod%>" >
        <input type="hidden" name="keterangan<%=ctrz%>" value="<%=keterangan%>" >
        <input type="hidden" name="pemilik1<%=ctrz%>" value="<%=pemilik1%>">
		<input type="hidden" name="ex1<%=ctrz%>" value="<%=ex1%>">
        <font face="Trebuchet MS" size="2" color="#000000"><%=kod%></font> 
      <td width="80%"> <font size="2" color="#000000" face="Trebuchet MS"><%=keterangan%></font></td>
      <td width="80%">
	    <input type="button" name="pilih<%=ctrz%>" onClick="open_test(this.form,pemilik1<%=ctrz%>,kod<%=ctrz%>,keterangan<%=ctrz%>,ex1<%=ctrz%>)" value="Pilih" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 7pt; font-weight: normal">
</td>
      </tr>
    <%
    Sqd.movenext
  	loop
%>
    <input type="hidden" name="pemilik1" value="<%=pemilik1%>">
	<input type="hidden" name="ex1" value="<%=ex1%>">
  </table>
<% end if
end sub %>
</form>
</body>  