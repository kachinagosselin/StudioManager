<script>
Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
$(document).ready(function() {

  $(id).submit(function(event) {

    // disable the submit button to prevent repeated clicks
    $('.submit-button').attr("disabled", "disabled");
    var card_number = document.getElementById('card_number').value;
    var card_code = document.getElementById('card_code').value;
    var card_month = document.getElementById('card_month').value;
    var card_year = document.getElementById('card_year').value;
    //alert('Number: ' + card_number + ' CVC: ' + card_code + ' Month:' + card_month + 'Year:' + card_year);
    
    var end = card_number.length;
    var last_4_digits = card_number[end-4]+card_number[end-3]+card_number[end-2]+card_number[end-1];
    $(id).append("<input type='hidden' name='last_4_digits' value='" + last_4_digits + "'/>");
    alert('Last 4 Digits: ' + last_4_digits);

    Stripe.createToken({
        number: $('#card_number').val(),
        cvc: $('#card_code').val(),
        exp_month: $('#card_month').val(),
        exp_year: $('#card_year').val()
    }, stripeResponseHandler);

    // prevent the form from submitting with the default action
    return false;
  });
});

function stripeResponseHandler(status, response) {
    if (response.error) {
        // show the errors on the form
        $(".payment-errors").text(response.error.message);
        $(".submit-button").removeAttr("disabled");
    } else {
        var token = response['id'];
        // insert the token into the form so it gets submitted to the server
        $(id).append("<input type='hidden' name='stripe_card_token' value='" + token + "'/>");
        // and submit
        $(id).get(0).submit();
        //alert(token); 
    }
    return false;
}

</script>