<%response.buffer=true%>
<!--#INCLUDE FILE="halangan.inc"-->
<!--#include file="focus.inc"-->
<script language="javascript">

nextfield = "pekerja" ;
 function invalid_kod(a)
 { alert(a+" Kod Sudah Ada!!! ");
   return(true);
 }
 function keluar(f)
 { location=window.close();	}
 
function check(b)
{
if(b.pekerja.value==""){
alert("Sila Masukkan No Pekerja !!");
b.pekerja.focus();
return false}
}
</script>
<!-- #INCLUDE FILE="menukom.asp" -->
<form name=komp method="POST" action="hg161.asp" onsubmit="return check(this)">
<%	response.cookies("amenu") = "hg161.asp" 
  
  proses = Request.Form("B1")
  pekerja = request.form("pekerja")
  b2 = request.form("b2")
  
  mula2
  
  if proses = "Hantar" then
     hantar
  end if
    
  if proses = "Simpan" then
     bilrec = request.form("bilrec")
         ss = "delete majlis.kebenaran_2002 where no_pekerja = '"& pekerja &"' and sistem = 'hg' "
         Set Rsss = objConn.Execute(ss)
         
  if bilrec <> "" then
     proses="z"
     for i = 1 to bilrec
         rowid = "rowid" + cstr(i)
         kod1 = "kod1" + cstr(i)
         kod2 = "kod2" + cstr(i)
         kod3 = "kod3" + cstr(i)
         kod4 = "kod4" + cstr(i)
		 kod5 = "kod5" + cstr(i)
         ket1 = "ket1" + cstr(i)
         ket2 = "ket2" + cstr(i)
         ket3 = "ket3" + cstr(i)
         ket4 = "ket4" + cstr(i)
		 ket5 = "ket5" + cstr(i)

         rowid = request.form(""& rowid &"")
         kod1 = request.form(""& kod1 &"")
         kod2 = request.form(""& kod2 &"")
         kod3 = request.form(""& kod3 &"")
         kod4 = request.form(""& kod4 &"")
		 kod5 = request.form(""& kod5 &"")
         ket1 = request.form(""& ket1 &"")
         ket2 = request.form(""& ket2 &"")
         ket3 = request.form(""& ket3 &"")
         ket4 = request.form(""& ket4 &"")
		 ket5 = request.form(""& ket5 &"")

         if ket1 = "1" then
            i1 = " insert into majlis.kebenaran_2002 (no_pekerja,sistem,skrin) "
            i1 = i1 & " values ('"& pekerja &"','hg','"& kod1 &"') "
            Set Rsi1 = objConn.Execute(i1)
         end if

         if ket2 = "1" then
            i2 = " insert into majlis.kebenaran_2002 (no_pekerja,sistem,skrin) "
            i2 = i2 & " values ('"& pekerja &"','hg','"& kod2 &"') "
            Set Rsi2 = objConn.Execute(i2)
         end if

         if ket3 = "1" then
            i3 = " insert into majlis.kebenaran_2002 (no_pekerja,sistem,skrin) "
            i3 = i3 & " values ('"& pekerja &"','hg','"& kod3 &"') "
            Set Rsi3 = objConn.Execute(i3)
         end if

         if ket4 = "1" then
            i4 = " insert into majlis.kebenaran_2002 (no_pekerja,sistem,skrin) "
            i4 = i4 & " values ('"& pekerja &"','hg','"& kod4 &"') "
            Set Rsi4 = objConn.Execute(i4)
         end if
		 
		 if ket5 = "1" then
            i5 = " insert into majlis.kebenaran_2002 (no_pekerja,sistem,skrin) "
            i5 = i5 & " values ('"& pekerja &"','hg','"& kod5 &"') "
            Set Rsi5 = objConn.Execute(i5)
         end if

     next
     hantar
  end if
  end if
  
  bilrecsen = request.form("bilrecsen")
  if bilrecsen <> "" then
     proses = "z"
     for i = 1 to bilrecsen
     
         d = "d" + cstr(i)
         e = "e" + cstr(i)
         nopekerja = "nopekerja" + cstr(i)
         nama = "nama" + cstr(i)
         
         d = request.form (""& d &"")
         e = request.form (""& e &"")
         nopekerja = request.form (""& nopekerja &"")
         nama = request.form (""& nama &"")
         
         if d = "Hapus" then
            db = " delete majlis.kebenaran_2002 where no_pekerja = '"& nopekerja &"' "
            set objrsdb = objConn.Execute(db)
            
            mula
            mula3
            senarai
         elseif e = "Edit" then
             pekerja = nopekerja
             sistem = sistem2
             hantar
         end if
     next   
  end if
  
 sub mula2 
 if pekerja <> "" then
  z0 = "select initcap(nama) nama from payroll.tetap_sambilan where no_pekerja = '"& pekerja &"' "
  Set Rsz0 = objConn.Execute(z0) 
  if not rsz0.eof then
     nama = rsz0("nama")
  else
     nama = ""
  end if
  end if
  %>
<table bgcolor="<%=color1%>" width="100%" align="center" cellpadding="0" cellspacing="1" border="0" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
  <tr> 
    <td align="center">No Pekerja 
      <input type="text" name="pekerja" value="<%=pekerja%>" size="5" maxlength="5"  onFocus="nextfield='B1';"><%=nama%>
      <a href="javascript:void(0)" onClick="open_staff('komp.pekerja','nama');" onmouseover="window.status='Senarai No Pekerja';return true;" onmouseout="window.status='';return true;"> 
      <input type="button" value="List" name="B3" style="font-family: Arial; font-size: 8pt; font-weight: bold">
      </a>
      <input type="submit" name="B1" value="Hantar"  onFocus="nextfield='done';">
    </td>
  </tr>
</table>

<%end sub
''' ===============================================================================================
  sub hantar %>
<table width="98%" align="center" border=1 cellspacing="0">
<%b1 =     "select rowid,kod,keterangan,paras,tamat "
  b1 = b1 & "  from majlis.menu_2002 where paras=1 and sistem = 'hg' order by kod "
  Set Rsb1 = objConn.Execute(b1)
 
  ctrz = 0
  Do while not Rsb1.EOF
     ctrz = cdbl(ctrz) + 1
     ket1 = rsb1("keterangan")
     kod1 = rsb1("kod") 
     rowid = rsb1("rowid")
     tamat1 = rsb1("tamat")
%>
<tr bgcolor="#dddddd"> 
  <td colspan=3><font color="ff0000" face="Arial Narrow" size="3"><b><%=ket1%></b></font>
  <input type="hidden" name="rowid<%=ctrz%>" value="<%=rowid%>">
  <input type="hidden" name="kod1<%=ctrz%>" value="<%=kod1%>">
  </td>
</tr>
<%   b2 =      "select rowid,kod,keterangan,paras,tamat "
     b2 = b2 & "  from majlis.menu_2002 where kod like '"& kod1 &"'||'%' and paras=2 and sistem = 'hg' order by kod "
     Set Rsb2 = objConn.Execute(b2)
 
     Do while not Rsb2.EOF
     ctrz = cdbl(ctrz) + 1
     ket2 = rsb2("keterangan")
     kod2 = rsb2("kod") 
     rowid = rsb2("rowid")
     tamat2 = rsb2("tamat")

     b2a =       "select 'x' from majlis.kebenaran_2002 "
     b2a = b2a & " where no_pekerja = '"& pekerja &"' and sistem = 'hg' and skrin = '"& kod2 &"' "
     Set Rsb2a = objConn.Execute(b2a)
 
     b3 =      "select rowid,kod,keterangan,paras,tamat "
     b3 = b3 & "  from majlis.menu_2002 where kod like '"& kod2 &"'||'%' and paras=3 and sistem = 'hg' order by kod "
     Set Rsb3 = objConn.Execute(b3)
 
     if rsb3.eof then
%>
<tr bgcolor="#dddddd"> 
  <%if ket2z <> ket2 then%>
  <td colspan=3 width="33%">
      <%if tamat2 = "Y" then%><input type="checkbox" name="ket2<%=ctrz%>" value="1"
      <% if not rsb2a.eof then%>checked<%end if%> >
      <%end if%>
      <font face="Arial Narrow" size="3"><b><%=ket2%></b></font>
      <input type="hidden" name="rowid<%=ctrz%>" value="<%=rowid%>">
      <input type="hidden" name="kod2<%=ctrz%>" value="<%=kod2%>">
      </td>
  <%else%>
  <td colspan=3 bgcolor="white" width="33%">&nbsp;</td>
  <%end if%>
</tr>
<%else
     Do while not Rsb3.EOF
     ctrz = cdbl(ctrz) + 1
     ket3 = rsb3("keterangan")
     kod3 = rsb3("kod") 
     tamat3 = rsb3("tamat")
     rowid = rsb3("rowid")

     b3a =       "select 'x' from majlis.kebenaran_2002 "
     b3a = b3a & " where no_pekerja = '"& pekerja &"' and sistem = 'hg' and skrin = '"& kod3 &"' "
     Set Rsb3a = objConn.Execute(b3a)
 
     b4 =      "select rowid,kod,keterangan,paras,tamat "
     b4 = b4 & "  from majlis.menu_2002 where kod like '"& kod3 &"'||'%' and paras=4 and sistem = 'hg' order by kod "
     Set Rsb4 = objConn.Execute(b4)
 
     if rsb4.eof then
%>
<tr bgcolor="#dddddd"> 
  <%if ket2z <> ket2 then%>
  <%if tamat2 = "Y" then%>
  <td >
      <input type="checkbox" name="ket2<%=ctrz%>" value="1"
      <% if not rsb2a.eof then%>checked<%end if%> >
      <font face="Arial Narrow" size="3"><%=ket2%></font>
      <input type="hidden" name="rowid<%=ctrz%>" value="<%=rowid%>">
      </td>
  <%else%>
  <td bgcolor="<%=color1%>" style="font-family: Trebuchet MS; font-size: 10pt; color:yellow">
      <%=ket2%>
      <input type="hidden" name="rowid<%=ctrz%>" value="<%=rowid%>">
      </td>
  <%end if%>
  <%else%>
  <td bgcolor="white" >&nbsp;</td>
  <%end if%>
  <td colspan=2 >
      <%if tamat3 = "Y" then%><input type="checkbox" name="ket3<%=ctrz%>" value="1"
      <% if not rsb3a.eof then%>checked<%end if%> >
      <%end if%>
      <font face="Arial Narrow" size="3">
      <%if ket3z <> ket3 then%><%=ket3%><%end if%></font>
      <input type="hidden" name="rowid<%=ctrz%>" value="<%=rowid%>">
      <input type="hidden" name="kod3<%=ctrz%>" value="<%=kod3%>">
      </td>
</tr>

<%else
     Do while not Rsb4.EOF
     ctrz = cdbl(ctrz) + 1
     ket4 = rsb4("keterangan")
     kod4 = rsb4("kod") 

     b4a =       "select 'x' from majlis.kebenaran_2002 "
     b4a = b4a & " where no_pekerja = '"& pekerja &"' and sistem = 'hg' and skrin = '"& kod4 &"' "
     Set Rsb4a = objConn.Execute(b4a)
%> 

<tr bgcolor="#dddddd"> 
  <%if ket2z <> ket2 then%>
  <td >
      <%if tamat2 = "Y" then%><input type="checkbox" name="ket2<%=ctrz%>" value="1"
      <% if not rsb2a.eof then%>checked<%end if%> >
      <%end if%>
      <font face="Arial Narrow" size="3"><%=ket2%></font></td>
  <%else%>
  <td bgcolor="white" >&nbsp;</td>
  <%end if%>
  <%if ket3z <> ket3 then%>
  <td width="33%" >
      <%if tamat3 = "Y" then%><input type="checkbox" name="ket3<%=ctrz%>" value="1"
      <% if not rsb3a.eof then%>checked<%end if%> >
      <%end if%>
      <font face="Arial Narrow" size="3"><%=ket3%></font>
      </td>
  <%else%>
  <td width="33%" bgcolor="white" >&nbsp;</td>
  <%end if%>
  <td ><input type="checkbox" name="ket4<%=ctrz%>" value="1"
      <% if not rsb4a.eof then%>checked<%end if%> >
      <font face="Arial Narrow" size="3"><%=ket4%></font>
      <input type="hidden" name="rowid<%=ctrz%>" value="<%=rowid%>">
      <input type="hidden" name="kod4<%=ctrz%>" value="<%=kod4%>">
      </td>
</tr>
<%ket2z = ket2
  ket3z = ket3
  Rsb4.Movenext
  Loop   
  end if   
  ket2z = ket2
  ket3z = ket3
  Rsb3.Movenext
  Loop 
  end if  
  Rsb2.Movenext
  Loop   
  Rsb1.Movenext
  Loop %> 
<tr> 
  <td colspan=3 align="center" ><input type="submit" name="B1" value="Simpan">      </td>
</tr>
</table>
<input type="hidden" name="bilrec" value="<%=ctrz%>" >
<%end sub	%>