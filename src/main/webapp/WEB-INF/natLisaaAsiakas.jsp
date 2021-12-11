<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Lisaa asiakas</title>
</head>
<body onkeydown="tutkiKey(event)">
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="3" id="ilmo"></th>
				<th colspan="2" class="oikealle"><a href="natListaaAutot">Takaisin listaukseen</a></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puh" id="puh"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="button" id="tallenna" value="Lisää" onclick="lisaaTiedot()"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
</body>
<script>
function tutkiKey(event) {
	if(event.keyCode==13) {
		lisaaTiedot();
	}
}
document.getElementById("etunimi").focus();

function lisaaTiedot() {
	var ilmo="";
	if(document.getElementById("etunimi").value.length<2) {
		ilmo="Liian lyhyt";
	} else if(document.getElementById("sukunimi").value.length<2) {
		ilmo="Liian lyhyt";
	} else if(document.getElementById("puh").value.length<5) {
		ilmo="Liian lyhyt";
	} else if(document.getElementById("sposti").value.length<10) {
		ilmo="Liian lyhyt";
	}
	if(ilmo!="") {
		document.getElementById("ilmo").innerHTML=ilmo;
		setTimeout(function() {
			document.getElementById("ilmo").innerHTML="";
		},5000);
		return;
	}
	document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
	document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
	document.getElementById("puh").value=siivoa(document.getElementById("puh").value);
	document.getElementById("sposti").value=siivoa(document.getElementById("sposti").value);
	
	var formJsonStr=formDataToJSON(document.getElementById("tiedot"));
	
	fetch("asiakkaat", {
		method: 'POST'
		body: formJsonStr
	})
	.then(function(response) {
		return response.json()
	})
	.then(function(responseJson) {
		var re=responseJson.response;
		if(re==0) {
			document.getElementById("ilmo").innerHTML="Asiakkaan lisäys epäonnistui."
		} else if(re==1) {
			document.getElementById("ilmo").innerHTML="Asiakkaan lisäys onnistui."
		}
		setTimeout(function() {
			document.getElementById("ilmo").innerHTML="";
		},5000);
	})
	document.getElementById("tiedot").reset();
}
</script>
</html>