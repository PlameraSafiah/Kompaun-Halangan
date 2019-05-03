<script language="Javascript">
var new_akta

function open_winakta1(p_item)
	{
	 if(!win_opened())
	  {
	   new_akta = window.open("akta1.asp?pemilik="+p_item,"", "height=500, width=700, left=45, top=10,scrollbars=yes")  	    	   	   
	  } 
	 else
	  {
	   new_akta.focus()
	  }
    }
	
var new_win

function open_win(p_item,q_item)
	{
	 if(!win_opened())
	  {
	   new_win = window.open("akta.asp?pemilik="+p_item+"&ex="+q_item,"", "height=500, width=700, left=45, top=10,scrollbars=yes")  	    	   	   
	  } 
	 else
	  {
	   new_win.focus()
	  }
    }	
var new_butirsalah	
	
	function open_salah(p_item,q_item)
	{
	 if(!win_opened())
	  { var dot = p_item.indexOf(".")
	   var formname = p_item.substring(0,dot)
	   q_item = document[formname][q_item].value 
	   new_butirsalah= window.open("salah1.asp?pemilik="+p_item+"&akta="+q_item,"", "height=500, width=700, left=45, top=10,scrollbars=yes")  	    	   	   
	  } 
	 else
	  {
	   new_butirsalah.focus()
	  }
    }
	
var new_salah

function open_salah(p_item,q_item,r_item)
	{
	 if(!win_opened())
	  { var dot = p_item.indexOf(".")
	   var formname = p_item.substring(0,dot)
	   q_item = document[formname][q_item].value 
	   new_salah= window.open("salah.asp?pemilik="+p_item+"&akta="+q_item+"&ex="+r_item,"", "height=500, width=700, left=45, top=10,scrollbars=yes")  	    	   	   
	  } 
	 else
	  {
	   new_salah.focus()
	  }
    }
	
	
function win_opened()
	{
	 if (!new_win)
	  {
	   return false
	  } 
	 else if (new_win.closed)
	  {
	   return false
	  }
	 else
	  {
	   return true
	  }
	}
	
	function open_staff(num,name)
	{
	 if(!win_opened())
	  {
	   new_win = window.open("staff.asp?pemilik="+num+"&nstaff="+name,"", "height=500, width=700, left=45, top=10,scrollbars=yes")  	    	   	   
	  } 
	 else
	  {
	   new_win.focus()
	  }
    }
	
	var new_salah
		
</script>