$(document).ready(function() {
  $("#added-questions").on("click", ".add-option", function() {
    event.preventDefault();
    var question_index = lastQuestionIndex();
    var option_index = lastOptionIndex($(this));
    $( buildOption(option_index, question_index) ).insertBefore( $(this).parent().last() )
  })
  $("#new-question").click(function() {
    event.preventDefault();
    var question_index = lastQuestionIndex();
    $("#added-questions").append( buildQuestion(question_index + 1) )
  })
  $("#added-questions").on("click", ".delete-question", function() {
    event.preventDefault();
    if ( $("#added-questions li:last").index() === 0 ) {
      return null
    } else {
      $( $(this).parent().parent() ).remove();
    }
  })
});

function buildQuestion(index) {
  return "<li class='pad'> \
            <input class='form-control' name='questions[" + index + "][question]' placeholder='question'> \
            <input class='form-control unwide' name='questions[" + index + "][options][0]' placeholder='option'> \
            <input class='form-control unwide' name='questions[" + index + "][options][1]' placeholder='option'> \
            <div class='wrap-center'> \
              <button class='add-option btn btn-success'>add option</button> \
              <button class='delete-question btn btn-danger'>delete question</button> \
            </div> \
          </li>"
}

function buildOption(option_index, question_index) {
  return "<input class='form-control unwide' name='questions[" + question_index + "][options][" + option_index +"]' placeholder='option'>"
}

function lastQuestionIndex() {
  return parseInt($("#added-questions li:last input:first").attr('name').split('[')[1])
}

function lastOptionIndex(button) {
  return button.prev().index()
}

