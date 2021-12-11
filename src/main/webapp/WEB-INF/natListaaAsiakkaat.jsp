<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="scripts/main.js"></script>
<title>Asiakastiedot</title>
</head>
<body onkeydown="tutkiKey(event)">
<table id="listaus">
	<thead>
		<tr>
			<th colspan="5" id="ilmo"></th>
			<th><a id="uusiAsiakas" href="natLisaaAuto.jsp">Lisää uusi asiakas</a></th>
		</tr>
		<tr>
			<th class="oikealle">Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="haku" onclick="haeAsiakkaat()"></th>
		</tr>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody id="tbody">
	</tbody>
</table>
</body>
<script>
haeAsiakkaat();
document.getElementById("haku").focus();

function tutkiKey(event) {
	if(event.keyCode==13) {
		haeAsiakkaat();
	}
}

function haeAsiakkaat() {
	document.getElementById("tbody").innerHTML = "";
	fetch("asiakkaat/"+document.getElementById("hakusana").value, {
		method: 'GET'
	})
	.then(function(response) {
		return response.json()
	})
	.then(function(responseJson) {
		var asiakkaat=responseJson.asiakkaat;
		var htmlStr="";
		for(var i=0; i<asiakkaat.length; i++) {
			htmlStr+="<tr>";
			htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
			htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
			htmlStr+="<td>"+asiakkaat[i].puh+"</td>";
			htmlStr+="<td>"+asiakkaat[i].sposti+"</td>";
			htmlStr+="<td><a href='natMuutaAsiakas.jsp?asiakas_id="+asiakkaat[i].asiakas_id+"'>Muuta</a>&nbsp;";
			htmlStr+="<span class='poista' onclick=poista('"+asiakkaat[i].asiakas_id+"')>Poista</span></td>";
			htmlStr+="</tr>";
		}
		document.getElementById("tbody").innerHTML=htmlStr;
	})
}

function poista(asiakas_id, etunimi, sukunimi) {
	if(confirm("Poista asiakas "+etunimi+" " +sukunimi+"?")){
		fetch("asiakkaat/"+asiakas_id+etunimi+sukunimi, {
			method: 'DELETE'
		})
		.then(function(response) {
			return response.json()
		})
		.then(function(responseJson) {
			var re=responseJson.response;
			if(re==0) {
				document.getElementById("ilmo").innerHTML="Asiakkaan poisto epäonnistui."
			} else if(re==1) {
				document.getElementById("ilmo").innerHTML="Asiakkaan "+etunimi+" "+sukunimi+" poisto onnistui."
				haeAsiakkaat();
			}
			setTimeout(function() {
				document.getElementById("ilmo").innerHTML="";
			},5000);
		})
	}
}
</script>
</html>