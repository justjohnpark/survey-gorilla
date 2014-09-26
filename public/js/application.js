$(document).ready(function() {
  $("#added-questions").on("click", ".add-option", function() {
    event.preventDefault();
    var question_index = lastQuestionIndex();
    var option_index = lastOptionIndex($(this));
    $( buildOption(option_index, question_index) ).insertBefore( $(this).last() )
  })
  $("#new-question").click(function() {
    event.preventDefault();
    var question_index = lastQuestionIndex();
    $("#added-questions").append( buildQuestion(question_index + 1) )
  })
});

function buildQuestion(index) {
  return "<li> \
            <input name='questions[" + index + "][question]' placeholder='question'> \
            <input class='option' name='questions[" + index + "][options][0]' placeholder='option'> \
            <input class='option' name='questions[" + index + "][options][1]' placeholder='option'> \
            <button class='add-option'>add option</button> \
          </li>"
}

function buildOption(option_index, question_index) {
  return "<input class='option' name='questions[" + question_index + "][options][" + option_index +"]' placeholder='option'>"
}

function lastQuestionIndex() {
  return $("#added-questions li").last().index()
}

function lastOptionIndex(button) {
  return button.prev().index()
}

