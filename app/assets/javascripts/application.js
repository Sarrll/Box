// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery.ui.all
//= require jquery.cookie
//= require jquery-placeholder
//= require dropkick
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap-select
//= require bootstrap-switch
//= require flat-ui
//= require_tree ../../../vendor/assets/javascripts/.
//= require_tree .

$(document).on('page:change', function() {
    $(':checkbox').checkbox();
});

$(document).on('page:fetch', function() {
    $('#content').addClass('animated fadeOut');
    $('body').prepend("<span class='loader'></span>");
});

$(function(){
	$('.col-eqh').equalHeights();
});


$(document).on("input change", "input", function(){
	$form = $(this).parents("form");

	if($form.find('.alert').length){
		$form.find(".form-group").removeClass("has-error has-success has-feedback");
		$form.find(".form-group").find(".form-control-feedback,.form-control-feedback-msg").remove();
		$form.find('.alert').fadeOut();
	}

	$(this).parents(".form-group").removeClass("has-error has-success has-feedback");
	$(this).parents(".form-group").find(".form-control-feedback,.form-control-feedback-msg").remove();
	$form.find("input[type='submit'],button[type='submit']").prop('disabled', false);
});

$(function($)  {
   $.fn.extend({
      check : function()  {
         return this.parent(".checkbox").not(".checked").click();
      },
      uncheck : function()  {
         return this.parent(".checkbox.checked").click();
      }
   });
});

function link_submission(link_id) {
	var $link = $(link_id);
	var $form = $link.parents("form");
	$link.on("ajax:send", function() {
		$form.off("ajax:send ajax:complete ajax:error ajax:success");
	});
	$link.on("ajax:complete", function() {
		if($form.length) {
			setTimeout(function() {
				if($form.length) {
					form_submission("#" + $form.attr("id"));
				}
			}, 500);
		}
	});
	$link.on("ajax:success", function(e, data, status, xhr) {
		console.log(status);
	});
	$link.on("ajax:error", function(e, xhr, status, error) {
		console.log(status);
	});
};

function form_submission(form_id) {
	var $form = $(form_id);
	$form.on("ajax:send", function(){
		$loader = "<div class='formLoader'></div>";
		$form.find('.alert').remove();
		$form.find(".has-error").removeClass("has-error");
		$form.find(".has-success").removeClass("has-success");
		$form.find(".has-feedback").removeClass("has-feedback");
		$form.find(".form-group").find(".form-control-feedback,.form-control-feedback-msg").remove();
		$form.find("input[type='submit'],button[type='submit']").prepend($loader).prop('disabled', true);
		//console.log("send");
	});

	$form.on("ajax:complete", function(){
		var $form_group = $form.find(".form-group").not(".has-error");
		$form_group.addClass("has-success");
		$form.find(".formLoader").remove();
		$.each($form_group, function() {
			if ($(this).find(".input-icon").length === 0) {
				$(this).addClass("has-feedback");
				var $input = $(this).find("input");
				if ($input.not("[type='checkbox'],[type='hidden'],[type='submit'],[type='button'],[type='file']").length) {
					$input.parents(".form-group").addClass("has-feedback");
					$input.after('<span class="fui-check form-control-feedback" aria-hidden="true"></span>');
				}
			}
		});
		// console.log("complete");
	});
	$form.on("ajax:success", function(e, data, status, xhr){
		$.each(xhr.responseJSON, function( index, value ) {
			if (index == "redirect_to") {

			}else {
				$.cookie(index, value, { expires: 1, path: '/' });
			}
		});
		
		$('#content').addClass('animated fadeOut');
    	$('body').prepend("<span class='loader'></span>");

		if (data.redirect_to) {
			window.location.replace(data.redirect_to);
		}
		else {
			window.location.reload();
			console.log(data);
		}
		// console.log("success");
	});
	$form.on("ajax:error", function(e, xhr, status, error) {
		var i = 0;
		$.each(xhr.responseJSON, function( index, value ) {
		  // console.log( index + ": " + value );
		  var $input = $form.find('[name*="['+index+']"]').not("[type='hidden']");
		  if($input.length) {
		  	i++;
		  	$input.parents(".form-group").addClass("has-error");
		  	if ($input.not("[type='checkbox']").length) {
		  		$input.parents(".form-group").addClass("has-feedback");
		  		$feedback = '<span class="fui-cross form-control-feedback" aria-hidden="true"></span><span class="form-control-feedback-msg"> . ';
				$.each(value,function( index, value ) {
					$feedback += value+' . ';
				});
				$feedback += '</span>';
		  		$input.after($feedback);
		  	}
		  }
		});
		if (i === 0){
			var alert = "<div class='alert alert-danger alert-dismissible' style='display:none;' data-alert='alert' role='alert'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>"+xhr.responseJSON.error+"</div>";
			$form.prepend(alert);
			var $alert = $form.find('.alert').fadeIn();
			var $form_group = $form.find(".form-group");
			$form_group.addClass("has-error");
		}
		// console.log("error");
	});
};




