$(document).ready(function(){

	var i=1;
	$("#add_row").click(function(){
		$('#drive'+i).html("<td><input type='checkbox'></td><td>"+ (i+1) +"</td><td><input name='name"+i+"' type='text' placeholder='Name' class='form-control input-md'  /> </td><td><input  name='driver"+i+"' type='file'  class='form-control input-md'></td><td><input  name='expected"+i+"' type='text' placeholder='Expected files'  class='form-control input-md'></td>");
		$('#drivers').append('<tr id="drive'+(i+1)+'"></tr>');
		i++;
	});
     $("#delete_row").click(function(){
    	 if(i>1){
		 $("#drive"+(i-1)).html('');
		 i--;
		 }
	 });


});



