

// $('#create-tour-package')
// https://stackoverflow.com/questions/13249862/colorbox-not-showing-content-correctly

document.addEventListener("turbolinks:load", function() {
	$('#search-form').submit(function(e){
		e.preventDefault();
		var starting_point = this.elements[1].value;
    var end_point = this.elements[2].value;
    var start_date = this.elements[3].value;
    var anything = JSON.stringify({starting_point: starting_point, end_point: end_point, start_date: start_date});
		$.post("/tourism_packages/search?anything=" + anything);
		return false;
	})

	close_accordion_section();

	function close_accordion_section() {
    $('.accordion .accordion-section-title').removeClass('active');
    $('.accordion .accordion-section-content').slideUp(300).removeClass('open');
	}

	$(document).on('click','.accordion-section-title', function(e) {
	  // Grab current anchor value
	  var currentAttrValue = $(this).attr('href');

	  if($(e.target).is('.active')) {
	    close_accordion_section();
	  }
	  else {
	    close_accordion_section();

	    // Add active class to section title
	    $(this).addClass('active');
	    // Open up the hidden content panel
	    $('.accordion ' + currentAttrValue).slideDown(300).addClass('open');
	  }
	})

})


// $('#search-result').html('<%= escape_javascript(render(template: "tourism_packages/search_packages.html")) %>');

// $("#search-result").html("<%= escape_javascript(render(template: 'tourism_packages/search_packages.html.erb') %>");

$("#search-result").html("<%= escape_javascript(render partial: 'search-result', locals: { packages: @packages } ) %>"); 
