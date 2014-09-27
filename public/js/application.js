$(document).ready(function() {
  $("#added-questions").on("click", ".add-option", function() {
    event.preventDefault();
    var question_index = lastQuestionIndex();
    var option_index = lastOptionIndex($(this));
    $( buildOption(option_index + 1, question_index) ).insertAfter( $(this).parent().prev().children().last() )
  });
  $("#added-questions").on("click", ".delete-option", function() {
    event.preventDefault();
    if ( !($(this).parent().children().last().index() <= 5) ) {
      $(this).prev().remove();
      $(this).next().remove();
      $(this).remove();
    }
  });
  $("#new-question").click(function() {
    event.preventDefault();
    var question_index = lastQuestionIndex();
    $("#added-questions").append( buildQuestion(question_index + 1) )
  });
  $("#added-questions").on("click", ".delete-question", function() {
    event.preventDefault();
    if ( $("#added-questions li:last").index() === 0 ) {
      return null
    } else {
      $( $(this).parent().parent() ).remove();
    }
  });
  $("#new-survey input[type=submit]").click(function(event) {
    event.preventDefault();
    var isFilledOut = checkIfFormIsFilledOut("#new-survey");
    if (isFilledOut) {
      $("#new-survey").submit();
    } else {
      $(".alert").remove();
      $("#new-survey input[type=submit]").parent().prepend("<p class='alert alert-danger unwide'>All fields must be filled out.</p>");
    }
  });


  $(".take-survey").on("submit", function(e) {
    var answered_count = 0;
    var question_count = $(".question").length;
    $(".take-survey :input").each(function() {
      var input = $(this);
      if ($(input).is(':checked')) {
        answered_count += 1
      };
    });
    if (answered_count < question_count) {
      e.preventDefault();
      $("#missing-answers").html("<p class = 'alert alert-danger unwide'>You missed something!</p>")
    };
  });
});

function buildQuestion(index) {
  return  "<li class='pad'> \
            <input class='form-control' name='questions[" + index + "][question]' placeholder='question'> \
            <div class='wrap-center'> \
              <input class='form-control unwide inline' name='questions[" + index + "][options][0]' placeholder='option'> <button class='delete-option btn btn-danger btn-sm'>delete option</button><br> \
              <input class='form-control unwide inline' name='questions[" + index + "][options][1]' placeholder='option'> <button class='delete-option btn btn-danger btn-sm'>delete option</button><br> \
            </div> \
            <div class='wrap-center'> \
              <button class='add-option btn btn-success'><span class='glyphicon glyphicon-plus'></span> add option</button> \
              <button class='delete-question btn btn-danger'><span class='glyphicon glyphicon-minus'></span> delete question</button> \
            </div> \
          </li>"
}

function buildOption(option_index, question_index) {
  return "<input class='form-control unwide inline' name='questions[" + question_index + "][options][" + option_index + "]' placeholder='option'> <button class='delete-option btn btn-danger btn-sm'>delete option</button><br>"
}

function lastQuestionIndex() {
  return parseInt($("#added-questions li:last input:first").attr('name').split('[')[1])
}

function lastOptionIndex(button) {
  return parseInt(button.parent().prev().children().filter("input:last").attr("name").split('[')[3]) 
}

function checkIfFormIsFilledOut(selector) {
  var isFilledOut = true;

  $( selector + " input" ).each(function() {
    var input = $(this).val();
    if (!input.length) {
      isFilledOut = false;
    }
  });

  return isFilledOut;
}

