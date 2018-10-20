let initialize_calendar;
initialize_calendar = function () {
  $('.calendar').each(function () {
    const calendar = $(this);
    calendar.fullCalendar({
      // header: {
      //   left: 'title',
      //   center: 'month,agendaWeek,agendaDay',
      //   right: 'prev,next,today',
      // },
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay',
      },
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      events: '/events.json',
      locale: 'ca',

      select(start, end) {
        $.getScript('/events/new', () => {});

        calendar.fullCalendar('unselect');
      },

      eventDrop(event, delta, revertFunc) {
        event_data = {
          event: {
            id: event.id,
            start: event.start.format(),
            end: event.end.format(),
          },
        };
        $.ajax({
          url: event.update_url,
          data: event_data,
          type: 'PATCH',
        });
      },

      eventClick(event, jsEvent, view) {
        $.getScript(event.edit_url, () => {});
      },
    });
  });
};
$(document).on('turbolinks:load', initialize_calendar);
