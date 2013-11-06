$('#counters_table').html "<%=j render 'counters_table' %>"

$('#current_year').html "<%= params[:year] %>"

$(".btn-block").hide()

$('.overlay').hover(
  -> $(this).find('.btn-block').fadeIn(250)
  -> $(this).find('.btn-block').fadeOut(250)
)
