$(document).ready(function() {
  $("#modal").click(function(event) {
    event.preventDefault();
    $.modal( buildForm($(this).attr('href')), { overlayClose: true } )
  });
});


function buildForm(current_page) {
  return " \
      <div id='dialog'> \
        <h1>Hold your horses</h1> \
        <h4>You must log in to continue</h4> \
        <form action='/login' method='post'> \
          <input class='form-control unwide' name='username' type='text' placeholder='username'> \
          <input class='form-control unwide' name='password' type='password' placeholder='password'> \
          <input type='hidden' name='current_page' value='" + current_page + "'> \
          <div class='wrap-center'> \
            <input class='btn btn-primary' type='submit' value='login'> \
            <br> \
            <br> \
            Not a user? <a href='/users/new'>register here</a> \
          </div> \
        </form> \
      </div>"

}