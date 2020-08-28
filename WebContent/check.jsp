    <%
        if(session!=null){
            if(session.getAttribute("user")!=null){
                user = (User) session.getAttribute("user");
                %>
