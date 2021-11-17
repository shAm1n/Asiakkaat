<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
th {
  background-color: #47d147;
  color: white;
}
td, th {
	border: 1px solid #ddd;
}
tr:nth-child(even) {
	background-color: #f2f2f2;
}
.oikealle {
	text-align: right;
}
</style>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="2" class="oikealle">Hakusana:</th>
			<th><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="haku"></th>
		</tr>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function() {
	haeAsiakkaat();
	
	$("#haku").click(function() {		
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event) {
		  if(event.which==13) {
			  haeAsiakkaat();
		  }});
	$("#hakusana").focus();
});
function haeAsiakkaat() {
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result) {
		$.each(result.asiakkaat, function(i, field){
			var htmlStr;
			htmlStr+="<tr>";
			htmlStr+="<td>"+field.etunimi+"</td>";
			htmlStr+="<td>"+field.sukunimi+"</td>";
			htmlStr+="<td>"+field.puh+"</td>";
			htmlStr+="<td>"+field.sposti+"</td>";
			htmlStr+="</tr>";
			$("#listaus tbody").append(htmlStr);
		});
	}});
}
</script>
</body>
</html>