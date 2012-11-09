# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->$('#chinazo_nombre').autocomplete({source: "/ajax/users"})

$(document).ready ->$('.star-rating-applied').click ->$.post(
            '/vote/new'
			{ value: $(this).find('a').text(),chinazo_id: $('#chinazo_id').val() })

$(document).ready ->$('#comentariosForm').bind('ajax:success', (event, data, status, xhr) -> $('#comentarios_container').html(data); $('#comentario').val(''))

$(document).ready -> setInterval(refrescamientos,10000)

refrescamientos = () -> refreshComentarios(); refreshComentariosIndex(); 

refreshComentarios = () -> $('#comentarios_container').load("/comentarios/"+$('#chinazo_id').val())
refreshComentariosIndex = () -> $('#ultimos_comentarios_container').load("/comentarios/")

replaceURLWithHTMLLinks => (text) ->
    exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/i;
    return text.replace(exp,"<a href='$1'>$1</a>"); 
