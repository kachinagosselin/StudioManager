<script> 
$(document).ready(function() {
$('#calendar').fullCalendar({
	defaultView: 'agendaWeek',
	minTime: 6,
	height: 500,
	header: {
  	left: 'prev,next today',
  	center: 'title',
  	right: 'month,agendaWeek,agendaDay',
  	},
    eventSources: [{
            url: '/studios/1/events/', // use the `url` property
    }]
});
</script> 
