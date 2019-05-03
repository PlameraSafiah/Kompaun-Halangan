<SCRIPT LANGUAGE="JavaScript">
<!-- Begin

netscape="";
ver=navigator.appVersion; len=ver.length;
for(iln=0;iln<len;iln++)if(ver.charAt(iln)=="(")break;
netscape=(ver.charAt(iln+1).toUpperCase()!="C");

function keyDown(DnEvents){
k=(netscape)?DnEvents.which:window.event.keyCode;
if(k==13){
if(nextfield=='done')return true;
else{
eval('document.komp.'+nextfield+'.focus()');
return false;
		}
	}
}
document.onkeydown=keyDown;
if(netscape)document.captureEvents(Event.KEYDOWN|Event.KEYUP);
//End -->

</script>