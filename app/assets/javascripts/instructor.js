// $(document).ready(function(){

// 	var i=1;
// 	$("#add_row").click(function(){
// 		$('#drive'+i).html("<td><input type='checkbox'></td><td>"+ (i+1) +"</td><td><input name='name"+i+"' type='text' placeholder='Name' class='form-control input-md'  /> </td><td><input  name='driver"+i+"' type='file'  class='form-control input-md'></td><td><input  name='expected"+i+"' type='text' placeholder='Expected files'  class='form-control input-md'></td>");
// 		$('#drivers').append('<tr id="drive'+(i+1)+'"></tr>');
// 		i++;
// 	});
//      $("#delete_row").click(function(){
//     	 if(i>1){
// 		 $("#drive"+(i-1)).html('');
// 		 i--;
// 		 }
// 	 });


// });

(function ($) {
	var $form,
		$testDriverTpl,
		$testDriverFileTpl,
		$testDriverContainer,
		$addDriverButton,
		options,
		methods;

	options = {
		driverContainer: 'drivers',
		addDriverButton: 'add-test-driver'
	};

	methods = {
		initializeForm: function () {
			$testDriverContainer = $(options.driverContainer);
			$addDriverButton = $(options.addDriverButton);

			methods.createTemplates();
			methods.createListeners();

			methods.addDriver();
		},
		createTemplates: function () {
			var $name, $file, $expectedFiles;

			$testDriverTpl = $('<div></div>');
			$name          = $('<div></div>');
			$file          = $('<div></div>');
			$expectedFiles = $('<div></div>');

			$('<label>Name</label>').appendTo($name);
			$('<input type="text" />').appendTo($name);
			$('<label>File</label>').appendTo($file);
			$('<label>Expected Output Files</label>').appendTo($expectedFiles);

			$name.appendTo($testDriverTpl);
			$file.appendTo($testDriverTpl);
			$expectedFiles.appendTo($testDriverTpl);
		},
		createListeners: function () {
			$addDriverButton.on('click', function () {
				methods.addDriver();
			});
		},
		addDriver: function () {
			var $driver;

			$driver = $testDriverTpl.clone();

			$driver.appendTo($testDriverContainer);
		}
	};

	$.fn.instructorForm = function (opts) {
		$form   = $(this);
		options = $.extend(options, opts);

		methods.initializeForm();
	}
})(jQuery);
