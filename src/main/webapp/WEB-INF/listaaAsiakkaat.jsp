<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakastiedot</title>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="5" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>
		<tr>
			<th colspan="3" class="oikealle">Hakusana:</th>
			<th><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="haku"></th>
		</tr>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</body>
<script>
$(document).ready(function() {
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaAsiakas.jsp";
	});
	
	$(document.body).on("keydown", function(event) {
		  if(event.which==13) {
			  haeAsiakkaat();
		  }});
	
	$("#haku").click(function() {		
		haeAsiakkaat();
	});

	$("#hakusana").focus();
		haeAsiakkaat();
});
function haeAsiakkaat() {
	$("#listaus tbody").empty();
	$.getJSON({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result) {
		$.each(result.asiakkaat, function(i, field){
			var htmlStr;
			htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>";
			htmlStr+="<td>"+field.asiakas_id+"</td>";
			htmlStr+="<td>"+field.etunimi+"</td>";
			htmlStr+="<td>"+field.sukunimi+"</td>";
			htmlStr+="<td>"+field.puh+"</td>";
			htmlStr+="<td>"+field.sposti+"</td>";
			htmlStr+="<td><a href='muutaAsiakas.jsp?asiakas_id="+field.asiakas_id+"'>Muuta</a>&nbsp;";
			htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakas_id+"','"+field.etunimi+"','"+field.sukunimi+"')>Poista</span></td>";
			htmlStr+="</tr>";
			$("#listaus tbody").append(htmlStr);
		});
	}});
}
function poista(asiakas_id, etunimi, sukunimi) {
	if(confirm("Poista asiakas "+etunimi+" " +sukunimi+"?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) {
	        if(result.response==0) {
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        } else if(result.response==1) {
	        	$("#rivi_"+asiakas_id).css("background-color", "red");
	        	alert("Asiakkaan "+etunimi+" "+sukunimi+" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}
</script>
</html>