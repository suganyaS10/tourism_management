
document.addEventListener("turbolinks:load", function() {



	fill_up_form_on_edit();

	$('.user-bookings').on('click', function(){
		window.location.replace('/bookings/' + this.dataset.bookingId)
	})

	$('#num_of_people').on('keyup', function(){

		if(this.value == ''){
      $('.passengers').remove();
		}
		else{
			build_dynamic_forms(this.value);
		}

		display_in_confirmation_div();

	});

	$('#master_passenger').on('change', function(){
		display_in_confirmation_div();
	})

	$('#all-passengers').change('.passengers', function(){
		display_in_confirmation_div();
	})

  function calculate_total_cost(){
  	num_of_people = $('#num_of_people').val();
  	total_cost = (cost_per_person * num_of_people);
  	$('#total_cost').text('Total Cost:' + total_cost);
  }

  function display_in_confirmation_div(){
  	$('#display_for_confirmation').empty();
  	$('#master_passenger').clone().prop('id', '').removeClass('tab').appendTo('#display_for_confirmation').css({display: 'block'});
  	$('.passengers').clone().appendTo('#display_for_confirmation');
  	$('<span id="total_cost"></span>').appendTo('#display_for_confirmation');
  	calculate_total_cost();
  	$('#display_for_confirmation').find(':input').prop('disabled','disabled');
  }
  

  $('.tab').hide();
  	$($('#basic-li').children("a").attr("href")).show();
		$($('#basic-li').children("a").attr("href")).find(':input:visible').prop('disabled', 'disabled');

  $('.tabs li').on('click', function(){
  	const selected_widget = $(this).children("a").attr("href");
	  $(".tab").hide();
	  $(selected_widget).show();

	  if(selected_widget == '#basic_information' || selected_widget == '#display_for_confirmation'){
	  	$(selected_widget).find(':input').prop('disabled', 'disabled');
	  }
	  if(selected_widget == '#display_for_confirmation')
	  	display_in_confirmation_div();
	  return false;
	});

  function build_dynamic_forms(num_of_people){
  	for(i=0; i<num_of_people; i++){			
			$all_passengers_form = $('.all-passengers').clone().appendTo($('#all-passengers')).removeClass('all-passengers').addClass('passengers').css({'display': 'block'});
	    $all_passengers_form.children().each(function(){
	    	if(this.tagName == 'LABEL'){
	    		var label_for = $(this).attr('for');
	    		prefix = label_for.substr(0,43);
	    		person = 'person' + (i+1) + '_';
	    		suffix = label_for.substr(43, label_for.length)
	    		label_for = prefix + person + suffix
	    		$(this).attr('for', label_for);
	    	}
	    	if(this.tagName == 'INPUT' || this.tagName == 'SELECT'){
	    		var input_name = this.name;
	    		prefix = input_name.substr(0,44);
	    		person = '[person' + (i+1) + ']';
	    		suffix = input_name.substr(44, input_name.length)
	    		input_name = prefix + person + suffix;
	    		$(this).attr('name', input_name);
	    	}
	    });
	  }
  }

	// ===================== Fill Up Forms on Edit===================
  function fill_up_form_on_edit(){
  	if(booking && booking != ''){
			var master_passenger_details = booking["master_passenger"];

			$('#master_passenger').children().each(function(){
				if(this.tagName == 'INPUT' || this.tagName == 'SELECT'){
					attr_name = this.id.substr(43, this.id.length)
					$(this).val(master_passenger_details[attr_name]);
				}
			});
      
      var num_of_people = Object.keys(booking["other_passengers"]).length;
      build_dynamic_forms(num_of_people);

      $('.passengers').each(function(){
      	$(this).children().each(function(){
      		if(this.tagName == 'INPUT' || this.tagName == 'SELECT'){
						attr_name = this.id.substr(43, this.id.length)
						$(this).val(master_passenger_details[attr_name]);
					}
      	});

      });
		}
  }








	// =====================================
  

	$('#people_count').on('keyup', function(){
		var remaining_people = max_people - this.value;
		$('#remaining-people').text(remaining_people);

		total_cost = (cost_per_person * this.value);
		$('#total_cost').text(total_cost);
	})

	$('#amount_paid').on('keyup', function(){
		remaining_amount = total_cost - this.value;
    $('#remaining-cost').text(remaining_amount);
	})

	if(booking_status){
		if(booking_status == 'Approved')
			$('#approve-booking').addClass('disable-status');
		else if(booking_status == 'Declined')
	    $('#decline-booking').addClass('disable-status');
	}


	$('#approve-booking').on('click', function(){
		if($(this).hasClass('disable-status'))
		  return false

		$.ajax({
			type: 'PUT',
			contentType: "application/json; charset=utf-8",
     	url: "/bookings/" + this.dataset.packageId,
      data : JSON.stringify({status:"Approved"}),
      dataType: "json",
      success: function (result) {
        //do somthing here
	        window.alert("Approved!");
	        $('#approve-booking').attr('disabled','disabled');
	        $('#approve-booking').addClass('disable-status');

	     },
	     error: function (){
	        window.alert("something wrong!");
	     }
		});
	});

	$('#decline-booking').on('click', function(){
		if($(this).hasClass('disable-status'))
		  return false

		$.ajax({
			type: 'PUT',
			contentType: "application/json; charset=utf-8",
     	url: "/bookings/" + this.dataset.packageId,
      data : JSON.stringify({status:"Decline"}),
      dataType: "json",
      success: function (result) {
        //do somthing here
	        window.alert("Declined!");
	        $('#decline-booking').attr('disabled','disabled');
	        $('#decline-booking').addClass('disable-status');

	     },
	     error: function (){
	        window.alert("something wrong!");
	     }
		});
	});


})
