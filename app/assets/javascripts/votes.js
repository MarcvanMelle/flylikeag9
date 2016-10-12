function vote(value, word_id, review_id) {

  $.ajax({
    method: "POST",
    url: "/words/" + word_id + "/reviews/" + review_id + "/votes",
    data: { vote: { up_down: value, review_id: review_id } },
    review: function(){
      return review_id
    },
    value: function(){
      return value
    },
    success: function(data){
      review_id = this.review();
      value =  this.value();
      if (value) {
        if ($("#up"+review_id).attr('class').includes("upvoted")){
          $("#up"+review_id).removeClass()
          $("#up"+review_id).addClass("button")
        } else if ($("#down"+review_id).attr('class').includes("downvoted")){
          $("#down"+review_id).removeClass()
          $("#down"+review_id).addClass("button")
          $("#up"+review_id).addClass("upvoted")
        } else {
          $("#up"+review_id).addClass("upvoted")
        }
      } else {
        if ($("#down"+review_id).attr('class').includes("downvoted")){
          $("#down"+review_id).removeClass()
          $("#down"+review_id).addClass("button")
        } else if ($("#up"+review_id).attr('class').includes("upvoted")){
          $("#up"+review_id).removeClass()
          $("#up"+review_id).addClass("button")
          $("#down"+review_id).addClass("downvoted")
        } else {
          $("#down"+review_id).addClass("downvoted")
        }
      }
      $("#count"+review_id).text(data);
    }
  }).success()
}
