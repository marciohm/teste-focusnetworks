<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:template>
    <jsp:body>
        <h1>Amigo Secreto FocusNetworks</h1>
        <hr/>
        <h3>Pessoas Cadastradas</h3>

        <div>
            <form method="GET" id="frmSearch" action="${pageContext.request.contextPath}/person/list/">
                <input type="text" id="param" placeholder="Pesquise por nome ou e-mail" style="width: 250px;">
                <input type="button" value="pesquisar" class="btn btn-info" onclick="searchPerson();">
            </form>
        </div><br/>

        <div>
            <p style="color:green;">${param.message}</p>
            <table class="table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>E-mail</th>
                        <th width="10%"></th>
                        <th width="10%"></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="person" items="${persons}">
                        <tr>
                            <td>${person.id}</td>
                            <td>${person.name}</td>
                            <td>${person.email}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/person/edit/${person.id}.html">Alterar</a><br/>
                            </td>
                            <td>
                                <a href="javascript:deletePerson(${person.id});">Remover</a><br/>
                            </td>                        
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <input type="hidden" id="listaNomes" value="<c:forEach var="person" items = "${persons}"><c:out value="${person.name}" />;</c:forEach>">
            </div>
            <hr/>

            <div  ng-app='ModalDemo'>
                <div ng-controller='MyCtrl'>
                    <button ng-click='toggleModal()' class="btn btn-success">Executar Sorteio</button>                
                    <modal-dialog show='modalShown' width='900px' height='90%'>
                        <p>
                        <h3>Resultado do Sorteio</h3>
                        <table class="table-striped">
                            <thead>
                                <tr>
                                    <th style="width: 20%;"></th>
                                    <th style="width: 10%;"></th>
                                    <th style="width: 20%;"></th>
                                </tr>
                            </thead>
                            <tbody id="tbResultado">
                            </tbody>
                        </table>
                        <p>
                    </modal-dialog>
                </div>                                   
            </div>



            <script type="text/javascript">
                app = angular.module('ModalDemo', []);
                app.directive('modalDialog', function() {
                    return {
                        restrict: 'E',
                        scope: {
                            show: '='
                        },
                        replace: true, // Replace with the template below
                        transclude: true, // we want to insert custom content inside the directive
                        link: function(scope, element, attrs) {
                            scope.dialogStyle = {};
                            if (attrs.width)
                                scope.dialogStyle.width = attrs.width;
                            if (attrs.height)
                                scope.dialogStyle.height = attrs.height;
                            scope.hideModal = function() {
                                scope.show = false;
                            };
                        },
                        template: "<div class='ng-modal' ng-show='show'><div class='ng-modal-overlay' ng-click='hideModal()'></div><div class='ng-modal-dialog' ng-style='dialogStyle'><div class='ng-modal-close' ng-click='hideModal()'>X</div><div class='ng-modal-dialog-content' ng-transclude></div></div></div>"
                    };
                });
                app.controller('MyCtrl', ['$scope', function($scope) {
                        $scope.modalShown = false;
                        $scope.toggleModal = function() {
                            executaSorteio();
                            $scope.modalShown = !$scope.modalShown;
                        };
                    }]);

                function searchPerson() {
                    var param = document.getElementById('param').value;
                    var form = document.getElementById('frmSearch');
                    if (param.trim() !== "") {
                        form.action += param;
                        form.submit();
                    }

                }

                function deletePerson(id) {
                    if (confirm("Confirma exclusão?")) {
                        window.location = "${pageContext.request.contextPath}/person/delete/" + id + ".html";
                    }
                }

                function executaSorteio() {
                    document.getElementById('tbResultado').innerHTML = "";
                    var listaNomes = document.getElementById('listaNomes').value;
                    var listaAux = listaNomes.split(";");
                    var listaAux2 = listaNomes.split(";");
                    var listaMain = new Array();

                    for (var i = 0; i < listaAux.length - 1; i++) {
                        var nome1 = listaAux[i].trim();
                        var indice = Math.floor((Math.random() * (listaAux2.length - 1)));
                        var nome2 = listaAux2[indice].trim();
                        if (nome1 !== nome2) {
                            listaMain.push([nome1, nome2]);
                            listaAux2.splice(indice, 1);
                            document.getElementById('tbResultado').innerHTML += "<tr><td>" + nome1 + "</td><td>tirou</td><td>" + nome2 + "</td></tr>";
                        } else {
                            i--;
                        }
                    }
                }

        </script>
    </jsp:body>
</t:template>        