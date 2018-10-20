const initialize_print_calendar = () => {
  $('.printCalendar').each(() => {
    const calendar = $('.printCalendar');
    console.log(calendar);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay',
      },
      defaultView: calendar.data('view'),
      defaultDate: calendar.data('date'),
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      events: '/events.json',
    });
  });
};

$(document).on('turbolinks:load', initialize_print_calendar);
