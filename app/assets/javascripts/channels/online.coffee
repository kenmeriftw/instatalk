jQuery(document).on 'turbolinks:load', ->
  App.online = App.cable.subscriptions.create { channel: 'OnlineChannel' },

    received: (data) ->
      $('#online').html data.users.map((user) -> "<li>#{user}</li>").join("\n")
