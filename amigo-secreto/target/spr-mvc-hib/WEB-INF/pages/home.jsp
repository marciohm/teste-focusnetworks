<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:redirect url="/person/list.html">
    <c:param name="message"
             value="${message}">         
    </c:param>
</c:redirect>

<t:template>
    <jsp:body>
        <h1>Amigo Secreto FocusNetworks</h1>
        <p>
            <a href="${pageContext.request.contextPath}/person/add.html">Adicionar Pessoa</a><br/>
            <a href="${pageContext.request.contextPath}/person/list.html">Lista de Pessoas</a><br/>
        </p>
    </jsp:body>
</t:template>        