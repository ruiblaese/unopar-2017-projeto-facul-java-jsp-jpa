<%
    if ((session.getAttribute("logado") != null) && ((Boolean) session.getAttribute("logado") == true)) {

%>
<%@ include file="menuLogado.jsp"%>
<%} else {
%>
<%@ include file="menuPublico.jsp"%>
<%
    };

%>
