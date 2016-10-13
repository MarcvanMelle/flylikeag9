function favorite(null_id, word_id, user_id) {

  $.ajax ({
    method: "PATCH",
    url: "/users/" + user_id + "/favorite_word",
    data: { word_id: word_id }
  }).done(function(){
    $("#fav_word").text("Favorited");
    $("#fav_button").attr('onClick', 'unfavorite(' + null_id + ',' + null_id + ',' + user_id + ')');
    $("#fav_button").text("Unfavorite Word");
  });
}

function unfavorite(null_id, word_id, user_id) {

  $.ajax ({
    method: "PATCH",
    url: "/users/" + user_id + "/favorite_word",
    data: { word_id: null_id }
  }).done(function(){
    $("#fav_word").text("");
    $("#fav_button").attr('onClick', 'favorite(' + null_id + ',' + word_id + ',' + user_id + ')');
    $("#fav_button").text("Favorite Word");
  });
}
