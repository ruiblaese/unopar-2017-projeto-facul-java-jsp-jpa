function logoff() {
    
     $.ajax({url: "logoff.jsp", success: function(){
        
    }});
    
    window.location.href = "index.jsp?";
    
}