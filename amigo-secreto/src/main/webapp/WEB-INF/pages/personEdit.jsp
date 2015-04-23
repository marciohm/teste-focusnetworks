<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <jsp:body>
        <h1>Alteração</h1>
        <p></p>
        <p>${message}</p>
        <form ng-app="myApp"  ng-controller="validateCtrl" method="POST" name="person" action="${pageContext.request.contextPath}/person/edit/${person.id}.html" novalidate>
            <table class="table-condensed">
                <tbody>
                    <tr>
                        <td>Nome</td>
                        <td>
                            <input type="text" value="${person.name}" name="name" ng-model="name" required style="width: 250px;" />
                            <span style="color:red" ng-show="person.name.$dirty && person.name.$invalid">
                                <span ng-show="person.name.$error.required">Nome é obrigatório.</span>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>E-mail</td>
                        <td>
                            <input type="email" value="${person.email}" name="email" ng-model="email" required style="width: 250px;" />
                            <span style="color:red" ng-show="person.email.$dirty && person.email.$invalid">
                                <span ng-show="person.email.$error.required">E-mail é obrigatório.</span>
                                <span ng-show="person.email.$error.email">E-mail inválido.</span>
                            </span>                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" value="Salvar" class="btn btn-success"
                                   ng-disabled="person.name.$dirty && person.name.$invalid ||
                                                       person.email.$dirty && person.email.$invalid">
                        </td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </form>

        <script>
            var app = angular.module('myApp', []);
            app.controller('validateCtrl', function($scope) {
                $scope.name = '${person.name}';
                $scope.email = '${person.email}';
            });
        </script>        
    </jsp:body>
</t:template>        